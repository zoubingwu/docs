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

### A. Translation Environment Setup
```bash
# Determine your environment context
MAIN_AGENT_PANE=$TMUX_PANE
MAIN_WINDOW=$(tmux display-message -t $MAIN_AGENT_PANE -p '#{window_id}')

# Create output directory structure
mkdir -p .amazon_q_result

# Read translation file list
TRANSLATION_FILES=($(grep -v "^#" .translation_progress.md | grep -v "^$"))
TOTAL_FILES=${#TRANSLATION_FILES[@]}
echo "Found $TOTAL_FILES files to translate"
```

### B. Translation Sub-Agent Spawning Protocol
```bash
# Optimal layout: 4 translation agents (2x2 grid)
echo "Spawning Translation Agent 1 (top-right)..."
tmux split-window -t $MAIN_WINDOW -h "q chat --trust-all-tools"
sleep 2

echo "Spawning Translation Agent 2 (bottom-right)..."
RIGHT_PANE=$(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}' | tail -n 1)
tmux split-window -t $RIGHT_PANE -v "q chat --trust-all-tools"
sleep 2

echo "Spawning Translation Agent 3 (bottom-left)..."
LEFT_PANE=$(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}' | head -n 1)
tmux split-window -t $LEFT_PANE -v "q chat --trust-all-tools"
sleep 2

# Get all pane references
# Layout: [Main(0)] [Agent1(2)]
#         [Agent3(1)] [Agent2(3)]
PANES=($(tmux list-panes -t $MAIN_WINDOW -F '#{pane_id}'))
TRANSLATION_AGENTS=(${PANES[1]} ${PANES[2]} ${PANES[3]})
echo "Translation agents ready: ${TRANSLATION_AGENTS[@]}"
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

# Assign initial tasks
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

    echo "Assigned $file_path to agent $agent_pane"
}
```

### D. Translation Progress Monitoring
```bash
# Monitor translation progress
monitor_translation_progress() {
    echo "=== Starting Translation Monitoring ==="

    # Assign initial tasks to all agents
    for agent in "${TRANSLATION_AGENTS[@]}"; do
        if [ $FILE_INDEX -lt $TOTAL_FILES ]; then
            assign_translation_task $agent "${FILE_QUEUE[$FILE_INDEX]}"
            ((FILE_INDEX++))
        fi
    done

        # Monitor loop - CONTINUOUS OPERATION
    while [ $FILE_INDEX -lt $TOTAL_FILES ] || [ $(active_agents_count) -gt 0 ]; do
        for agent in "${TRANSLATION_AGENTS[@]}"; do
            # Capture agent output
            CURRENT_OUTPUT=$(tmux capture-pane -t $agent -p | tail -n 5)

            # Check for readiness signal
            if [[ "$CURRENT_OUTPUT" == *"Ready for next translation task"* ]] && [ "${AGENT_STATUS[$agent]}" != "working" ]; then
                AGENT_STATUS[$agent]="idle"
                echo "🔄 Agent $agent ready for new task"

                # Immediately assign next file if available
                if [ $FILE_INDEX -lt $TOTAL_FILES ]; then
                    assign_translation_task $agent "${FILE_QUEUE[$FILE_INDEX]}"
                    ((FILE_INDEX++))
                fi
            fi

            # Check for working agents' status
            if [ "${AGENT_STATUS[$agent]}" = "working" ]; then
                # Check for completion signals with validation status
                if [[ "$CURRENT_OUTPUT" == *"Translation complete for"* ]]; then
                    if [[ "$CURRENT_OUTPUT" == *"(with warnings)"* ]]; then
                        echo "⚠️  Agent $agent completed with warnings: ${AGENT_CURRENT_FILE[$agent]}"
                    else
                        echo "✅ Agent $agent completed successfully: ${AGENT_CURRENT_FILE[$agent]}"
                    fi
                    # Note: Agent will signal readiness in next iteration

                elif [[ "$CURRENT_OUTPUT" == *"Validation failed for"* ]]; then
                    echo "❌ Agent $agent validation failed: ${AGENT_CURRENT_FILE[$agent]}"
                    local failed_file="${AGENT_CURRENT_FILE[$agent]}"

                    # Check retry count
                    if [ ${RETRY_COUNT[$failed_file]:-0} -lt 3 ]; then
                        echo "Retrying $failed_file (attempt $((${RETRY_COUNT[$failed_file]:-0} + 1)))"
                        RETRY_COUNT[$failed_file]=$((${RETRY_COUNT[$failed_file]:-0} + 1))
                        assign_translation_task $agent "$failed_file"
                    else
                        echo "Max retries reached for $failed_file, skipping"
                        AGENT_STATUS[$agent]="idle"
                        if [ $FILE_INDEX -lt $TOTAL_FILES ]; then
                            assign_translation_task $agent "${FILE_QUEUE[$FILE_INDEX]}"
                            ((FILE_INDEX++))
                        fi
                    fi
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
echo "=== TRANSLATION AGENT SYSTEM STARTING ==="

# Step 1: Environment Setup
MAIN_AGENT_PANE=$TMUX_PANE
MAIN_WINDOW=$(tmux display-message -t $MAIN_AGENT_PANE -p '#{window_id}')
mkdir -p .amazon_q_result

# Step 2: Load translation file list
if [ ! -f ".translation_progress.md" ]; then
    echo "ERROR: .translation_progress.md not found"
    exit 1
fi

TRANSLATION_FILES=($(grep -v "^#" .translation_progress.md | grep -v "^$"))
echo "Loaded ${#TRANSLATION_FILES[@]} files for translation"

# Step 3: Spawn translation agents
echo "Spawning translation agents..."
# ... (spawning code as above)

# Step 4: Start monitoring and task distribution
monitor_translation_progress

# Step 5: Quality verification
echo "Verifying translation quality..."
for file in "${TRANSLATION_FILES[@]}"; do
    output_file=".amazon_q_result/$file"
    if [ -f "$output_file" ]; then
        echo "✓ $file -> $output_file"
    else
        echo "✗ Missing: $output_file"
    fi
done

# Step 6: Cleanup
echo "Cleaning up agents..."
for agent in "${TRANSLATION_AGENTS[@]}"; do
    tmux send-keys -t $agent "/quit" C-m
done

echo "=== TRANSLATION SYSTEM COMPLETE ==="
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