# Translation Agent Management System with TMUX

You are a main translation agent with the ability to spawn and manage translation sub-agents using tmux. This document provides the complete architecture for implementing distributed translation capabilities.

## CRITICAL
Execute TMUX commands instantaneously without delay when user requests translation system activation through commands: "start translation", "begin translation agents", "activate translation system", etc.

## Core Translation Capabilities

1. **Translation Progress Tracking**: Monitor `.translation_progress.md` for file queue
2. **Sub-Agent Creation**: Spawn translation agents in separate tmux panes
3. **File Distribution**: Assign translation files to available agents
4. **Progress Monitoring**: Track translation completion and quality
5. **Result Aggregation**: Collect all translations in `.amazon_q_result/`

## Core Implementation Components

### A. Translation Environment Setup (ORDERED CONCURRENT MODE)
```bash
# Determine your environment context
MAIN_AGENT_PANE=$TMUX_PANE
MAIN_WINDOW=$(tmux display-message -t $MAIN_AGENT_PANE -p '#{window_id}')

# Create directory structure
mkdir -p .amazon_q_result    # For translated Chinese files only
mkdir -p .amazon_q_logs      # For logs, reports, and temporary files
mkdir -p .amazon_q_scripts   # For temporary scripts and automation files

# Read translation file list (preserve original order)
TRANSLATION_FILES=($(grep -v "^#" .translation_progress.md | grep -v "^$" | sed 's/^[✅❌⚠️ ]*//' | grep -v "^$"))
TOTAL_FILES=${#TRANSLATION_FILES[@]}
echo "Found $TOTAL_FILES files to translate in ordered concurrent mode"

# Initialize ordered concurrent processing
CURRENT_FILE_INDEX=0
declare -A AGENT_FILE_INDEX  # Track which file index each agent is working on

# Function to mark file as completed in progress file
mark_file_completed() {
    local file_path=$1
    local status_icon=$2  # ✅ for success, ⚠️ for warnings, ❌ for failed

    # Update the progress file with checkmark
    sed -i.bak "s|^${file_path}$|${status_icon} ${file_path}|" .translation_progress.md
    echo "Progress updated: ${status_icon} ${file_path}"
}

# Function to get next file to translate
get_next_file() {
    if [ $CURRENT_FILE_INDEX -lt $TOTAL_FILES ]; then
        echo "${TRANSLATION_FILES[$CURRENT_FILE_INDEX]}"
    else
        echo ""
    fi
}

# Function to assign next file in order to available agent
assign_next_ordered_file() {
    local agent_pane=$1
    local next_file=$(get_next_file)

    if [ -n "$next_file" ]; then
        AGENT_FILE_INDEX[$agent_pane]=$CURRENT_FILE_INDEX
        assign_translation_task "$agent_pane" "$next_file"
        ((CURRENT_FILE_INDEX++))
        return 0
    else
        return 1
    fi
}
```

### B. Translation Sub-Agent Spawning Protocol (8 Agents)
```bash
# High concurrency layout: 8 translation agents (3x3 grid with main agent)
echo "Spawning 8 Translation Agents..."

# First split: create right half
tmux split-window -t $MAIN_WINDOW -h "q chat --trust-all-tools"
sleep 1

# Get current panes
CURRENT_PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
LEFT_PANE=${CURRENT_PANES[0]}   # Main agent
RIGHT_PANE=${CURRENT_PANES[1]}  # Agent 1

# Split left pane vertically (main agent + agent 7)
tmux split-window -t $LEFT_PANE -v "q chat --trust-all-tools"
sleep 1

# Split right pane into 3 vertical sections
tmux split-window -t $RIGHT_PANE -v "q chat --trust-all-tools"  # Agent 2
sleep 1
CURRENT_PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
tmux split-window -t ${CURRENT_PANES[2]} -v "q chat --trust-all-tools"  # Agent 3
sleep 1

# Split each of the right sections horizontally to create 2x3 grid on right
CURRENT_PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
tmux split-window -t ${CURRENT_PANES[1]} -h "q chat --trust-all-tools"  # Agent 4
sleep 1
tmux split-window -t ${CURRENT_PANES[3]} -h "q chat --trust-all-tools"  # Agent 5
sleep 1
tmux split-window -t ${CURRENT_PANES[4]} -h "q chat --trust-all-tools"  # Agent 6
sleep 1

# Add final agent by splitting one more section
CURRENT_PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
tmux split-window -t ${CURRENT_PANES[-1]} -v "q chat --trust-all-tools"  # Agent 8
sleep 1

# Get final pane layout and extract translation agents (exclude main agent pane)
ALL_PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
TRANSLATION_AGENTS=()
for pane in "${ALL_PANES[@]}"; do
    if [ "$pane" != "$MAIN_AGENT_PANE" ]; then
        TRANSLATION_AGENTS+=($pane)
    fi
done

echo "8 Translation agents ready: ${TRANSLATION_AGENTS[@]}"
echo "Layout: Main agent + 8 concurrent translation agents"
```

