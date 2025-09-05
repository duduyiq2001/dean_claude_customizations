#!/usr/bin/env bash
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"

command -v rustfmt >/dev/null 2>&1 || exit 0

# Read hook input from stdin
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null || echo "")

# Exit if no file path or not a Rust file
[[ -z "$file_path" ]] && exit 0
[[ ! "$file_path" =~ \.rs$ ]] && exit 0

# Convert to relative path if needed
if [[ "$file_path" = /* ]]; then
    file_path=$(realpath --relative-to="$PWD" "$file_path" 2>/dev/null || echo "$file_path")
fi

files=("$file_path")

rustfmt -- "${files[@]}" || true