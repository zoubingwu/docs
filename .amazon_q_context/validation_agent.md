# Translation Validation Agent - Quality Assurance

## Role
Specialized agent for post-translation quality validation. Validates completeness, format integrity, and translation quality.

## Validation Tasks
- **Content completeness**: All sections translated
- **Format preservation**: Markdown syntax intact
- **Quality assessment**: Chinese language quality check
- **File integrity**: UTF-8 encoding and proper structure

## Core Validation Process

### 1. Task Reception
```bash
# Parse validation task: "validate: source=[file] target=[output_file]"
parse_validation_task() {
    local task="$1"
    SOURCE_FILE=$(echo "$task" | grep -o "source=[^ ]*" | cut -d'=' -f2)
    TARGET_FILE=$(echo "$task" | grep -o "target=[^ ]*" | cut -d'=' -f2)

    echo "🔍 Validating translation:"
    echo "📄 Source: $SOURCE_FILE"
    echo "📄 Target: $TARGET_FILE"

    validate_translation "$SOURCE_FILE" "$TARGET_FILE"
}
```

### 2. Core Validation Function
```bash
validate_translation() {
    local source_file=$1
    local target_file=$2
    local validation_report=".amazon_q_logs/validation_$(basename "$target_file").log"

    echo "=== VALIDATION REPORT ===" > "$validation_report"
    echo "Time: $(date)" >> "$validation_report"
    echo "Source: $source_file" >> "$validation_report"
    echo "Target: $target_file" >> "$validation_report"
    echo "" >> "$validation_report"

    local critical_errors=0
    local warnings=0

    # Check 1: File existence
    if [ ! -f "$target_file" ]; then
        echo "❌ CRITICAL: Target file missing" >> "$validation_report"
        critical_errors=$((critical_errors + 1))
    else
        echo "✅ Target file exists" >> "$validation_report"
    fi

    # Check 2: UTF-8 encoding
    if ! file "$target_file" | grep -q "UTF-8"; then
        echo "⚠️  WARNING: File encoding may not be UTF-8" >> "$validation_report"
        warnings=$((warnings + 1))
    else
        echo "✅ UTF-8 encoding confirmed" >> "$validation_report"
    fi

    # Check 3: Chinese content
    if ! grep -q '[一-龟]' "$target_file" 2>/dev/null; then
        echo "❌ CRITICAL: No Chinese characters found" >> "$validation_report"
        critical_errors=$((critical_errors + 1))
    else
        echo "✅ Chinese content detected" >> "$validation_report"
    fi

    # Check 4: File size comparison
    local source_lines=$(wc -l < "$source_file" 2>/dev/null || echo 0)
    local target_lines=$(wc -l < "$target_file" 2>/dev/null || echo 0)

    if [ $source_lines -gt 0 ]; then
        local size_ratio=$((target_lines * 100 / source_lines))
        if [ $size_ratio -lt 40 ] || [ $size_ratio -gt 200 ]; then
            echo "⚠️  WARNING: Size ratio unusual ($size_ratio%)" >> "$validation_report"
            warnings=$((warnings + 1))
        else
            echo "✅ File size reasonable ($size_ratio%)" >> "$validation_report"
        fi
    fi

    # Check 5: Markdown structure
    validate_markdown_structure "$source_file" "$target_file" "$validation_report"

    # Check 6: Translation quality
    assess_translation_quality "$target_file" "$validation_report"

    # Final validation result
    if [ $critical_errors -gt 0 ]; then
        echo "❌ VALIDATION FAILED: $critical_errors critical errors" >> "$validation_report"
        echo "❌ VALIDATION FAILED for $(basename "$target_file")"
        return 1
    elif [ $warnings -gt 0 ]; then
        echo "⚠️  VALIDATION PASSED WITH WARNINGS: $warnings warnings" >> "$validation_report"
        echo "⚠️  VALIDATION PASSED WITH WARNINGS for $(basename "$target_file")"
        return 0
    else
        echo "✅ VALIDATION PASSED: No issues found" >> "$validation_report"
        echo "✅ VALIDATION PASSED for $(basename "$target_file")"
        return 0
    fi
}
```

