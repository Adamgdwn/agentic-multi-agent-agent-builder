# 2026-06-29 - Forward Plan Refactor - Freedom Executive Capability

Status: retained reference; Freedom implementation parked by 2026-06-29 owner redirection
Owner: Adam Goodwin / Build Agent Orchestrator
Created: 2026-06-29T19:02:26-06:00
Last Updated: 2026-06-29T19:30:23-06:00

## Purpose

This note refactors the forward CNS build direction after Adam's 2026-06-29 Graphify boundary refinement.

The goal is a tight, fast, extensively capable multi-layer CNS where Freedom is the usable executive front door, GAIL OS is the authority and evidence layer, and Graphify is relationship intelligence and routing infrastructure. Infrastructure that exists but cannot be used through Freedom is not enough.

2026-06-29 update: Adam has serious Freedom improvements happening elsewhere
and directed this control-plane lane to stay away from Freedom for now. This
document remains the Freedom capability reference, but it is not current
permission to begin Freedom implementation. Use
`docs/build-control/2026-06-29 - Subject Repo Instruction Ledger.md` and
`docs/build-control/handoff-state.md` for the active/parked repo lane.

This document supersedes older forward-looking next-task language only when
Freedom work is explicitly resumed. Historical documents remain useful
evidence, but they are not the current restart point while Freedom is parked.

Read order for future capability planning:

1. `docs/build-control/handoff-state.md`
2. `docs/build-control/2026-06-29 - Subject Repo Instruction Ledger.md`
3. `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`
4. This document only if Adam has explicitly resumed Freedom work
5. `docs/current-build-pathway.md`
6. Target-repo instructions for the repo being changed

## Build Thesis

The CNS only matters if Adam can use it through Freedom.

Forward work should deliver specific usable pathways, not broad connection inventory. Every chunk must answer:

- What can Adam ask Freedom to do after this chunk that he could not do before?
- Which layer owns the capability?
- What is the fastest sufficient context path?
- What authority, evidence, or rollback boundary applies?
- What graceful degraded behavior exists when a layer is unavailable?

Avoid "connected but empty" outcomes. A connection is useful only when Freedom can reason over it, explain it, and initiate the appropriate next step through the governed layers.

## Layer Contract

| Layer | Owns | Forward constraint |
|---|---|---|
| Freedom | Executive cognition, conversation, planning, operator-facing tool use, local workspace reach, answer synthesis, pathway initiation | Must become the usable front portal. It must not become a bypass around GAIL OS authority for external, destructive, or live business actions. |
| GAIL OS | Authority, action state, connector registry, policy gates, evidence, OKP creation, action audit trail | Must stay the system of control. It should expose deep, simple interfaces rather than passive records or thin pass-throughs. |
| Graphify | Relationship intelligence, dependency maps, source references, entity neighborhoods, provenance, memory stitching | Must remain connective infrastructure. Use bounded graph context when relationships matter; do not embed full graph artifacts into hot paths. |
| M365 / Azure / Supabase / product systems | Work surfaces, deployment substrate, app data, client or business body | Must be reached through explicit governed pathways, not ad hoc product-side shortcuts. |

Freedom should reach Codex/Claude-level depth for approved local workspace inspection and task initiation. Live external writes, production data changes, permission changes, destructive actions, and customer-visible side effects still route through GAIL OS authority and evidence.

## Context Speed Model

Use the cheapest tier that gives enough confidence.

| Tier | Role | Default budget | Rule |
|---|---|---|---|
| Hot | Active conversation, selected files, focused `rg`, direct file reads, cached summaries | Targeted search and up to a small set of file excerpts | Use first for most Freedom answers and local repo questions. |
| Warm | Graphify entity, path, dependency, source-ref, or neighborhood query | One or two bounded graph queries | Use when relationship intelligence changes the answer or route. |
| Cold | Graph extraction, graph update, large semantic refresh, cross-machine graph merge | Background chunk or maintenance task | Do not block a live Freedom interaction on cold graph work unless explicitly requested. |
| External | Provider-backed web/API research | Explicit scoped research task | Use when local CNS knowledge is insufficient or freshness matters. |

Graphify should make Freedom faster and more connected, not heavier.

## Forward Capability Sequence

### F0 - Plan and Handoff Cleanup

Status: complete when this document and linked cleanup edits are committed.

Objective: remove stale forward-plan traps and make the Graphify boundary part of the restart path.

Acceptance:

