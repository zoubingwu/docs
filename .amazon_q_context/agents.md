# Translation System Architecture

## System Overview
This is a three-layer multi-agent translation system optimized for massive parallel processing.

## Architecture Layers

### Layer 1: Main Agent (`main_agent.md`)
- Spawns 200 concurrent tmux sessions
- Assigns one file per session
- Monitors translation progress
- Triggers validation for completed files
- Manages overall system coordination

### Layer 2: Sub Agents (`sub_agent.md`)
- File translation workers (one per tmux session)
- Handles single file translation
- Automatically splits large files (>1000 lines) into 2-4 sub-agents
- Reports completion status

### Layer 3: Validation Agents (`validation_agent.md`)
- Quality assurance processors
- Validates each completed translation
- Checks format integrity and translation quality
- Reports validation results

## File Flow
```
File Queue → Main Agent → 200 Sessions → Sub Agents → Large File Splitting (if needed) → Translation → Validation → Complete
```

## Key Features
- **Massive Concurrency**: Up to 200 parallel translations
- **Intelligent Splitting**: Large files auto-split into chunks
- **Quality Control**: Every file validated before completion
- **Progress Tracking**: Real-time monitoring and reporting
