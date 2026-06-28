# 2026-06-28 - Chunk 20 CNS Orchestration Amendment and Four-Repo Evolution Plan

**Purpose:** Amend the existing GAIL OS Chunk Twenty so the four active CNS repos can keep evolving without creating transport drift, source-of-truth drift, or premature live integrations.

**Repos covered:**

- `gail-ai-operating-system-rev-2`
- `the-freedom-engine-os`
- `graphify-workspace-cockpit`
- `ag-operations-m365-foundation`

**Program posture:** This is a build-control amendment, not a rewrite of the four repos.

---

## 1. Program decision

The next set of work should **not** stall on the GAIL OS HTTP API uncertainty.

The clean parking decision is:

```text
Park transport uncertainty at the transport seam.
Build canonical JSON contracts and transport-independent service functions now.
Expose those same contracts through HTTP later.
```

This prevents three bad outcomes:

1. Freedom invents TypeScript-side contracts before GAIL OS owns them.
2. GAIL OS delays all progress until the HTTP design is perfect.
3. Multiple agents build incompatible API assumptions across the four repos.

The architectural rule:

```text
Business logic and authority state machines must not depend on HTTP.
HTTP is only one future transport wrapper around canonical GAIL OS contracts.
```

---

## 2. Core direction changes

### 2.1 GAIL OS

GAIL OS remains the authority, evidence, and runtime-governance layer.

For this evolution, GAIL OS must also own the **Architecture Governor** function during build and integration.

The Architecture Governor ensures:

- every repo stays inside its CNS role;
- no repo creates a second source of truth;
- shared contracts are versioned and stable;
- transport decisions are parked cleanly;
- integration gates are explicit;
- intentional exceptions are surfaced to Adam.

### 2.2 Graphify

Graphify must be elevated in the build plan.

Graphify is not a visualization accessory. It is the **connectome / relationship field / information-transfer layer** of the CNS.

Useful metaphor, without hand-waving:

```text
Graphify is the rail system, the electrical grid, and the relationship field.
It does not approve action, but it determines whether the system sees isolated facts or connected meaning.
```

Quantum-style thinking may be used as a design lens only:

- relationship at distance;
- state propagation;
- latent connection discovery;
- context collapse into a concrete operating recommendation;
- signal coherence across disconnected systems.

But implementation must stay concrete:

- typed nodes;
- typed edges;
- stable IDs;
- safe references;
- deterministic fingerprints;
- source refs;
- evidence refs;
- extraction-write / API-read boundary.

### 2.3 Freedom

Freedom remains executive cognition and the future main orchestrator of the operating system.

During this build phase, Freedom should not become the build governor. It should consume contracts, propose missions, synthesize context, and preserve the operator experience.

Freedom may continue building against fake/local transports only when those transports are explicitly marked as provisional and validated against GAIL-owned schemas.

### 2.4 M365 Foundation

M365 is mature and live enough to be treated as the enterprise body.

This phase should **not** over-focus on executing more M365 actions.

The right focus is:

```text
M365 signals, records, links, identities, actions, and evidence references
must connect cleanly to GAIL OS.
```

M365 should emphasize bridge contracts, source references, one-writer posture, app-registration readiness, and future evidence linkage.

### 2.5 Infrastructure

Infrastructure must be documented now but not allowed to hijack CP-1.

The system must be platform-agnostic:

- current Windows/Linux split is a development placement detail;
- production architecture must be deployable as services, containers, hosted APIs, and connectors;
- no code should assume a permanent Windows-only or Linux-only role;
- if the system hits a wall, it should create a governed capability-gap record and propose/build a door through approved channels.

---

## 3. Amended Chunk Twenty doctrine

Replace the old Chunk Twenty interpretation:

```text
Add local approval/reject/hold/request-more-info actions only.
```

With the amended interpretation:

```text
Chunk Twenty establishes the build-phase orchestration guardrail, preserves the local approval action path, parks HTTP uncertainty at the service/contract seam, and prepares the four repos for CP-1 without live integrations.
```

Chunk Twenty does **not** approve:

- live M365 writes;
- direct Freedom execution;
- Graphify API write paths;
- cloud deployment;
- Supabase persistence for authority/evidence;
- Vercel deployment for GAIL OS authority;
- repo consolidation;
- shared runtime coupling;
- hidden autonomy.

---

## 4. Cross-repo sequencing

