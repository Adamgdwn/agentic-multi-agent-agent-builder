# Repo Workstream Board — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-25
**Owner:** Build Agent Orchestrator

Task states: `independent` | `coordinated` | `blocked` | `ready-for-integration` | `ready-for-review` | `complete`

---

## Phase 0 — Architecture Doctrine + Contract Consolidation

**Phase goal:** All repos aligned to master architecture language. Locked: CNS model, R/A ladders, object model, source-of-truth ownership. No repo races ahead until this is complete.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 0.1 | Accept master architecture doc as governing reference | All repos | `complete` | Locked 2026-06-25 in `master-plan-summary.md` |
| 0.2 | Align Freedom repo to "executive cognition" framing (not UI-first) | `the-freedom-engine-os` | `independent` | README already reflects this; verify AGENTS.md |
| 0.3 | Align GAIL OS Rev 2 to "deep-brain / autonomic management" framing | `gail-ai-operating-system-rev-2` | `independent` | Verify no "hand brake" framing in docs |
| 0.4 | Align Graphify to "core cognitive infrastructure" framing (not product spoke) | `graphify-workspace-cockpit` | `independent` | Cockpit docs need CNS-role section added |
| 0.5 | Document R0–R5 + A0–A6 ladders as shared canonical in GAIL OS | `gail-ai-operating-system-rev-2` | `independent` | Source of truth for both ladders |
| 0.6 | Align M365 Foundation to "first-class enterprise body" framing | `ag-operations-m365-foundation` | `independent` | Stage 9 doc already lays groundwork |
| 0.7 | Each product repo adds CNS role statement to AGENTS.md | All product repos | `independent` | Quick docs task per repo |
| 0.8 | Resolve what "Enhanced Graphify" on Windows means vs. cockpit on Linux | Windows + Linux | `coordinated` | Decision captured in master-plan-summary.md §8 |

**Phase 0 gate (CP-0):** All repos can map their purpose to CNS layer. Open a PR in each repo with role statement before Phase 1 proceeds in that repo.

---

## Phase 1 — Core Operating Spine

**Phase goal:** One canonical action can move through the state machine. GAIL OS Rev 2 is the implementation home.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 1.1 | Port `Mission` schema from UAOS Rev 1 → GAIL OS Rev 2 | `gail-ai-operating-system-rev-2` | `independent` | Rev 1 at `user-ai-operating-system` as reference |
| 1.2 | Port `Action` + state machine from Rev 1 → Rev 2 | `gail-ai-operating-system-rev-2` | `independent` | State: observed → proposed → … → learned |
| 1.3 | Define `AuthorityEnvelope` schema (all 14 charter fields from master plan) | `gail-ai-operating-system-rev-2` | `independent` | New work; no prior implementation |
| 1.4 | Define `EvidencePacket` schema (all required fields from master plan §11.4) | `gail-ai-operating-system-rev-2` | `independent` | New work |
| 1.5 | Build `Connector` registry (registered bridges, scopes, rate limits, evidence expectations) | `gail-ai-operating-system-rev-2` | `independent` | |
| 1.6 | Build `Agent` registry (purpose, owner/sponsor, maturity, permissions, performance) | `gail-ai-operating-system-rev-2` | `independent` | Freedom Engine already has agent registry — check for import |
| 1.7 | Define canonical event vocabulary as TypeScript types | `gail-ai-operating-system-rev-2` | `independent` | ~30 events from master plan §13.4 |
| 1.8 | Expose mission + action + evidence as API endpoints (HTTP or Supabase RPC) | `gail-ai-operating-system-rev-2` | `blocked` | Blocked by 1.1–1.4 |
| 1.9 | Walk one action through full state machine manually with evidence | `gail-ai-operating-system-rev-2` | `blocked` | Acceptance test for Phase 1 gate |

**Phase 1 gate (CP-1):** One action walks the full state machine. Evidence packet created. API reachable from Linux.

