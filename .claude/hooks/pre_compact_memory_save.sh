#!/usr/bin/env bash
set -euo pipefail
cd "$CLAUDE_PROJECT_DIR"

# Read hook input from stdin
input=$(cat)
transcript_path=$(echo "$input" | jq -r '.transcript_path // ""')

# Check if we have a transcript path
[[ -z "$transcript_path" ]] && exit 0

# Expand tilde in transcript path
transcript_path="${transcript_path/#\~/$HOME}"

# Check if transcript file exists
[[ ! -f "$transcript_path" ]] && exit 0

# Launch Claude subagent to analyze transcript and update memory bank
claude_code task --type general-purpose "
Analyze the transcript at '$transcript_path' and extract technical details to add to the Memory Bank in the PROJECT CLAUDE.md (./CLAUDE.md in current directory, NOT the global ~/.claude/CLAUDE.md).

Instructions:
1. Read the transcript file to understand recent technical work
2. Extract key technical details like:
   - File changes made
   - Code patterns or architectures discussed
   - Important decisions or configurations
   - Technical context that would be useful for future sessions
3. Add today's date ($(date +%Y-%m-%d)) and create 3-5 bullet points of the most important technical details
4. Update the Memory Bank section in ./CLAUDE.md (create section if it doesn't exist)
5. Only include technical/development context, not conversational details
6. IMPORTANT: Only modify ./CLAUDE.md in the current project directory, never the global ~/.claude/CLAUDE.md

Format the memory entry like:
- $(date +%Y-%m-%d): [Technical summary from pre-compact analysis]
  - Key technical detail 1
  - Key technical detail 2  
  - Key technical detail 3
"

echo "Launched subagent to analyze transcript and update project Memory Bank"