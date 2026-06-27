# Current Build Pathway

Last Updated: 2026-06-26
Status: draft
Owner: Technical Lead

> **Single active pathway document.** This is the one active pathway for this project.
> All prior pathway, deployment-plan, and build-plan documents in this repo must carry
> `Status: superseded` and reference this file.

## Purpose

This document is the live path from current plan to completed build. It keeps agent work small, timestamped, and easy to resume.

## Required Work Pattern

For ordinary scoped work, use lean startup:

1. Check `git status --short`.
2. Read the short repo-local agent instructions.
3. Use `docs/context-map.md` when context routing is unclear.
4. Inspect only the specific files, errors, or docs needed for the task.
5. Run targeted validation after the change.

For material or risk-triggering work sessions:

1. Start from `START_HERE.md`.
2. Run `bash scripts/governance-preflight.sh`.
3. Review `docs/standards/README.md`.
4. Review `docs/standards/engineering-governance-by-use-case.md`.
5. Review `docs/policy/durable-development-engineering-policy.md`.
6. Review `docs/standards/ship-ready-engineering-standard.md`.
7. Review `project-control.yaml` and open exceptions.
8. Capture a timestamp with `date -Iseconds`.
9. Define the next build chunk in this document.
10. Complete and validate that chunk before expanding scope.
11. Update this document with status, validation, and the next chunk.

Risk-triggering work includes production, deployment, authentication, authorization, payments, secrets, sensitive data, database migrations, customer communications, external side effects, infrastructure or provider settings, destructive actions, autonomous tool use, risk classification, governance policy changes, or release readiness.

After compaction or a context clear, restart from the latest handoff or active
work packet, then run `git status --short`, read short repo-local instructions,
and open only this plan plus the files needed for the next objective.

## Chunking Standard

Each build chunk should be small enough to fit comfortably in an agent context window.

A good chunk has:

- one objective
- a budget class: Tiny, Small, Medium, Large, or Strategic
- a target completion state
- clear acceptance criteria
- clear input files or documents
- clear output files or behavior
- explicit validation steps
- an explicit stop condition or escalation trigger
- a timestamped status note

Use second-level Markdown headings for active and planned chunks so they are easy to scan. Spell out the chunk number in the heading:

```md
## Chunk One - Short Objective
## Chunk Two - Short Objective
```

Continue the pattern for later chunks: `## Chunk Three - ...`, `## Chunk Four - ...`, and so on.

Avoid mixing unrelated code, governance, deployment, and product decisions in one chunk unless the change cannot be validated any other way.

## Active Path

| Step | Status | Timestamp | Owner | Notes |
|------|--------|-----------|-------|-------|
| Cloud agent infrastructure setup | complete | 2026-06-26 | Claude Code | All cloud agent files written and committed. See Chunk One. |
| Loop coordination infrastructure | complete | 2026-06-26 | Claude Code | Loop protocol, auto-refresh mechanism, loop state tracking. See Chunk Three. |
| Compaction-first loop protocol | complete | 2026-06-26 | Claude Code | Mandatory compaction, richer checkpoint format, rehydration spec. See Chunk Four. |
| Phase 0 cloud agent runs | planned | — | Claude Code (/loop) | 11 PRs across 9 repos. Run `/loop coordinate CNS build`. See Chunk Two. |
| CP-0 gate | pending | — | Adam | All Phase 0 PRs merged. All repos can map purpose to CNS layer. |

## Chunk One - Cloud Agent Infrastructure Setup

Status: complete
Date: 2026-06-26

Completion target: Task complete

Budget class: Small

Objective: Set up all infrastructure needed for cloud agents to operate on Phase 0 tasks in a structured, safe, and repeatable way — fixing broken local-path references in startup docs, creating machine-readable task dispatch, writing detailed chunk specs, and documenting env requirements.

Acceptance criteria:

- [x] `docs/cloud-agent-startup.md` created — cloud-safe startup instructions, branch strategy, claim/lock pattern, close-out protocol
- [x] `docs/build-control/cloud-dispatch.yaml` created — machine-readable dispatch with 11 available Phase 0 tasks, platform tags, branch naming convention
- [x] `docs/build-control/2026-06-26 - phase-0-chunk-specs.md` created — detailed specs for tasks 0.2–0.7f with acceptance criteria, templates, and stop conditions
- [x] `docs/cloud-env-requirements.md` created — env var and MCP tool requirements by phase and task type
- [x] `AGENTS.md` updated — cloud agent banner at top, Graphify Policy conditional, Close-Out Protocol updated (no /compact in cloud)
- [x] `AI_BOOTSTRAP.md` updated — Graphify Policy conditional, Commands section filled in (N/A — coordination repo)
- [x] `docs/build-control/repo-workstream-board.md` updated — Platform column added to Phase 0 and Phase 1 tables
- [x] All changes committed and pushed to GitHub

