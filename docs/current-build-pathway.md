# Current Build Pathway

Last Updated: 2026-06-29T20:11:10-06:00
Status: task complete (2026-06-29T20:11:10-06:00)
Owner: Technical Lead

> **Single active pathway document.** This is the one active pathway for this project.
> All prior pathway, deployment-plan, and build-plan documents in this repo must carry
> `Status: superseded` and reference this file.

## Purpose

This document is the live path from current plan to completed build. It keeps agent work small, timestamped, and easy to resume.

## 2026-06-29 Forward Reset

The forward build path is now governed by:

- `docs/build-control/handoff-state.md`
- `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`
- `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`

Older chunks in this file remain historical evidence unless they are listed in the current Active Path table. Do not use old Phase 1, Phase 5, Phase 6, or Phase 7 planning rows as next-task authority when they conflict with the handoff or the 2026-06-29 forward refactor.

2026-06-29 M365 redirection: Adam pulled AG Operations / M365 forward for
bridge-readiness informing. M365 should be ready as a daily team workspace and
as a powerful agentic IO substrate, but Freedom-origin M365 task completion
routes through GAIL OS authority/evidence. No live M365 writes, app consent,
permission changes, source webhooks, external sends, or unattended automation
were opened by this docs/config pass.

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
| Phase 0 cloud agent runs | complete | 2026-06-27 | Claude Code (/loop) | All 11 PRs opened and merged. See Chunk Two. |
| CP-0 gate | complete | 2026-06-27 | Adam | All Phase 0 PRs merged. All 9 repos mapped to CNS layer. |
| Phase 1–6 CNS spine, knowledge mesh, and R4 proof | complete | 2026-06-28 | Build agents | Phases 0–6 complete. See `docs/build-control/handoff-state.md`. |
| Phase 7 H0–H5 + H5-apply | complete | 2026-06-28 | Windows/Linux local | Azure pilot live; Supabase RLS applied to hosted Freedom project. |
| Graphify connective-layer boundary | complete | 2026-06-29 | Adam / Build agent | Graphify is connective infrastructure, not mandatory runtime ballast. |
| Forward plan refactor + stale-doc cleanup | complete | 2026-06-29T19:02:26-06:00 | Codex | Freedom capability concern documented; retained as reference while current owner direction parks Freedom implementation. |
| Subject repo instruction ledger + GAIL OS informing route | complete | 2026-06-29T19:30:23-06:00 | Codex | Keep repo instructions separate. GAIL OS PR #23, Graphify PR #5, and control PR #1 merged. |
| AG Operations M365 agentic IO bridge readiness | active | 2026-06-29T20:11:10-06:00 | Codex | M365 PR #5 opened with docs/config contract for information-out, information-in, triggered-action, and deliverable-out lanes. Freedom-origin task completion routes through GAIL OS authority/evidence. |
| Freedom executive capability build | parked | — | Freedom build session | Resume only when Adam explicitly routes back or Freedom asks for review/CI/implementation support. |
| H6 M365 readiness docs | active-subsumed | 2026-06-29T20:11:10-06:00 | Codex | Subsumed into AG Operations M365 agentic IO bridge readiness docs/config pass. No live M365 writes. |
| BLK-004 Windows Graphify extraction | queued-secondary | — | Windows | Useful relationship coverage, but not a blocker for active GAIL OS informing. |

## Current Forward Chunk - Subject Repo Instruction Ledger And GAIL OS Informing Route

Status: complete
Date: 2026-06-29T19:30:23-06:00

Completion target: Task complete

Budget class: Strategic

Objective: Keep main subject-repo instructions separate and redirect the active
control-plane lane away from Freedom implementation and into GAIL OS informing
for the Graphify boundary transfer.

Acceptance criteria:

- [x] Subject repo instruction ledger exists and names active, parked, queued,
  and historical lanes.
- [x] `START_HERE.md`, `handoff-state.md`, and `repo-workstream-board.md`
  point to the ledger and mark Freedom implementation parked.
- [x] GAIL OS has a repo-local informing packet for the refined Graphify
  boundary.
- [x] Validation is recorded honestly.
- [x] Changes are committed, pushed, and PRs are opened.

Stop condition: stop before Freedom implementation, live M365 writes, Graphify
persistent ingest, Azure setting changes, secret handling changes, or R4 live
execution.

Validation and closeout:

- `git diff --check` passed.
- Targeted stale-route scan passed.
- `bash scripts/governance-preflight.sh` failed on known control-repo validator
  gaps: `project-control.yaml` uses `risk_tier: strategic` and
  `repository_model: multi-repo-coordination`, which the current validator does
  not accept.
- GAIL OS PR opened: `https://github.com/Adamgdwn/gail-ai-operating-system-rev-2/pull/23`.
- Control repo PR opened: `https://github.com/Adamgdwn/agentic-multi-agent-agent-builder/pull/1`.

Closeout update 2026-06-29T20:11:10-06:00:

- GAIL OS PR #23 merged.
- Graphify PR #5 merged.
- Control repo PR #1 merged.

## Current Forward Chunk - AG Operations M365 Agentic IO Bridge Readiness

Status: active
Date: 2026-06-29T20:11:10-06:00