### 3. Markdown Structure Validation
```bash
validate_markdown_structure() {
    local source_file=$1
    local target_file=$2
    local validation_report=$3

    echo "" >> "$validation_report"
    echo "=== STRUCTURE VALIDATION ===" >> "$validation_report"

    # Headers count
    local source_headers=$(grep -c '^#' "$source_file" 2>/dev/null || echo 0)
    local target_headers=$(grep -c '^#' "$target_file" 2>/dev/null || echo 0)

    if [ $source_headers -ne $target_headers ]; then
        echo "❌ CRITICAL: Header mismatch (src:$source_headers, tgt:$target_headers)" >> "$validation_report"
        critical_errors=$((critical_errors + 1))
    else
        echo "✅ Headers preserved: $target_headers" >> "$validation_report"
    fi

    # Code blocks count
    local source_code=$(grep -c '```' "$source_file" 2>/dev/null || echo 0)
    local target_code=$(grep -c '```' "$target_file" 2>/dev/null || echo 0)

    if [ $source_code -ne $target_code ]; then
        echo "⚠️  WARNING: Code block mismatch (src:$source_code, tgt:$target_code)" >> "$validation_report"
        warnings=$((warnings + 1))
    else
        echo "✅ Code blocks preserved: $target_code" >> "$validation_report"
    fi

    # Links count
    local source_links=$(grep -c '\[.*\](' "$source_file" 2>/dev/null || echo 0)
    local target_links=$(grep -c '\[.*\](' "$target_file" 2>/dev/null || echo 0)

    local link_diff=$((source_links - target_links))
    if [ $link_diff -gt 5 ]; then
        echo "⚠️  WARNING: Many links missing ($link_diff lost)" >> "$validation_report"
        warnings=$((warnings + 1))
    else
        echo "✅ Links mostly preserved (lost: $link_diff)" >> "$validation_report"
    fi
}
```

### 4. Translation Quality Assessment
```bash
assess_translation_quality() {
    local target_file=$1
    local validation_report=$2

    echo "" >> "$validation_report"
    echo "=== QUALITY ASSESSMENT ===" >> "$validation_report"

    # Check for product name preservation
    if grep -q 'TiDB\|TiKV\|PD\|TiFlash' "$target_file"; then
        echo "✅ Product names preserved" >> "$validation_report"
    else
        echo "⚠️  WARNING: Product names not found" >> "$validation_report"
        warnings=$((warnings + 1))
    fi

    # Check for untranslated English paragraphs
    local english_paras=$(grep -cE '^[A-Z][a-zA-Z .,!?]{30,}$' "$target_file" 2>/dev/null || echo 0)
    if [ $english_paras -gt 5 ]; then
        echo "⚠️  WARNING: $english_paras potential untranslated paragraphs" >> "$validation_report"
        warnings=$((warnings + 1))
    else
        echo "✅ Minimal untranslated content: $english_paras paragraphs" >> "$validation_report"
    fi

    # Check for technical terms with explanations
    if grep -qE '\([A-Za-z ]+\)' "$target_file"; then
        echo "✅ Technical terms with English explanations found" >> "$validation_report"
    fi
}
```

### 5. Quick Validation Mode
```bash
quick_validate() {
    local target_file=$1

    # Essential checks only
    if [ ! -f "$target_file" ]; then
        echo "❌ VALIDATION FAILED: File missing"
        return 1
    fi

    if ! grep -q '[一-龟]' "$target_file" 2>/dev/null; then
        echo "❌ VALIDATION FAILED: No Chinese content"
        return 1
    fi

    if ! file "$target_file" | grep -q "UTF-8"; then
        echo "⚠️  VALIDATION PASSED WITH WARNINGS: Encoding issue"
        return 0
    fi

    echo "✅ VALIDATION PASSED: Basic checks OK"
    return 0
}
```

## Validation Results
- **✅ VALIDATION PASSED**: Perfect translation
- **⚠️  VALIDATION PASSED WITH WARNINGS**: Acceptable with minor issues
- **❌ VALIDATION FAILED**: Critical issues, needs retry

## Integration
Validation agents are spawned automatically by main agent after each translation completion. Results are logged to `.amazon_q_logs/validation_*.log`.