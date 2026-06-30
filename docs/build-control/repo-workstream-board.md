# Repo Workstream Board — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-29 — Phases 0–6 COMPLETE. Phase 7 H1–H5 + H5-apply done. Forward pivot: Freedom executive capability is the next priority; H6 and BLK-004 remain secondary queued support work.
**Owner:** Build Agent Orchestrator

Task states: `independent` | `coordinated` | `queued` | `queued-secondary` | `blocked` | `ready-for-integration` | `ready-for-review` | `complete`

## 2026-06-29 Forward Pivot

This board is no longer the sole next-task source for capability work. For forward planning, use:

- `docs/build-control/handoff-state.md`
- `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`
- `docs/build-control/2026-06-29 - Graphify Connective Layer Boundary Note.md`

Freedom executive capability is the next priority. Graphify remains relationship infrastructure and should not become mandatory runtime ballast. H6 and BLK-004 are useful support work, but they are secondary to fixing Freedom's use-capability gap.

---

## Phase 0 — Architecture Doctrine + Contract Consolidation

**Phase goal:** All repos aligned to master architecture language. Locked: CNS model, R/A ladders, object model, source-of-truth ownership. No repo races ahead until this is complete.

Platform tags: `cloud-safe` = GitHub MCP only | `windows-local` = needs Windows execution | `linux-local` = needs Linux execution | `coordinated` = cross-machine

| # | Task | Repo | Platform | State | Notes |
|---|---|---|---|---|---|
| 0.1 | Accept master architecture doc as governing reference | All repos | — | `complete` | Locked 2026-06-25 in `master-plan-summary.md` |
| 0.2 | Align Freedom repo to "executive cognition" framing (not UI-first) | `the-freedom-engine-os` | `cloud-safe` | `complete` | Merged 2026-06-27. PR #21. |
| 0.3 | Align GAIL OS Rev 2 to "deep-brain / autonomic management" framing | `gail-ai-operating-system-rev-2` | `cloud-safe` | `complete` | Merged 2026-06-27. PR #1. |
| 0.4 | Align Graphify to "core cognitive infrastructure" framing (not product spoke) | `graphify-workspace-cockpit` | `cloud-safe` | `complete` | Merged 2026-06-27. PR #1. vision.md UAOS→GAIL OS conflict resolved. |
| 0.5 | Document R0–R5 + A0–A6 ladders as shared canonical in GAIL OS | `gail-ai-operating-system-rev-2` | `cloud-safe` | `complete` | Merged 2026-06-27. PR #2. A-level descriptions elaborated (Adam confirmed). |
| 0.6 | Align M365 Foundation to "first-class enterprise body" framing | `ag-operations-m365-foundation` | `cloud-safe` | `complete` | Merged 2026-06-27. PR #2. UAOS drift in stage docs flagged for rename pass. |
| 0.7 | Each product repo adds CNS role statement to AGENTS.md | All product repos | `cloud-safe` | `complete` | Merged 2026-06-27. PRs 0.7a–0.7f all merged across 6 repos. |
| 0.8 | Resolve what "Enhanced Graphify" on Windows means vs. cockpit on Linux | Windows + Linux | `coordinated` | `coordinated` | Decision in master-plan-summary.md §8. Blocked by open Q2. |

**Phase 0 gate (CP-0):** All repos can map their purpose to CNS layer. Open a PR in each repo with role statement before Phase 1 proceeds in that repo.

---

## Phase 1 — Core Operating Spine

**Phase goal:** One canonical action can move through the state machine. GAIL OS Rev 2 is the implementation home.

Note: Phase 1 tasks are `windows-local`. A cloud agent may write code and open a PR, but test validation requires the Windows machine or GitHub Actions CI (not yet configured in GAIL OS Rev 2).

