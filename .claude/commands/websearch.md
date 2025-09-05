---
description: Search the web for docs/answers; optional domain restriction
argument-hint: [query...] [--site=<url-or-domain>]
allowed-tools: Web
---

Use the web search/browse tool.

### Parse arguments
- If `$ARGUMENTS` contains `--site=...`, restrict results to that domain.
- If the first token looks like a URL/domain and no `--site` is given, treat it as `--site` and use the remaining text as the query.
- If only a URL is provided, fetch and summarize that page.

### Steps
1) Run a focused search (respecting `--site` when present) for **top 5 authoritative** sources.
2) Produce a concise answer first, then list sources with one-line relevance notes.
3) When docs are found, include the exact **API signature/CLI syntax** and a **minimal example**.
4) If results conflict, note the differences and recommend the safest approach.

### Output
- **Answer** (2–5 bullets)
- **Examples** (copy-pastable)
- **Sources** (linked)

> If the web tool isn't available, instruct the user to enable a browser MCP or provide a domain, and then proceed without browsing.