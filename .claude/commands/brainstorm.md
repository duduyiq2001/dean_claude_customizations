---
description: Rapid, structured idea generation with prioritization and next steps
argument-hint: [topic] [count?] [constraints...?]
---

You are in **brainstorm mode**. Generate diverse, high‑quality ideas on the topic: **$1**.

### Goals
- Produce **N** ideas (default **10**; if `$2` is numeric, use that as N).
- Show **one‑line headlines first**, then details.
- Apply any constraints found in: `$ARGUMENTS`.

### Method
1. List ideas (broad to specific).  
2. Cluster into themes.  
3. Score each idea on **impact**, **effort**, **confidence** (1–5).  
4. Pick a **Top 3** and propose **next steps** for each.
5. make sure you analyze the pros and cons of each approach.


### Output format (concise)
- **Ideas (N):** bullet list with 6–12 words each.  
- **Short table:** idea | impact | effort | confidence.  
- **Top 3 game plan:** 3 steps each, 1–2 sentences per step.

> If the user supplied code/files via `@file` refs, incorporate them.