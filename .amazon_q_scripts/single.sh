#!/bin/bash

get_next_file() {
    grep "^\- \[ \] \`" .translation_progress.md | head -n 1 | grep -o '`[^`]*`' | sed 's/`//g'
}

next_file=$(get_next_file)

echo "Next file: $next_file"

prompt=$(printf "You are Translation Agent. Translate this file: %q. Save output to .amazon_q_result/%q. If it is too large, split it into multiple chunks and translate one chunk at a time, then save the output with a progress indicator like '<----line 123----->', then continue to translate the next chunk, use the progress indicator to learn where you should start for the next chunk, and replace old indicator with the new content and new indicator to the file." "$next_file" "$next_file")

echo "$prompt"