- Live handoff points to this document and the Graphify boundary note.
- Current pathway no longer points agents at old Phase 1 work as the next build.
- Workstream board reflects Phases 0-6 complete and H5-apply complete.
- Older turnover/build-plan docs are clearly marked historical or superseded for forward planning.

### F1 - Freedom Capability Audit and Build Packet

Repo: `the-freedom-engine-os`

Objective: inspect Freedom's actual AI entry points, provider routing, API routes, local tools, auth boundaries, and current GAIL OS / Graphify clients. Produce a concrete build packet for the first usable executive pathway.

Acceptance:

- Inventory the current Freedom AI/chat/orchestration path.
- Identify where tool planning and tool execution belong.
- Identify what local file/search/read capability exists or is missing.
- Identify what GAIL OS and Graphify calls are already usable.
- Define the first user-visible demo prompt and expected answer/action.
- Define tests and safety gates before implementation.

### F2 - Freedom Local Workspace Tool Spine

Repo: `the-freedom-engine-os`

Objective: let Freedom answer real questions about approved local project files using fast, bounded workspace inspection.

Acceptance:

- Freedom can search approved repo paths, read bounded file excerpts, and cite source refs.
- Secrets and ignored env files are excluded.
- Tool calls are logged with request id, path budget, and result count.
- Slow or denied reads degrade cleanly.
- User-visible demo: "What is the current CNS build status and what should we do next?"

### F3 - Freedom System-State Q&A Pathway

Repos: `the-freedom-engine-os`, `gail-ai-operating-system-rev-2`, `graphify-workspace-cockpit`

Objective: Freedom can answer system-state questions by combining hot local context, GAIL OS authority/evidence state, and warm Graphify relationship context only when needed.

Acceptance:

- Freedom distinguishes facts, inferences, and missing context.
- GAIL OS is queried for authority/evidence/action state.
- Graphify is queried for relationships and source-reference expansion.
- Graphify unavailable state does not prevent a useful reduced answer.
- User-visible demo: "Show me the evidence chain and related systems for this mission/action."

### F4 - M365 Read Pathway Through Freedom

Repos: `the-freedom-engine-os`, `gail-ai-operating-system-rev-2`, `ag-operations-m365-foundation`

Objective: Freedom can initiate a governed M365 read/check pathway through GAIL OS, starting with low-risk observe operations.

Acceptance:

- No live M365 write is introduced.
- Read scope is named and documented.
- GAIL OS owns connector readiness, auth status, and evidence.
- Freedom explains what was checked, what was not checked, and why.
- User-visible demo: "Check the CRM/M365 state for X and summarize what you can verify."

### F5 - Governed Action Initiation

Repos: Freedom first, then GAIL OS as needed.

Objective: Freedom can propose and initiate specific activities through GAIL OS without bypassing authority.

Acceptance:

- Freedom can classify the requested action and request validation.
- GAIL OS returns permitted, blocked, pending, or charter-required status.
- Evidence is created for initiated actions.
- Rollback or recovery note exists for any mutation-capable path.
- User-visible demo: "Create or prepare the next internal task for this outcome," with dry-run before live execution.

### F6 - Learning and Relationship Feedback Loop

Repos: all three CNS code repos as needed.

Objective: results from Freedom/GAIL OS actions become evidence and OKPs, then Graphify relationship context, without making Graphify the authority layer.

Acceptance:

- EvidencePacket remains unchanged.
- OKP wraps evidence where appropriate.
- Graphify receives bounded relationship writes through approved routes.
- Freedom can use the learning later without carrying graph artifacts in the prompt.

### F7 - Speed, Capability, and Reliability Hardening

Objective: make the executive pathways fast, resilient, and measurable.

Acceptance:

- Retrieval budgets are enforced.
- Hot/warm/cold tier choices are observable.
- Timeout and degraded-state behavior is tested.
- The first demo pathway is repeatable by Adam without agent intervention.

## Non-Negotiables

- Freedom is the front door for use.
- GAIL OS remains the authority and evidence layer.
- Graphify remains connective intelligence, not runtime ballast.
- No broad "connect everything" chunk without a user-visible capability.
- No live external write without explicit named approval and evidence.
- No secret values in docs, logs, prompts, or graph inputs.
- No stale plan should be treated as current when it conflicts with the handoff, this refactor, or the Graphify boundary note.

## Validation Note

Governance preflight was run on 2026-06-29 and failed on two pre-existing validator enum mismatches: `risk_tier: strategic` and `repository_model: multi-repo-coordination`. Those values are intentional in `project-control.yaml`; no governance-level change is made by this refactor.
