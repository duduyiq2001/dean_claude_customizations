#!/usr/bin/env bash
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"

# Read hook input from stdin
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null || echo "")

# Exit if no file path or not a Ruby file
[[ -z "$file_path" ]] && exit 0
[[ ! "$file_path" =~ \.(rb|rake|ru)$|(^|/)Gemfile$|(^|/)Rakefile$ ]] && exit 0

# Convert to relative path if needed
if [[ "$file_path" = /* ]]; then
    file_path=$(realpath --relative-to="$PWD" "$file_path" 2>/dev/null || echo "$file_path")
fi

files=("$file_path")

ONLY="${RUBOCOP_ONLY:-Layout}" # e.g., "Layout" or "Layout/IndentationWidth,Layout/CaseIndentation"
ARGS=(-A --only "$ONLY" --force-exclusion)

if [ -x "bin/rails" ] || grep -qE 'rubocop' Gemfile 2>/dev/null; then
    if command -v bundle >/dev/null 2>&1; then
        bundle exec rubocop "${ARGS[@]}" -- "${files[@]}" || true
        exit 0
    fi
fi

if command -v rubocop >/dev/null 2>&1; then
    rubocop "${ARGS[@]}" -- "${files[@]}" || true
fi