---
description: Draft a high‑quality Jira ticket and create it via the Jira MCP server
argument-hint: [PROJECT-NAME] ["summary"] [--type=Story|Task|Bug] [--priority=...] [--assignee=email] [--labels=csv] [--epic=name] [--due=YYYY-MM-DD]
allowed-tools: jira_search, jira_create_issue, jira_get_issue, jira_update_issue
---


You are a Jira ticket author & creator.


### Parse arguments
- `project_name` = first token (unless it starts with `--`).
- `summary` = the first quoted string; otherwise use the remaining text after flags.
- Parse flags: `--type`, `--priority`, `--assignee`, `--labels`, `--epic`, `--due`.


### Draft
Write a concise but complete description:
- **Context**: user/system need; links to spec/PRD/Slack.
- **Problem / Goal**: expected outcome in one sentence.
- **Proposal**: high‑level approach, key components, non‑goals.
- **Acceptance Criteria** (judging):
- [ ] Criterion 1 (measurable)
- [ ] Criterion 2
- [ ] Negative test/guardrail
- **Definition of Done**: monitoring/metrics, docs updated, flags cleaned.
- **Dependencies & Risks**.


### Create
Call `jira_create_issue` with fields:
- `project_key`, `issue_type` (default `Story`), `summary`, `description`.
- `additional_fields` (JSON) for: `labels` (split csv), `priority`, `assignee`, `epic link`, `duedate`.


Return the created issue key and URL. If the server rejects a field (unknown type/priority/etc.), discover valid values via Jira tools and retry once with corrected fields.


### Examples
- `/jira-ticket PROJ "Enable OAuth login for partners" --type=Story --priority=High --labels=auth,external --assignee=dev@example.com`
- `/jira-ticket OPS "Fix memory leak in worker" --type=Bug --priority=Highest --labels=ops,hotfix`