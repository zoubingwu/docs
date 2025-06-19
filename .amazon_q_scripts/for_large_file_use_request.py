#!/usr/bin/env python3
"""
Script to split a large markdown file into chunks, translate each chunk to Chinese
using HTTP API requests, and concatenate the results. Supports checkpoint/resume functionality.
"""

import os
import sys
import requests
import json
import re
import tempfile
import hashlib
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import threading
import time
import random

def get_api_key():
    """Get API key from environment variable."""
    api_key = os.getenv('OPENROUTER_API_KEY')
    if not api_key:
        print("Error: OPENROUTER_API_KEY environment variable not set")
        sys.exit(1)
    return api_key

def translate_text_api(text, max_retries=3):
    """
    Translate text using OpenRouter API.
    Returns translated text or None if failed.
    """
    api_key = get_api_key()

    prompt = f"""Translate the following markdown content to Chinese. Return ONLY the translated markdown content without any explanations or additional formatting:

{text}"""

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "HTTP-Referer": "https://docs.pingcap.com",
        "X-Title": "TiDB Docs Translation",
    }

    data = {
        "model": "google/gemini-2.0-flash-001",
        "messages": [
            {
                "role": "user",
                "content": prompt
            }
        ],
        "temperature": 0.3,
        "max_tokens": 8192
    }

    for attempt in range(max_retries):
        try:
            response = requests.post(
                url="https://openrouter.ai/api/v1/chat/completions",
                headers=headers,
                data=json.dumps(data),
                timeout=120
            )

            if response.status_code == 200:
                result = response.json()
                if 'choices' in result and len(result['choices']) > 0:
                    translated = result['choices'][0]['message']['content']
                    return translated.strip()
                else:
                    print(f"API response missing choices: {result}")
                    return None
            elif response.status_code == 429:
                # Rate limit
                print(f"Rate limit hit, attempt {attempt + 1}/{max_retries}")
                if attempt < max_retries - 1:
                    time.sleep(2 ** attempt)
                    continue
                return None
            else:
                print(f"API request failed with status {response.status_code}: {response.text}")
                return None

        except requests.exceptions.Timeout:
            print(f"Request timeout, attempt {attempt + 1}/{max_retries}")
            if attempt < max_retries - 1:
                time.sleep(1)
                continue
            return None
        except requests.exceptions.RequestException as e:
            print(f"Request exception: {e}, attempt {attempt + 1}/{max_retries}")
            if attempt < max_retries - 1:
                time.sleep(1)
                continue
            return None
        except Exception as e:
            print(f"Unexpected error: {e}")
            return None

    return None

def get_file_hash(file_path):
    """Get MD5 hash of file content for checkpoint validation."""
    hasher = hashlib.md5()
    with open(file_path, 'rb') as f:
        hasher.update(f.read())
    return hasher.hexdigest()

def get_checkpoint_dir(input_file):
    """Get checkpoint directory for the input file."""
    file_hash = get_file_hash(input_file)
    checkpoint_dir = f".amazon_q_scripts/checkpoints/{Path(input_file).stem}_{file_hash[:8]}"
    os.makedirs(checkpoint_dir, exist_ok=True)
    return checkpoint_dir

def save_chunk_result(checkpoint_dir, chunk_index, translated_content):
    """Save translated chunk to individual file."""
    chunk_file = os.path.join(checkpoint_dir, f"chunk_{chunk_index:04d}.md")
    with open(chunk_file, 'w', encoding='utf-8') as f:
        f.write(translated_content)

def load_chunk_result(checkpoint_dir, chunk_index):
    """Load translated chunk from file if exists."""
    chunk_file = os.path.join(checkpoint_dir, f"chunk_{chunk_index:04d}.md")
    if os.path.exists(chunk_file):
        with open(chunk_file, 'r', encoding='utf-8') as f:
            return f.read()
    return None

def save_progress(checkpoint_dir, total_chunks, completed_chunks, failed_chunks):
    """Save current progress to checkpoint file."""
    progress_data = {
        'total_chunks': total_chunks,
        'completed_chunks': list(completed_chunks),
        'failed_chunks': list(failed_chunks),
        'timestamp': time.time()
    }
    progress_file = os.path.join(checkpoint_dir, 'progress.json')
    with open(progress_file, 'w', encoding='utf-8') as f:
        json.dump(progress_data, f, indent=2)

