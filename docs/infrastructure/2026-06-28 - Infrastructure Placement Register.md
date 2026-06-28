# Infrastructure Placement Register

**Date:** 2026-06-28
**Chunk:** 20H — Infrastructure Placement Register and Promotion Gates
**Status:** Register complete
**Cross-repo authority:** This document is maintained in `agentic-multi-agent-agent-builder` (control repo). Each repo's AGENTS.md points here for infrastructure placement decisions.

---

## Purpose

This register distinguishes current development placement from target product placement for all four CNS repos. It records runtime owners, data owners, and what must change to promote from development to production.

**Platform vs. product distinction:** Where a service runs today (Windows/Linux laptop, scratchpad clone) is development placement — a practical constraint of the current build phase. Where a service runs in target architecture is product placement — what must be provisioned before Phase 4 ships. These are not the same thing, and treating development placement as architecture is a common source of hidden assumptions.

---

## Placement Table

### GAIL OS (`gail-ai-operating-system-rev-2`)

| Dimension | Current (Development) | Target (Product) |
|---|---|---|
| **Platform** | Windows (primary dev machine) | Linux container or cloud worker |
| **Runtime owner** | Adam Goodwin (manual) | Automated deployment pipeline |
| **Data owner** | GAIL OS package (`uaos-core`) | Same — GAIL OS is always data owner |
| **Persistence** | Local JSON files (mission records, approval decisions, evidence packets) | Cloud-accessible store (TBD — Supabase, Turso, or equivalent) |
| **API exposure** | None (transport-parked at service/contract seam) | FastAPI HTTP wrapper (Chunk 21) |
| **Code access mode** | Windows native git; Linux access via `gh api` or scratchpad clone | Containerized, env-var configured, platform-agnostic |
| **Test execution** | Linux clone + pytest (cross-platform Python) | CI pipeline on every PR |
| **Secret handling** | `.env.master` on local machine, never committed | Cloud secrets manager (not yet provisioned) |

**Promotion gate:** Chunk 21 (FastAPI HTTP API) + cloud deployment decision (not yet scoped).

---

### Graphify (`graphify-workspace-cockpit`)

| Dimension | Current (Development) | Target (Product) |
|---|---|---|
| **Platform** | Linux (primary cockpit); Windows Enhanced Graphify = extraction node | Cloud-first — HTTP API served from container on any platform |
| **Runtime owner** | Adam Goodwin (manual start) | Docker Compose or cloud runner |
| **Data owner** | Graphify CNS store (SQLite, `cns.db`) | Same — Graphify is always data owner for graph store |
| **Persistence** | Local SQLite file at `CNS_STORE_PATH` | Mounted volume (Phase 2) → Turso or PostgreSQL (Phase 3+) |
| **API exposure** | FastAPI HTTP, port 8001, containerized (Phase 2 live) | Shared cloud endpoint — same API, cloud-hosted |
| **Extraction** | On-demand (CLI) + scheduled; writes to SQLite | Same pattern — any extraction node writes to the store |
| **Code access mode** | Direct Linux git | Same |
| **Test execution** | Local pytest (Linux) | CI pipeline on every PR |

**Promotion gate:** Cloud deployment decision for CNS API service (not yet scoped). Phase 2 local deployment is complete — cloud promotion follows.

---

### Freedom (`the-freedom-engine-os`)

| Dimension | Current (Development) | Target (Product) |
|---|---|---|
| **Platform** | Linux | Linux container or cloud worker |
| **Runtime owner** | Adam Goodwin (manual) | Automated deployment pipeline |
| **Data owner** | Freedom owns no persistent data (it reasons; GAIL OS persists) | Same |
| **Persistence** | None (stateless cognitive layer) | None at this phase |
| **API exposure** | None (operator-facing layer, not a service) | TBD — Chunk 23 (Freedom ↔ GAIL OS bridge) |
| **Code access mode** | Direct Linux git | Same |
| **Test execution** | npm / TypeScript typecheck (Linux) | CI pipeline on every PR |
| **GAIL OS coupling** | Transport-parked — consumes CP-1 JSON schemas; no live HTTP calls yet | HTTP calls to GAIL OS (Chunk 21+) |

**Promotion gate:** Chunk 21 (GAIL OS HTTP API live) + Chunk 23 (Freedom bridge). TypeScript contract adapter (Chunk 20F) unlocks typed development without live HTTP.

---

### M365 Foundation (`ag-operations-m365-foundation`)

| Dimension | Current (Development) | Target (Product) |
|---|---|---|
| **Platform** | Windows (primary) | Windows or cloud agent — M365 SDK requires tenant access |
| **Runtime owner** | Adam Goodwin (human, all writes manual) | GAIL OS M365 Connector (Phase 4) |
| **Data owner** | Adam Goodwin / business operations | Same — M365 tenant data stays in M365 |
| **Persistence** | SharePoint Lists, Planner, Teams (tenant-managed) | Same |
| **API exposure** | Microsoft Graph API (via registered app) | Same — connector wraps Graph API |
| **Code access mode** | Windows native git; agent access via `mcp__github__push_files` (docs only) | Same for docs; connector code via GAIL OS |
| **Write boundary** | Human only (A1 — no agent writes) | GAIL OS Connector registry (Phase 4) |
| **App registration** | BLK-005 — unconfirmed | Confirmed Entra app registration required before Phase 4 |

**Promotion gate:** BLK-005 resolved + GAIL OS Connector registry operational + Phase 4 explicit authorization.

---

## One-Writer Rule Summary

| Write Surface | Designated Writer | Current Status |
|---|---|---|
| GAIL OS mission/action records | GAIL OS `uaos-core` package | Active at A1 (local JSON) |
| GAIL OS approval decisions | GAIL OS `approval_actions.py` + `ApprovalStore` | Active at A1 |
| GAIL OS evidence packets | GAIL OS evidence module | Active at A1 |
| Graphify CNS store (entities + relationships) | Graphify extraction pipeline only | Active (no API write path) |
| Freedom cognitive state | Freedom reasoning module | No persistence yet — stateless |
| M365 SharePoint Lists | Adam Goodwin (human) → GAIL OS Connector (Phase 4) | Human-only at A1 |
| M365 Planner / Teams | Adam Goodwin (human) → GAIL OS Connector (Phase 4) | Human-only at A1 |

No dual-writer conflicts identified. No unregistered write paths.

---

## Current Blockers

| Blocker | Status | Impact |
|---|---|---|
| BLK-005 — M365 Entra app registration | UNKNOWN/BLOCKED | Phase 4 production bridge blocked |
| GAIL OS HTTP API — Chunk 21 | NOT STARTED | CP-1 gate blocked; Freedom ↔ GAIL OS live coupling blocked |
| Cloud deployment decision | NOT SCOPED | GAIL OS and Graphify remain laptop-local until scoped |

---

*Register status: Task complete. Four repos placed. One-writer rule confirmed clean. No infrastructure provisioned. See Promotion Gates doc for advancement criteria.*