```text
20A - GAIL OS Architecture Governor and CP-1 Transport Parking
  ↓
20B - GAIL OS Local Approval Actions, now under the new guardrail
  ↓
20C - GAIL OS Canonical JSON Contract Export
  ↓
20D - Graphify CNS Connectome Contract Normalization
  ↓
20E - GAIL OS → Graphify Safe Graph-Fact Extraction Lane
  ↓
20F - Freedom Mission Proposal Against Parked GAIL Contract
  ↓
20G - M365 Bridge Placement and One-Writer Audit
  ↓
20H - Infrastructure Placement Register and Promotion Gates
```

The first three are the critical path. Graphify work should run closely behind, not later as a distant integration.

---

# 5. Chunk specifications

## Chunk Twenty-A (GAIL OS — Platform Agnostic) — Architecture Governor and CP-1 Transport Parking

**Status:** Ready

**Objective:** Create the build-phase Architecture Governor record and park the GAIL HTTP uncertainty at a contract/service seam so CP-1 work can proceed without choosing final hosting or full HTTP design.

**Acceptance criteria:**

- [ ] Existing Chunk Twenty is amended, not deleted.
- [ ] GAIL OS is explicitly named as the build-phase Architecture Governor.
- [ ] The amended plan distinguishes transport-independent contracts from HTTP transport.
- [ ] The plan states that HTTP will wrap service functions later rather than define business logic.
- [ ] No FastAPI production route is created in this chunk.
- [ ] No M365, Supabase, Vercel, Graphify ingest, or Freedom runtime coupling is activated.
- [ ] All four repos are named as first-class participants with current build responsibilities.
- [ ] Graphify is elevated as the connectome / relationship field, not a late accessory.
- [ ] The Windows/Linux split is marked as current development placement, not product architecture.

**Output files:**

- `docs/decisions/2026-06-28 - Chunk 20 CNS Orchestration Amendment.md`
- `docs/build-control/2026-06-28 - Four Repo Coordination Map.md`
- `docs/build-control/2026-06-28 - CP1 Transport Parking Decision.md`
- Updates to `docs/current-build-pathway.md`
- Updates to `START_HERE.md` or equivalent startup routing if present

**Validation:**

- Search repo for conflicting next-step language: `HTTP API next`, `approval actions next`, `Chunk Twenty`, `Graphify`, `M365`, `Freedom`.
- Confirm the active plan no longer gives agents two incompatible paths.
- Confirm no new live connector, HTTP production API, cloud placement, or runtime coupling was added.
- Run existing governance preflight and document-control checks.

**Unblocks:**

- Chunk Twenty-B local approval actions.
- Chunk Twenty-C canonical contract export.
- Freedom-side CP-1 preparation without waiting for final HTTP hosting.

**Stop condition:**

Stop before implementing FastAPI, publishing TypeScript contracts, modifying Freedom, modifying Graphify, accessing M365, or changing infrastructure.

---

## Chunk Twenty-B (GAIL OS — Platform Agnostic) — Local Approval Actions Under Governor Guardrails

**Status:** Ready after Chunk Twenty-A

**Objective:** Implement local approval, reject, hold, and request-more-info actions while preserving the no-network, no-live-tool boundary and producing relay/evidence-shaped records for later CP-1.

**Acceptance criteria:**

- [ ] Existing Chunk Twenty approval-action intent is preserved.
- [ ] Approval actions write governed local records only.
- [ ] Approval actions support: `approve`, `reject`, `hold`, `request_more_info`.
- [ ] Stale state is rejected.
- [ ] Terminal states cannot be reopened.
- [ ] R5 remains human-only.
- [ ] R4 requires a valid AuthorityEnvelope reference.
- [ ] Every local approval action has a source ref, actor, timestamp, reason, and evidence placeholder.
- [ ] No live tool execution occurs after approval.
- [ ] Approval output can later be wrapped by GAIL OS service functions.

**Output files:**

- `packages/uaos-core/src/gail_ai_operating_system/approval_actions.py`
- `tests/test_approval_actions.py`
- Updated package exports
- Updated `docs/current-build-pathway.md`

**Validation:**

- Focused approval-action tests.
- Full Python test suite.
- Governance preflight.
- Secret scan.
- Diff check.
- Manual local proof using synthetic mission/action/evidence records.

**Unblocks:**

- Canonical CP-1 service functions.
- Evidence view/handoff view.
- Future HTTP wrapper.

**Stop condition:**

Stop before HTTP exposure, cloud placement, hosted authorization, live connector execution, M365 adapter work, Freedom runtime activation, or production behaviour.

---

## Chunk Twenty-C (GAIL OS — Platform Agnostic) — Canonical CP-1 Contract Export

**Status:** Ready after Chunk Twenty-B

**Objective:** Create GAIL-owned JSON Schema contracts for the CP-1 cognitive cycle so Freedom can consume stable types without becoming the schema authority.

