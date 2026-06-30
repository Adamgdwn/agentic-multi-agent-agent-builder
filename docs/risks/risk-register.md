# Risk Register

## Current Risk Classification

- Tier: strategic
- Owner: Adam Goodwin
- Last reviewed: 2026-06-29T19:30:23-06:00

## Key Risks

| ID | Risk | Likelihood | Impact | Controls | Owner | Status |
| --- | --- | --- | --- | --- | --- | --- |
| R-001 | Subject-repo instructions blur together, causing agents to apply a Freedom, Graphify, GAIL OS, AG Operations, or product-repo instruction in the wrong repository. | Medium | High | Maintain `docs/build-control/2026-06-29 - Subject Repo Instruction Ledger.md`; update `START_HERE.md`, `handoff-state.md`, and `repo-workstream-board.md` when active/parked lanes change. | Build Agent Orchestrator | Open |
| R-002 | Freedom work restarts from older "next priority" text despite Adam's current instruction to stay away while improvements happen elsewhere. | Medium | High | Handoff and board now mark Freedom implementation parked; Freedom forward refactor retained only as reference until Adam explicitly routes back. | Build Agent Orchestrator | Open |
| R-003 | Graphify boundary drift turns relationship intelligence into authority, execution, raw storage, or mandatory runtime ballast. | Medium | High | Apply `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`; Graphify/GAIL OS docs clarify no authority or execution transfer and owner-gated learning lanes. | Build Agent Orchestrator | Open |
