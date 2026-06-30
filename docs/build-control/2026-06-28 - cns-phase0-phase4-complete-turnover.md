# CNS Build Turnover — Phases 0–4 Complete
**Date:** 2026-06-28
**Status:** historical / superseded for forward planning as of 2026-06-29
**Prepared for:** GPT Pro deep research / phase planning session
**Author:** Build Agent (Claude Sonnet 4.6), reviewed by Adam Goodwin

---

## 2026-06-29 Supersession Notice

This turnover is historical evidence for Phases 0–4. It is no longer the restart point and must not be used as current next-task authority.

For current work, read:

1. `docs/build-control/handoff-state.md`
2. `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`
3. `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`
4. `docs/current-build-pathway.md`

Known stale items in this document include the Phase 5/6 open questions, BLK-005 status, Supabase RLS status, and "read this document first" language. The latest handoff and forward refactor supersede them.

## Purpose of This Document

This is a complete, standalone turnover of everything built to this point on the
**Guided AI Labs Agentic OS CNS** (Central Nervous System) project. It includes:

- What the system is and why it's being built
- The four repos that are the subject of all CNS core work
- Exactly what was built in Phases 0–4 (including what compiles, what tests pass, what is dry-run only)
- Why product repos (Guided AI Journey, OldSkoolAI, Bowtie, etc.) appeared in the plan and why that work is on hold
- What "Phase 5" was supposed to mean in the original workstream board, and why that needs a rethink
- What Phase 6 (R4 Autonomy) is supposed to be
- Open questions and decisions Adam needs to make before Phase 5/6 can proceed

This document is intended to be self-contained. A fresh agent should be able to read it and give Adam a grounded recommendation on what Phase 5 and Phase 6 should actually look like.

---

## Part 1 — What This System Is

### 1.1 The Concept

The **Guided AI Labs Agentic OS** is an internal agentic operating system for
running AI partners inside a governed authority structure. This is not a product
dashboard, chatbot, or automation workflow. It is an architecture for
**coordinated AI agency** — where AI agents can observe, reason, propose, act,
and learn under explicit human-governed authority boundaries.

The system is modelled as a **Central Nervous System (CNS)**:

| CNS Layer | Biological Analogy | Role | Primary Repo |
|---|---|---|---|
| **Freedom** | Prefrontal cortex / executive cognition | Reasons, plans, explains, delegates, orchestrates, acts as AI executive business partner | `the-freedom-engine-os` |
| **GAIL OS** | Midbrain / autonomic management | Authority envelopes, risk classification, evidence ledger, action state machine, connector registry, agent registry, policy gate | `gail-ai-operating-system-rev-2` |
| **Graphify** | Connectome / association cortex | Relationship intelligence, dependency maps, context routing, research ingestion, memory indexing | `graphify-workspace-cockpit` |

**Everything else** — websites, M365, product apps — is the **body, sensory system, and motor system** around this core. The product apps are sensory inputs. M365 is an executive body (where work happens). The CNS is what governs and coordinates.

### 1.2 The Four Core Repos

All CNS work lives in exactly these four repos:

| Repo | GitHub | Platform | CNS Role |
|---|---|---|---|
| `gail-ai-operating-system-rev-2` | `Adamgdwn/gail-ai-operating-system-rev-2` | Windows (Python, FastAPI) | Authority, evidence, state machine, policy gate |
| `the-freedom-engine-os` | `Adamgdwn/the-freedom-engine-os` | Linux (TypeScript, Next.js 16 monorepo) | Executive cognition, briefing, portal gate |
| `graphify-workspace-cockpit` | `Adamgdwn/graphify-workspace-cockpit` | Linux (Python, FastAPI + React) | Relationship intelligence, graph API |
| `ag-operations-m365-foundation` | `Adamgdwn/ag-operations-m365-foundation` | Windows (docs + planning) | Microsoft 365 enterprise execution body |

**These are the only repos that should have received CNS build work.** The product repos
(guided-ai-journey, oldskoolai, bowtie, etc.) were NOT supposed to be touched as part
of Phases 1–4 core build, and should not have been touched in Phase 5 without explicit
Adam direction.

