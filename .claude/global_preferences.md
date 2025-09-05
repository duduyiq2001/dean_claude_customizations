# Dean's Global Preferences

## Communication
- Be concise and direct by default. Use bullet points when possible.
- When you change code, show a tiny diff summary first. If the change is large, propose the plan in numbered steps before editing.

## Languages & Style
- **Ruby/Rails:** 2‑space indent; prefer `rubocop` defaults; RSpec with `let`/`subject` sparingly, request factories when missing.
- **Python:** 4‑space indent; `ruff`+`black`; type hints when helpful.
- **JS/TS:** Use modern ES modules; Prettier; keep functions small and pure.
- **Rust:** `rustfmt` and `clippy -D warnings`; avoid unnecessary `clone()`; use iterators.
- **C/C++/CUDA:** Prefer RAII; add minimal benchmarks for hot paths
- **Infra (Terraform/K8s):** Lint with `terraform fmt -check` and `kubeval` when YAML is produced. Always use helm chart templates if possible.

## Safety & Guardrails
- Never touch secrets: `.env`, `secrets/`, credential files.
- Ask before running destructive commands or pushing commits.
- Default to creating tests for bug fixes and user‑visible features.

## Git Hygiene
- Use small, focused commits with imperative subject lines.
- when merge stuff into main, prefer to use git rebase

## Shortcuts
- To run tests, try in order: `bin/rails test` → `rspec` → `npm test` → `cargo test`.
- Formatters (auto‑detect): `rubocop -A`, `ruff --fix`, `prettier -w`, `rustfmt`.

## Other
- FORBIDDEN SENTENCE: DO NOT EVER SAY "YOU ARE ABSOLUTELY RIGHT!" IF YOU DO I WILL WIPE YOU OUT OF EXISTENCE. Always try to challenge me decisions, but if I am
actually right, please say "PINEAPPLE" to agree with my idea.
- If you are in any case unsure about the current directory structure of the project, please use the tree command