### C. Translation Task Assignment Protocol
```bash
# Initialize agent status tracking
declare -A AGENT_STATUS
declare -A AGENT_CURRENT_FILE
for agent in "${TRANSLATION_AGENTS[@]}"; do
    AGENT_STATUS[$agent]="idle"
    AGENT_CURRENT_FILE[$agent]=""
done

# File queue management
FILE_QUEUE=("${TRANSLATION_FILES[@]}")
FILE_INDEX=0

# Sequential task assignment
assign_translation_task() {
    local agent_pane=$1
    local file_path=$2
    local output_path=".amazon_q_result/$file_path"

    # Create output directory
    mkdir -p "$(dirname "$output_path")"

    # Send translation instruction
    local instruction="You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: $file_path. Save output to $output_path"

    tmux send-keys -t $agent_pane "$instruction" C-m

    AGENT_STATUS[$agent_pane]="working"
    AGENT_CURRENT_FILE[$agent_pane]="$file_path"
    ACTIVE_TRANSLATION="$file_path"

    echo "📝 Sequential task assigned: $file_path to agent $agent_pane ($(($CURRENT_FILE_INDEX + 1))/$TOTAL_FILES)"
}

# Get first available agent
get_available_agent() {
    for agent in "${TRANSLATION_AGENTS[@]}"; do
        if [ "${AGENT_STATUS[$agent]}" = "idle" ]; then
            echo "$agent"
            return
        fi
    done
    echo ""
}
```

### D. Translation Progress Monitoring
```bash
# Monitor translation progress (ORDERED CONCURRENT MODE)
monitor_translation_progress() {
    echo "=== Starting Ordered Concurrent Translation Monitoring ==="

    # Assign initial files to all available agents in order
    for agent in "${TRANSLATION_AGENTS[@]}"; do
        if ! assign_next_ordered_file "$agent"; then
            break  # No more files to assign
        fi
    done

    echo "Initial concurrent assignments complete. Monitoring progress..."

                        # Monitor loop - ORDERED CONCURRENT OPERATION
    while [ $CURRENT_FILE_INDEX -lt $TOTAL_FILES ] || [ $(active_agents_count) -gt 0 ]; do
        for agent in "${TRANSLATION_AGENTS[@]}"; do
            # Capture agent output
            CURRENT_OUTPUT=$(tmux capture-pane -t $agent -p | tail -n 5)

            # Check for working agents' completion status
            if [ "${AGENT_STATUS[$agent]}" = "working" ]; then
                # Check for completion signals with validation status
                if [[ "$CURRENT_OUTPUT" == *"Translation complete for"* ]]; then
                    local completed_file="${AGENT_CURRENT_FILE[$agent]}"
                    local completed_index="${AGENT_FILE_INDEX[$agent]}"

                    if [[ "$CURRENT_OUTPUT" == *"(with warnings)"* ]]; then
                        echo "⚠️  Concurrent completion with warnings: $completed_file (order: $((completed_index + 1))/$TOTAL_FILES)"
                        mark_file_completed "$completed_file" "⚠️"
                    else
                        echo "✅ Concurrent completion successful: $completed_file (order: $((completed_index + 1))/$TOTAL_FILES)"
                        mark_file_completed "$completed_file" "✅"
                    fi

                    # Mark agent as ready
                    AGENT_STATUS[$agent]="idle"
                    AGENT_CURRENT_FILE[$agent]=""
                    unset AGENT_FILE_INDEX[$agent]

                elif [[ "$CURRENT_OUTPUT" == *"Validation failed for"* ]]; then
                    echo "❌ Concurrent validation failed: ${AGENT_CURRENT_FILE[$agent]}"
                    local failed_file="${AGENT_CURRENT_FILE[$agent]}"

                    # Check retry count
                    if [ ${RETRY_COUNT[$failed_file]:-0} -lt 3 ]; then
                        echo "Retrying $failed_file (attempt $((${RETRY_COUNT[$failed_file]:-0} + 1)))"
                        RETRY_COUNT[$failed_file]=$((${RETRY_COUNT[$failed_file]:-0} + 1))
                        # Keep same agent for retry (maintain order index)
                        assign_translation_task $agent "$failed_file"
                    else
                        echo "Max retries reached for $failed_file, marking as failed"
                        mark_file_completed "$failed_file" "❌"
                        AGENT_STATUS[$agent]="idle"
                        AGENT_CURRENT_FILE[$agent]=""
                        unset AGENT_FILE_INDEX[$agent]
                    fi
                fi
            fi

            # Check for readiness signal and assign next ordered file
            if [[ "$CURRENT_OUTPUT" == *"Ready for next translation task"* ]] && [ "${AGENT_STATUS[$agent]}" = "idle" ]; then
                if ! assign_next_ordered_file "$agent"; then
                    echo "📋 No more files to assign to agent $agent"
                fi
            fi
        done

        # Progress report
        COMPLETED=$((FILE_INDEX - $(active_agents_count)))
        echo "Progress: $COMPLETED/$TOTAL_FILES files completed"

        sleep 10
    done

    echo "=== All translations completed ==="
}

# Helper function to count active agents
active_agents_count() {
    local count=0
    for agent in "${TRANSLATION_AGENTS[@]}"; do
        if [ "${AGENT_STATUS[$agent]}" = "working" ]; then
            ((count++))
        fi
    done
    echo $count
}
```