### 1.3 The Six Product / Circuit Repos (Sensory Layer — NOT part of CNS core build)

| Repo | CNS Role | Phase 5 Task as Listed |
|---|---|---|
| `guided-ai-journey-website-and-tools` | Diagnostic sensory + readiness pathway | Emit `readiness.completed`, `pilot_candidate.created`, `inquiry.created` |
| `oldskoolai.com` | Learning + capability signal layer | Emit `lesson.completed`, `role_path.selected`, `capability.signal_emitted` |
| `bowtie_risk_program` | Risk + control modelling circuit | Emit `risk.identified`, `control.applied`, `risk_program.updated` |
| `change-leadership-tools` | Adoption + organizational change circuit | Emit `stakeholder.engagement_recorded`, `adoption.milestone_reached` |
| `clean-pdf-build` | Document-production motor circuit (EasyDraft) | Document generation under source/evidence control |
| `guided-ai-labs-website` | Front door + commercial signal | Emit `inquiry.created`, `demo_requested` |

---

## Part 2 — What Was Built (Phases 0–4)

### Phase 0 — Architecture Doctrine + Contract Consolidation (COMPLETE)

**Goal:** All repos aligned to master architecture language. One governing reference document.

**What was done:**
- Locked the CNS model, R/A ladders, object model, source-of-truth ownership
- Added CNS role statements (AGENTS.md) to **all 10 repos** (4 core + 6 product)
- Documented canonical R0–R5 authority ladder and A0–A6 autonomy ladder in GAIL OS
- Resolved UAOS→GAIL OS naming drift across Graphify and M365 docs
- All 11 Phase 0 PRs opened and merged

**Outcome:** Every repo knows what it is and what layer it belongs to. No architectural ambiguity.

---

### Phase 1 — Core Operating Spine (COMPLETE — CP-1 gate proven)

**Goal:** One canonical action can move through the state machine. GAIL OS is the implementation home.

**Repo:** `gail-ai-operating-system-rev-2` (Python / FastAPI)

**What was built:**

