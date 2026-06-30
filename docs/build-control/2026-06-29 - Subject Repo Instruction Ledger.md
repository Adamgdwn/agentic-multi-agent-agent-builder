# 2026-06-29 - Subject Repo Instruction Ledger

Document type: cross-repo instruction ledger
Date: 2026-06-29
Saved: 2026-06-29T19:30:23-06:00
Last Updated: 2026-06-29T19:30:23-06:00
Status: active
Owner: Adam Goodwin

## Purpose

This ledger keeps main subject-repo instructions separate and visible. Use it
when asking:

- which repo received which instruction;
- which repo is active, parked, queued, or historical;
- where a future agent should look before editing a subject repo;
- whether a cross-repo instruction has been applied locally in the subject
  repo.

This ledger does not replace repo-local `AGENTS.md`, `START_HERE.md`, active
work packets, or PR records. It indexes them so instructions do not blur across
repositories.

## Current Owner Direction

2026-06-29:

- stay away from Freedom for a bit because serious improvements are happening
  there separately;
- change gears into GAIL AI Operating System Rev 2 for informing and boundary
  alignment;
- keep Graphify as the lightning-fast relationship-transfer layer, not
  authority, execution, raw storage, or mandatory runtime ballast;
- clean up loose instruction ends so weak fallback layers and rework do not
  accumulate.

## Main Subject Repo Instruction Register

| Repo | Current state | Instruction currently applied | Durable place to read it | Notes |
|---|---|---|---|---|
| `agentic-multi-agent-agent-builder` | Active control plane | Keep per-subject-repo instructions in this ledger and route active plans through the handoff/board. | This file, `START_HERE.md`, `docs/build-control/handoff-state.md`, `docs/build-control/repo-workstream-board.md` | Draft PR: `https://github.com/Adamgdwn/agentic-multi-agent-agent-builder/pull/1`. This repo tracks cross-repo instructions; it should not silently become the implementation home for subject repo changes. |
| `gail-ai-operating-system-rev-2` | Active informing lane | Import the Graphify boundary revelation into GAIL OS planning: GAIL OS owns authority/evidence; Graphify may remember approved relationships but cannot approve or execute; Freedom implementation is parked. | `docs/decisions/2026-06-29 - Graphify Boundary Transfer And GAIL OS Informing Plan.md` in the GAIL OS repo | Draft PR: `https://github.com/Adamgdwn/gail-ai-operating-system-rev-2/pull/23`. Docs-only informing pass prepared on branch `docs/2026-06-29-gail-graphify-boundary-informing`. |
| `graphify-workspace-cockpit` | Active boundary/speed planning PR | Make Graphify the high-speed relationship-transfer function: bounded context packets, hot/warm/cold planes, no authority drift, no hot-path ballast. | Graphify PR #5 and `docs/2026-06-29 - Graphify Quantum Speed Execution Plan.md` in the Graphify repo | Graphify owns relationship intelligence and approved graph-memory writes, not GAIL OS authority or Freedom execution. |
| `the-freedom-engine-os` | Parked by current owner instruction | Do not start new Freedom implementation from this control-plane lane while Adam is actively improving Freedom elsewhere. Preserve prior Freedom executive-capability plan as historical/queued guidance. | `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md` in this control repo, plus Freedom repo-local docs when work resumes | Existing Freedom capability concern remains real, but current instruction is to stay out for now. |
| `ag-operations-m365-foundation` | Queued support lane | Keep M365 bridge readiness/document prep queued. No live M365 writes or business-system actions without a fresh owner gate. | `docs/build-control/repo-workstream-board.md`, hosting/infrastructure docs, and AG Operations repo-local records | H6 remains useful but secondary to the active GAIL OS informing lane. |
| Product app repos | Historical/abandoned Phase 5 branches unless explicitly reopened | Do not restart product event-emitter branches from old Phase 5 notes. Product surfaces remain future sensory/motor circuits. | `docs/build-control/repo-workstream-board.md` and Phase 5 reset records | Avoid reviving abandoned event-emitter paths by accident. |

## Active Instruction Packets By Repo

### Control Repo

Active:

- `docs/build-control/2026-06-29 - Subject Repo Instruction Ledger.md`
- `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`
- `docs/build-control/handoff-state.md`
- `docs/build-control/repo-workstream-board.md`

Queued or historical:

- `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`
  is retained as the Freedom capability refactor reference, but Freedom
  implementation is currently parked.

### GAIL OS Rev 2

Active:

- `docs/decisions/2026-06-29 - Graphify Boundary Transfer And GAIL OS Informing Plan.md`

Applied instruction:

- treat GAIL OS as the authority/evidence spine;
- clarify "read-only Graphify" as no authority or execution transfer, not a ban
  on approved graph-memory writes;
- shape future Graphify learning lanes as owner-gated connector-like
  boundaries;
- keep Freedom implementation out of this lane.

### Graphify Workspace Cockpit

Active:

- Graphify PR #5, "Refactor Graphify CNS speed plan"
- `docs/specs/2026-06-29 - Graphify Function Boundary And Speed Doctrine.md`
- `docs/2026-06-29 - Graphify Quantum Speed Execution Plan.md`

Applied instruction:

- make Graphify the function that transfers relationship context at high speed;
- serve bounded context packets instead of full graph dumps;
- keep authority and execution out of Graphify;
- keep extraction and learning writes out of the hot read path.

### Freedom Engine

Parked:

- no new control-plane-driven Freedom implementation while Adam is actively
  improving Freedom elsewhere.

Retained reference:

- `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`

Resume condition:

- Adam explicitly routes a session back into Freedom, or a Freedom repo PR/issue
  asks for review, CI, or implementation support.

### AG Operations / M365 Foundation

Queued:

- H6 M365 bridge readiness docs/prep.

Boundary:

- no live M365 business writes, sends, Planner changes, SharePoint mutations,
  Power Automate changes, Exchange configuration changes, or tenant-scope
  expansion without a fresh owner gate.

## Ledger Maintenance Rule

When a subject repo receives a material new instruction, add or update one row
here and link the subject repo's durable packet. Do not bury repo-specific
instructions only in chat, PR body text, or a generic handoff.

When a repo is parked, say so explicitly and preserve the resume condition.

When an older instruction remains true but is no longer the active lane, mark it
as queued, retained reference, historical, or superseded.
