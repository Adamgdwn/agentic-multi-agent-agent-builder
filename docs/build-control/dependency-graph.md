# Dependency Graph — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-25
**Owner:** Build Agent Orchestrator

---

## 1. Layer Dependency Order

```
Phase 0: Architecture + Contracts (FOUNDATION — all repos blocked until this is complete)
  │
  ├── Phase 1: GAIL OS Core Spine
  │     mission state / authority envelope / evidence ledger / registries / event contracts
  │     └── OWNED BY: gail-ai-operating-system-rev-2 (Windows)
  │
  ├── Phase 2: Graphify Core Promotion
  │     graph schema / entity model / research ingestion / retrieval API
  │     └── OWNED BY: graphify-workspace-cockpit (Linux) + Enhanced Graphify (Windows)
  │
  ├── Phase 3: Freedom Operating Cognition  [DEPENDS ON: Phase 1 + Phase 2]
  │     mission state connection / Graphify context / authority requests / agent routing
  │     └── OWNED BY: the-freedom-engine-os (Linux)
  │
  ├── Phase 4: M365 Execution Lane  [DEPENDS ON: Phase 1]
  │     M365 bridge / Microsoft Graph / SharePoint/Lists/Planner/Teams/Exchange
  │     └── OWNED BY: ag-operations-m365-foundation (Windows) → implementation in GAIL OS
  │
  ├── Phase 5: Product App + Website Integration  [DEPENDS ON: Phase 1]
  │     event contracts / authority envelopes / data boundaries per product
  │     └── OWNED BY: each product repo independently, OS as event bus
  │
  ├── Phase 6: R4 Delegated Autonomy  [DEPENDS ON: Phase 1 + Phase 3]
  │     first authority charter / stop conditions / evidence proof
  │     └── OWNED BY: GAIL OS (charter) + Freedom (execution)
  │
  ├── Phase 7: Recursive Learning Loop  [DEPENDS ON: Phase 1 + Phase 2 + Phase 3]
  │     outcome → memory → graph → SOP/route/capability update
  │     └── OWNED BY: GAIL OS (evidence) + Graphify (graph) + Freedom (learning)
  │
  ├── Phase 8: Client-Ready Package  [DEPENDS ON: Phases 1–4]
  │     enterprise onboarding / governance review / M365 path / training
  │     └── OWNED BY: Guided AI Labs company layer
  │
  └── Phase 9: R&D Edge  [INDEPENDENT — never blocks production]
        A5/A6 / eval loops / fine-tuning
        └── OWNED BY: separate R&D track
```

---

## 2. Cross-Repo Contract Dependencies

### Upstream → Downstream (what each repo PROVIDES)

| Provider Repo | Contract Provided | Consumers |
|---|---|---|
| `gail-ai-operating-system-rev-2` | `Mission`, `Action`, `AuthorityEnvelope`, `Approval`, `EvidencePacket`, `Agent` registry, `Connector` registry, R0–R5 classification, event vocabulary | Freedom, Graphify, all product apps, M365 bridge |
| `graphify-workspace-cockpit` | `GraphNode`, `GraphEdge`, `SourceRef`, `ResearchClaim`, graph query API (`query/path/explain`) | Freedom, GAIL OS, all product apps |
| `the-freedom-engine-os` | Agent workforce orchestration, capability discovery, override requests, executive briefings | User portals, GAIL OS (override routing), Graphify (learning updates) |
| `ag-operations-m365-foundation` | M365 bridge contracts, Microsoft Graph action patterns, identity + least-privilege model, SharePoint/Lists/Planner/Teams/Exchange writeback patterns | GAIL OS (connector registry), Freedom (M365 action calls) |

### Downstream → Upstream (what each repo REQUIRES)

| Consumer Repo | Required From | Dependency Type |
|---|---|---|
| `the-freedom-engine-os` | `gail-ai-operating-system-rev-2` — authority envelopes, mission state, evidence | Hard: Freedom cannot act without OS gate |
| `the-freedom-engine-os` | `graphify-workspace-cockpit` — context retrieval, dependency maps | Soft: Freedom degrades gracefully but loses relationship reasoning |
| `gail-ai-operating-system-rev-2` | `graphify-workspace-cockpit` — graph references in evidence packets | Soft: OS works without graph refs but evidence is weaker |
| `ag-operations-m365-foundation` | `gail-ai-operating-system-rev-2` — authority envelope validation before any M365 write | Hard: No M365 write without OS classification and approval |
| All product apps | `gail-ai-operating-system-rev-2` — event intake, mission candidate creation | Hard: Unregistered product events have no governed path |
| All product apps | `graphify-workspace-cockpit` — graph node creation for their entities | Soft: Product events land in OS but are not relationship-mapped |

