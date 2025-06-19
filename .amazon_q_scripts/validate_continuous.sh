#!/bin/bash

# Simplified monitoring script that checks for translated file existence and validates them with AI.
MAIN_LOG=".amazon_q_logs/translation_system.log"
COMPLETION_LOG=".amazon_q_logs/completions.log"
VALIDATION_LOG=".amazon_q_logs/validation.log"

echo "=== AI-Powered Validation Monitoring Started $(date) ===" | tee -a $MAIN_LOG

# Function to mark a file as completed in the progress file.
# It now operates on files that were marked for validation.
mark_file_completed() {
    local file_path=$1
    local status=$2  # "✅", "❌", etc.

    if [ -z "$file_path" ]; then
        echo "$(date): [ERROR] Attempted to mark an empty file path as completed. Skipping." | tee -a $MAIN_LOG
        return
    fi

    local temp_progress_file=".translation_progress.md.tmp"
    local escaped_path=$(printf '%s\n' "$file_path" | sed 's/[][\.^$*]/\\&/g')

    local new_line
    if [ "$status" == "✅" ]; then
        # On success, mark with a check and a peace sign, so we know not to check it again.
        new_line="- [x] \`${file_path}\` ${status} ✌️"
    else
        # On failure, just mark with a cross. It will be picked up in the next run.
        new_line="- [x] \`${file_path}\` ${status}"
    fi

    # Atomically update the progress file. It finds the line marked with `[>]` (validating).
    if grep -q "^\- \[>\] \`${escaped_path}\`" .translation_progress.md; then
        sed "s|^\- \[>\] \`${escaped_path}\`.*$|${new_line}|" .translation_progress.md > "$temp_progress_file" && mv "$temp_progress_file" .translation_progress.md
        echo "$(date): $status $file_path" >> $COMPLETION_LOG
    else
        echo "$(date): [WARN] Could not find file '$file_path' marked with '[>]' to update its status to '$status'." | tee -a $MAIN_LOG
    fi
}

