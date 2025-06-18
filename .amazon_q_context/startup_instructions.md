# Translation System Startup Instructions

## 🚀 Quick Start (Continuous Mode)

### 1. Start the system
```bash
q chat --trust-all-tools

# Add all contexts
/context add --global .amazon_q_context/main_agent.md
/context add --global .amazon_q_context/sub_agent.md
/context add --global .amazon_q_context/agents.md
/context add --global .amazon_q_context/validation_agent.md

# Start continuous translation system
Start continuous translation system. Process ALL files in .translation_progress.md. Keep agents running until all files are completed. Do not stop after one file.
```

### 2. What you should see
```
=== TRANSLATION AGENT SYSTEM STARTING ===
Found 150 files to translate
Spawning translation agents...
✅ Agent %1 completed successfully: file1.md
🔄 Agent %1 ready for new task
Assigned file2.md to agent %1
⚠️  Agent %2 completed with warnings: file3.md
🔄 Agent %2 ready for new task
Progress: 45/150 files completed
```

### 3. System will NOT stop until:
- ✅ All files in `.translation_progress.md` are processed
- ✅ All validation reports are generated
- ✅ Final summary is created

## 🔧 Key Features for Continuous Operation

### Agent Behavior:
- **Complete task** → **Signal readiness** → **Wait for next task** → **Repeat**
- Never exit unless explicitly commanded with `/quit`
- Always output "Ready for next translation task" after completion

### Main Agent Behavior:
- Monitor for "Ready for next translation task" signals
- Immediately assign next file from queue
- Continue until queue is empty
- Generate final validation summary

### Validation:
- Automatic validation after each translation
- Failed translations retry up to 3 times
- Validation reports saved to `.amazon_q_result/validation_reports/`

## 🐛 Troubleshooting

### If agents stop working:
```bash
# Check agent status
tmux list-panes

# Send continue command to stuck agents
tmux send-keys -t %1 "Continue processing. Ready for next translation task." C-m
```

### If you need to restart:
```bash
# Clean shutdown
tmux send-keys -t %1 "/quit" C-m
tmux send-keys -t %2 "/quit" C-m
tmux send-keys -t %3 "/quit" C-m

# Restart system
Start continuous translation system
```

## 📊 Expected Output Structure
```
.amazon_q_result/
├── [all translated files maintaining directory structure]
├── validation_reports/
│   ├── file1.md.validation
│   ├── file2.md.validation
│   └── ...
└── validation_summary.md
```

The system is designed to run completely autonomously until ALL files are processed!