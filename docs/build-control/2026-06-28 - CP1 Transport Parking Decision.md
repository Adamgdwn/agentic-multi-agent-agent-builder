# CP-1 Transport Parking Decision

**Date:** 2026-06-28
**Owner:** Build Agent Orchestrator (agentic-multi-agent-agent-builder)
**Decision Type:** Architectural — locked for CP-1 and Chunk 20 scope
**Status:** Confirmed. Operationalized in Chunk 20 execution.

---

## Decision

**Park HTTP transport uncertainty at the service/contract seam.**

Business logic and authority state machines in GAIL OS must not depend on HTTP as a transport. HTTP is one future transport wrapper. The service functions and JSON Schema contracts are the stable surface — transport wraps them later.

---

## Rationale

### The Problem Being Avoided

If GAIL OS authority logic is written to assume HTTP (FastAPI routes, request/response objects, HTTP status codes), then:

1. The authority logic cannot be tested without running an HTTP server
2. Future transport changes (WebSocket, gRPC, direct function call) require rewriting authority logic
3. Freedom and other consumers cannot use the contracts until the HTTP layer exists
4. Testing authority rules requires integration test overhead before unit correctness is established

### The Pattern

```
GAIL OS authority logic
    ↓
transport-independent service functions
    (pure Python, no HTTP dependency, fully unit-testable)
    ↓
canonical JSON Schema contracts
    (owned by GAIL OS, versioned, stable surface)
    ↓
future FastAPI wrapper
    (Chunk 21 — thin HTTP adapter over service functions)
    ↓
future Freedom HTTP transport
    (Chunk 23 — consumes FastAPI, uses @gail/contracts TypeScript types)
```

### Why This Order Matters

- Service functions can be tested now (Chunk 20B) without FastAPI existing
- JSON Schema contracts can be exported now (Chunk 20C) without Freedom existing
- Freedom can consume contracts as typed stubs now (Chunk 20F) without HTTP being live
- When FastAPI arrives (Chunk 21), it wraps existing service functions — it does not replace them
- CP-1 validation proves the full cycle before the transport is load-bearing

---

## What Is Parked

The following are explicitly NOT part of Chunk 20 scope:

| Parked Item | When It Arrives | Who Owns It |
|---|---|---|
| FastAPI routes for approval actions | Chunk 21 | GAIL OS |
| HTTP status codes / error models | Chunk 21 | GAIL OS |
| `@gail/contracts` TypeScript package (npm) | Chunk 22 | GAIL OS (source), consumers (generated types) |
| Freedom → GAIL OS HTTP bridge | Chunk 23 | Freedom |
| Live connector execution over HTTP | Post-CP-1 | GAIL OS Connector registry |
| Cloud deployment of GAIL OS API | Post-CP-1 | Infrastructure (20H placement register) |

---

## What Is NOT Parked

The following are built in Chunk 20 and must be stable before HTTP arrives:

| Item | Chunk | Validation |
|---|---|---|
| `approval_actions.py` — transport-independent approval service functions | 20B | pytest on Python (cross-platform) |
| `test_approval_actions.py` — full unit coverage without HTTP | 20B | pytest green, CI green |
| `contracts/json-schema/` — 8 CP-1 JSON Schema files | 20C | jsonschema validation against synthetic records |
| `scripts/export-cp1-contracts.py` — export script | 20C | Script runs cleanly, schemas validate |
| Freedom contract adapter / TypeScript type stubs | 20F | npm typecheck passes |
| Graphify connectome contract docs | 20D | Doc review, no new write path |
| GAIL graph-fact extraction lane spec | 20E | Schema validates, extraction-write rule preserved |

---

## Enforcement Rules

These rules apply to all agents working on GAIL OS during Chunk 20:

1. **No FastAPI import in `approval_actions.py`** — service functions only
2. **No HTTP request/response objects in service function signatures** — use plain Python types
3. **No hardcoded localhost URLs** — any reference to a service endpoint goes in config or contracts, not in business logic
4. **JSON Schema contracts are GAIL OS canonical source** — Freedom does not author schemas; Freedom consumes generated types
5. **`@gail/contracts` is a TypeScript generated types package** — it does not contain Python types; it does not bridge back

---

## Relationship to CP-1

CP-1 (Checkpoint 1) is the first full cognitive cycle:

```
Freedom observes signal
    → Freedom queries Graphify (LIVE — BLK-002 closed)
    → Freedom proposes mission to GAIL OS (HTTP — Chunk 23, not yet)
    → GAIL OS validates authority envelope
    → GAIL OS issues PolicyDecision
    → Freedom receives decision
    → EvidencePacket written to local store
```

The transport parking decision ensures that by the time Chunk 23 wires the HTTP bridge:
- The authority logic is already tested and stable
- The contracts are already published (JSON Schema) and typed (generated TypeScript)
- CP-1 validation is a thin integration test, not a first-time correctness proof

---

## Decision Owner

This decision was locked in the Chunk 20 CNS Orchestration Amendment (2026-06-28). It is not subject to agent override. If a chunk author wants to deviate from the transport-independent pattern, they must flag it as an `[ADAM DECISION REQUIRED]` item in the run ledger before writing code.
