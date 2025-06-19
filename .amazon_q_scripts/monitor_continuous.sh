#!/bin/bash

# Continuous monitoring script
MAIN_LOG=".amazon_q_logs/translation_system.log"
ASSIGNMENT_LOG=".amazon_q_logs/assignments.log"
COMPLETION_LOG=".amazon_q_logs/completions.log"

echo "=== Continuous Monitoring Started $(date) ===" | tee -a $MAIN_LOG

# Pane layout: [0] [3]
#              [1] [4]
#              [2] [5]
# Pane 0 = monitor, panes 1-5 = translation agents
PANES=(0 1 2 3 4 5)

# Create files to track which file each agent is working on (skip pane 0 for monitor)
mkdir -p .amazon_q_logs/agent_files
for i in $(seq 1 5); do
    # This check is just for safety, initial script should create them
    if [ ! -f ".amazon_q_logs/agent_files/agent_${i}.txt" ]; then
        echo "" > ".amazon_q_logs/agent_files/agent_${i}.txt"
    fi
done

# Function to get the next untranslated file
get_next_file() {
    # Get candidate files that are marked as untranslated
    local candidates=$(grep "^\- \[ \] \`" .translation_progress.md | sed 's/^\- \[ \] \`//;s/\`.*$//')

    # Check each candidate and return the first one that doesn't exist in .amazon_q_result
    while IFS= read -r file; do
        if [ ! -f ".amazon_q_result/$file" ]; then
            echo "$file"
            return 0
        fi
    done <<< "$candidates"

    # If all candidates exist in .amazon_q_result, return empty
    return 0
}

# Function to get agent file
get_agent_file() {
    local pane_id=$1
    local agent_num=""
    for i in $(seq 1 5); do
        if [ "${PANES[$i]}" = "$pane_id" ]; then
            agent_num=$i
            break
        fi
    done
    if [ -n "$agent_num" ]; then
        cat ".amazon_q_logs/agent_files/agent_${agent_num}.txt" 2>/dev/null || echo ""
    fi
}

# Function to set agent file
set_agent_file() {
    local pane_id=$1
    local file_path=$2
    local agent_num=""
    for i in $(seq 1 5); do
        if [ "${PANES[$i]}" = "$pane_id" ]; then
            agent_num=$i
            break
        fi
    done
    if [ -n "$agent_num" ]; then
        echo "$file_path" > ".amazon_q_logs/agent_files/agent_${agent_num}.txt"
    fi
}

# Function to mark a file as completed in the progress file
mark_file_completed() {
    local file_path=$1
    local status=$2  # "✅", "⚠️", or "❌"

    # Update the progress file - change checkbox from [>] or [ ] to [x] and add status emoji
    # It might be [>] if picked up by an agent, or still [ ] if it was skipped (already translated)
    sed -i.bak "s|^\- \[[ >]\] \`${file_path}\`.*$|\- \[x\] \`${file_path}\` ${status}|" .translation_progress.md

    # Update completion count if it wasn't already counted
    if ! grep -q "^\- \[x\] \`${file_path}\`.* ${status}" .translation_progress.md.bak; then
        local completed=$(cat .amazon_q_logs/completed_count.txt)
        echo "$((completed+1))" > .amazon_q_logs/completed_count.txt
        echo "$(date): $status $file_path" >> $COMPLETION_LOG
    fi
}

