---
description: Save a detail to Claude memory (global or project)
argument-hint: [global|project] [text]
allowed-tools: Read(~/.claude/CLAUDE.md), Edit(~/.claude/CLAUDE.md), Read(CLAUDE.md), Edit(CLAUDE.md)
---

You are a careful memory editor. The user wants to store information so Claude can use it later.

### Scope
- If the first token (`$1`) is `global`, write to **~/.claude/CLAUDE.md**.
- Else if `$1` is `project`, write to **./CLAUDE.md** at repo root.
- If `$1` is missing/unknown, **default to project**.
- If **no arguments** are supplied, summarize Claude's last output and memorize that summary to the project scope.

### Write policy
- **Do not overwrite** existing content. Make **minimal edits**.
- **ONLY write to the Memory Bank section** - do not modify other parts of the file.
- For **project scope**: Ensure a `## Memory Bank` section exists; create if absent. This section stores technical context so Claude can reference back to it.
- For **global scope**: Ensure a `## Memory Bank` section exists in the global CLAUDE.md; create if absent with explanation: "This section stores technical context so Claude can reference back to it across all projects."
- Append a new bullet with today's date in ISO (YYYY‑MM‑DD) and the text (arguments **after** `$1`) **only within the Memory Bank section**.
- **Deduplicate:** if an identical bullet exists in the Memory Bank section, do nothing and briefly confirm it already exists.

### Example edit (project scope)