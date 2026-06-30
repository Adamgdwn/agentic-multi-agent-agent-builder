# 2026-06-28 — Deep Integration Test Pass — Session Summary

**Session type:** Deep integration test + seam validation
**Date:** 2026-06-28
**Status:** Integration complete

---

## What Was Done

### Bugs Found and Fixed

1. **Graphify `cns_api/app.py`**: Missing `init_db()` at startup. Fresh SQLite DB caused every
   read route to crash with HTTP 500 (`no such table: relationships`). Fixed with
   `asynccontextmanager` lifespan hook.

2. **Graphify `cns_api/routes/health.py`**: Freedom's Graphify client probes `/api/cns/health`
   to detect server liveness. Route didn't exist — only `/health`. Phase 3.2 integration tests
   were silently skipping rather than running. Fixed by adding route alias.

3. **Graphify `tests/test_operating_knowledge_api.py`**: Test asserted `proof_chain_version ==
   "stub-l2"` but code returned `"v1-l2"` since CP-5. Pre-existing stale assertion. Fixed.

All three committed to `graphify-workspace-cockpit` (commit `9656f1e`).

### Python Dependencies Fixed (Linux)

`fastapi`, `msal`, `slowapi`, `python-multipart` were missing from Linux pyenv. Installed.
Result: GAIL OS went from 435 to 557 passing tests; Graphify went from 0 to 300.

### Windows GAIL OS Server

Server was running old build (5/15 routes). After Windows agent rebased onto `main` and
restarted uvicorn, server now serves 13 routes including m365, authority, agents, and OKP.

### Linux M365 CLI Authentication

New Entra app registration created: `Guided AI Labs - CLI for Microsoft 365 Local Agent`
(appId `9aeeeae6-be2a-476c-9c34-389dbc927c99`, tenantId `1ca92af5-21ff-42e3-87ae-3bde9c2cc501`).
Delegated permissions: `User.Read`, `Flows.Read.All`, `User`, `user_impersonation`.
Auth type: deviceCode. Token local to Linux, never committed.

---

## Test Results

| Suite | Count | Result |
|---|---|---|
| GAIL OS Python full suite (Linux) | 557/557 | PASS |
| Graphify Python full suite (Linux) | 300/300 | PASS |
| Freedom TypeScript unit tests | 255/255 | PASS |
| GAIL OS Python suite (Windows — scoped) | 251 pass | PASS |

### Integration Gate Results

| Gate | Tests | Result |
|---|---|---|
| CP-1 Freedom → GAIL OS (Windows at 10.77.77.1:8123) | 4/4 | PASS |
| Phase 3.2 Freedom → Graphify (localhost:8001) | 4/4 | PASS |
| CTP-2 m365/status (Windows) | probe | PASS |
| CTP-2 m365/observe dry-run (Windows) | probe | PASS |
| CTP-2 authority/override (Windows) | probe | PASS |
| CTP-2 agents registry (Windows) | probe | PASS |
| Linux M365 CLI Power Automate flow list | list | PASS |

---

## CTP-2 Key Probe Results

### m365/status
Correctly reports `configured: false` — Azure Graph credentials not set (expected, A1 local).

### m365/observe dry-run
Returns EvidencePacket with `execution_mode: "dry-run"`, `result: "stopped"`,
`authority_basis: "R0_OBSERVE — m365-graph-api-bridge — not configured"`.
No live M365 call made. Boundary enforced.

### authority/override
Records pending override request with UUID. Returns `status: "pending"`.
Correct escalation pathway.

### agents registry
6 agents registered: freedom-executive, freedom-gateway, freedom-desktop,
freedom-mobile, gail-os-policy, graphify-cockpit. Authority levels consistent.

---

## Boundaries Maintained Throughout

- No live Microsoft Graph call.
- No SharePoint, CRM, Teams, email, SMS, or client write.
- No R4 live execution.
- No Entra permission expansion beyond delegated flows/graph/ARM for CLI.
- All probes: dry-run or read-only.
- A1 local no-network boundary.
- GAIL_OS_API_KEY = env var only, never hardcoded, never committed.

---

## Remaining

- **2026-06-29 update**: This session summary is historical. Current restart point is `docs/build-control/handoff-state.md`.
- **Phase 7 scope**: Determined and mostly executed. H1-H5 + H5-apply complete; H6 remains queued-secondary.
- **SharePoint/CRM write gate**: Requires separate Entra expansion + Adam approval.
- **BLK-004**: Windows Enhanced Graphify extraction of GAIL OS Rev 2 + M365 Foundation still pending.
- **Supabase RLS**: Closed by H5/H5-apply. Hosted apply covered 21 target tables on 2026-06-28.