---

## Phase 2 — Graphify Core Promotion

**Phase goal:** Graphify maps clients, workflows, repos, agents, source refs, risks, evidence, and research claims as relationship intelligence — not just workspace visualization.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 2.1 | Extend graph schema to cover CNS entity domains (see master plan §12.1) | `graphify-workspace-cockpit` | `independent` | Add: Evidence, Risk/Control, Capabilities/Agents, Research, Code/Build domains |
| 2.2 | Add `EvidencePacket` node type — link to OS evidence via `SourceRef` | `graphify-workspace-cockpit` | `coordinated` | Requires CP-1 (OS evidence schema) |
| 2.3 | Add `ResearchClaim` node type with confidence, expiry, recheck fields | `graphify-workspace-cockpit` | `independent` | |
| 2.4 | Add `Agent` / `Capability` node types linked to OS agent registry | `graphify-workspace-cockpit` | `coordinated` | Requires 1.6 |
| 2.5 | Build research ingestion pipeline (source → claim → affected capability → graph edge) | `graphify-workspace-cockpit` | `independent` | New backend route + service |
| 2.6 | Expose graph query API as named HTTP endpoint (not just CLI) | `graphify-workspace-cockpit` | `independent` | Required before Freedom can query Graphify |
| 2.7 | Windows Enhanced Graphify: extract GAIL OS Rev 2 + M365 Foundation repos | Windows | `independent` | Run extraction, push graph.json to GitHub |
| 2.8 | Merge Windows graph output into Linux cockpit workspace graph | `graphify-workspace-cockpit` | `blocked` | Blocked by 2.7 |

**Phase 2 gate:** Graphify can answer: "What agents exist?", "What evidence links to this mission?", "What research affects this capability?"

---

## Phase 3 — Freedom Operating Cognition

**Phase goal:** Freedom produces a decision brief with context, risk, next action, and authority path.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 3.1 | Connect Freedom to GAIL OS mission state API | `the-freedom-engine-os` | `blocked` | Blocked by CP-1 |
| 3.2 | Connect Freedom to Graphify graph query API | `the-freedom-engine-os` | `blocked` | Blocked by 2.6 |
| 3.3 | Build authority request flow (Freedom → OS override request) | `the-freedom-engine-os` + `gail-ai-operating-system-rev-2` | `blocked` | Coordinated; blocked by CP-1 |
| 3.4 | Build agent/capability discovery + routing in Freedom | `the-freedom-engine-os` | `blocked` | Blocked by CP-1 + OS agent registry (1.6) |
| 3.5 | Build executive briefing generator (context + risk + next action + authority path) | `the-freedom-engine-os` | `blocked` | Blocked by 3.1 + 3.2 |
| 3.6 | Integrate Freedom cockpit portals (desktop, gateway, mobile) with OS + Graphify | `the-freedom-engine-os` | `blocked` | Final integration; blocked by 3.1–3.5 |

**Phase 3 gate (CP-3):** Freedom produces a decision brief. Override request recorded in OS.

---

## Phase 4 — M365 First-Class Execution Lane

**Phase goal:** A governed M365 writeback (List row or Planner task) occurs through the OS with source refs and evidence.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 4.1 | Register M365 bridge in OS Connector registry | `gail-ai-operating-system-rev-2` | `blocked` | Blocked by CP-1 (connector registry) |
| 4.2 | Implement Microsoft Graph auth (app registration, least privilege) | `ag-operations-m365-foundation` → GAIL OS | `independent` | Stage 2 docs already complete; implement in GAIL OS |
| 4.3 | Implement first M365 read action (R0 observe) with evidence | `gail-ai-operating-system-rev-2` | `blocked` | Blocked by 4.1 |
| 4.4 | Implement first M365 internal write (R2) — List row or Planner task | `gail-ai-operating-system-rev-2` | `blocked` | Blocked by 4.3 + CP-1 authority envelope |
| 4.5 | Evidence packet returned and stored after M365 write | `gail-ai-operating-system-rev-2` | `blocked` | Blocked by 4.4 + 1.4 |
| 4.6 | Graphify updates relationship map after M365 action | `graphify-workspace-cockpit` | `blocked` | Blocked by 4.5 + CP-1 graph edge from evidence |

