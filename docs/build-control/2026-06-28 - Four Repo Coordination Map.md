# Four Repo CNS Coordination Map

**Date:** 2026-06-28
**Owner:** Build Agent Orchestrator (agentic-multi-agent-agent-builder)
**Source:** Chunk 20 CNS Orchestration Amendment
**Status:** historical — Chunk 20 and Phases 0–6 are complete. Use `docs/build-control/handoff-state.md` and the 2026-06-29 forward refactor for current routing.

---

## CNS Role Assignments

| Repo | CNS Role | Platform | Access Mode | Current State |
|---|---|---|---|---|
| `gail-ai-operating-system-rev-2` | Authority, evidence, policy, action state, connector registry, **Architecture Governor** | Windows | GitHub MCP (code + docs) | Phase 1 complete — 59 tests, CI green, 7 PRs merged |
| `graphify-workspace-cockpit` | Connectome, relationship intelligence, context graph, dependency map, **information-transfer layer** | Linux | Direct git | Phase 2 complete — 6 HTTP endpoints on port 8001, 0.2ms p50 on 12,687 entities |
| `the-freedom-engine-os` | Executive cognition, operator-facing business partner | Linux | Direct git | Phase 0 complete — CNS role in AGENTS.md, no code started (correctly blocked) |
| `ag-operations-m365-foundation` | Enterprise body, M365 I/O surface — first-class participant | Windows | GitHub MCP (docs only, no live writes) | Docs-only state — BLK-005 unconfirmed |

---

## Architecture Identity Rules

These are working rules, not aspirational. Every chunk must check against them.

| Layer | Identity Statement |
|---|---|
| **Freedom** | Executive cognition — observes signals, proposes missions, does not act directly. Operator-facing business partner. |
| **GAIL OS** | Architecture governor — authority, evidence, policy, action-state machine, connector registry, controlled execution spine. Owns all canonical contracts. |
| **Graphify** | Connectome — relationship intelligence, context graph, dependency map, information-transfer layer. Core CNS infrastructure. NOT a side utility or visualization accessory. |
| **M365** | Enterprise body — where real-world inputs arrive and outputs land. First-class participant. No live execution without OS Connector registry, authority envelope, and evidence packet. |

---

## Inter-Repo Dependency Map

```
                    ┌─────────────────────────────────────┐
                    │         GAIL OS (Authority)          │
                    │  - Architecture Governor             │
                    │  - Action state machine (12 stages)  │
                    │  - Authority ladder (R0–R5, A0–A6)   │
                    │  - Connector registry                 │
                    │  - Evidence packets                   │
                    │  - Canonical JSON Schema contracts    │
                    └──────────────┬──────────────────────┘
                                   │ CP-1 contracts (20C)
                    ┌──────────────▼──────────────────────┐
                    │         Freedom (Executive)          │
                    │  - Observes signals                  │
                    │  - Proposes missions                 │
                    │  - Consumes GAIL contracts (read)    │
                    │  - Does NOT self-approve             │
                    └──────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │       Graphify (Connectome)          │
                    │  - Read-only HTTP API (port 8001)    │
                    │  - Extraction pipeline writes        │
                    │  - Receives graph facts from GAIL    │
                    │  - Queried by Freedom + GAIL OS      │
                    └──────────────────────────────────────┘

                    ┌─────────────────────────────────────┐
                    │       M365 (Enterprise Body)         │
                    │  - All writes via GAIL OS Connector  │
                    │  - Source: email, Teams, SharePoint  │
                    │  - Sink: send, create, update, share │
                    │  - BLK-005: app reg unconfirmed      │
                    └──────────────────────────────────────┘
```

---

## Communication Patterns

| From | To | Pattern | Status |
|---|---|---|---|
| Freedom → GAIL OS | Propose mission, receive PolicyDecision | HTTP (Chunk 21+) or CP-1 JSON contract stub | Blocked on Chunk 21 (FastAPI) |
| Freedom → Graphify | Query entity context, domain map, recent mission context | HTTP GET to port 8001 | **LIVE** — BLK-002 closed |
| GAIL OS → Graphify | Emit sanitized graph facts via extraction lane | Extraction write path (not HTTP API) | Spec in 20E |
| Graphify → GAIL OS | Connector scope validation, entity neighborhood, authority chain | HTTP GET to port 8001 | **LIVE** — BLK-002 closed |
| GAIL OS → M365 | Governed write actions via connector registry | OS Connector with authority envelope + evidence packet | Blocked on BLK-005 |
| M365 → GAIL OS | Inbound events (email, Teams, SharePoint) | Inbound connector (future) | Blocked on BLK-005 |

---

## CP-1 Gate Requirements

CP-1 = first full cognitive cycle. Required before production autonomy claims.

| Requirement | Chunk | Status |
|---|---|---|
| GAIL OS HTTP API live | 21 (FastAPI) | Not started |
| `@gail/contracts` TypeScript types | 22 | Not started — 20C creates JSON Schema source |
| Freedom → GAIL OS HTTP call | 23 (bridge) | Not started |
| Graphify HTTP API live | Phase 2 complete | **DONE** |
| GAIL OS local authority/evidence schema | Phase 1 complete | **DONE** |
| CP-1 JSON contracts exist (JSON Schema) | 20C | In progress (Chunk 20) |

CP-1 does NOT require M365 integration. CP-1 does NOT require Graphify Phase 2 (already done).

---

## One-Writer Rule — Write Surface Ownership

Every write surface must have exactly one designated writer.

| Write Surface | Owner | Permitted Writer(s) | Blocked On |
|---|---|---|---|
| Action state machine | GAIL OS | GAIL OS authority engine | — |
| Evidence packets | GAIL OS | GAIL OS evidence writer | — |
| Connector registry | GAIL OS | GAIL OS connector registry | — |
| JSON Schema contracts | GAIL OS | GAIL OS contract export | — |
| Graphify graph store | Graphify extraction pipeline | Extraction pipeline only | — |
| M365 (email, docs, calendar) | GAIL OS via Connector | M365 connector (GAIL-brokered) | BLK-005 |
| Freedom mission proposals | Freedom | Freedom executive layer | — |
| TypeScript contract types | Generated from GAIL OS JSON Schema | `@gail/contracts` generate script | — |

---

## Platform vs Product Architecture

**Development placement (current):**
- GAIL OS: Windows
- Freedom: Linux
- Graphify: Linux (primary), Windows (extraction node)
- M365: Windows

**Target product placement (future):**
- All services: containerized, env-var configured, cloud-deployable
- No hard-coded platform assumptions in code
- Windows/Linux split is development reality only

This distinction must survive every chunk. Do not let dev placement become product architecture.

---

## Active Blockers Summary (as of 2026-06-28)

| ID | Description | Resolved By |
|---|---|---|
| BLK-001 | GAIL OS not yet HTTP-exposed | Chunk 21 |
| BLK-003 | `@gail/contracts` TypeScript types don't exist | Chunk 22 (source: 20C JSON Schemas) |
| BLK-004 | Windows Graphify hasn't extracted GAIL OS + M365 repos | Phase 2.7 on Windows |
| BLK-005 | M365 app registration status unconfirmed | Adam to verify against `M365_STAGE_2_IDENTITY_FOUNDATION.md` |
| ~~BLK-002~~ | ~~Graphify not externally callable~~ | **CLOSED 2026-06-27** |