**Acceptance criteria:**

- [ ] GAIL OS owns the canonical schema source.
- [ ] JSON Schemas exist for the CP-1 objects:
  - `Mission`
  - `Action`
  - `PolicyDecision`
  - `AuthorityEnvelope`
  - `EvidencePacket`
  - `ConnectorStatus`
  - `GraphContextRef`
  - `SourceRef`
- [ ] Schemas map to existing Python validation rules.
- [ ] R0-R5 and A0-A6 enums are exported.
- [ ] The 12-stage action lifecycle is exported as a closed enum.
- [ ] Schemas are transport-neutral and do not reference FastAPI.
- [ ] A generated/packaged TypeScript publication path is documented but not required to be published in this chunk.
- [ ] Existing Python tests prove schema export does not weaken validation.

**Output files:**

- `contracts/json-schema/mission.schema.json`
- `contracts/json-schema/action.schema.json`
- `contracts/json-schema/policy-decision.schema.json`
- `contracts/json-schema/authority-envelope.schema.json`
- `contracts/json-schema/evidence-packet.schema.json`
- `contracts/json-schema/connector-status.schema.json`
- `contracts/json-schema/source-ref.schema.json`
- `contracts/json-schema/graph-context-ref.schema.json`
- `scripts/export-cp1-contracts.py`
- `tests/test_contract_exports.py`
- `docs/contracts/2026-06-28 - CP1 Contract Export Notes.md`

**Validation:**

- Export schemas from Python source or validated schema definitions.
- Validate example synthetic records against exported schemas.
- Confirm invalid R-level, A-level, lifecycle state, missing R4 envelope, and R5 execution cases fail.
- Full Python test suite.

**Unblocks:**

- Freedom TypeScript contract consumption.
- Future `@gail/contracts` package.
- Thin FastAPI wrapper later.

**Stop condition:**

Stop before creating a live API, publishing package to npm, modifying Freedom directly, or changing runtime authority rules.

---

## Chunk Twenty-D (Graphify — Platform Agnostic) — CNS Connectome Contract Normalization

**Status:** Ready after Chunk Twenty-A; can run parallel to Twenty-B/C if scoped tightly

**Objective:** Normalize the Graphify CNS query contract so Freedom and GAIL OS can request context without relying on old endpoint assumptions or treating Graphify as a mere code-map UI.

**Acceptance criteria:**

- [ ] Graphify docs clearly describe Graphify as CNS connectome / relationship field.
- [ ] Endpoint families are documented:
  - legacy graph query endpoints;
  - CNS query endpoints;
  - future adapter endpoints.
- [ ] Freedom-facing context query shape is documented.
- [ ] GAIL-facing authority/connector/dependency query shape is documented.
- [ ] Existing read-only HTTP API boundary is preserved.
- [ ] Extraction pipeline remains the only write path.
- [ ] No Graphify recommendation is treated as approval authority.
- [ ] Platform assumptions are env-var/config based, not Linux-only product assumptions.

**Output files:**

- `docs/specs/2026-06-28 - Graphify CNS Connectome Contract.md`
- `docs/specs/2026-06-28 - Graphify Endpoint Family Map.md`
- Optional compatibility note in `AGENTS.md` / `START_HERE.md`

**Validation:**

- Run Graphify API tests if present.
- Run backend compile/type/lint checks as applicable.
- Confirm no new API write path was added.
- Confirm no M365/Freedom/GAIL runtime coupling was added.

**Unblocks:**

- Freedom Graphify client normalization.
- GAIL OS graph-fact export path.
- Future relationship-aware CP-2 cycle.

**Stop condition:**

Stop before new live ingestion, source mutation, approval authority, or execution authority.

---

## Chunk Twenty-E (GAIL OS + Graphify) — Safe Graph-Fact Extraction Lane

**Status:** Ready after Twenty-C and Twenty-D

**Objective:** Define a concrete lane where GAIL OS emits sanitized graph facts and Graphify can ingest them through the extraction/write pipeline, not through a live API write path.

**Acceptance criteria:**

- [ ] GAIL OS graph facts use stable IDs and deterministic fingerprints.
- [ ] Fact records include entity type, relationship type, source refs, evidence refs, authority level, and data classification.
- [ ] Unsafe content is rejected: secrets, raw logs, raw audio, raw client payloads, full M365 content, live connector payloads.
- [ ] Graphify ingest is described as extraction/import pipeline work, not HTTP API write work.
- [ ] Graphify can reject invalid fact records without damaging the current graph store.
- [ ] The lane supports future research claims surfaced by Freedom or build agents.

**Output files:**

GAIL OS:

- `contracts/json-schema/graph-fact.schema.json`
- `docs/contracts/2026-06-28 - Graphify Fact Export Contract.md`

Graphify:

- `docs/specs/2026-06-28 - GAIL Graph Fact Import Boundary.md`
- Optional parser test fixture using synthetic records only

**Validation:**

- Validate synthetic graph facts from GAIL OS.
- Validate Graphify import fixture rejects unsafe fields.
- Confirm extraction-write/API-read rule is preserved.

**Unblocks:**

- Relationship-aware evidence.
- Cross-system memory and dependency mapping.
- Future recursive learning loops.

**Stop condition:**

Stop before importing live M365 data, live client data, secrets, unredacted logs, or executing any action from graph output.

---

## Chunk Twenty-F (Freedom — Platform Agnostic) — Mission Proposal Against Parked GAIL Contract

**Status:** Ready after Twenty-C

**Objective:** Update Freedom to consume GAIL-owned CP-1 contracts and prepare mission proposals without requiring the final GAIL HTTP API to exist.

**Acceptance criteria:**

- [ ] Freedom imports or copies generated TypeScript types from the GAIL-owned contract export path.
- [ ] Existing fake/unreachable transports are clearly marked provisional.
- [ ] Freedom can create a CP-1-shaped mission proposal using the GAIL contract.
- [ ] Freedom does not claim approval without a GAIL policy decision.
- [ ] Freedom does not execute restricted actions locally.
- [ ] Freedom can operate in degraded mode when GAIL OS or Graphify is unavailable.
- [ ] Any Graphify use is read-only context enrichment.

**Output files:**

- `packages/gail-os-client/src/cp1ContractAdapter.ts` or equivalent
- `packages/mission-proposal/src/cp1Proposal.ts` or update existing mission proposal module
- `packages/shared/src/generated/gail-contracts/` if generated copy is used
- Tests for valid proposal, GAIL unavailable, Graphify unavailable, blocked restricted action, and schema mismatch

**Validation:**

- `npm run typecheck`
- Targeted mission proposal tests
- Existing Freedom test suite if runtime permits
- Confirm no direct M365, Graphify write, or GAIL approval bypass was added

**Unblocks:**

- Thin HTTP transport once GAIL OS publishes endpoint.
- First CP-1 cognitive cycle.

**Stop condition:**

Stop before live GAIL HTTP calls, live M365 calls, external sends, production releases, or direct connector execution.

---

## Chunk Twenty-G (AG Operations / M365 — Platform Agnostic) — Bridge Placement and One-Writer Audit

**Status:** Ready; no dependency on CP-1 if kept read-only / documentation-first

**Objective:** Document the M365 bridge posture so M365 connects cleanly to GAIL OS without adding new execution complexity.

**Acceptance criteria:**

- [ ] Current live flows are inventoried.
- [ ] Current source-of-truth surfaces are listed.
- [ ] Current writers are listed.
- [ ] One-writer posture is confirmed for each write surface.
- [ ] BLK-005 app-registration status is recorded as known, unknown, or blocked.
- [ ] No new tenant write is performed.
- [ ] The plan emphasizes connection to GAIL OS through source refs, evidence refs, and action-log records.
- [ ] M365 bridge permissions are narrower than setup-helper/admin permissions.
- [ ] Future M365 events map to GAIL R0-R5 and A0-A6 terminology.

**Output files:**

- `docs/2026-06-28_M365_GAIL_OS_BRIDGE_PLACEMENT_REGISTER.md`
- `docs/2026-06-28_M365_ONE_WRITER_AUDIT.md`
- Optional update to `START_HERE.md`

**Validation:**

- Documentation review.
- No M365 write commands.
- No `-Apply`, `-Approve`, connector creation, flow creation/update, permission grant, or app registration change.
- Record BLK-005 status explicitly.

**Unblocks:**

- Future M365 connector registration.
- Future CP-2 / CP-3 enterprise body integration.

**Stop condition:**

Stop before live writes, app registration, consent grants, Selected permissions, Exchange RBAC, external sends, guest access, public forms, sharing changes, deletes, or unattended automation.

---

## Chunk Twenty-H (GAIL OS or Build-Control Repo — Platform Agnostic) — Infrastructure Placement Register

**Status:** Ready after Twenty-A

**Objective:** Create an infrastructure placement register so Vercel, Supabase, M365, local runtime, containers, and future hosting tools are acknowledged without being prematurely chosen as authority stores or execution runtimes.

**Acceptance criteria:**