Inputs:

- `docs/build-control/handoff-state.md`
- `docs/build-control/repo-workstream-board.md`
- `AGENTS.md`, `AI_BOOTSTRAP.md`

Outputs:

- `docs/cloud-agent-startup.md`
- `docs/build-control/cloud-dispatch.yaml`
- `docs/build-control/2026-06-26 - phase-0-chunk-specs.md`
- `docs/cloud-env-requirements.md`
- Updated `AGENTS.md`, `AI_BOOTSTRAP.md`, `docs/build-control/repo-workstream-board.md`

Validation:

- Human review: open `cloud-dispatch.yaml` — confirm task list, branch strategy, platform tags
- Human review: open `cloud-agent-startup.md` — confirm startup sequence is cloud-safe (no local paths)
- Human review: open `AGENTS.md` — confirm cloud banner is at top of file

Stop condition: N/A — chunk complete.

Known gaps:

- GitHub Actions CI not yet added to `gail-ai-operating-system-rev-2` — Phase 1 code tasks cannot be fully validated by cloud agents until this is set up
- Private repos (0.7d change-leadership-tools, 0.7e clean-pdf-build) may need explicit `repo` scope confirmation on GitHub token before cloud agent can access them

Next action: Run first cloud agent against dispatch task 0.2, or run all 0.2–0.7f tasks in parallel.

---

## Chunk Two - Phase 0 Cloud Agent Runs

Status: planned

Completion target: Task complete

Budget class: Small

Objective: Run cloud agents against all available Phase 0 dispatch tasks (0.2–0.7f). Each agent opens one PR per task to the target repo. Adam reviews and merges. Phase 0 gate (CP-0) is confirmed when all PRs are merged.

Acceptance criteria:

- [ ] PRs opened for all 11 Phase 0 tasks (0.2, 0.3, 0.4, 0.5, 0.6, 0.7a–0.7f)
- [ ] Each PR contains correct CNS framing per chunk spec in `docs/build-control/2026-06-26 - phase-0-chunk-specs.md`
- [ ] Adam reviews and merges each PR
- [ ] `cloud-dispatch.yaml` updated: all 0.x tasks marked `complete` (by agent in their PR)
- [ ] `repo-workstream-board.md` Phase 0 tasks updated to `complete`
- [ ] CP-0 confirmed: all repos can map their purpose to CNS layer

Inputs:

- `docs/build-control/cloud-dispatch.yaml`
- `docs/build-control/2026-06-26 - phase-0-chunk-specs.md`
- `docs/cloud-agent-startup.md`

Outputs:

- 11 PRs across 9 repos
- All Phase 0 tasks marked `complete` in dispatch and workstream board

Validation:

- Human review of each PR before merge
- After all merges: check Phase 0 table in `repo-workstream-board.md` — all rows should be `complete`

Stop condition: Stop if a task is blocked (access denied, conflicting framing). Surface as `[BLOCKED]` PR in control repo. Do not skip blocked tasks silently.

Known gaps:

- 0.7d and 0.7e are private repos — may be blocked by token scope
- If GitHub Actions is added to GAIL OS Rev 2 before chunk two is complete, Phase 1 code tasks become cloud-validated

Next action: After CP-0 — update `handoff-state.md` Phase 0 status. Then proceed to Phase 1 (Chunk 20 in `gail-ai-operating-system-rev-2`, Windows-local).

## Chunk Three - Loop Coordination Infrastructure

Status: complete
Date: 2026-06-26

Completion target: Task complete

Budget class: Small

Objective: Build the autonomous coordination loop so that a local Claude Code session can run `/loop coordinate CNS build` and execute all Phase 0 tasks across all subject repos, auto-refreshing context via `ScheduleWakeup` before hitting token limits, and resuming cleanly from persistent loop state in `handoff-state.md`.

Acceptance criteria:

- [x] `docs/loop-protocol.md` created — full iteration protocol: startup sequence, task selection, execution by type, token budget check, context refresh via ScheduleWakeup, stop conditions, loop state format
- [x] `AGENTS.md` updated — `## Loop Mode` section added with `/loop coordinate CNS build` entry point
- [x] `docs/build-control/handoff-state.md` updated — `## Loop State` block added at top for mid-task resume state
- [x] `docs/current-build-pathway.md` updated — Chunk Three added, Active Path table updated

Inputs:

- `docs/build-control/cloud-dispatch.yaml`
- `docs/build-control/2026-06-26 - phase-0-chunk-specs.md`
- `docs/cloud-agent-startup.md`

Outputs:

- `docs/loop-protocol.md`
- Updated `AGENTS.md`, `docs/build-control/handoff-state.md`

Validation:

- Human review: open `docs/loop-protocol.md` — confirm iteration structure, ScheduleWakeup mechanism, stop conditions, and loop state format are all present and actionable
- Human review: open `AGENTS.md` — confirm `## Loop Mode` section appears near top, before Normal Startup

Stop condition: N/A — chunk complete.

Next action: Run `/loop coordinate CNS build` in this repo to begin Phase 0 execution (Chunk Two).

---

## Chunk Four - Compaction-First Loop Protocol

Status: complete
Date: 2026-06-26

Completion target: Task complete

Budget class: Small

Objective: Rewrite the loop protocol so that compaction is the architectural core of multi-hour autonomous sessions — not an afterthought. Establish the `checkpoint → compact → rehydrate → continue` invariant on all runtime surfaces. Add richer checkpoint format and explicit rehydration spec so fresh contexts can resume without the chat transcript.

Acceptance criteria:

- [x] `docs/loop-protocol.md` — "Compaction — The Core Continuity Mechanism" section replaces "Token Budget and Context Refresh"
- [x] Invariant stated: `checkpoint → compact → rehydrate → continue`
- [x] Compaction threshold defined: 100,000 input tokens
- [x] Runtime-specific mechanisms: ScheduleWakeup (local /loop), auto-compaction (Claude Code web)
- [x] Safe checkpoint boundary rules defined
- [x] Trigger signals listed (any one sufficient)
- [x] "Rehydration — Minimum Context After Compaction" section added — 5-item minimum set + explicit "do not reload" list
- [x] Checkpoint format expanded: `exact_next_step`, `acceptance_criteria` (met/remaining), `decisions`, `validation`, `required_context_on_resume`, `compaction_count`, `current_phase`
- [x] `AGENTS.md` cloud banner updated — compaction required in all contexts; invariant stated; `/compact` no longer listed as local-only

Inputs:

- `docs/loop-protocol.md` (prior version)
- `AGENTS.md` (prior version)
- `2026-06-27-agentic-multi-agent-context-compaction-requirements.md` (user-provided requirements doc)

Outputs:

- `docs/loop-protocol.md` (rewritten compaction section + rehydration + checkpoint format)
- `AGENTS.md` (cloud banner corrected)

Validation:

- Human review: open `docs/loop-protocol.md` — confirm "Compaction" section leads with the invariant, defines both runtime paths, and rehydration section is present
- Human review: open `AGENTS.md` — confirm cloud banner states compaction required in all contexts

Stop condition: N/A — chunk complete.

Key decision: Adam confirmed — "cloud agents must compact is absolutely the answer and the loop inside must compact. That's the key to keeping this running for hours and hours without losing fidelity."

Next action: Run `/loop coordinate CNS build` in this repo to begin Phase 0 execution (Chunk Two).

---

## Timestamp Rule

Use ISO-style timestamps for work notes, handoffs, decisions, exceptions, release notes, and validation records. Prefer the local command:

```bash
date -Iseconds
```

## Validation Log

| Timestamp | Command | Result | Notes |
|-----------|---------|--------|-------|
| 2026-06-26 | `git status --short` | clean | Confirmed before Chunk One edits. |
| 2026-06-26 | Human review: `docs/cloud-agent-startup.md` | pending | Verify startup sequence has no local paths before first cloud agent run. |
| 2026-06-26 | Human review: `docs/build-control/cloud-dispatch.yaml` | pending | Verify task list, branch strategy, and platform tags. |

## Next Handoff

Next agent should use lean startup for ordinary scoped work: check `git status --short`, read short repo-local instructions, use `docs/context-map.md` when routing is unclear, inspect targeted files, and run targeted validation. After compaction or a context clear, resume from the latest handoff/work packet before loading more context. Use this file to identify the current chunk, budget class, target completion state, acceptance criteria, stop condition, validation status, known gaps, and next bounded action.