def load_progress(checkpoint_dir):
    """Load progress from checkpoint file."""
    progress_file = os.path.join(checkpoint_dir, 'progress.json')
    if os.path.exists(progress_file):
        with open(progress_file, 'r', encoding='utf-8') as f:
            return json.load(f)
    return None

def split_markdown_file(file_path, max_chars=8000):
    """
    Split markdown file into chunks, preserving structure.
    Split by headings first, then by logical blocks if sections are too large.
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    chunks = []
    lines = content.split('\n')

    # First, split by headings but preserve exact line structure
    sections = []
    current_section_lines = []
    section_start_indexes = []
    current_start = 0

    for i, line in enumerate(lines):
        # Check if this is a heading (# ## ### etc.)
        if re.match(r'^#{1,6}\s+', line.strip()) and current_section_lines:
            # Save previous section
            sections.append(current_section_lines)
            section_start_indexes.append(current_start)
            current_section_lines = []
            current_start = i
        current_section_lines.append(line)

    # Add the last section
    if current_section_lines:
        sections.append(current_section_lines)
        section_start_indexes.append(current_start)

    # Now process each section, preserving exact line count
    for section_lines in sections:
        section_content = '\n'.join(section_lines)
        section_size = len(section_content)

        # Skip empty sections
        if not section_content.strip():
            continue

        # If section is small enough, keep it as one chunk
        if section_size <= max_chars:
            chunks.append(section_content)
        else:
            # Section is too large, split it more carefully
            chunks.extend(split_large_section(section_content, max_chars))

    # Filter out any empty chunks that might have been created
    chunks = [chunk for chunk in chunks if chunk.strip()]
    return chunks

def split_large_section(section, max_chars):
    """
    Split a large section while preserving markdown blocks.
    """
    chunks = []
    lines = section.split('\n')
    current_chunk = []
    current_size = 0
    in_code_block = False
    in_quote_block = False
    code_fence = None

    i = 0
    while i < len(lines):
        line = lines[i]
        line_size = len(line) + 1  # +1 for newline

        # Track code blocks
        if line.strip().startswith('```'):
            if not in_code_block:
                in_code_block = True
                code_fence = line.strip()
            elif line.strip() == code_fence or line.strip() == '```':
                in_code_block = False
                code_fence = None

        # Track quote blocks (rough approximation)
        if line.strip().startswith('>'):
            in_quote_block = True
        elif in_quote_block and line.strip() == '':
            # Continue quote block through empty lines
            pass
        elif in_quote_block and not line.strip().startswith('>'):
            in_quote_block = False

        # Check if we should split here
        should_split = (
            current_size + line_size > max_chars and
            current_chunk and
            not in_code_block and
            not in_quote_block and
            not line.strip().startswith('|')  # Don't split tables
        )

        if should_split:
            # Look for a good split point (empty line, list item, etc.)
            if (line.strip() == '' or
                line.strip().startswith('-') or
                line.strip().startswith('*') or
                line.strip().startswith('1.') or
                re.match(r'^\d+\.', line.strip())):
                chunks.append('\n'.join(current_chunk))
                current_chunk = []
                current_size = 0

        current_chunk.append(line)
        current_size += line_size
        i += 1

    # Add the last chunk if it has content
    if current_chunk:
        chunks.append('\n'.join(current_chunk))

    # Filter out any empty chunks
    chunks = [chunk for chunk in chunks if chunk.strip()]
    return chunks

def translate_chunk(chunk, chunk_num, total_chunks, checkpoint_dir, max_retries=5, initial_delay=1.0, backoff_factor=2.0):
    """
    Translate a single chunk using HTTP API with retry logic.
    Saves result to checkpoint after successful translation.
    """
    thread_id = threading.current_thread().name

    # Check if chunk is already translated
    existing_result = load_chunk_result(checkpoint_dir, chunk_num - 1)
    if existing_result:
        print(f"[{thread_id}] Chunk {chunk_num}/{total_chunks} already translated, skipping...")
        return existing_result

    # Check for empty or very small chunks
    chunk_length = len(chunk.strip())
    print(f"[{thread_id}] Translating chunk {chunk_num}/{total_chunks} (length: {chunk_length} chars)...")

    if chunk_length == 0:
        print(f"[{thread_id}] Warning: Chunk {chunk_num} is empty! Skipping translation.")
        return ""

    if chunk_length < 10:
        print(f"[{thread_id}] Warning: Chunk {chunk_num} is very small: '{chunk.strip()}'")

    for attempt in range(max_retries + 1):
        try:
            # Add small random delay to avoid thundering herd
            if attempt > 0:
                delay = initial_delay * (backoff_factor ** (attempt - 1))
                jitter = random.uniform(0.1, 0.3) * delay
                total_delay = delay + jitter
                print(f"[{thread_id}] Retry {attempt}/{max_retries} for chunk {chunk_num}, waiting {total_delay:.1f}s...")
                time.sleep(total_delay)

            # Use HTTP API to translate
            translated = translate_text_api(chunk)

            if translated is None:
                if attempt < max_retries:
                    print(f"[{thread_id}] API translation failed for chunk {chunk_num}, attempt {attempt + 1}/{max_retries + 1}")
                    continue
                else:
                    print(f"[{thread_id}] Max retries reached for chunk {chunk_num} due to API failures")
                    return chunk

            if not translated.strip():
                if attempt < max_retries:
                    print(f"[{thread_id}] Empty translation for chunk {chunk_num}, retrying... ({attempt + 1}/{max_retries + 1})")
                    continue
                else:
                    print(f"[{thread_id}] Warning: Empty translation for chunk {chunk_num} after all retries, using original")
                    return chunk

            # Save successful translation to checkpoint
            save_chunk_result(checkpoint_dir, chunk_num - 1, translated)
            print(f"[{thread_id}] Chunk {chunk_num} translated successfully on attempt {attempt + 1}")
            return translated

        except Exception as e:
            if attempt < max_retries:
                print(f"[{thread_id}] Exception for chunk {chunk_num}: {e}, attempt {attempt + 1}/{max_retries + 1}")
                continue
            else:
                print(f"[{thread_id}] Max retries reached for chunk {chunk_num} due to exceptions: {e}")
                return chunk

    # This should not be reached, but just in case
    return chunk

def clean_output(raw_output):
    """
    Clean the output from API response by removing extra formatting.
    """
    # Remove excessive empty lines
    result = re.sub(r'\n\s*\n\s*\n', '\n\n', raw_output)
    return result.strip()

def main():
    input_file = 'TOC.md'
    output_file = '.amazon_q_result/TOC.md'
    max_workers = 10  # Reduced to avoid quota limits
    max_retries = 10
    initial_delay = 2.0  # Start with longer delay
    backoff_factor = 2.0

    # Check if input file exists
    if not os.path.exists(input_file):
        print(f"Error: {input_file} not found in current directory")
        sys.exit(1)

    # Create checkpoint directory
    checkpoint_dir = get_checkpoint_dir(input_file)
    print(f"Using checkpoint directory: {checkpoint_dir}")

    print(f"Processing {input_file} with {max_workers} concurrent workers...")
    print(f"Retry settings: max_retries={max_retries}, initial_delay={initial_delay}s, backoff_factor={backoff_factor}")

    # Split the file into chunks
    print("Splitting file into chunks...")
    chunks = split_markdown_file(input_file)
    print(f"File split into {len(chunks)} chunks")

    # Load previous progress if exists
    previous_progress = load_progress(checkpoint_dir)
    completed_chunks = set()
    failed_chunks = set()

    if previous_progress:
        print(f"Found previous progress: {len(previous_progress['completed_chunks'])} completed, {len(previous_progress['failed_chunks'])} failed")
        completed_chunks = set(previous_progress['completed_chunks'])
        failed_chunks = set(previous_progress['failed_chunks'])

        # Verify existing chunk files
        verified_completed = set()
        for chunk_idx in completed_chunks:
            if load_chunk_result(checkpoint_dir, chunk_idx):
                verified_completed.add(chunk_idx)
            else:
                print(f"Warning: Chunk {chunk_idx + 1} marked as completed but file missing, will re-translate")
        completed_chunks = verified_completed

    # Determine which chunks need translation
    chunks_to_translate = []
    for i in range(len(chunks)):
        if i not in completed_chunks:
            chunks_to_translate.append(i)

    if not chunks_to_translate:
        print("All chunks already translated! Assembling final file...")
    else:
        print(f"Need to translate {len(chunks_to_translate)} chunks (resuming from previous session)")

        # Translate chunks concurrently while preserving order
        print("Starting concurrent translation...")
        translated_chunks = [None] * len(chunks)  # Pre-allocate list to preserve order

        # Load already completed chunks
        for i in completed_chunks:
            result = load_chunk_result(checkpoint_dir, i)
            if result:
                translated_chunks[i] = result

        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            # Submit only untranslated chunks
            future_to_index = {
                executor.submit(
                    translate_chunk,
                    chunks[i],
                    i + 1,
                    len(chunks),
                    checkpoint_dir,
                    max_retries,
                    initial_delay,
                    backoff_factor
                ): i
                for i in chunks_to_translate
            }

            # Collect results as they complete
            completed_count = len(completed_chunks)
            failed_count = len(failed_chunks)

            for future in as_completed(future_to_index):
                index = future_to_index[future]
                try:
                    translated_chunk = future.result()
                    translated_chunks[index] = translated_chunk

                    # Check if this was a failure (original chunk returned)
                    if translated_chunk == chunks[index]:
                        failed_count += 1
                        failed_chunks.add(index)
                        print(f"⚠️  Chunk {index + 1} failed translation, using original content")
                    else:
                        completed_chunks.add(index)

                    completed_count += 1
                    print(f"Progress: {completed_count}/{len(chunks)} chunks completed ({failed_count} failed)")

                    # Save progress periodically
                    save_progress(checkpoint_dir, len(chunks), completed_chunks, failed_chunks)

                except Exception as exc:
                    print(f"Chunk {index + 1} generated an exception: {exc}")
                    translated_chunks[index] = chunks[index]  # Use original chunk as fallback
                    failed_chunks.add(index)
                    failed_count += 1
                    completed_count += 1
                    save_progress(checkpoint_dir, len(chunks), completed_chunks, failed_chunks)

    # Load all translated chunks in correct order
    print("Assembling final translated file...")
    final_chunks = []
    for i in range(len(chunks)):
        result = load_chunk_result(checkpoint_dir, i)
        if result:
            final_chunks.append(result)
        else:
            print(f"Warning: Using original content for chunk {i + 1}")
            final_chunks.append(chunks[i])

        # Concatenate all translated chunks in correct order
    # Add proper spacing only before headings
    final_content = ''
    for i, chunk in enumerate(final_chunks):
        if i == 0:
            # First chunk, no prefix
            final_content += chunk
        else:
            # Check if this chunk starts with a heading
            chunk_lines = chunk.strip().split('\n')
            first_line = chunk_lines[0] if chunk_lines else ''
            is_heading = re.match(r'^#{1,6}\s+', first_line.strip())

            if is_heading:
                # Add spacing before headings
                if not final_content.endswith('\n\n'):
                    if final_content.endswith('\n'):
                        final_content += '\n'
                    else:
                        final_content += '\n\n'
            else:
                # For non-heading chunks, just ensure single newline if needed
                if not final_content.endswith('\n'):
                    final_content += '\n'

            final_content += chunk

    # Create output directory if it doesn't exist
    os.makedirs(os.path.dirname(output_file), exist_ok=True)

    # Write to output file
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(final_content)

    # Save final progress
    save_progress(checkpoint_dir, len(chunks), completed_chunks, failed_chunks)

    print(f"Translation completed! Output saved to {output_file}")
    print(f"Original file size: {os.path.getsize(input_file)} bytes")
    print(f"Translated file size: {os.path.getsize(output_file)} bytes")
    print(f"Summary: {len(completed_chunks)}/{len(chunks)} chunks successfully translated, {len(failed_chunks)} failed")
    print(f"Checkpoint directory: {checkpoint_dir}")

    if len(failed_chunks) == 0:
        print("🎉 All chunks translated successfully! You can safely delete the checkpoint directory.")
    else:
        print("⚠️  Some chunks failed. You can re-run the script to retry failed chunks.")

if __name__ == '__main__':
    main()
