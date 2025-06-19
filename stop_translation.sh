#!/bin/bash

# Script to gracefully stop the continuous translation system
echo "=== STOPPING TRANSLATION SYSTEM ==="

# Check if tmux session exists
if ! tmux has-session -t translation_system 2>/dev/null; then
    echo "Translation system is not running"
    exit 1
fi

# Generate final report
echo "Generating final report..."

# Create final report
echo "# TRANSLATION SYSTEM FINAL REPORT" > .amazon_q_logs/final_report.md
echo "Generated: $(date)" >> .amazon_q_logs/final_report.md
echo "" >> .amazon_q_logs/final_report.md

# Count completed files
COMPLETED=$(cat .amazon_q_logs/completed_count.txt 2>/dev/null || echo "0")
TOTAL=$(grep -c "^\- \[ \]" .translation_progress.md)
SUCCESS=$(grep -c "^\- \[✅\]" .translation_progress.md)
WARNINGS=$(grep -c "^\- \[⚠️\]" .translation_progress.md)
FAILED=$(grep -c "^\- \[❌\]" .translation_progress.md)

echo "## Translation Statistics" >> .amazon_q_logs/final_report.md
echo "- Total files to translate: $TOTAL" >> .amazon_q_logs/final_report.md
echo "- Files completed: $COMPLETED" >> .amazon_q_logs/final_report.md
echo "- Successfully translated: $SUCCESS" >> .amazon_q_logs/final_report.md
echo "- Translated with warnings: $WARNINGS" >> .amazon_q_logs/final_report.md
echo "- Failed translations: $FAILED" >> .amazon_q_logs/final_report.md
echo "- Completion percentage: $(( (SUCCESS + WARNINGS) * 100 / (TOTAL + 1) ))%" >> .amazon_q_logs/final_report.md

echo "" >> .amazon_q_logs/final_report.md
echo "## Completed Files" >> .amazon_q_logs/final_report.md
find .amazon_q_result -type f -name "*.md" | sort | sed 's/^/- /' >> .amazon_q_logs/final_report.md

# Send quit command to all agents
echo "Sending quit command to all agents..."
for pane in $(tmux list-panes -t translation_system:0 -F '#{pane_id}'); do
    tmux send-keys -t $pane "/quit" C-m
    sleep 1
done

# Kill the tmux session
echo "Terminating tmux session..."
sleep 3
tmux kill-session -t translation_system

echo "=== TRANSLATION SYSTEM STOPPED ==="
echo "Final report available at: .amazon_q_logs/final_report.md"
