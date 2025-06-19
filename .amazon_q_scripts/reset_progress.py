#!/usr/bin/env python3
import os
import re

# Path to the progress file
progress_file = '.translation_progress.md'
result_dir = '.amazon_q_result'

# Read the progress file
with open(progress_file, 'r') as f:
    lines = f.readlines()

# Create a list to store modified lines
modified_lines = []
changes_made = 0

# Process each line
for line in lines:
    # Check if the line has [>] or [x] status
    if line.strip().startswith('- [>]') or line.strip().startswith('- [x]'):
        # Extract the filename
        match = re.search(r'`([^`]+)`', line)
        if match:
            filename = match.group(1)
            # Check if the file exists in the result directory
            result_file = os.path.join(result_dir, filename)
            if not os.path.exists(result_file):
                # Reset the status to [ ] and remove specific emojis
                modified_line = line.replace('- [>]', '- [ ]').replace('- [x]', '- [ ]')
                # Remove only ✅ and ✌️ emojis at the end
                modified_line = re.sub(r'\s*[✅✌️]+\s*$', '\n', modified_line)
                modified_lines.append(modified_line)
                changes_made += 1
                print(f"Resetting: {filename}")
            else:
                modified_lines.append(line)
        else:
            modified_lines.append(line)
    else:
        modified_lines.append(line)

# Write the modified content back to the file
with open(progress_file, 'w') as f:
    f.writelines(modified_lines)

print(f"\nDone! Reset {changes_made} files from [>] or [x] to [ ]")