**Phase 4 gate (CP-4):** M365 write with OS evidence. Graphify updated. Reversible first action.

---

## Phase 5 — Product App + Website Integration

**Phase goal:** Each product app operates as a bounded circuit with registered authority, data, and evidence model.

| # | Task | Repo | State | Notes |
|---|---|---|---|---|
| 5.1 | Guided AI Journey: define + emit structured events to OS | `guided-ai-journey-website-and-tools` | `blocked` | Blocked by CP-1 event contracts |
| 5.2 | OldSkoolAI: define + emit capability signal events | `oldskoolai.com` | `blocked` | Blocked by CP-1 |
| 5.3 | Bowtie: define + emit risk/control events to OS + Graphify | `bowtie_risk_program` | `blocked` | Blocked by CP-1 + Graphify risk domain (2.1) |
| 5.4 | Change Leadership Tools: emit stakeholder + adoption events | `change-leadership-tools` | `blocked` | Blocked by CP-1 |
| 5.5 | EasyDraft Docs: document generation under source/evidence control | `clean-pdf-build` | `blocked` | Blocked by CP-1 evidence model |
| 5.6 | guidedailabs.com: emit `inquiry.created`, `demo_requested`, etc. | `guided-ai-labs-website` | `blocked` | Blocked by CP-1 event contracts |
| 5.7 | guidedaijourney.com: emit `readiness.completed`, `pilot_candidate.created` | `guided-ai-journey-website-and-tools` | `blocked` | Blocked by CP-1 |
| 5.8 | oldskoolai.com: emit `lesson.completed`, `role_path.selected` | `oldskoolai.com` | `blocked` | Blocked by CP-1 |

---

## Phase 6–9 — Future Phases

Phases 6–9 are sequenced after Phase 1–5 gates are met. Do not plan implementation tasks for these until the preceding gate is cleared.

| Phase | Next action when gate met |
|---|---|
| 6 — R4 Autonomy | Define first R4 charter (narrow + reversible) when CP-3 is cleared |
| 7 — Learning Loop | Define first learning consolidation target when Phases 1+2+3 produce operational evidence |
| 8 — Client Package | Begin packaging when CP-4 is cleared + one R4 charter is proven |
| 9 — R&D Edge | R&D track runs in parallel; never blocks production gates |

---

## Repo Status Summary (2026-06-25)

| Repo | Phase 0 | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Notes |
|---|---|---|---|---|---|---|---|
| `the-freedom-engine-os` | in-progress | blocked | — | blocked | — | — | V1 scaffold exists; needs OS + Graphify connection |
| `gail-ai-operating-system-rev-2` | in-progress | independent | — | — | blocked | — | Active Windows development; needs Rev 2 spine |
| `graphify-workspace-cockpit` | in-progress | — | in-progress | — | — | — | "Second video ready"; needs CNS schema extensions |
| `ag-operations-m365-foundation` | independent | — | — | — | independent | — | Stages 1–9 documented; needs OS connector registration |
| `guided-ai-journey-website-and-tools` | independent | — | — | — | — | blocked | Active product; urgent customer journey fix in progress |
| `oldskoolai.com` | independent | — | — | — | — | blocked | Active product |
| `bowtie_risk_program` | independent | — | — | — | — | blocked | Active product |
| `change-leadership-tools` | independent | — | — | — | — | blocked | |
| `clean-pdf-build` | independent | — | — | — | — | blocked | |
| `guided-ai-labs-website` | independent | — | — | — | — | blocked | Active site |
