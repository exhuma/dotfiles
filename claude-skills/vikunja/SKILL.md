---
name: vikunja
description: Query and manage tasks on the user's self-hosted Vikunja instance via the `vk` CLI. Use when the user asks what to work on, to check/look at/update Vikunja, to find candidate tasks, or references a Vikunja task by id or title. Requires VIKUNJA_URL and VIKUNJA_TOKEN to be set in the environment.
---

# Vikunja

`vk` (in `~/dotfiles/bin`, already on `PATH`) is a thin, policy-free CLI
wrapper around the Vikunja REST API. It reads `VIKUNJA_URL` and
`VIKUNJA_TOKEN` from the environment — if either is unset, `vk` exits with an
error; tell the user to export them rather than asking for the values
yourself. This skill is the policy layer: it says which tasks matter and how
to treat them once `vk` gets you the data.

## Candidate tasks

A **candidate** is a task that is not done, and is either unassigned or
assigned to the human user (`VIKUNJA_OWNER`, default `exhuma`). This is
exactly what `vk candidates [--project ID]` returns, across every
non-archived project, ranked highest-priority-first:

1. Vikunja's native `priority` (0=unset .. 4=DO NOW), descending.
2. Within equal priority, an `impact:low|medium|high` minus `cost:low|medium|high`
   label score, where both labels are present (higher impact / lower cost
   ranks first). Only a subset of tasks — mostly GitHub-issue-mirrored ones
   in the `Code` and `Repos` projects — carry these labels.
3. Soonest `due_date` as the final tiebreaker.

Use `vk candidates` to answer "what should I work on?" / "what's on my
plate?". Use `vk candidates --project ID` (see `vk projects` for ids) to
scope to one project. `vk show TASK_ID` gives full detail (description,
labels, current bucket, comments) for one task.

## Working agreement (shared, multi-agent instance)

This Vikunja instance is shared between the user, this and other Claude Code
instances, and other bots (e.g. a "Hermes" integration). The rules below come
from the **"Agentic Helper"** project's (id 15) own in-app description — the
canonical, occasionally-updated source. Re-read it with `vk project 15` if
something here seems stale. They apply as safe defaults everywhere, since
other bots/humans touch multiple projects:

- **Read before you write.** Always `vk show TASK_ID` immediately before
  changing it. Never overwrite a title or description you didn't write —
  use `vk comment` to add information instead.
- **Identify yourself.** Every comment you post should start with who you
  are, e.g. `Claude Code (bot-local-claude): ...`. Get the exact identity
  string by running `vk whoami` — it differs per machine (e.g.
  `bot-local-claude` here, `bot-claude-basilisk` elsewhere), so don't
  hardcode a name from a past session.
- **No secrets.** Never put tokens, passwords, or credentials in a task
  title, description, or comment. Variable *names* are fine.
- **Claim before you act.** Before starting real work on a candidate task,
  run `vk assign TASK_ID --me` (assigns to whichever identity `VIKUNJA_TOKEN`
  authenticates as — this makes it visible to the user and other bots that
  you're the one acting on it now). Release it with `vk assign TASK_ID
  --unassign` if you stop without finishing.
- **Bucket names are load-bearing in `Agentic Helper` (project id 15).**
  `Triage → Backlog → Ready → In Progress → Waiting on Michel → Review →
  Done / Archive`. The names `Ready`, `In Progress`, and `Review` are looked
  up by name by another integration — never rename them, and use `vk move
  TASK_ID "<name>"` (exact match) to relocate a task.
- **In `Agentic Helper` specifically: finished agent work goes to `Review`,
  never `done`.** Use `vk move TASK_ID Review`, not `vk done`, when you
  finish something there — the user closes it out themselves. In any other
  project (no such bucket convention exists), `vk done TASK_ID` is fine once
  work is actually complete.

## Command reference

| Command | Purpose |
|---|---|
| `vk projects` | List non-archived projects (id + tree) |
| `vk project ID [--json]` | One project's description + kanban buckets |
| `vk candidates [--project ID] [--json]` | Ranked list of candidate tasks |
| `vk show TASK_ID [--json]` | Full task detail + comments + current bucket |
| `vk comment TASK_ID "text"` | Append a comment (always self-identify) |
| `vk assign TASK_ID --me` \| `--unassign` | Claim / release a task |
| `vk move TASK_ID "Bucket Name"` | Move a task to a named kanban bucket |
| `vk done TASK_ID` | Mark a task done (not for `Agentic Helper` — see above) |
| `vk labels [--json]` | List all labels |
| `vk label TASK_ID NAME [--remove]` | Add/remove a label |
| `vk whoami [--json]` | Show the identity `VIKUNJA_TOKEN` authenticates as |

All commands print plain text by default; add `--json` for machine-readable
output when you need to post-process results.