Completion target: Task complete

Budget class: Strategic

Objective: Pull the AG Operations / M365 foundation repo forward for bridge
readiness so Microsoft 365 remains a strong daily team workspace and becomes a
well-bounded agentic IO substrate for information-out, information-in,
triggered-action, and deliverable-out lanes.

Acceptance criteria:

- [x] AG Operations repo has an active agentic IO / GAIL OS bridge contract.
- [x] AG Operations repo has a structured companion config for future surface
  review/preflight work.
- [x] Startup, active plan, Stage 9, source-map, and index docs route future
  agents to the new contract.
- [x] Direct Freedom-to-M365 writes are explicitly blocked; Freedom-origin M365
  task completion routes through GAIL OS authority/evidence.
- [x] Validation is recorded honestly.
- [x] M365 PR is opened.
- [x] Control repo ledger/pathway update is committed, pushed, and PR opened.

Stop condition: stop before live M365 business writes, sends, Planner changes,
SharePoint mutations, Power Automate changes, Exchange configuration changes,
app registration, consent, permission changes, source webhooks, source secrets,
external sends, unattended automation, or direct Freedom-to-M365 writes.

Validation and closeout:

- AG Operations `jq . config/M365_AGENTIC_IO_GAIL_OS_BRIDGE_CONTRACT.json`
  passed.
- AG Operations `git diff --check` passed.
- AG Operations targeted stale-route scan passed.
- AG Operations Markdown fence balance check passed.
- AG Operations draft PR opened:
  `https://github.com/Adamgdwn/ag-operations-m365-foundation/pull/5`.
- Control repo draft PR opened:
  `https://github.com/Adamgdwn/agentic-multi-agent-agent-builder/pull/2`.

## Current Forward Chunk - Graphify Boundary Plan Refactor

Status: complete
Date: 2026-06-29T19:02:26-06:00

Completion target: Task complete

Budget class: Strategic

Objective: Refactor the control repo's live plan so future work builds a fast, usable Freedom executive capability while preserving Graphify as relationship infrastructure and GAIL OS as the authority/evidence layer.

Acceptance criteria:

- [x] Forward capability refactor exists as a dated build-control document.
- [x] Current pathway points to the forward refactor and Graphify boundary note.
- [x] Workstream board no longer presents old Phase 5/6 rows as blocked future work.
- [x] H5 hosted Supabase apply status is corrected where stale.
- [x] Older planning docs are marked historical or superseded for forward planning.
- [x] Governance preflight result is recorded honestly.

Next action superseded 2026-06-29T19:30:23-06:00: Freedom implementation is
parked by current owner direction. Use the subject repo instruction ledger and
GAIL OS informing packet instead.

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

Status: complete
Date: 2026-06-27

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

## Chunk Five - Phase 1 CI and Test Harness Setup

Status: historical / superseded
Date: —

Completion target: Task complete

Budget class: Tiny

Objective: Historical Phase 1 setup plan retained for evidence. Do not use as current next work; Phase 1 is complete.

Acceptance criteria:

- [ ] `.github/workflows/ci.yml` merged to main in `gail-ai-operating-system-rev-2`
- [ ] Workflow triggers on `push` and `pull_request` to `main`
- [ ] Runs `python -m pytest tests/` (or `unittest discover` if pytest not available)
- [ ] Workflow passes on a clean repo (no tests yet = zero failures, not an error)
- [ ] `cloud-dispatch.yaml` task 1.0 marked `complete`
- [ ] Phase 1 code tasks (1.1–1.4) unblocked from 1.0 dependency (updated to `available` in dispatch)

Inputs:

- `gail-ai-operating-system-rev-2` repo structure (read via GitHub MCP to confirm Python layout)
- `docs/build-control/2026-06-25 - phase-1-chunk-specs.md`

Outputs:

- `.github/workflows/ci.yml` in `gail-ai-operating-system-rev-2`
- Updated `cloud-dispatch.yaml`: task 1.0 → `complete`, tasks 1.1/1.3/1.4 → `available`

Validation:

- GitHub Actions run passes on merge (zero test failures on a clean repo is a pass)
- `cloud-dispatch.yaml` reflects updated task statuses

Stop condition: Stop if GitHub Actions is already configured (check before creating). If present, skip and mark task 1.0 complete immediately.

Platform: cloud-safe (GitHub MCP only — write one YAML file, open one PR)

Next action: Superseded by completed Phase 1 work and the 2026-06-29 forward reset above.

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
| 2026-06-29T19:02:26-06:00 | `bash scripts/governance-preflight.sh` | failed: 2 pre-existing errors | Validator does not accept intentional `risk_tier: strategic` and `repository_model: multi-repo-coordination`. |

## Next Handoff

Next agent should use lean startup for ordinary scoped work: check `git status --short`, read short repo-local instructions, use `docs/context-map.md` when routing is unclear, inspect targeted files, and run targeted validation. For forward CNS capability work, resume from `docs/build-control/handoff-state.md`, then read the 2026-06-29 forward refactor and Graphify boundary note before touching target repos. The next bounded action is F1 in `the-freedom-engine-os`: audit Freedom's actual AI capability path and write the build packet for the first usable executive pathway.
