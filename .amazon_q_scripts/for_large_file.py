#!/usr/bin/env python3
"""
Script to split a large markdown file into chunks, translate each chunk to Chinese
using q chat, and concatenate the results. Supports checkpoint/resume functionality.
"""

import os
import sys
import subprocess
import re
import tempfile
import json
import hashlib
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import threading
import time
import random

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
    Try to split at section boundaries (##, ###, etc.) when possible.
    """
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    chunks = []
    lines = content.split('\n')
    current_chunk = []
    current_size = 0

    i = 0
    while i < len(lines):
        line = lines[i]
        line_size = len(line) + 1  # +1 for newline

        # If adding this line would exceed max_chars, save current chunk
        if current_size + line_size > max_chars and current_chunk:
            chunks.append('\n'.join(current_chunk))
            current_chunk = []
            current_size = 0

        current_chunk.append(line)
        current_size += line_size
        i += 1

    # Add the last chunk if it has content
    if current_chunk:
        chunks.append('\n'.join(current_chunk))

    return chunks

def translate_chunk(chunk, chunk_num, total_chunks, checkpoint_dir, max_retries=5, initial_delay=1.0, backoff_factor=2.0):
    """
    Translate a single chunk using q chat command with retry logic.
    Saves result to checkpoint after successful translation.
    """
    thread_id = threading.current_thread().name

    # Check if chunk is already translated
    existing_result = load_chunk_result(checkpoint_dir, chunk_num - 1)
    if existing_result:
        print(f"[{thread_id}] Chunk {chunk_num}/{total_chunks} already translated, skipping...")
        return existing_result

    print(f"[{thread_id}] Translating chunk {chunk_num}/{total_chunks}...")

    for attempt in range(max_retries + 1):
        try:
            # Add small random delay to avoid thundering herd
            if attempt > 0:
                delay = initial_delay * (backoff_factor ** (attempt - 1))
                jitter = random.uniform(0.1, 0.3) * delay
                total_delay = delay + jitter
                print(f"[{thread_id}] Retry {attempt}/{max_retries} for chunk {chunk_num}, waiting {total_delay:.1f}s...")
                time.sleep(total_delay)

            # Prepare a more specific translation prompt
            prompt = f"""Translate the following markdown content to Chinese. Return ONLY the translated markdown content without any explanations, tool usage, or additional formatting:

{chunk}"""

            # Run q chat command
            cmd = [
                'q', 'chat', '--trust-all-tools', '--model', 'claude-3.5-sonnet',
                '--no-interactive', prompt
            ]

            result = subprocess.run(
                cmd,
                text=True,
                capture_output=True,
                encoding='utf-8',
                timeout=120  # 2 minute timeout
            )

            # Check output content for errors (q chat may return 0 even with errors)
            output_content = result.stdout.lower() + result.stderr.lower()

            print(output_content)

            # Check for quota/rate limit errors in output
            if any(keyword in output_content for keyword in ['quota has reached its limit', 'rate limit', 'too many requests', 'limit exceeded']):
                if attempt < max_retries:
                    print(f"[{thread_id}] Quota/rate limit detected in output for chunk {chunk_num}, attempt {attempt + 1}/{max_retries + 1}")
                    continue
                else:
                    print(f"[{thread_id}] Max retries reached for chunk {chunk_num} due to quota limits")
                    return chunk

            # Check for network/connection errors in output
            elif any(keyword in output_content for keyword in ['connection', 'network', 'timeout', 'dns', 'backtrace omitted']):
                if attempt < max_retries:
                    print(f"[{thread_id}] Network/system error detected in output for chunk {chunk_num}, attempt {attempt + 1}/{max_retries + 1}")
                    continue
                else:
                    print(f"[{thread_id}] Max retries reached for chunk {chunk_num} due to network/system errors")
                    return chunk

            # Check return code for other types of failures
            if result.returncode != 0:
                error_msg = result.stderr.lower()
                print(f"[{thread_id}] Non-zero return code for chunk {chunk_num}: {result.stderr}")
                if attempt < max_retries:
                    print(f"[{thread_id}] Retrying chunk {chunk_num} due to non-zero return code")
                    continue
                else:
                    return chunk

            # Clean the output
            translated = clean_output(result.stdout)

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

        except subprocess.TimeoutExpired:
            if attempt < max_retries:
                print(f"[{thread_id}] Timeout for chunk {chunk_num}, attempt {attempt + 1}/{max_retries + 1}")
                continue
            else:
                print(f"[{thread_id}] Max retries reached for chunk {chunk_num} due to timeouts")
                return chunk

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
    Clean the output from q chat command by removing ANSI codes and extracting content.
    """
    # Remove ANSI escape sequences
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    cleaned = ansi_escape.sub('', raw_output)

    # Remove common q chat formatting patterns
    lines = cleaned.split('\n')
    content_lines = []

    skip_patterns = [
        'Using tool:',
        '🛠️',
        '●',
        '⋮',
        'Path:',
        'I\'ll help translate',
        'I\'ll create',
        'Here\'s the translated',
        'The translation is:',
        'Here is the translation:',
        'Translation:',
        '.amazon_q_result/',
        '.amazon_a_logs/'
    ]

    in_content = False
    for line in lines:
        line = line.strip()

        # Skip empty lines at start
        if not in_content and not line:
            continue

        # Skip lines that match skip patterns
        if any(pattern in line for pattern in skip_patterns):
            continue

        # Skip lines with only numbers and colons (line numbers)
        if re.match(r'^\s*\d+\s*[,:]\s*\d*\s*[:]\s*$', line):
            continue

        # Skip lines that look like status messages
        if line.startswith('[') and ']' in line:
            continue

        # If we find a markdown-like line, we're in content
        if line.startswith('#') or line.startswith('---') or line.startswith('`') or len(line) > 10:
            in_content = True

        if in_content:
            content_lines.append(line)

    # Join and clean up extra whitespace
    result = '\n'.join(content_lines)

    # Remove excessive empty lines
    result = re.sub(r'\n\s*\n\s*\n', '\n\n', result)

    return result.strip()

def main():
    input_file = 'system-variables.md'
    output_file = 'system-variables-zh-cn-concurrent.md'
    max_workers = 1  # Reduced to avoid quota limits
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
    final_content = '\n\n'.join(final_chunks)

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
