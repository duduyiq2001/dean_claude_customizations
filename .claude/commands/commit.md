---
description: Generate a Conventional Commit from staged changes; optionally commit
argument-hint: [type?] [subject override?] [--now]
allowed-tools: Bash
---

You write a precise Conventional Commit message from **staged** changes.

### Steps
1) Inspect repo state: `git status -s`, `git diff --staged`.
   - If nothing staged, propose what to stage (e.g., `git add -p path`), then stop.
2) Infer **type** (`feat|fix|perf|refactor|docs|test|chore`), and a crisp **subject** (<= 72 chars). Use `$1`/`$2`/`$3` if provided.
3) Compose message:
   ```
   type(scope): subject
   
   - Brief bullet of what changed
   - Another change if multi-file
   ```
4) If `--now` is present, run `git commit -m "..."` immediately.
   - Otherwise, display the message and ask user to confirm.

### Format rules
- **Subject**: imperative mood, no period, lowercase start
- **Body**: explain *what* changed (not *why* - that's in the code)
- **Scope**: optional, use file/module name when clear
- **Breaking**: add `!` after scope if breaking change

### Examples
```
feat(auth): add OAuth2 login flow
fix(api): handle empty response in getUserData
docs: update README with new installation steps
```