# Main monitoring loop
while true; do
    echo "---" | tee -a $MAIN_LOG
    echo "$(date): [CYCLE START] Checking for work..." | tee -a $MAIN_LOG

    # Find the next file that doesn't have ✅ ✌️ completion markers or ❌ failure markers
    file_to_check=$(grep "^\- \[[ x>]\] \`" .translation_progress.md | grep -v "✅📏$" | grep -v "✅ ✌️$" | grep -v "❌$" | head -n 1 | sed 's/^\- \[[ x>]\] \`//;s/\`.*$//')

    if [ -z "$file_to_check" ]; then
        echo "$(date): [COMPLETE] No more unprocessed files found. All files have been processed. Exiting." | tee -a $MAIN_LOG
        break
    fi

    echo "$(date): [FOUND] Pending file: '$file_to_check'. Checking for translation..." | tee -a $MAIN_LOG
    translated_file_path=".amazon_q_result/${file_to_check}"

    if [ -f "$translated_file_path" ]; then
        echo "$(date): [LOCKING] Found '$translated_file_path'. Locking for validation." | tee -a $MAIN_LOG
        # Lock the file by marking it for validation, regardless of current state [ ] or [x].
        escaped_path=$(printf '%s\n' "$file_to_check" | sed 's/[][\.^$*]/\\&/g')
        sed -i.bak "s|^\- \[[ x]\] \`${escaped_path}\`.*$|- [>] \`${escaped_path}\` (Validating...)|" .translation_progress.md
        rm .translation_progress.md.bak

        if [ -s "$translated_file_path" ]; then # Check if file has content
            # Check if file has more than 1000 lines
            original_lines=$(wc -l < "$file_to_check" 2>/dev/null || echo 0)

            if [ "$original_lines" -gt 200 ]; then
                echo "$(date): [LINE-CHECK] File '$file_to_check' has $original_lines lines (>200). Using line count validation." | tee -a $MAIN_LOG

                translated_lines=$(wc -l < "$translated_file_path" 2>/dev/null || echo 0)

                if [ "$original_lines" -eq "$translated_lines" ]; then
                    echo "$(date): [PASS] Line count validation PASSED for '$file_to_check'. Lines: $original_lines = $translated_lines" | tee -a $MAIN_LOG
                    mark_file_completed "$file_to_check" "✅📏"
                else
                    echo "$(date): [FAIL] Line count validation FAILED for '$file_to_check'. Original: $original_lines, Translated: $translated_lines" | tee -a $MAIN_LOG
                    mark_file_completed "$file_to_check" "❌"
                fi
            else
                echo "$(date): [VALIDATING] File '$file_to_check' has $original_lines lines (≤200). Starting AI validation." | tee -a $MAIN_LOG

                VALIDATION_PROMPT="You are a translation validation agent. Read instructions at .amazon_q_context/validation_agent.md. Validate the translation in '${translated_file_path}' against the original source file '${file_to_check}'. If the quality is good, respond ONLY with the text 'Validation passed.'. If not, respond ONLY with 'Validation failed.' and a brief, one-line reason."

                # Run AI validation
                validation_output=$(q chat --no-interactive --trust-all-tools --model claude-3.5-sonnet "$VALIDATION_PROMPT")
                echo "$(date): [AI-RESPONSE] Raw output for '$file_to_check': $validation_output" >> $VALIDATION_LOG

                if echo "$validation_output" | grep -q "Validation passed."; then
                    echo "$(date): [PASS] AI validation PASSED for '$file_to_check'." | tee -a $MAIN_LOG
                    mark_file_completed "$file_to_check" "✅"
                else
                    failure_reason=$(echo "$validation_output" | sed 's/Validation failed. //')
                    echo "$(date): [FAIL] AI validation FAILED for '$file_to_check'. Reason: $failure_reason" | tee -a $MAIN_LOG
                    mark_file_completed "$file_to_check" "❌"
                fi
            fi
        else
            echo "$(date): [FAIL] Found file '$translated_file_path' but it is EMPTY. Marking as failed." | tee -a $MAIN_LOG
            mark_file_completed "$file_to_check" "❌"
        fi

        # --- Progress Report Generation after a file is processed ---
        echo "$(date): [REPORT] Generating progress report." | tee -a $MAIN_LOG
        TOTAL_FILES_REPORT=$(grep -c "^\- \[[ x>]\] \`" .translation_progress.md)
        COMPLETED_REPORT=$(grep -c "✌️$" .translation_progress.md)
        REMAINING=$((TOTAL_FILES_REPORT - COMPLETED_REPORT))
        if [ "$REMAINING" -lt 0 ]; then REMAINING=0; fi

        if [ "$TOTAL_FILES_REPORT" -gt 0 ]; then
            progress_perc=$(( COMPLETED_REPORT * 100 / TOTAL_FILES_REPORT ))
        else
            progress_perc=0
        fi

        cat > .amazon_q_logs/progress_report.md << EOF
# Translation Progress Report
Generated: $(date)

## Overall Progress
- Total files: $TOTAL_FILES_REPORT
- Completed: $COMPLETED_REPORT
- Remaining: $REMAINING
- Progress: ${progress_perc:-0}%

## Recent Activity
$(tail -n 20 $COMPLETION_LOG)
EOF

    else
        echo "$(date): [FAIL] Translated file for '$file_to_check' not found. Marking as failed and moving to next." | tee -a $MAIN_LOG

        # Lock the file by marking it for validation first
        escaped_path=$(printf '%s\n' "$file_to_check" | sed 's/[][\.^$*]/\\&/g')
        sed -i.bak "s|^\- \[[ x]\] \`${escaped_path}\`.*$|- [>] \`${escaped_path}\` (Validating...)|" .translation_progress.md
        rm .translation_progress.md.bak

        # Mark as failed
        mark_file_completed "$file_to_check" "❌"
    fi

    echo "$(date): [CYCLE END] Finished processing. Next check in 3s." | tee -a $MAIN_LOG
    sleep 3
done

echo "=== Monitoring Script Exited Gracefully $(date) ===" | tee -a $MAIN_LOG