| Task | What It Is | Status |
|---|---|---|
| 1.1 `mission.py` | `MissionStatus` enum (12-stage action state machine), Mission type re-exports. 10 tests. | Merged PR #4 |
| 1.2 `action.py` | `Action` dataclass, `VALID_TRANSITIONS` (12 stages), `ActionTransitionError`, `create_action()`, `transition_action()`. 21 tests. | Merged PR #7 |
| 1.3 `authority_envelope.py` | 14-field `AuthorityEnvelope`, `AuthorityLevel` (R0–R5), `AutonomyLevel` (A0–A6), `EnvelopeStatus`, `validate_authority_envelope()`. 14 tests. | Merged PR #5 |
| 1.4 `evidence_packet.py` | 12-field `EvidencePacket`, `EvidenceResult`, `ExecutionMode`, `create_evidence_packet()`, `validate_evidence_packet()`. 14 tests. | Merged PR #6 |
| 1.5 Connector registry | `ConnectorProfile` dataclass, `ConnectorRegistry`, `initial_connector_profiles()` with 7 seed connectors, `GET /api/v1/connectors`. Auth-gated. | Merged (Chunk 20 PRs #3–#11) |
| 1.6 Agent registry | `AgentProfile` dataclass, `AgentRegistry` with 6 seed agents (across Freedom/OS/Graphify layers), `GET /api/v1/agents`. 10 tests. | Merged PR #13 |
| 1.7 Event vocabulary (TypeScript types) | `@gail/contracts` — 39 canonical event types across 4 groups (OS 18, Graphify 4, Agent 7, Website 10). `CnsEvent` base interface. 4 typed product event interfaces. 8 tests. | Merged PR #33 (the-freedom-engine-os) |
| 1.8 API endpoints | Full FastAPI HTTP layer: `POST /api/v1/missions`, `POST /api/v1/actions/validate`, `POST /api/v1/authority/override`, `GET /api/v1/connectors`, `GET /api/v1/agents`. Auth-gated. | Merged (Chunk 21 PRs) |

**CP-1 integration proof (4/4 tests passing against live server on Windows via cable link):**
- Health check ✓
- `proposeMission` → mission_id + status `proposed` ✓
- `validateAction` → PolicyDecision received (policy_blocked at A1 boundary as expected) ✓
- `listConnectors` → all 7 connectors `canExecute: false` ✓

**Phase 1 gate: PROVEN AND CLOSED.**

**A1 boundary note:** The GAIL OS server enforces `allow_live=False` and `dry_run=True` on all M365
and external endpoints. No live network calls occur. This is the Phase 1 local-only boundary.

---

### Phase 2 — Graphify Core Promotion (COMPLETE — CP-2 gate met)

**Goal:** Graphify maps entities, evidence, research, and agents as relationship intelligence — not just workspace visualization.

**Repo:** `graphify-workspace-cockpit` (Python / FastAPI, SQLite graph store)

**What was built:**

| Task | What It Is | Status |
|---|---|---|
| 2.1–2.4 Schema extension | New node types: `EvidencePacket`, `ResearchClaim`, `Agent`, `Capability` + `SourceRef`. Cluster and importance_tier fields. | Merged (chunks 2.1–2.9) |
| 2.5 Research ingest | `cns_api/routes/ingest.py` — source → claim → affected capability → graph edge pipeline | Merged |
| 2.6 CNS HTTP API | FastAPI app on port 8001. Freedom endpoints: entity context, mission history, domain mapping. GAIL OS query endpoints. 217 tests passing. p95 latency < 0.3ms on 12,687-node graph. | Merged — **BLK-002 resolved** |
| 2.7 Windows Graphify extraction | Run Enhanced Graphify extraction on Windows repos → push graph.json to GitHub | **NOT DONE** — windows-local, pending |
| 2.8 Merge Windows graph | Merge Windows graph output into Linux cockpit workspace graph | **BLOCKED** by 2.7 |

**Phase 2 gate: DONE for Linux-side. Windows extraction (2.7/2.8) still pending.**

---

### Phase 3 — Freedom Operating Cognition (COMPLETE — CP-3 gate met)

**Goal:** Freedom produces a decision brief with context, risk, next action, and authority path.

**Repo:** `the-freedom-engine-os` (TypeScript / Next.js 16, Node.js packages)

**What was built:**

| Task | What It Is | PRs |
|---|---|---|
| 3.1 GAIL OS mission state API | `gail-os-server.ts` singleton + `/api/gail-os/missions` (proposeMission) + `/api/gail-os/actions/validate` (validateAction) routes | #28 |
| 3.2 Graphify graph query API | `createHttpGraphifyTransport` + `@freedom/graphify-client` CNS methods: `cnsEntityContext`, `cnsMissionHistory`, `cnsDomainInfo`. `graphify-server.ts` singleton. Entity enrichment route. 8/8 tests. | #28 |
| 3.3 Authority request flow | `requestAuthorityOverride` in `@freedom/gail-os-client` + `POST /api/gail-os/authority/override`. GAIL OS Python: `POST /api/v1/authority/override` (OverrideRequest, pending status, UUID-based ID). 10/10 tests. | #29 (Freedom) + #12 (GAIL OS) |
| 3.4 Agent/capability discovery | `listAgents` in gail-os-client + `agentRouter.ts` (`resolveAgentForAction`, ranking: active > prototype). 11/11 + 7/7 = 18/18 tests. | #31 |
| 3.5 Executive briefing generator | `generateExecutiveBrief()` — concurrent GAIL OS + Graphify fan-out. Returns `ExecutiveBrief` with context, risk, nextAction (proceed/await_approval/halt), authorityPath. `POST /api/executive-brief`. 8/8 tests. **CP-3 gate met.** | #30 |
| 3.6 CNS portal gate | `checkCnsActionGate()` + `POST /api/cns-gate` — unified pre-flight check for all portal actions. Returns permitted/recommendation/brief/assignedAgent. 6/6 tests. 238/238 suite clean. | #32 |

**Phase 3 gate: DONE. Freedom fully wired to GAIL OS and Graphify.**

---

### Phase 4 — M365 First-Class Execution Lane (COMPLETE — CP-4 gate met)

**Goal:** A governed M365 writeback occurs through the OS with source refs and evidence. Reversible.

**Repos:** `gail-ai-operating-system-rev-2` (tasks 4.1–4.5) + `graphify-workspace-cockpit` (task 4.6)

**What was built:**

| Task | What It Is | Status |
|---|---|---|
| 4.1 M365 bridge connector | `m365-graph-api-bridge` `ConnectorProfile` in connector registry. `current_state: registry-only`, `live_access_enabled: False`, `allowed_capabilities: [planning-only, inventory-only, readiness-check]`. 10 tests. | Merged PR #15 |
| 4.2 Graph auth provider | `GraphAuthProvider` (MSAL client-credentials) + `GET /api/v1/m365/status` (config readiness check, no live call, no token in response). `requirements.txt` updated with `msal`. 11 tests. | Merged PR #14 |
| 4.3 R0 observe action | `observe_graph_metadata()` — dry-run R0 observe. Validates auth config, produces EvidencePacket without any live Graph call (A1 boundary). `POST /api/v1/m365/observe`. 12 tests. | Merged PR #16 |
| 4.4 R2 write action | `create_planner_task()` — R2 dry-run write. Validates plan_id, bucket_id, task_title, auth config. Produces EvidencePacket. `POST /api/v1/m365/write/planner-task`. Always `dry_run=True, allow_live=False` in Phase 4. Rollback note: `DELETE /v1.0/planner/tasks/{task_id}`. 13 tests. | Merged PR #17 |
| 4.5 Evidence persistence | `save_evidence_packet()` — writes EvidencePacket as JSON to `{GAIL_OS_STORE_PATH}/evidence/{evidence_id}.json`. `GET /api/v1/evidence/{mission_id}` returns refs. 10 tests. Full roundtrip proven. | Merged PR #18 |
| 4.6 Graphify evidence ingest | `ingest_evidence_entity()` — upserts EvidencePacket as graph entity (`kind='EvidencePacket'`, `cluster='evidence'`). `produced_by_mission` + `via_connector` relationship edges. `POST /api/cns/evidence` (201) + `GET /api/cns/evidence/{evidence_id}` (200/404). 10 tests. | Merged Graphify PR #2 |

**CP-4 gate verification:**
- M365 write (dry-run) ✓
- OS evidence created and persisted ✓
- Graphify updated with EvidencePacket entity and relationship edges ✓
- Reversible (rollback note in every evidence packet) ✓

**Phase 4 gate: PROVEN AND CLOSED.**

---

## Part 3 — The Phase 5 Confusion: What Happened and Why

### 3.1 What the Workstream Board Said About Phase 5

The workstream board defined Phase 5 as **"Product App + Website Integration"** — 8 tasks
across 6 product repos. The tasks were:

- 5.1: Guided AI Journey — emit `readiness.completed`, `pilot_candidate.created`, `inquiry.created`
- 5.2: OldSkoolAI — emit `lesson.completed`, `role_path.selected`, `capability.signal_emitted`
- 5.3: Bowtie — emit `risk.identified`, `control.applied`, `risk_program.updated`
- 5.4: Change Leadership Tools — emit `stakeholder.engagement_recorded`, `adoption.milestone_reached`
- 5.5: EasyDraft Docs (clean-pdf-build) — document generation under source/evidence control
- 5.6: guidedailabs.com — emit `inquiry.created`, `demo_requested`
- 5.7: guidedaijourney.com (repeat of 5.1 — duplicate in board)
- 5.8: oldskoolai.com (repeat of 5.2 — duplicate in board)

All 8 were marked `blocked` pending CP-1 event vocabulary contracts (task 1.7).

### 3.2 Why the Agent Went Into Product Repos

When Adam asked "Where is Phase 5?" and confirmed that the CP-1 blocker should not hold
things up, the build agent:

1. Completed task 1.7 (event vocabulary TypeScript types in `@gail/contracts`) — this was correct
2. Then proceeded to execute Phase 5 as written in the workstream board — this was wrong

The agent created branches and pushed code to 3 product repos before Adam stopped it:

| Repo | Branch | Files Pushed | PR Created? |
|---|---|---|---|
| `guided-ai-journey-website-and-tools` | `phase5/5.1-5.7-gai-journey-events` | `src/lib/cns-events.ts` + `tests/cns-events.test.ts` | No |
| `oldskoolai.com` | `phase5/5.2-5.8-oldskool-events` | `src/lib/cns-events.ts` + `src/lib/cns-events.test.ts` | No |
| `bowtie_risk_program` | `phase5/5.3-bowtie-events` | `src/lib/cns-events.ts` + `tests/cns-events.test.ts` + updated `package.json` | No |
| `change-leadership-tools` | `phase5/5.4-change-leadership-events` | Nothing pushed | No |
| `clean-pdf-build` | `phase5/5.5-easydraft-events` | Nothing pushed | No |
| `guided-ai-labs-website` | `phase5/5.6-gail-labs-events` | Nothing pushed | No |

**No PRs were created. The branches exist but can be abandoned without impact.**

The code pushed to the 3 product repos was "A1 dry-run" event emission stubs:
a `CnsEvent` type, an `emitCnsEvent()` function that does nothing in Phase 1, and
a `buildEventId()` helper. This is not harmful, but it was not what Adam asked for.

### 3.3 The Root Cause: Phase 5 Scope Was Written Before the Four-Repo Constraint Was Clear

The workstream board was written from the master architecture document (§13.4 — event
vocabulary, product apps as sensory layer). The architecture document correctly
describes product apps as circuit nodes in the CNS body. The agent interpreted that
architectural description as a build instruction.

**Adam's direction:** "I really only want you to focus on the four repos that we
discussed originally." This means Phase 5 as written in the workstream board is
either (a) not what Adam wants right now, or (b) needs to be redesigned as
integration work that lives in the CNS core repos, not in each product repo.

---

## Part 4 — What Phase 5 and Phase 6 Should Actually Be

### 4.1 What "Phase 5" Was Originally Designed to Solve

The original Phase 5 goal was: **connect the product apps to the CNS so that real
business events (readiness assessments, lessons, risk entries, M365 tasks) flow into
GAIL OS and Graphify with evidence and authority.**

The original design put event emission code in each product repo because it assumed
each app would call the OS directly. That's one valid architecture.

But there are other architectures that keep all CNS work in the four core repos:

**Option A — Push model (current workstream plan):** Each product repo gets a thin
`emitCnsEvent()` stub that fires events to GAIL OS. Code lives in the product repos.
This is what the build agent started doing.

**Option B — Pull model:** GAIL OS or Graphify polls/subscribes to existing product
data sources (M365 lists, Supabase tables, webhook endpoints) and ingests events.
No new code in product repos. All work in the four core repos.

**Option C — Shared SDK approach:** A shared npm/pip package (e.g., `@gail/cns-emitter`)
lives in one of the core repos and is imported by product repos. Product repos don't
get CNS logic — they just depend on the package. Most CNS work stays in core.

**Option D — OS webhook endpoint:** GAIL OS exposes a `POST /api/v1/events/ingest`
endpoint. Product apps just POST to it (or their existing tools do). Zero new code
in most product repos.

### 4.2 What Phase 6 Is

The workstream board defines Phase 6 as **R4 Autonomy** — the first R4 charter.

R4 is the authority level where AI agents can take autonomous action inside a
**pre-approved, narrowly scoped charter** (think: "you may reschedule any Planner
task older than 7 days with no stakeholders assigned, up to 5 tasks per session,
with evidence logged for each"). This is the first time the OS actually executes
actions on its own rather than waiting for human confirmation.

**Prerequisites for Phase 6:**
- CP-3 cleared (Freedom produces decision brief) ✓
- At least one R4 charter defined (not done)
- OS authority envelope can accept and validate an R4 charter (not done)
- Freedom can invoke an action under an R4 charter without a per-action human approval (not done)

Phase 6 would be entirely in the four core repos:
- GAIL OS: `CharterProfile` schema, charter validation, `POST /api/v1/charters`, R4 authority envelope linkage
- Freedom: R4 charter discovery, charter-gated action invocation, evidence return
- Graphify: Charter node type, link charter to evidence and missions
- M365 Foundation: Candidates for first R4 charter (Planner task management, calendar slot blocking, list row updates)

---

## Part 5 — What Is Still Open / Needs Adam's Decision

### 5.1 Phase 5 Architecture Decision

**Question:** How do product apps connect to the CNS?

- Option A (push, code in each product repo) — what the workstream board specified; not what Adam wants
- Option B (pull, OS/Graphify ingests from existing data sources) — all work in core repos
- Option C (shared SDK package) — most CNS work in core, product repos depend on package
- Option D (OS webhook endpoint) — easiest for product teams, all CNS work in core

**Recommendation:** Option D is the most consistent with the four-repo constraint. GAIL OS
adds `POST /api/v1/events/ingest` as a generic intake endpoint. Each product app's
event emission is one HTTP POST from whatever mechanism is convenient (webhook, cron,
button click). No CNS logic leaks into product repos.

### 5.2 Phase 6 Scope and First R4 Charter

**Question:** What is the first R4 charter scope?

The master architecture requires a charter to be:
- Narrow (specific action type, specific resource scope)
- Reversible (rollback defined)
- Time-bounded
- Evidence-logged (every execution produces an EvidencePacket)

Candidates:
- Planner task triage (reschedule unassigned tasks > 7 days old)
- M365 SharePoint list row append (evidence-logged data capture)
- Graphify relationship update (mark stale research claims expired)
- Freedom mission status polling + summary report to Supabase

### 5.3 BLK-005 — M365 App Registration

**Question:** Has an Azure Entra app registration been provisioned for GAIL OS?

This is required before any live M365 Graph calls. Phase 4 completed dry-run only.
Phase 4 auth provider (`GraphAuthProvider`) is ready; it just needs real `AZURE_CLIENT_ID`,
`AZURE_CLIENT_SECRET`, `AZURE_TENANT_ID` environment variables.

### 5.4 BLK-004 — Windows Enhanced Graphify Extraction

**Question:** Run Graphify extraction on `gail-ai-operating-system-rev-2` and
`ag-operations-m365-foundation` on Windows, push `graph.json` to GitHub so it can
be merged into the Linux cockpit graph.

This is tasks 2.7 and 2.8 in the workstream board. They are Windows-local and have
not been done.

### 5.5 Supabase RLS

**2026-06-29 update:** Closed. H5/H5-apply found 21 legacy public tables, committed the remediation package, and applied the hosted migration on 2026-06-28. Post-apply state: 21/21 target tables with `relrowsecurity=true`, 0 new policies, service-role paths intact.

---

## Part 6 — System State Snapshot (as of 2026-06-28)

### What Works Right Now (Local / A1 Boundary Only)

| Capability | Where | How to Test |
|---|---|---|
| Mission creation + state machine | GAIL OS at `10.77.77.1:8123` (Windows) | `POST /api/v1/missions` + `POST /api/v1/actions/validate` |
| Authority envelope validation | GAIL OS | Part of `validateAction` response |
| Evidence packet creation + persistence | GAIL OS | `POST /api/v1/m365/write/planner-task` → check `local_store/evidence/` |
| M365 dry-run observe (R0) | GAIL OS | `POST /api/v1/m365/observe` with `dry_run: true` |
| M365 dry-run write (R2) | GAIL OS | `POST /api/v1/m365/write/planner-task` with `dry_run: true` |
| Connector registry | GAIL OS | `GET /api/v1/connectors` |
| Agent registry | GAIL OS | `GET /api/v1/agents` |
| Authority override request | GAIL OS | `POST /api/v1/authority/override` |
| Graphify CNS API | Graphify at port 8001 (Linux) | `GET /api/cns/entity-context/{id}`, `POST /api/cns/evidence` |
| Evidence ingest → graph entity | Graphify | `POST /api/cns/evidence` → EvidencePacket node + edges in SQLite |
| Freedom executive briefing | Freedom (`the-freedom-engine-os`) | `POST /api/executive-brief` (fans out to GAIL OS + Graphify) |
| Freedom portal gate | Freedom | `POST /api/cns-gate` → `permitted: true/false` + recommendation |
| Freedom → GAIL OS authority override | Freedom | `POST /api/gail-os/authority/override` |
| Event vocabulary TypeScript types | `@gail/contracts` (in Freedom monorepo) | Import `CnsEventType`, `CnsEvent` etc. |

### What Is Stubbed / Dry-Run Only

- All M365 Graph calls (no live calls — A1 boundary)
- Event emission from product apps (stubs only, never triggered)
- Supabase persistence in Freedom (no RLS remediation done)

### What Is Not Started

- Phase 6: R4 Autonomy (charter schema, charter-gated action invocation)
- Phase 7: Learning Loop (consolidation of evidence into updated Graphify research claims)
- Phase 8: Client packaging
- Windows Enhanced Graphify extraction (tasks 2.7/2.8)
- Live M365 Graph calls (needs BLK-005 resolution)

---

## Part 7 — File Map: Key Files Across the Four Repos

### `gail-ai-operating-system-rev-2` (Python / FastAPI)

```
packages/uaos-core/src/gail_ai_operating_system/
├── mission.py             # MissionStatus enum, Mission types
├── action.py              # Action, state machine, transitions
├── authority_envelope.py  # AuthorityEnvelope, R-levels, A-levels
├── evidence_packet.py     # EvidencePacket, EvidenceResult, ExecutionMode
├── evidence_store.py      # save_evidence_packet(), file-based JSON store
├── connector_registry.py  # ConnectorProfile, ConnectorRegistry, 7 seed connectors
├── agent_registry.py      # AgentProfile, AgentRegistry, 6 seed agents
├── m365_auth.py           # GraphAuthProvider (MSAL, dry-run)
├── m365_reader.py         # observe_graph_metadata() — R0 dry-run
└── m365_writer.py         # create_planner_task() — R2 dry-run

apps/gail-os-api/routers/
├── missions.py            # POST /api/v1/missions
├── actions.py             # POST /api/v1/actions/validate
├── authority.py           # POST /api/v1/authority/override
├── connectors.py          # GET /api/v1/connectors
├── agents.py              # GET /api/v1/agents
├── m365.py                # GET /api/v1/m365/status, POST /api/v1/m365/observe
└── m365_write.py          # POST /api/v1/m365/write/planner-task
```

### `the-freedom-engine-os` (TypeScript / Next.js 16)

```
packages/gail-os-client/src/
└── index.ts               # GailOsClient — proposeMission, validateAction, requestAuthorityOverride, listAgents, getEvidence

packages/graphify-client/src/
└── index.ts               # GraphifyClient — cnsEntityContext, cnsMissionHistory, cnsDomainInfo

packages/contracts/src/
└── index.ts               # @gail/contracts — EvidencePacket, AuthorityEnvelope, ConnectorProfile, GailOsAgent
                           #                   + event vocabulary: 39 CnsEventType values, CnsEvent base, typed product events

src/lib/
├── gail-os-server.ts      # Server-side GAIL OS client singleton
├── graphify-server.ts     # Server-side Graphify client singleton
├── executiveBriefGenerator.ts  # generateExecutiveBrief() — Freedom decision brief
├── agentRouter.ts         # resolveAgentForAction() — best agent for action kind
└── cnsActionGate.ts       # checkCnsActionGate() — unified portal pre-flight check

src/app/api/
├── cns-gate/route.ts      # POST /api/cns-gate
├── executive-brief/route.ts
├── gail-os/missions/route.ts
├── gail-os/actions/validate/route.ts
├── gail-os/authority/override/route.ts
└── gail-os/agents/route.ts
```

### `graphify-workspace-cockpit` (Python / FastAPI)

```
cns_api/
├── app.py                 # FastAPI app, port 8001, router registration
└── routes/
    ├── freedom.py         # GET /api/cns/entity-context/{id}, mission-history, domain-info
    ├── gail_os.py         # GAIL OS query endpoints
    ├── ingest.py          # POST /api/cns/ingest — research claim ingestion
    └── evidence.py        # POST /api/cns/evidence, GET /api/cns/evidence/{id}

cns_store/
└── evidence_writer.py     # ingest_evidence_entity() — upserts EvidencePacket as graph node
```

### `ag-operations-m365-foundation`

- Stages 1–9 documented (M365 setup stages)
- Stage 9: Agentic OS Bridge Readiness (planning docs only, no code)
- AGENTS.md: CNS role statement added (Phase 0)
- **No CNS code has been written here yet**

---

## Part 8 — Questions for GPT Pro / Adam

1. **Phase 5 architecture:** Which approach connects product apps to the CNS?
   - A: Push — event emission code in each product repo (original plan, rejected by Adam)
   - B: Pull — GAIL OS/Graphify ingests from existing data sources (no new code in product repos)
   - C: Shared SDK — `@gail/cns-emitter` package, product repos import it
   - D: OS webhook — `POST /api/v1/events/ingest` in GAIL OS, product apps just POST
   - **My recommendation: Option D** — simplest, all CNS logic stays in GAIL OS

2. **Phase 5 timing:** Should Phase 5 (product connection) happen before Phase 6 (R4 Autonomy),
   or are these independent tracks? The master architecture puts 5 before 6, but that was
   written when the plan was broader.

3. **Phase 6 first charter:** What is the first narrow R4 action the system should execute
   autonomously? Candidates: Planner task triage, SharePoint row append, Graphify staleness
   sweep, Freedom memory consolidation.

4. **BLK-005 M365 app registration:** Closed 2026-06-28. Entra app and expanded scopes were confirmed. Live writes still require explicit named approval.

5. **Supabase RLS:** Closed 2026-06-28. H5/H5-apply covered 21 target tables and applied the hosted migration after Adam approval.

6. **Windows Graphify extraction (BLK-004):** When will Adam run the extraction on Windows
   to push `gail-ai-operating-system-rev-2` and `ag-operations-m365-foundation` graph data?

---

## Part 9 — What to Tell the Next Agent

The next build agent (whether GPT or Claude) should:

1. **Do not use this document as the restart point.** Read `docs/build-control/handoff-state.md`, the 2026-06-29 forward refactor, and the Graphify boundary note first.

2. **Start with Adam's Phase 5/6 decisions** from the questions in Part 8.

3. **Do NOT push code to any product repo** (guided-ai-journey, oldskoolai, bowtie, change-leadership, clean-pdf-build, guided-ai-labs-website) unless Adam explicitly authorizes that as the Phase 5 approach.

4. **Do NOT create PRs for the product repo branches** that were created in the previous session:
   - `guided-ai-journey-website-and-tools` / `phase5/5.1-5.7-gai-journey-events`
   - `oldskoolai.com` / `phase5/5.2-5.8-oldskool-events`
   - `bowtie_risk_program` / `phase5/5.3-bowtie-events`
   - `change-leadership-tools` / `phase5/5.4-change-leadership-events`
   - `clean-pdf-build` / `phase5/5.5-easydraft-events`
   - `guided-ai-labs-website` / `phase5/5.6-gail-labs-events`
   These branches exist, no PRs open, they can be abandoned or deleted when ready.

5. **All work should be in the four core repos** unless Adam explicitly expands scope.

6. **The GAIL OS server runs on Windows at `10.77.77.1:8123`** (direct cable link from Linux).
   Cloud agents write code and open PRs via GitHub MCP; test validation requires the Windows machine or GitHub Actions CI.

7. **Platform tag rule:** Tasks tagged `cloud-safe` can be executed via GitHub MCP.
   Tasks tagged `windows-local` require the Windows machine (or GitHub CI to be configured for them).

---

*End of turnover. This document covers everything built through 2026-06-28 and is
intended to give GPT Pro a complete, authoritative starting point for Phase 5/6 planning.*
