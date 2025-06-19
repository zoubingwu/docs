#!/bin/bash

SESSION="agent"
LAST_LINE=""
WAIT_COUNT=0
LOG_FILE="agent_monitor.log"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== 开始监控 tmux session: $SESSION ==="

while true; do
    # 检查session是否存在
    if ! tmux has-session -t "$SESSION" 2>/dev/null; then
        log "错误: tmux session '$SESSION' 不存在，退出监控"
        exit 1
    fi

    # 获取所有输出并提取最后一行
    ALL_OUTPUT=$(tmux capture-pane -t $SESSION -p 2>/dev/null)
    if [ $? -ne 0 ]; then
        log "警告: 无法获取输出内容"
        sleep 5
        continue
    fi

    # 获取最后一行（非空）
    CURRENT_LINE=$(echo "$ALL_OUTPUT" | grep -v '^$' | tail -1)

    log "最后一行: '$CURRENT_LINE'"

    # 检测最后一行是否是 '>'
    if [ "$CURRENT_LINE" = ">" ]; then
        # 如果和上次一样，增加计数
        if [ "$CURRENT_LINE" = "$LAST_LINE" ]; then
            WAIT_COUNT=$((WAIT_COUNT + 1))
            log "检测到 '>' 且内容未变化，等待计数: $WAIT_COUNT/3"

            if [ $WAIT_COUNT -ge 3 ]; then
                log "🚀 连续3次检测到 '>' 提示符，发送继续命令"
                tmux send-keys -t $SESSION "pls continue from what you have left off" Enter
                if [ $? -eq 0 ]; then
                    log "✅ 命令发送成功"
                else
                    log "❌ 命令发送失败"
                fi
                WAIT_COUNT=0
                log "重置等待计数"
                sleep 10  # 发送后等10秒再检测
            else
                sleep 5   # 继续等待
            fi
        else
            # 第一次检测到 '>'
            WAIT_COUNT=1
            log "首次检测到 '>' 提示符，开始计数: $WAIT_COUNT/3"
            sleep 5
        fi
    else
        # 不是 '>'，重置计数
        if [ $WAIT_COUNT -gt 0 ]; then
            log "📝 内容变化，重置等待计数 (之前: $WAIT_COUNT)"
        fi
        WAIT_COUNT=0
        sleep 5
    fi

    LAST_LINE="$CURRENT_LINE"
done