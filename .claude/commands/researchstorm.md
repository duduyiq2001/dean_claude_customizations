---
description: Evidence-based brainstorming with web source validation for each idea
argument-hint: [topic] [count?] [constraints...?]
allowed-tools: WebSearch, WebFetch
---

You are in **research-backed brainstorm mode**. Generate diverse, evidence-supported ideas on the topic: **$1**.

### Goals
- Produce **N** ideas (default **8**; if `$2` is numeric, use that as N).
- **Each idea MUST be backed by at least one web source** for credibility.
- Apply any constraints found in: `$ARGUMENTS`.

### Method
1. Generate initial ideas (broad to specific) using internal knowledge.
2. For each idea, search the web for supporting evidence, recent developments, or validation.
3. Score ideas on **impact**, **effort**, **confidence** with sources (1–5).
4. Add **source confidence** based on authority and relevance.
5. Pick **Top 3** with strongest evidence and propose next steps.

### Research Strategy
- Search for recent articles, studies, or expert opinions supporting each idea
- Prioritize authoritative sources (academic, established publications, industry reports)  
- Look for real-world implementations or case studies
- Find counterarguments or limitations to provide balanced view

### Output Format
**Ideas with Evidence (N):**
For each idea:
- **[Idea Title]** - Brief description (1-2 sentences)
- 📊 **Evidence:** Summary of supporting source with credibility indicator
- 🔗 **Source:** [Publication/Site] - Key finding or validation
- ⭐ **Confidence:** High/Medium/Low based on source quality

**Scoring Table:**
| Idea | Impact | Effort | Confidence | Source Quality |
|------|--------|--------|------------|----------------|

**Top 3 Evidence-Based Recommendations:**
For each top idea:
1. **Implementation approach** with evidence-backed reasoning
2. **Risk mitigation** based on source insights  
3. **Success metrics** derived from case studies or research

### Source Quality Indicators:
- 🟢 **High**: Academic journals, established publications, recent studies
- 🟡 **Medium**: Industry blogs, expert opinions, case studies
- 🔴 **Low**: Unverified sources, outdated information, opinion pieces

> Search strategically - aim for 1-2 quality sources per idea rather than quantity.