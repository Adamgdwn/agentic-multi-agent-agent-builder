# Risks and Blockers — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-29 (AG Operations / M365 bridge-readiness informing pulled forward. Freedom capability risk retained but implementation lane parked by current owner direction. RSK-017 tracks instruction drift. BLK-004 remains queued-secondary.)
**Owner:** Build Agent Orchestrator

---

## Active Blockers

| ID | Blocker | Affects | Unblocked By |
|---|---|---|---|
| ~~BLK-001~~ | ~~GAIL OS spine not exposed as HTTP API~~ | **CLOSED 2026-06-28** — Phase 1 complete. FastAPI HTTP layer live (PRs #8–#11). CP-1 integration test 4/4 passed. Freedom bridge live (Freedom PR #27). | Resolved |
| ~~BLK-002~~ | ~~Graphify graph query HTTP API not yet exposed for external callers~~ | **CLOSED 2026-06-27** — Graphify Phase 2 complete. 6 HTTP endpoints on port 8001, all SLAs verified. Freedom can query Graphify. | Resolved |
| ~~BLK-003~~ | ~~`@gail/contracts` shared types package does not exist~~ | **CLOSED 2026-06-28** — `@gail/contracts` JSON Schema package implemented in Phase 1 Chunk 22. TypeScript wire types merged to Freedom (PR #33). Cross-language contracts live. | Resolved |
| BLK-004 | Windows Enhanced Graphify has not extracted GAIL OS Rev 2 + M365 Foundation repos | Graphify has incomplete Windows-side architecture coverage | Phase 2.7 task on Windows — queued-secondary. Useful for relationship coverage, not a blocker for the active M365 bridge-readiness informing lane. |
| ~~BLK-005~~ | ~~M365 app registration + least-privilege permissions not yet confirmed as provisioned~~ | **CLOSED 2026-06-28** — App `9aeeeae6-be2a-476c-9c34-389dbc927c99` (`Guided AI Labs - CLI for Microsoft 365 Local Agent`) created via `m365 setup`, auth type `deviceCode`, tenant `1ca92af5-21ff-42e3-87ae-3bde9c2cc501`. Read-only proof passed (flow list verified). Full Entra scope expansion complete 2026-06-28. | Resolved |

---

## Active Risks

### Architecture Risks

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| RSK-001 | GAIL OS Rev 2 (Windows) and Freedom (Linux) develop incompatible API contracts because they're on different machines with no shared type enforcement | High | Critical | Create `@gail/contracts` package first. Cross-machine integration test at CP-1. |
| RSK-002 | Graphify graph on Linux and Graphify extraction on Windows produce divergent graph schemas | Medium | High | Lock graph schema in `graphify-workspace-cockpit/backend/graph_schema.py` as canonical. Windows Enhanced Graphify must validate against it before push. |
| RSK-003 | Product repos (GAI Journey, OldSkoolAI, Bowtie) race ahead with features that don't conform to OS event contracts | High | Medium | Phase 0: add CNS role statement and event contract stub to each product repo AGENTS.md before further feature work. |
| RSK-004 | Freedom continues V1 development without connecting to OS, creating a "Freedom island" that is hard to integrate later | Medium | High | Freedom Phase 3 tasks are clearly blocked on OS API. Do not build Freedom features that assume no OS. |
| RSK-005 | M365 Foundation is comprehensive documentation but no code connector — risk of doc-only perpetual planning | Medium | High | Phase 4 must produce at least one working M365 read + write with evidence. Documentation alone is not Phase 4 acceptance. |

### Governance Risks

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| RSK-006 | Autonomy language slips — A6 or "full autonomous" phrasing appears in code or config before safety evidence exists | Low | Critical | Non-negotiable rule 15 in master plan. Any A6 reference in non-R&D code is a build error. |
| RSK-007 | Evidence packets are skipped for "quick" actions, creating holes in the audit trail | Medium | High | Evidence is non-optional per action state machine. No action may skip `evidenced` state. Lint or test check recommended. |
| RSK-008 | GAIL OS is framed as a "hand brake" in documentation or agent instructions | Low | Medium | DEC-002 + master plan §3.2. Governance-as-handbrake framing is a non-negotiable violation. |

### Execution Risks

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| RSK-009 | Context resets between sessions cause agents to lose cross-repo coordination state | High | High | This risk is why this coordination repo exists. All state in files. All agents restart from `docs/build-control/handoff-state.md`. |
| RSK-010 | Build effort spreads across too many repos simultaneously before core spine exists | High | Medium | Strict phase gates. Phase 1 (GAIL OS spine) must reach CP-1 before Freedom or product app integration work begins. |
| RSK-011 | Direct link (Windows/Linux cable) used as primary coordination path — becomes a fragile dependency | Low | High | DEC-006: GitHub is primary. Direct link is last resort. |
| RSK-012 | `user-ai-operating-system` (Linux, superseded) accidentally used as reference for new OS work | Medium | Medium | SUPERSEDED notice is in place. Agents must check `SUPERSEDED_BY_GAIL_AI_OPERATING_SYSTEM_REV_2.md` before reading. |

### Critical Capability Risks

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| RSK-015 | **Freedom AI capability gap** — Infrastructure connectivity to GAIL OS / Graphify / M365 exists (Phase 3–7 complete) but the Freedom AI interface cannot USE those connections. Freedom can say "I'm connected" but cannot check M365, query files, initiate actions, or answer questions through the CNS. All Phase 3–7 infrastructure work is effectively unusable until Freedom's AI interface is built to executive depth. | **CRITICAL** | **Critical** | Retain the Freedom executive AI build reference, but do not restart Freedom implementation from this control-plane lane while Adam is actively improving Freedom elsewhere. Resume only when Adam routes back or Freedom asks for review/CI/implementation support. |
| RSK-016 | Graphify becomes mandatory runtime ballast or absorbs authority/execution responsibilities while trying to solve the Freedom capability gap. | Medium | High | Apply `2026-06-29 - Graphify Connective Layer Boundary Note.md` and the active subject repo ledger. Use hot/warm/cold context tiers; Graphify informs relationships, GAIL OS owns authority/evidence, Freedom owns executive use. |
| RSK-017 | Subject-repo instructions blur together, causing agents to apply parked Freedom work, Graphify speed doctrine, GAIL OS authority work, or M365 queued work in the wrong repository. | Medium | High | Maintain `2026-06-29 - Subject Repo Instruction Ledger.md`; update `handoff-state.md`, `repo-workstream-board.md`, and target repo startup docs when repo lanes change. |

### Commercial Risks

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| RSK-013 | Build produces a technically impressive system that no client can understand or adopt | Low | Critical | Phase 8 (client package) is non-optional. Infographic-first explanation is required before enterprise pitch. |
| RSK-014 | M365 integration is slow/incomplete, blocking the "meets organizations where they work" proof | Medium | High | Phase 4 is an explicit phase gate. M365 write with evidence is the acceptance test — not documentation. |

---

## Resolved / Mitigated

| ID | Risk/Blocker | Resolution | Date |
|---|---|---|---|
| RSK-000 | Ambiguity between Freedom, GAIL OS, and Graphify as architecture layers | Master plan locked. DEC-001, DEC-002, DEC-003 captured. | 2026-06-25 |
| RSK-00A | Graphify cross-machine graph fragmentation | DEC-005: Linux primary, Windows extraction node, GitHub sync. | 2026-06-25 |
| BLK-001 | GAIL OS spine not exposed as HTTP API | Phase 1 complete. FastAPI HTTP layer live. CP-1 4/4 passed. Freedom bridge live. | 2026-06-28 |
| BLK-002 | Graphify HTTP API not externally callable | Graphify Phase 2 complete. 6 HTTP endpoints on port 8001, all SLAs verified (0.2ms p50 on 12,687 entities). | 2026-06-27 |
| BLK-003 | `@gail/contracts` shared types package missing | Phase 1 Chunk 22 implemented JSON Schema contracts. TypeScript wire types merged to Freedom PR #33. | 2026-06-28 |
| BLK-005 | M365 app registration not confirmed | App `9aeeeae6` created. Full Entra scope expansion complete. Read-only proof passed. | 2026-06-28 |

---

## Risk Review Cadence

Review this file at the start of every new phase and after any major integration event. Update probabilities based on evidence, not assumption.