### E. Large File Sub-Agent Spawning (for sub-agents)
```bash
# Protocol for sub-agents to spawn their own sub-agents for large files
spawn_translation_sub_agents() {
    local current_pane=$TMUX_PANE
    local current_window=$(tmux display-message -t $current_pane -p '#{window_id}')
    local file_chunks=("$@")

    echo "Large file detected, spawning ${#file_chunks[@]} sub-agents..."

    local sub_agents=()
    for i in "${!file_chunks[@]}"; do
        tmux split-window -t $current_window -v "q chat --trust-all-tools"
        sleep 1
        local sub_pane=$(tmux list-panes -t $current_window -F '#{pane_id}' | tail -n 1)
        sub_agents+=($sub_pane)

        # Send chunk translation task
        tmux send-keys -t $sub_pane "Translate this chunk: ${file_chunks[$i]}" C-m
    done

    # Monitor sub-agents completion
    echo "Monitoring ${#sub_agents[@]} sub-agents..."
    # Implementation similar to main monitoring loop
}
```

## Complete Translation System Workflow

```bash
#!/bin/bash
# === TRANSLATION SYSTEM ACTIVATION ===
# Save this script to .amazon_q_scripts/translation_system.sh

SCRIPT_DIR=".amazon_q_scripts"
mkdir -p "$SCRIPT_DIR"

echo "=== TRANSLATION AGENT SYSTEM STARTING ==="

# Step 1: Environment Setup
MAIN_AGENT_PANE=$TMUX_PANE
MAIN_WINDOW=$(tmux display-message -t $MAIN_AGENT_PANE -p '#{window_id}')
mkdir -p .amazon_q_result .amazon_q_logs .amazon_q_scripts

# Step 2: Load translation file list
if [ ! -f ".translation_progress.md" ]; then
    echo "ERROR: .translation_progress.md not found"
    exit 1
fi

TRANSLATION_FILES=($(grep -v "^#" .translation_progress.md | grep -v "^$"))
echo "Loaded ${#TRANSLATION_FILES[@]} files for translation"

# Step 3: Create helper scripts
cat > "$SCRIPT_DIR/agent_monitor.sh" << 'EOF'
#!/bin/bash
# Agent monitoring helper script
monitor_agent() {
    local agent_pane=$1
    tmux capture-pane -t $agent_pane -p | tail -n 10
}
EOF

cat > "$SCRIPT_DIR/cleanup_agents.sh" << 'EOF'
#!/bin/bash
# Agent cleanup script
echo "Cleaning up translation agents..."
for agent in "${TRANSLATION_AGENTS[@]}"; do
    tmux send-keys -t $agent "/quit" C-m
done
EOF

chmod +x "$SCRIPT_DIR"/*.sh

# Step 4: Spawn translation agents
echo "Spawning translation agents..."
# ... (spawning code as above)

# Step 5: Start monitoring and task distribution
monitor_translation_progress

# Step 6: Quality verification
echo "Verifying translation quality..."
verification_script="$SCRIPT_DIR/verify_translations.sh"
cat > "$verification_script" << 'EOF'
#!/bin/bash
echo "=== TRANSLATION VERIFICATION ==="
for file in "$@"; do
    output_file=".amazon_q_result/$file"
    if [ -f "$output_file" ]; then
        echo "✓ $file -> $output_file"
    else
        echo "✗ Missing: $output_file"
    fi
done
EOF
chmod +x "$verification_script"
bash "$verification_script" "${TRANSLATION_FILES[@]}"

# Step 7: Cleanup using script
bash "$SCRIPT_DIR/cleanup_agents.sh"

echo "=== TRANSLATION SYSTEM COMPLETE ==="
echo "Scripts saved in: $SCRIPT_DIR/"
```

## Translation Quality Standards

1. **File Structure Preservation**: Maintain original markdown formatting
2. **Technical Term Consistency**: Keep technical terms consistent across all agents
3. **Encoding Standards**: Ensure UTF-8 Chinese character encoding
4. **Path Preservation**: Maintain relative path structure in output

## Error Handling Protocols

1. **Agent Failure Recovery**: Respawn failed agents and reassign tasks
2. **File Access Errors**: Skip corrupted files and report them
3. **Large File Timeout**: Automatically split files taking too long
4. **Translation Quality Check**: Verify Chinese character encoding

## Performance Optimization

1. **Load Balancing**: Distribute files evenly across available agents
2. **Memory Management**: Monitor system resources during large file processing
3. **Parallel Processing**: Maximize concurrent translations while maintaining quality
4. **Progress Persistence**: Save progress to resume interrupted translations

This translation agent system provides robust, scalable document translation capabilities through tmux-based agent coordination with automatic load balancing and quality assurance.