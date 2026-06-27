# Cloud Agent Startup — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-26
**Applies to:** Cloud agents (claude.ai, scheduled runs, remote CI) — NOT local Claude Code sessions

---

## What You Are Running In

You are a cloud agent. You do NOT have access to:

- Adam's local Linux filesystem (`/home/adamgoodwin/...`)
- Adam's local Windows machine
- The Graphify CLI (`graphify`, `graphify update`, `/graphify`)
- `/compact` or `/clear` — these are Claude Code CLI commands, meaningless here
- Local shell execution of any kind unless explicitly provided via a tool
- The master env file (`/home/adamgoodwin/code/.env.master`)

You DO have access to:

- GitHub MCP — read files, create branches, open PRs, push commits to `Adamgdwn` org
- Any MCP tools configured for this session (Supabase, Stripe, Vercel, etc.)
- Web search / fetch if enabled

**Machine boundaries are irrelevant to you.** `the-freedom-engine-os` (Linux) and `gail-ai-operating-system-rev-2` (Windows) are both GitHub repos you access the same way. The machine tags in the dispatch file tell you whether *test execution* or *runtime validation* requires a physical machine — not whether you can read or write the repo.

---

## Startup Sequence (Cloud)

1. Read `docs/build-control/cloud-dispatch.yaml` in this repo — find an unclaimed `available` task matching your capabilities and the session's available tools
2. Check GitHub for an existing branch matching `cloud/{task-id}-*` in the target repo — if a branch exists, that task is already claimed; pick a different one
3. Read the task's `chunk_spec_ref` file for full acceptance criteria before touching any files
4. Read the target repo's `AGENTS.md` via GitHub MCP
5. Create a feature branch (`cloud/{task-id}-{short-slug}`) — **branch creation is your claim lock**
6. Make changes
7. Open a PR to `main` in the target repo
8. Update `cloud-dispatch.yaml` in your PR: set `status: ready-for-review`, fill `branch` and `pr_url`

---

## Branch Strategy (Mandatory)

- **Never push directly to `main`** in any repo — always create a feature branch first
- Branch naming: `cloud/{task-id}-{short-slug}` — e.g., `cloud/0.2-freedom-framing`
- One task per branch — do not bundle unrelated tasks
- PR title format: `[CNS Task {id}] {title}`

This is not optional. Adam may have uncommitted local changes in any repo at any time. Direct pushes to main cause merge conflicts when he pulls.

---

## Claim / Lock Pattern

GitHub branch creation is the lock. The race condition is handled as follows:

1. Check `cloud-dispatch.yaml` for `status: available`
2. Check GitHub branches in the target repo for `cloud/{task-id}-*`
3. If no branch exists → create your branch immediately → you own this task
4. If a branch already exists → someone else claimed it → pick a different task
5. If you cannot create a branch (network error, permission issue) → stop and surface the issue in a comment

Do not claim two tasks simultaneously in one session.

---

## Cross-Repo Context (No Graphify CLI)

You cannot run the Graphify CLI. Do not attempt `graphify`, `graphify update`, or `/graphify`.

For architecture and dependency context, read these files in this control repo:

- `docs/build-control/master-plan-summary.md` — CNS model, repo inventory, phase plan
- `docs/build-control/dependency-graph.md` — layer order, blocking dependencies
- `docs/build-control/handoff-state.md` — current phase, active blockers, open questions

For Phase 0 docs tasks, these are sufficient. Graphify is not needed.

---

## Close-Out Protocol (Cloud)

At the end of every task:

1. Confirm all acceptance criteria from the chunk spec are met
2. Open a PR with title: `[CNS Task {id}] {title}`
3. PR description must include:
   - What was changed and why
   - Which acceptance criteria are met (checkboxes)
   - Any known gaps or follow-up items
   - Link back to the chunk spec (`docs/build-control/{chunk-spec-file}`)
4. In the same PR, update `docs/build-control/cloud-dispatch.yaml`: set `status: ready-for-review`, fill `claimed_by`, `branch`, and `pr_url` fields
5. Do NOT self-merge — Adam reviews and merges

There is no `/compact`. End your session after opening the PR.

---

## Blocked? Surface It.

If you hit a blocker (missing file, unclear spec, access denied, conflicting branch state):

1. Open a PR with what you have, even if partial
2. Prefix the PR title with `[BLOCKED]`
3. Describe the blocker clearly in the PR body — what you needed, what you found, what the options are
4. Do not guess or invent information to get past a blocker — stop and surface it

---

## Environment Requirements

See `docs/cloud-env-requirements.md` for what credentials and MCP tools are needed per task type.

**Phase 0 docs tasks:** Only GitHub MCP access is needed. No API keys required. Private repos (`change-leadership-tools`, `clean-pdf-build`) require the GitHub token to have `repo` scope.
