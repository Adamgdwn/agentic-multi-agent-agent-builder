# Promotion Gates

**Date:** 2026-06-28
**Chunk:** 20H — Infrastructure Placement Register and Promotion Gates
**Status:** Gates documented — no gates currently open
**Authority:** This document is maintained in `agentic-multi-agent-agent-builder` (control repo). Gates must be verified here before any infrastructure promotion proceeds.

---

## Purpose

A promotion gate is a verified condition that must be satisfied before a service advances from development placement to production placement. Gates are cumulative — a service cannot skip gates.

This document defines the gate sequence for each CNS repo. Gates are ordered: later gates cannot open before earlier gates close.

---

## GAIL OS Promotion Gates

**Current placement:** Windows dev machine, transport-parked, A1 local no-network.  
**Target placement:** Cloud-hosted FastAPI service, persistent store, live connector registry.

| Gate | ID | Condition | Status | Depends On |
|---|---|---|---|---|
| **G1-GAIL** | Schema contracts stable | 9 JSON Schema contracts in `contracts/json-schema/` validated and passing 43+ contract tests | **OPEN** | — (20C complete) |
| **G2-GAIL** | HTTP API layer | `fastapi` app wrapping GAIL OS service functions; all CP-1 routes implemented and tested | BLOCKED | Chunk 21 |
| **G3-GAIL** | Transport validation | Freedom can call GAIL OS HTTP API end-to-end (CP-1 gate) | BLOCKED | G2-GAIL + Chunk 23 |
| **G4-GAIL** | Persistent store | Mission/action/evidence records persisted to cloud-accessible store, not local JSON files | BLOCKED | Cloud deployment decision + G2-GAIL |
| **G5-GAIL** | Connector registry live | `ConnectorProfile` records registered for all four CNS participants; policy gate validates live | BLOCKED | G4-GAIL + BLK-005 resolved |
| **G6-GAIL** | Production ready | CI green, secrets in cloud manager, rollback path documented, Adam final approval | BLOCKED | All above |

**Next action:** Chunk 21 (FastAPI HTTP wrapper) opens G2-GAIL.

---

## Graphify Promotion Gates

**Current placement:** Linux local, SQLite store, Docker Compose, port 8001 live.  
**Target placement:** Cloud-hosted CNS API service, accessible to all platforms and cloud workers.

| Gate | ID | Condition | Status | Depends On |
|---|---|---|---|---|
| **G1-GPHY** | Phase 2 implementation complete | 6 endpoints live, speed SLAs verified, extraction pipeline writes to store | **OPEN** | — (Phase 2 complete 2026-06-27) |
| **G2-GPHY** | CNS contracts normalized | Connectome contract and endpoint family map documented; graph-context-ref and source-ref schemas in GAIL OS | **OPEN** | — (20D + 20C complete) |
| **G3-GPHY** | Graph-fact extraction lane | GAIL OS `graph-fact.schema.json` defined; Graphify import boundary documented | BLOCKED | 20E (graph-fact extraction lane) |
| **G4-GPHY** | Cloud deployment | CNS API containerized and deployed to cloud endpoint; environment variables configured | BLOCKED | Cloud deployment decision (not yet scoped) |
| **G5-GPHY** | Multi-platform access | Windows Enhanced Graphify extraction confirmed writing to same store schema | BLOCKED | G4-GPHY + BLK-004 resolution |
| **G6-GPHY** | Production ready | CI green, cloud store migration complete, rollback path documented, Adam final approval | BLOCKED | All above |

**Next action:** 20E (graph-fact extraction lane) opens G3-GPHY.

---

## Freedom Promotion Gates

**Current placement:** Linux, TypeScript, no live HTTP connections, no persistent state.  
**Target placement:** Live cognitive layer calling GAIL OS HTTP API and Graphify CNS API.

| Gate | ID | Condition | Status | Depends On |
|---|---|---|---|---|
| **G1-FREE** | CP-1 contract adapter | TypeScript adapter consuming GAIL OS JSON Schema contracts; typecheck passes | BLOCKED | 20F (this chunk) |
| **G2-FREE** | GAIL OS live coupling | Freedom can call GAIL OS HTTP API; mission proposals submitted and governed | BLOCKED | G2-GAIL (Chunk 21) + Chunk 23 |
| **G3-FREE** | Graphify live coupling | Freedom calls Graphify CNS API for entity context, mission history, domain mapping | BLOCKED | G4-GPHY |
| **G4-FREE** | Full cognitive cycle | Observe → Relate (Graphify) → Reason (Freedom) → Govern (GAIL OS) → Act cycle runs end-to-end | BLOCKED | G2-FREE + G3-FREE |
| **G5-FREE** | Production ready | CI green, no hardcoded URLs, auth keys in secrets manager, Adam final approval | BLOCKED | All above |

**Next action:** 20F (Freedom TypeScript contract adapter) opens G1-FREE.

---

## M365 Promotion Gates

**Current placement:** Human-only writes, A1 boundary enforced.  
**Target placement:** GAIL OS Connector executing approved writes, returning evidence packets.

| Gate | ID | Condition | Status | Depends On |
|---|---|---|---|---|
| **G1-M365** | BLK-005 resolved | Entra app registration confirmed; consent grants verified | **BLOCKED** | Adam confirms in Entra admin |
| **G2-M365** | GAIL OS Connector registry live | G5-GAIL open; ConnectorProfile records for M365 surfaces registered | BLOCKED | G5-GAIL |
| **G3-M365** | Connector dry-run validated | GAIL OS issues dry-run authority envelope for M365 write; evidence packet returned and verified | BLOCKED | G1-M365 + G2-M365 |
| **G4-M365** | Live write validated | First live M365 write via Connector; evidence packet verified; one-writer rule confirmed by integration test | BLOCKED | G3-M365 + Adam explicit Phase 4 authorization |
| **G5-M365** | Production ready | All surfaces covered by ConnectorProfiles; audit trail continuous; rollback tested; Adam final approval | BLOCKED | All above |

**Critical:** G1-M365 is a human-only gate. No agent can resolve BLK-005.

---

## Cross-Repo CP-1 Gate Summary

CP-1 is the first full cognitive cycle requiring GAIL OS to be callable over HTTP.

| CP-1 Requirement | Gate | Status |
|---|---|---|
| GAIL OS JSON Schema contracts | G1-GAIL | **OPEN** |
| GAIL OS HTTP API (FastAPI) | G2-GAIL | BLOCKED — Chunk 21 |
| Freedom → GAIL OS HTTP calls | G2-FREE | BLOCKED — Chunk 21 + 23 |
| `@gail/contracts` TypeScript types | (Chunk 22) | BLOCKED — Chunk 21 |

CP-1 does NOT require:
- Graphify Phase 2 (already open — G1-GPHY, G2-GPHY)
- M365 bridge (Phase 4)
- Cloud deployment

---

## Stop Condition (Confirmed)

This document records gate conditions only. It does not:
- Deploy any service
- Provision any infrastructure
- Move any persistence layer
- Add any secrets or credentials
- Configure DNS, Vercel, Supabase, or any cloud provider

All infrastructure provisioning requires explicit authorization from Adam and a named gate being open.

---

*Gates documented. No gates provisioned. CP-1 next gate: Chunk 21 (GAIL OS FastAPI). Phase 4 next gate: BLK-005 resolution by Adam.*