---

## 3. Blocking Dependencies (Phase Gate)

| Blocked Work | Blocked By | Gate Condition |
|---|---|---|
| Phase 3 (Freedom cognition) | Phase 1 (OS spine) | OS must expose `Mission` + `AuthorityEnvelope` API before Freedom can connect |
| Phase 3 (Freedom cognition) | Phase 2 (Graphify) | Graphify must expose graph query API before Freedom can route via context |
| Phase 4 (M365 lane) | Phase 1 (OS spine) | OS `Connector` registry must be live before M365 bridge registers |
| Phase 6 (R4 autonomy) | Phase 1 + Phase 3 | OS charter mechanism + Freedom override request path must exist |
| Phase 7 (recursive learning) | Phases 1, 2, 3 | All three core layers must produce evidence before learning loop can consolidate |
| Phase 8 (client package) | Phases 1–4 | At minimum one governed M365 write through OS must be demonstrated |

---

## 4. Cross-Machine Data Flow

```
Windows (GAIL OS Rev 2)
  ├── Runs OS core: mission state, authority, evidence, registries
  ├── Runs M365 bridge: Microsoft Graph, SharePoint, Teams, Exchange
  └── Pushes via GitHub → Linux reads

Linux (Freedom Engine OS)
  ├── Runs Freedom: cognition, briefings, portals, orchestration
  ├── Reads OS API (via registered connector or shared Supabase)
  └── Pushes via GitHub → Windows reads

Linux (Graphify Workspace Cockpit)
  ├── Primary Graphify API + visualization
  ├── Serves graph queries to Freedom and OS
  └── Ingests graph updates from Windows Enhanced Graphify via GitHub

Windows (Enhanced Graphify)
  ├── Extracts Windows repos: GAIL OS Rev 2, M365 Foundation, AG Operations
  ├── Ingests M365 metadata, SharePoint structure, agent relationships
  └── Pushes graph.json updates to GitHub → Linux cockpit ingests

GitHub (shared transport)
  ├── Source of truth for all code
  ├── Cross-machine coordination channel
  ├── Event contract definitions (shared types packages)
  └── graph.json sync point
```

---

## 5. Shared Type / Schema Contracts

These must be co-owned and versioned across all repos consuming them.

| Contract | Current Home | Status |
|---|---|---|
| R0–R5 authority ladder enum | `gail-ai-operating-system-rev-2/packages/` | Needs extraction as shared package |
| A0–A6 autonomy maturity enum | `gail-ai-operating-system-rev-2/packages/` | Needs extraction as shared package |
| `Mission` schema | `gail-ai-operating-system-rev-2` | Exists (prior UAOS work carried forward) |
| `AuthorityEnvelope` schema | `gail-ai-operating-system-rev-2` | Needs formalization in Rev 2 |
| `EvidencePacket` schema | `gail-ai-operating-system-rev-2` | Exists in prior work, needs Rev 2 port |
| `Action` state machine | `gail-ai-operating-system-rev-2` | Exists in prior work, needs Rev 2 port |
| `GraphNode` / `GraphEdge` schema | `graphify-workspace-cockpit/backend/graph_schema.py` | Exists |
| Event vocabulary (`signal.created`, etc.) | GAIL OS (canonical) | Needs first formal definition in Rev 2 |
| Website event contracts | Each website repo | Needs formalization per site |

---

## 6. Synchronization Checkpoints

| Checkpoint | Required Before | What Must Be True |
|---|---|---|
| **CP-0** | Phase 1 start | All repos can map to master architecture language. R/A ladders, object model, source-of-truth ownership locked. |
| **CP-1** | Phase 3 start | OS exposes `Mission`, `AuthorityEnvelope`, `EvidencePacket` endpoints. Graphify exposes graph query API. |
| **CP-2** | Phase 4 start | OS `Connector` registry is live and tested with at least one internal connector. |
| **CP-3** | Phase 6 start | Freedom + OS demonstrated at least one R3 approved action with evidence. |
| **CP-4** | Phase 8 start | One governed M365 write (create List row or Planner task) completed with source refs and evidence packet. |