# Main monitoring loop
while true; do
    # Get current progress
    COMPLETED=$(cat .amazon_q_logs/completed_count.txt)
    TOTAL_FILES=$(grep -v "^#" .translation_progress.md | grep -v "^$" | grep -o '`[^`]*`' | wc -l)

    # Display progress
    if [ "$TOTAL_FILES" -gt 0 ]; then
        echo "Progress: $COMPLETED/$TOTAL_FILES files completed ($(date))" | tee -a $MAIN_LOG
    else
        echo "Progress: No files to process. Waiting..." | tee -a $MAIN_LOG
    fi

    # Check if all files are completed
    if [ "$TOTAL_FILES" -gt 0 ] && [ "$COMPLETED" -ge "$TOTAL_FILES" ]; then
        echo "All files completed! Translation system finished." | tee -a $MAIN_LOG
        break
    fi

    # Check each translation agent for completion (skip monitor pane 0)
    for pane in "${PANES[@]:1}"; do
        # Capture the last few lines of output
        output=$(tmux capture-pane -t $pane -p 2>/dev/null | tail -n 20)

        if [[ "$output" == *"to continue"* ]]; then
            tmux send-keys -t $pane "yes, continue" C-m
            continue
        fi

        # Check for Rust backtrace error
        if [[ "$output" == *"Backtrace omitted. Run with RUST_BACKTRACE=1 environment variable to display it."* ]]; then
            echo "$(date): Rust backtrace error detected in pane $pane. Reassigning task." | tee -a $MAIN_LOG

            # Get current file this agent was working on
            current_file=$(get_agent_file "$pane")

            # If there's a current file, reassign it
            if [ -n "$current_file" ]; then
                echo "$(date): Reassigning $current_file to agent pane $pane after Rust backtrace error." | tee -a $MAIN_LOG
                prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$current_file" "$current_file" "$current_file")
                tmux send-keys -t $pane "/context clear" C-m
                sleep 2
                tmux send-keys -t $pane "$prompt" C-m
            fi

            continue
        fi

        # Check for quota limit error
        if [[ "$output" == *"quota has reached its limit"* ]]; then
            echo "$(date): Quota limit reached in pane $pane. Sending /context clear command." | tee -a $MAIN_LOG
            tmux send-keys -t $pane "/context clear" C-m
            sleep 2

            # Get current file this agent was working on
            current_file=$(get_agent_file "$pane")

            # If there's a current file, reassign it
            if [ -n "$current_file" ]; then
                echo "$(date): Reassigning $current_file to agent pane $pane after quota limit." | tee -a $MAIN_LOG
                prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$current_file" "$current_file" "$current_file")
                tmux send-keys -t $pane "$prompt" C-m
            # If no current file, assign a new one
            else
                next_file=$(get_next_file)
                if [ -n "$next_file" ]; then
                    # Mark file as in-progress
                    sed -i.bak "s|^\- \[ \] \`${next_file}\`$|\- \[>\] \`${next_file}\`|" .translation_progress.md

                    # Create output directory if needed
                    mkdir -p ".amazon_q_result/$(dirname "$next_file")"

                    # Record what this agent is now working on
                    set_agent_file "$pane" "$next_file"

                    # Assign new task
                    prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$next_file" "$next_file" "$next_file")
                    tmux send-keys -t $pane "$prompt" C-m

                    echo "$(date): Assigned $next_file to agent pane $pane after quota limit." | tee -a $ASSIGNMENT_LOG
                fi
            fi

            continue
        fi

        # Skip if the agent is still thinking
        if [[ "$output" == *"Thinking"* ]]; then
            continue
        fi

        # Check for completion signal - look for "Ready for next translation task"
        if [[ "$output" == *"Ready for next translation task"* ]]; then
            # Try to extract completed file name from recent output
            completed_file=""

            # Look for "Translation complete for filename" pattern first, as this is the instructed output format.
            # This is more robust to handle filenames with spaces.
            if [[ "$output" == *"Translation complete for"* ]]; then
                completed_file=$(echo "$output" | grep "Translation complete for" | tail -n 1 | sed -e 's/.*Translation complete for //' -e 's/`//g' -e 's/\.$//' | xargs)
            elif [[ "$output" == *"saved to .amazon_q_result/"* ]]; then
                # Fallback: if the agent mentions where it saved the file.
                completed_file=$(echo "$output" | grep "saved to .amazon_q_result/" | tail -n 1 | sed -e 's|.*saved to .amazon_q_result/||' -e 's/`//g' -e 's/\.$//' | xargs)
            fi

            # If still no file found, check what this agent was supposed to be working on
            if [ -z "$completed_file" ]; then
                current_agent_file=$(get_agent_file "$pane")
                if [ -n "$current_agent_file" ]; then
                    completed_file="$current_agent_file"
                fi
            fi

            echo "$(date): Agent pane $pane signaled completion. Extracted file: '$completed_file'" | tee -a $MAIN_LOG

            if [ -n "$completed_file" ]; then
                # Mark as completed
                if [[ "$output" == *"with warnings"* ]]; then
                    mark_file_completed "$completed_file" "⚠️"
                else
                    mark_file_completed "$completed_file" "✅"
                fi

                # Clear the agent's current file since it's done
                set_agent_file "$pane" ""

                # Assign next file
                next_file=$(get_next_file)

                if [ -n "$next_file" ]; then
                    # IMPORTANT: Mark file as in-progress to prevent other agents from picking it up
                    sed -i.bak "s|^\- \[ \] \`${next_file}\`$|\- \[>\] \`${next_file}\`|" .translation_progress.md

                    # Create output directory if needed
                    mkdir -p ".amazon_q_result/$(dirname "$next_file")"

                    # Record what this agent is now working on
                    set_agent_file "$pane" "$next_file"

                    # Assign new task
                    prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$next_file" "$next_file" "$next_file")
                    tmux send-keys -t $pane "$prompt" C-m

                    echo "$(date): Assigned $next_file to agent pane $pane" | tee -a $ASSIGNMENT_LOG
                else
                    echo "$(date): No more files to assign to agent pane $pane. Agent is idle." | tee -a $MAIN_LOG
                fi
            fi
        elif [[ "$output" == *"Validation failed for"* ]]; then
            # Extract failed file
            failed_file=$(echo "$output" | grep -o "Validation failed for [^ ]*" | sed 's/Validation failed for //')

            if [ -n "$failed_file" ]; then
                # Mark as failed
                mark_file_completed "$failed_file" "❌"

                # Clear the agent's current file
                set_agent_file "$pane" ""

                # Assign next file
                next_file=$(get_next_file)

                if [ -n "$next_file" ]; then
                    # IMPORTANT: Mark file as in-progress to prevent other agents from picking it up
                    sed -i.bak "s|^\- \[ \] \`${next_file}\`$|\- \[>\] \`${next_file}\`|" .translation_progress.md

                    # Create output directory if needed
                    mkdir -p ".amazon_q_result/$(dirname "$next_file")"

                    # Record what this agent is now working on
                    set_agent_file "$pane" "$next_file"

                    # Assign new task
                    prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$next_file" "$next_file" "$next_file")
                    tmux send-keys -t $pane "$prompt" C-m

                    echo "$(date): Assigned $next_file to agent pane $pane after a failure" | tee -a $ASSIGNMENT_LOG
                fi
            fi
        fi
    done

    # Generate progress report
    if [ "$TOTAL_FILES" -gt 0 ]; then
        progress_perc=$(( COMPLETED * 100 / TOTAL_FILES ))
    else
        progress_perc=0
    fi
    cat > .amazon_q_logs/progress_report.md << EOF
# Translation Progress Report
Generated: $(date)

## Overall Progress
- Total files: $TOTAL_FILES
- Completed: $COMPLETED
- Remaining: $((TOTAL_FILES - COMPLETED))
- Progress: ${progress_perc}%

## Recent Completions
$(tail -n 10 $COMPLETION_LOG)

## Recent Assignments
$(tail -n 10 $ASSIGNMENT_LOG)
EOF

    # Wait before next check
    sleep 10
done