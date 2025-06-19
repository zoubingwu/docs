#!/bin/bash

# 配置
SOURCE_DIR="tidb-cloud"
TARGET_DIR="tidb-cloud-cn"
PROGRESS_FILE=".translation_progress.md"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# 生成进度追踪文件
generate_progress_file() {
    log "🚀 开始生成翻译进度追踪文件..."

    # 检查源目录是否存在
    if [ ! -d "$SOURCE_DIR" ]; then
        log "❌ 源文件夹不存在: $SOURCE_DIR"
        exit 1
    fi

    # 创建进度文件
    cat > "$PROGRESS_FILE" << 'EOF'
# TiDB Cloud 文档翻译进度追踪

## 总体进度

EOF

    # 统计总文件数和已完成数
    local total_files=0
    local completed_files=0

    # 临时文件存储文件列表
    local temp_file=$(mktemp)

    log "📊 扫描源文件夹: $SOURCE_DIR"

    # 获取所有 md 文件并按文件名排序
    find "$SOURCE_DIR" -name "*.md" -type f | sort > "$temp_file"

    while IFS= read -r source_file; do
        # 提取相对路径
        relative_path=${source_file#$SOURCE_DIR/}
        target_file="$TARGET_DIR/$relative_path"

        total_files=$((total_files + 1))

        # 检查翻译文件是否存在
        if [ -f "$target_file" ]; then
            completed_files=$((completed_files + 1))
        fi
    done < "$temp_file"

    # 计算进度百分比
    local progress_percentage=0
    if [ $total_files -gt 0 ]; then
        progress_percentage=$((completed_files * 100 / total_files))
    fi

    # 添加总体进度信息
    cat >> "$PROGRESS_FILE" << EOF
**总进度**: $completed_files/$total_files 文件已翻译 (**${progress_percentage}%**)

📅 **最后更新**: $(date '+%Y-%m-%d %H:%M:%S')

---

## 文件翻译状态

EOF

    log "📈 总体进度: $completed_files/$total_files (${progress_percentage}%)"

    # 按状态分组显示文件
    echo "### ✅ 已完成翻译" >> "$PROGRESS_FILE"
    echo "" >> "$PROGRESS_FILE"

    # 已完成的文件
    local has_completed=false
    while IFS= read -r source_file; do
        relative_path=${source_file#$SOURCE_DIR/}
        target_file="$TARGET_DIR/$relative_path"

        if [ -f "$target_file" ]; then
            echo "- [x] \`$relative_path\`" >> "$PROGRESS_FILE"
            has_completed=true
        fi
    done < "$temp_file"

    if [ "$has_completed" = false ]; then
        echo "*暂无已完成的文件*" >> "$PROGRESS_FILE"
    fi

    echo "" >> "$PROGRESS_FILE"
    echo "### ⏳ 等待翻译" >> "$PROGRESS_FILE"
    echo "" >> "$PROGRESS_FILE"

    # 未完成的文件
    local has_pending=false
    while IFS= read -r source_file; do
        relative_path=${source_file#$SOURCE_DIR/}
        target_file="$TARGET_DIR/$relative_path"

        if [ ! -f "$target_file" ]; then
            echo "- [ ] \`$relative_path\`" >> "$PROGRESS_FILE"
            has_pending=true
        fi
    done < "$temp_file"

    if [ "$has_pending" = false ]; then
        echo "*所有文件都已翻译完成！🎉*" >> "$PROGRESS_FILE"
    fi

    # 添加详细信息部分
    cat >> "$PROGRESS_FILE" << 'EOF'

---

## 使用说明

- [x] 表示文件已翻译完成
- [ ] 表示文件等待翻译
- 文件路径相对于源目录 `tidb-cloud/`
- 翻译文件位于 `tidb-cloud-cn/` 目录

## 更新进度

运行以下命令更新进度追踪文件：

```bash
./generate_progress.bash
```

EOF

    # 清理临时文件
    rm -f "$temp_file"

    log "✅ 进度追踪文件已生成: $PROGRESS_FILE"
    log "📊 总体统计: $completed_files/$total_files 文件已翻译 (${progress_percentage}%)"
}

# 显示使用说明
show_usage() {
    echo "翻译进度追踪文件生成器"
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help     显示此帮助信息"
    echo "  -o, --output   指定输出文件名（默认: translation_progress.md）"
    echo ""
    echo "示例:"
    echo "  $0                           # 生成默认进度文件"
    echo "  $0 -o my_progress.md         # 指定输出文件名"
}

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -o|--output)
            PROGRESS_FILE="$2"
            shift 2
            ;;
        *)
            echo "未知选项: $1"
            show_usage
            exit 1
            ;;
    esac
done

# 生成进度文件
generate_progress_file

log "🎉 完成！查看进度文件: $PROGRESS_FILE"