- [ ] Register includes every active repo and major system.
- [ ] Each component has current placement and future candidate placement.
- [ ] Authority/evidence owner is identified separately from UI hosting.
- [ ] Vercel is listed as a public web/app/intake surface, not the default GAIL authority runtime.
- [ ] Supabase is listed as app persistence where appropriate, not default GAIL authority/evidence source of truth.
- [ ] M365 is listed as enterprise body and official business record surface.
- [ ] Graphify is listed as relationship intelligence store/service.
- [ ] GAIL OS is listed as authority/evidence/action-state owner.
- [ ] Platform-specific current locations are marked as dev placement, not product architecture.
- [ ] Promotion gates are defined before local → hosted moves.

**Output files:**

- `docs/infrastructure/2026-06-28 - Infrastructure Placement Register.md`
- `docs/infrastructure/2026-06-28 - Promotion Gates.md`
- Optional `docs/infrastructure/placement-register.yaml`

**Validation:**

- Check for accidental source-of-truth conflicts.
- Check for hard-coded Windows/Linux assumptions in the register.
- Confirm no cloud service is granted new authority by being mentioned.

**Unblocks:**

- Future hosting decisions.
- Cloud deployment planning.
- Investor/client explanation.

**Stop condition:**

Stop before deploying services, moving persistence, adding secrets, changing DNS, configuring Vercel/Supabase, or exposing live APIs publicly.

---

# 6. Risk closure map

| Risk | Controlled by chunk | Control mechanism |
|---|---|---|
| GAIL HTTP uncertainty stalls work | 20A | Park transport at service/contract seam |
| Freedom becomes accidental schema authority | 20C, 20F | GAIL exports canonical JSON schemas; Freedom consumes |
| Graphify remains undervalued | 20D, 20E | Elevate as connectome/relationship field and create graph-fact lane |
| Graphify gets execution authority by accident | 20D, 20E | API-read/extraction-write rule and no approval authority |
| M365 live writes expand too soon | 20G | One-writer audit, no live write boundary, BLK-005 status |
| Vercel/Supabase become accidental authority stores | 20H | Placement register separates UI/app persistence from authority/evidence |
| Windows/Linux current split becomes product constraint | 20A, 20H | Platform-agnostic service rule |
| Four builds converge into one blob | 20A | Architecture Governor and repo ownership map |
| Recursive learning bypasses governance | 20E, 20F | Learning inputs become evidence/graph/research records, not authority |
| Build agents over-read or overbuild | All chunks | One objective, named outputs, stop condition, validation |

---

# 7. Universal instructions for all coding agents

Use this instruction block at the top of each repo-specific prompt:

```text
You are working inside the Guided AI Labs Agentic OS CNS architecture.
Do not redesign the architecture.
Do not merge repos.
Do not create a second source of truth.
Do not activate live connectors unless the chunk explicitly authorizes it.
Do not treat Graphify recommendations as approval authority.
Do not let Freedom self-approve restricted actions.
Do not let M365 become the governance brain.
Do not let GAIL OS become the executive cognition layer.
Do not hard-code the current Windows/Linux split as the product architecture.
Build the smallest durable slice that satisfies the chunk acceptance criteria.
Stop when the chunk is complete.
```

---

# 8. Recommended execution order

The safest next execution order is:

1. **20A** — GAIL OS Architecture Governor and CP-1 parking.
2. **20B** — GAIL OS local approval actions under guardrails.
3. **20C** — GAIL OS canonical CP-1 contract export.
4. **20D** — Graphify CNS connectome contract normalization.
5. **20F** — Freedom mission proposal against GAIL-owned contracts.
6. **20G** — M365 bridge placement and one-writer audit.
7. **20H** — Infrastructure placement register.
8. **20E** — GAIL OS → Graphify safe graph-fact extraction lane.

20E can move earlier if Graphify acceleration becomes the main blocker, but it should not precede 20C unless the graph-fact schema is tightly synthetic and explicitly provisional.

---

# 9. Non-blocking open questions for Adam

These do not block Chunk Twenty-A.

1. Should the Architecture Governor live only in GAIL OS, or also be mirrored in the agentic multi-agent builder control repo? **Default:** GAIL OS first.
2. Should the infrastructure placement register live in GAIL OS, or in a separate CNS/build-control repo once one exists? **Default:** control repo first, migration allowed.
3. Is BLK-005 still unknown, or has the M365 app registration status changed since the latest repo docs? **Default:** unknown/blocked for production bridge.
4. Should the first `@gail/contracts` package be local-file generated only, or eventually published to npm/private GitHub Packages? **Default:** local generated TypeScript first.
5. Should the first Graphify graph-fact import target be GAIL-only records, or include Freedom proposal records once CP-1 is proven? **Default:** GAIL-only synthetic records first.