| # | Task | Repo | Platform | State | Notes |
|---|---|---|---|---|---|
| 1.1 | Port `Mission` schema from UAOS Rev 1 → GAIL OS Rev 2 | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #4 2026-06-27. `MissionStatus` enum + Mission types. 10 tests. |
| 1.2 | Port `Action` + state machine from Rev 1 → Rev 2 | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #7 2026-06-28. `Action` dataclass + 12 state transitions + `transition_action()`. 21 tests. |
| 1.3 | Define `AuthorityEnvelope` schema (all 14 charter fields from master plan) | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #5 2026-06-27. 14-field `AuthorityEnvelope`, R0–R5, A0–A6 enums. 14 tests. |
| 1.4 | Define `EvidencePacket` schema (all required fields from master plan §11.4) | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #6 2026-06-27. 12-field `EvidencePacket`, `create_evidence_packet()`, `validate_evidence_packet()`. 14 tests. |
| 1.5 | Build `Connector` registry (registered bridges, scopes, rate limits, evidence expectations) | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #11 2026-06-28. `ConnectorRegistry` + 7 seed connectors. CP-1 prerequisite. |
| 1.6 | Build `Agent` registry (purpose, owner/sponsor, maturity, permissions, performance) | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PR #13 2026-06-28. `AgentRegistry` + 6 seed agents. `GET /api/v1/agents`. 10 tests. |
| 1.7 | Define canonical event vocabulary as TypeScript types | `the-freedom-engine-os` + `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Freedom PR #33: TypeScript wire types merged. GAIL OS Python-side `OkpRecordType` enum addressed in Chunk 5.2. Both sides covered. |
| 1.8 | Expose mission + action + evidence as API endpoints | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | Merged PRs #8–#11 2026-06-28. FastAPI HTTP layer live. CP-1 integration test (Freedom PR #27) passes. |
| 1.9 | Walk one action through full state machine manually with evidence | `gail-ai-operating-system-rev-2` | `complete` | `complete` | CP-1 proven 2026-06-28. 4/4 integration tests pass against live GAIL OS server via direct cable link. |

**Phase 1 gate (CP-1):** One action walks the full state machine. Evidence packet created. API reachable from Linux. **CP-1 COMPLETE 2026-06-28.**

---

## Phase 2 — Graphify Core Promotion

**Phase goal:** Graphify maps clients, workflows, repos, agents, source refs, risks, evidence, and research claims as relationship intelligence — not just workspace visualization.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 2.1 | Extend graph schema to cover CNS entity domains (see master plan §12.1) | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27 — chunks 2.1–2.9 in cockpit. Evidence, Research, Agent, Code/Build domains added. |
| 2.2 | Add `EvidencePacket` node type — link to OS evidence via `SourceRef` | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27 — part of schema extension work. |
| 2.3 | Add `ResearchClaim` node type with confidence, expiry, recheck fields | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27. |
| 2.4 | Add `Agent` / `Capability` node types linked to OS agent registry | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27. |
| 2.5 | Build research ingestion pipeline (source → claim → affected capability → graph edge) | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27 — `cns_api/routes/ingest.py` live. |
| 2.6 | Expose graph query API as named HTTP endpoint (not just CLI) | `graphify-workspace-cockpit` | `complete` | Done 2026-06-27. **BLK-002 resolved.** CNS API on port 8001. Freedom endpoints: entity context, mission history, domain mapping. 217 tests passing. |
| 2.7 | Windows Enhanced Graphify: extract GAIL OS Rev 2 + M365 Foundation repos | Windows | `independent` | Run extraction, push graph.json to GitHub |
| 2.8 | Merge Windows graph output into Linux cockpit workspace graph | `graphify-workspace-cockpit` | `blocked` | Blocked by 2.7 |

**Phase 2 gate:** Graphify can answer: "What agents exist?", "What evidence links to this mission?", "What research affects this capability?"

---

## Phase 3 — Freedom Operating Cognition

**Phase goal:** Freedom produces a decision brief with context, risk, next action, and authority path.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 3.1 | Connect Freedom to GAIL OS mission state API | `the-freedom-engine-os` | `complete` | Merged PR #28 2026-06-28. `gail-os-server.ts` singleton + `/api/gail-os/missions` + `/api/gail-os/actions/validate` routes. |
| 3.2 | Connect Freedom to Graphify graph query API | `the-freedom-engine-os` | `complete` | Merged PR #28 2026-06-28. `createHttpGraphifyTransport` + CNS entity methods in `@freedom/graphify-client`. Entity context enrichment route. 8/8 unit tests. |
| 3.3 | Build authority request flow (Freedom → OS override request) | `the-freedom-engine-os` + `gail-ai-operating-system-rev-2` | `complete` | Merged Freedom PR #29 + GAIL OS PR #12 2026-06-28. `requestAuthorityOverride` in gail-os-client + POST /api/gail-os/authority/override route. 10/10 tests pass. |
| 3.4 | Build agent/capability discovery + routing in Freedom | `the-freedom-engine-os` | `complete` | Merged PR #31 2026-06-28. `listAgents` in gail-os-client + `agentRouter.ts` (resolveAgentForAction). 18/18 tests. |
| 3.5 | Build executive briefing generator (context + risk + next action + authority path) | `the-freedom-engine-os` | `complete` | Merged PR #30 2026-06-28. `generateExecutiveBrief()` — concurrent GAIL OS + Graphify fan-out, structured brief with context/risk/next-action/authority-path. 8/8 tests. **CP-3 gate met.** |
| 3.6 | Integrate Freedom cockpit portals (desktop, gateway, mobile) with OS + Graphify | `the-freedom-engine-os` | `complete` | Merged PR #32 2026-06-28. `checkCnsActionGate()` + `POST /api/cns-gate`. 6/6 tests. 238/238 suite clean. |

**Phase 3 gate (CP-3):** Freedom produces a decision brief. Override request recorded in OS.

---

## Phase 4 — M365 First-Class Execution Lane

**Phase goal:** A governed M365 writeback (List row or Planner task) occurs through the OS with source refs and evidence.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 4.1 | Register M365 bridge in OS Connector registry | `gail-ai-operating-system-rev-2` | `complete` | Merged PR #15 2026-06-28. `m365-graph-api-bridge` ConnectorProfile added (registry-only, readiness-check). 10 tests. |
| 4.2 | Implement Microsoft Graph auth (app registration, least privilege) | `gail-ai-operating-system-rev-2` | `complete` | Merged PR #14 2026-06-28. `GraphAuthProvider` (MSAL client-credentials) + `GET /api/v1/m365/status`. 11 tests. |
| 4.3 | Implement first M365 read action (R0 observe) with evidence | `gail-ai-operating-system-rev-2` | `complete` | Merged PR #16 2026-06-28. `observe_graph_metadata()` + `POST /api/v1/m365/observe`. 12 tests. |
| 4.4 | Implement first M365 internal write (R2) — List row or Planner task | `gail-ai-operating-system-rev-2` | `complete` | Merged PR #17 2026-06-28. `create_planner_task()` + `POST /api/v1/m365/write/planner-task`. 13 tests. |
| 4.5 | Evidence packet returned and stored after M365 write | `gail-ai-operating-system-rev-2` | `complete` | Merged PR #18 2026-06-28. `save_evidence_packet()` + updated write endpoint. 10 tests. |
| 4.6 | Graphify updates relationship map after M365 action | `graphify-workspace-cockpit` | `complete` | Merged PR #2 2026-06-28. `ingest_evidence_entity()` + `POST /api/cns/evidence` + `GET /api/cns/evidence/{id}`. 10 tests. |

**Phase 4 gate (CP-4):** M365 write with OS evidence. Graphify updated. Reversible first action. **CP-4 COMPLETE.**

---

## Phase 5 — Operating Knowledge Intake and Relationship Mesh

**Phase goal:** GAIL OS and Graphify ingest controlled operating knowledge from internal CNS sources. Freedom briefs with Signal Gravity. Synaptic Proof Chain demonstrated in dual format (CP-5).

**Scope reset 2026-06-28:** Prior product-repo event-emitter tasks are retired. All Phase 5 implementation stays in the four core CNS repos. See `docs/decisions/2026-06-28 - Phase 5 and Phase 6 Reset Decision.md`.

Platform tags: `cloud-safe` = GitHub MCP only | `windows-local` = needs Windows | `blocked` = hard dependency outstanding

| # | Chunk | Repo | Platform | State | Notes |
|---|---|---|---|---|---|
| 5.0 | Corrections + board reconciliation | `agentic-multi-agent-agent-builder` | `cloud-safe` | `complete` | Decision doc written. Board corrected. 2026-06-28. |
| 5.1 | Product branch abandonment notes | Six product repos (docs only) | `cloud-safe` | `complete` | Completed during Phase 5 reset. Product repo event-emitter path retired. |
| 5.2 | OKP schema + EvidencePacket wrapper | `gail-ai-operating-system-rev-2` | `cloud-safe` | `complete` | Completed 2026-06-28. See handoff-state and CP-5 proof chain. |
| 5.3 | OKP ingest + Signal Gravity L1 | `gail-ai-operating-system-rev-2` | `cloud-safe` | `complete` | Completed 2026-06-28. |
| 5.4 | Graphify OKP nodes + Signal Gravity L2 | `graphify-workspace-cockpit` | `cloud-safe` | `complete` | Completed 2026-06-28. Graphify remains relationship intelligence, not authority. |
| 5.5 | M365 CNS source surface map | `ag-operations-m365-foundation` | `cloud-safe` | `complete` | Completed 2026-06-28. No live Graph writes. |
| 5.6 | Freedom OKP briefing + Signal Gravity | `the-freedom-engine-os` | `cloud-safe` | `complete` | Completed 2026-06-28. |
| 5.7 | CP-5 dry-run proof (dual format) | All three code repos | `cloud-safe` | `complete` | CP-5 proof complete; see `docs/build-control/2026-06-28 - CP5 Synaptic Proof Chain.md`. |
| 5.8 | Windows Graphify extraction status update | `graphify-workspace-cockpit` | `windows-local` | `queued-secondary` | BLK-004 remains useful, but does not block hot-path Freedom capability work. |

**Phase 5 gate (CP-5):** COMPLETE. Operating knowledge flows from source record → Graphify relationship → Freedom brief with Signal Gravity and Synaptic Proof Chain (dual format).

---

## Phase 6 — R4 Autonomy (Charter-Based)

**Phase goal:** Define, prove, and execute the first R4 autonomous charter — Graphify stale-claim review — under governed conditions.

**Gate:** COMPLETE.

| # | Chunk | Repo | Platform | State | Notes |
|---|---|---|---|---|---|
| 6.0 | R4 Charter Doctrine | `gail-ai-operating-system-rev-2` (docs) | `cloud-safe` | `complete` | Commit `57b52fc`. R4/R5 distinction, R4-001 scope, exclusions, rollback, simulation-before-mutation rule. |
| 6.1 | CharterProfile schema | `gail-ai-operating-system-rev-2` | `cloud-safe` | `complete` | Commit `307d4c1`. 17 tests. |
| 6.2 | Graphify charter nodes | `graphify-workspace-cockpit` | `cloud-safe` | `complete` | Commit `7fdc23d`. 21 tests. |
| 6.3 | Freedom charter discovery + briefing | `the-freedom-engine-os` | `cloud-safe` | `complete` | Commit `e00fbc2`. No self-approval. |
| 6.4 | R4 dry-run simulation | All three code repos | `mixed` | `complete` | Commit `f53e35f`. No live mutation. |
| 6.5 | R4 limited internal execution | All three code repos | `mixed` | `complete` | Adam approved. Graphify stale-claim review executed; graphify commit `48167ef`, GAIL OS commit `5478b64`. |

**Phase 6 gate (CP-6):** COMPLETE 2026-06-28.

---

## Phase 7 — CNS Hosting Pilot

**Phase goal:** Deploy GAIL OS + Graphify to Azure Container Apps (Canada Central). Connect Freedom on Vercel. Remediate Supabase RLS. Prepare M365 live bridge readiness docs. Budget target: under $300/month.

**Status:** H1–H5 + H5-apply complete. H6 (M365 docs) + BLK-004 (Windows Graphify) pending.

**Gate:** Phases 0–6 complete. Azure personal account (`adamgdwn@hotmail.com`) approved for pilot.

| H | Chunk | Repo | Platform | State | Notes |
|---|---|---|---|---|---|
| H0 | Hosting placement register | `agentic-multi-agent-agent-builder` | `cloud-safe` | `complete` | `docs/hosting/2026-06-28 - CNS Hosting Pilot Strategy.md` + `cns-hosting-placement-register.yaml` committed. |
| H1 | Azure foundation scaffold | `agentic-multi-agent-agent-builder` | `windows-local` | `complete` | Resource group, Log Analytics, Key Vault, Storage Account, ACR, ACA environment — all provisioned in `canadacentral`. IaC in `infra/azure-pilot/deploy-notes.md`. |
| H2 | GAIL OS container deployed | `gail-ai-operating-system-rev-2` | `windows-local` | `complete` | `aca-gail-os-api` live. Health: `{"status":"ok","boundary":"A1 local no-network","phase":"1"}` HTTP 200. URL: `https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` |
| H3 | Graphify container + persistent storage | `graphify-workspace-cockpit` | `windows-local` | `complete` | `aca-graphify-cns-api` live with Azure Files share `graphify-files` mounted at `/app/data`. Health: `{"status":"ok","store":"connected","node_count":0}` HTTP 200. |
| H4 | Freedom → Azure connected | `the-freedom-engine-os` | `linux-local` | `complete` | API keys applied via `.env.local`. All 6 smoke test checks pass (both sides ACK). Env var doc: `docs/hosting/2026-06-28 - vercel-env-setup.md`. |
| H5 | Supabase RLS package committed | `the-freedom-engine-os` | `windows-local` | `complete` | Commits `530f575` (Freedom) + `3e4b5d7` (Rev 2). 21 legacy public tables covered. Forward migration + rollback SQL + remediation plan committed. CI green (`28348544121`). Hosted apply completed separately in H5-apply. |
| H5-apply | Hosted Supabase RLS migration apply | `the-freedom-engine-os` | `windows-local` | `complete` | Applied 2026-06-28. Project `basbwglynuyfxcqxfyur`. 21/21 tables `relrowsecurity=true`, 0 new policies. 7 backups confirmed pre-apply. Service-role access intact. Freedom `3543b29`, Rev 2 `e93b358`. |
| H6 | M365 live bridge readiness docs | `ag-operations-m365-foundation` | `linux-local` | `queued-secondary` | Lane 2. Docs/prep only — update M365 source surface map. No live M365 writes. |
| BLK-004 | Windows Graphify extraction | Windows | `windows-local` | `queued-secondary` | Useful for relationship coverage; not a hot-path blocker for Freedom executive capability work. |

**Phase 7 gate (CP-7):** All H-chunks complete (including H5-apply after Adam gate) + budget confirmed under $300/month + no secrets committed + no live M365 writes without explicit separate approval.

---

## Phase 8–9 — Future Phases

Phases 8–9 are sequenced after Phase 7 gate is met.

| Phase | Next action when gate met |
|---|---|
| 8 — Client Package | Begin packaging when CP-7 cleared + one R4 charter proven in execution |
| 9 — R&D Edge | R&D track runs in parallel; never blocks production gates |

---

## Repo Status Summary (2026-06-29)

| Repo | P0 | P1 | P2 | P3 | P4 | P5 | P6 | P7 | Notes |
|---|---|---|---|---|---|---|---|---|---|
| `the-freedom-engine-os` | ✓ | ✓ | — | ✓ | — | ✓ | ✓ (6.3) | H4 ✓ H5 ✓ H5-apply ✓ | H5-apply: hosted Supabase RLS applied to `basbwglynuyfxcqxfyur` — 21/21 tables, 0 new policies (3543b29). Freedom CI green. |
| `gail-ai-operating-system-rev-2` | ✓ | ✓ | — | ✓ | ✓ | ✓ | ✓ (6.5) | H2 ✓ | ACA deployed. GAIL OS A1 boundary enforced. Rev 2 coordination commit 3e4b5d7 (H5). |
| `graphify-workspace-cockpit` | ✓ | — | ✓ | — | ✓ | ✓ | ✓ (6.2) | H3 ✓ | ACA deployed with Azure Files persistence. CNS store connected. |
| `ag-operations-m365-foundation` | ✓ | — | — | — | — | ✓ | — | H6 (queued) | Lane 2. H6 docs/prep queued. No live writes. |
| `agentic-multi-agent-agent-builder` | — | — | — | — | — | — | — | H0 ✓ H1 ✓ | IaC scripts committed. Build control docs current. |
| `guided-ai-journey-website-and-tools` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
| `oldskoolai.com` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
| `bowtie_risk_program` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
| `change-leadership-tools` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
| `clean-pdf-build` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
| `guided-ai-labs-website` | ✓ | — | — | — | — | abandoned | — | — | Product repo. Phase 5 branch abandoned. |
