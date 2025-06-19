#!/bin/bash

# Continuous Translation System
# This script sets up a translation system that will continuously process
# all files in .translation_progress.md until completion

echo "=== CONTINUOUS TRANSLATION SYSTEM STARTING ==="

# Setup directories
mkdir -p .amazon_q_result .amazon_q_logs .amazon_q_logs/agent_files

# Initialize log files
MAIN_LOG=".amazon_q_logs/translation_system.log"
ASSIGNMENT_LOG=".amazon_q_logs/assignments.log"
COMPLETION_LOG=".amazon_q_logs/completions.log"

echo "=== Translation System Log $(date) ===" > $MAIN_LOG
echo "=== File Assignments Log $(date) ===" > $ASSIGNMENT_LOG
echo "=== File Completions Log $(date) ===" > $COMPLETION_LOG

# Get total files to translate
TOTAL_FILES=$(grep -v "^#" .translation_progress.md | grep -v "^$" | grep -o '`[^`]*`' | wc -l)
echo "Found $TOTAL_FILES files to translate" | tee -a $MAIN_LOG

# On startup, count how many files are already marked as completed
COMPLETED_FILES=$(grep "^\- \[x\]" .translation_progress.md | wc -l)
echo "Found $COMPLETED_FILES already completed files." | tee -a $MAIN_LOG
echo "$COMPLETED_FILES" > .amazon_q_logs/completed_count.txt

# Set number of agents (1 monitor + 5 translation agents = 6 panes total)
NUM_AGENTS=5
echo "Starting $NUM_AGENTS concurrent translation agents" | tee -a $MAIN_LOG

# Function to get the next untranslated file
# This function finds the first file in the progress file that is not marked with '[x]'
get_next_file() {
    grep "^\- \[ \] \`" .translation_progress.md | head -n 1 | grep -o '`[^`]*`' | sed 's/`//g'
}

# Function to mark a file as completed in the progress file
mark_file_completed() {
    local file_path=$1
    local status=$2  # "✅", "⚠️", or "❌"

    # Update the progress file - change checkbox to [x] and add status emoji
    sed -i.bak "s|^\- \[ \] \`${file_path}\`$|\- \[x\] \`${file_path}\` ${status}|" .translation_progress.md

    # Update completion count
    local completed=$(cat .amazon_q_logs/completed_count.txt)
    echo "$((completed+1))" > .amazon_q_logs/completed_count.txt

    echo "$(date): $status $file_path" >> $COMPLETION_LOG
}

# Kill any existing tmux session
tmux has-session -t translation_system 2>/dev/null && tmux kill-session -t translation_system

# Create tmux session with 3x2 pane layout
tmux new-session -d -s translation_system

# Create 3x2 layout (6 panes: 1 monitor + 5 translation agents)
# Split horizontally to get 2 columns
tmux split-window -h

# Split left column vertically twice to get 3 rows
tmux select-pane -t 0
tmux split-window -v
tmux split-window -v

# Split right column vertically twice to get 3 rows
tmux select-pane -t 3
tmux split-window -v
tmux split-window -v

# Get pane IDs - layout will be:
# [0] [3]
# [1] [4]
# [2] [5]
PANES=(0 1 2 3 4 5)

# wait for panes to be created
sleep 3
echo "Created 6 panes in 3x2 layout: pane 0 (monitor) + panes 1-5 (translation agents)" | tee -a $MAIN_LOG

# Start q chat in translation agent panes (skip pane 0 for monitor)
for i in $(seq 1 $NUM_AGENTS); do
    tmux send-keys -t ${PANES[$i]} "q chat --trust-all-tools --model claude-3.5-sonnet" C-m
    sleep 3
done

# Assign initial files to agents (skip pane 0)
for i in $(seq 1 $NUM_AGENTS); do
    next_file=$(get_next_file)
    if [ -n "$next_file" ]; then
        # IMPORTANT: Mark file as in-progress to prevent other agents from picking it up
        sed -i.bak "s|^\- \[ \] \`${next_file}\`$|\- \[>\] \`${next_file}\`|" .translation_progress.md

        # Create output directory if needed
        mkdir -p ".amazon_q_result/$(dirname "$next_file")"

        # Record what this agent is working on
        echo "$next_file" > ".amazon_q_logs/agent_files/agent_${i}.txt"

        # Assign translation task
        prompt=$(printf "You are Translation Agent %s. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$i" "$next_file" "$next_file" "$next_file")
        tmux send-keys -t ${PANES[$i]} "$prompt" C-m

        echo "$(date): Assigned $next_file to agent $i" | tee -a $ASSIGNMENT_LOG
    else
        echo "No initial files to assign to agent $i" | tee -a $MAIN_LOG
    fi
done

# Start the monitoring script in pane 0 (monitor pane)
tmux send-keys -t 0 "clear && echo 'Monitor Starting...' && ./.amazon_q_logs/monitor_continuous.sh" C-m

echo "=== CONTINUOUS TRANSLATION SYSTEM STARTED ==="
echo "Attach to the session with: tmux attach -t translation_system"
echo "Pane layout (3x2):"
echo "  [0 Monitor] [3 Agent]"
echo "  [1 Agent  ] [4 Agent]"
echo "  [2 Agent  ] [5 Agent]"
echo "Switch between panes with: Ctrl+B then arrow keys"
echo "To detach without stopping: Ctrl+B then D"
echo "Progress report available at: .amazon_q_logs/progress_report.md"
echo "System will continue running until all files are translated"
