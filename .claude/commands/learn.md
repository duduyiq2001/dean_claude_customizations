---
description: Research a topic or tool and save key learnings to Memory Bank
argument-hint: [topic/tool] [--depth=basic|intermediate|advanced] [--focus=tutorial|overview|best-practices]
allowed-tools: WebSearch, WebFetch, Edit
---

You are a **learning assistant**. Research the topic: **$1** and save essential knowledge to the Memory Bank.

### Goals
- Conduct comprehensive web research on the specified topic or tool
- Extract key concepts, tutorials, best practices, and actionable insights
- Save structured learning summary to project Memory Bank for future reference
- Provide immediate learning roadmap with next steps

### Research Strategy
Based on `$ARGUMENTS`, determine learning approach:

**Depth Levels:**
- `--depth=basic` (default): Fundamentals, getting started, core concepts
- `--depth=intermediate`: Advanced features, common patterns, real-world usage
- `--depth=advanced`: Expert techniques, edge cases, performance optimization

**Focus Areas:**
- `--focus=tutorial` (default): Step-by-step guides, hands-on examples
- `--focus=overview`: Conceptual understanding, architecture, ecosystem
- `--focus=best-practices`: Industry standards, common pitfalls, expert advice

### Search Targets
1. **Official documentation** - authoritative source, latest features
2. **Tutorial sites** - practical guides, code examples
3. **Expert blogs** - real-world insights, best practices
4. **Recent articles** (last 12 months) - current trends, updates
5. **Community resources** - Stack Overflow, Reddit, forums

### Learning Extraction
For each source, extract:
- **Key concepts** with brief explanations
- **Getting started steps** or installation process
- **Common use cases** and examples
- **Best practices** and gotchas to avoid
- **Related tools/technologies** in the ecosystem

### Memory Bank Storage
Save to `## Memory Bank` section in CLAUDE.md:

```
- [DATE]: Learned about [TOPIC]
  - Core concepts: [3-5 key points]
  - Getting started: [essential first steps]
  - Key resources: [2-3 best sources with URLs]
  - Next steps: [recommended learning path]
```

### Output Format
**Immediate Learning Summary:**
- **What is [TOPIC]:** 2-3 sentence overview
- **Key Concepts:** 4-6 essential points to understand
- **Getting Started:** 3-4 actionable first steps
- **Best Practices:** Top 3-4 recommendations from experts
- **Common Pitfalls:** What to avoid based on community wisdom
- **Learning Path:** Recommended next steps for deeper knowledge

**Saved to Memory Bank:** ✅ Essential learnings stored for future reference

**Top Resources Found:**
1. [Source Name] - [Key insight/utility]
2. [Source Name] - [Key insight/utility]
3. [Source Name] - [Key insight/utility]

> Focus on actionable, practical knowledge that can be immediately applied.