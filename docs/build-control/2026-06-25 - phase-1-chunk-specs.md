# Phase 1 Chunk Specs — GAIL OS Spine → HTTP API

**Last Updated:** 2026-06-27
**Owner:** Build Agent Orchestrator
**Phase gate:** CP-1 — GAIL OS HTTP API live, tested, callable by Freedom and Graphify

---

## Architecture Context (read before starting any chunk)

GAIL OS Rev 2 is **Python** (not TypeScript). The spine is complete through Chunks 1–19:
- Mission spine, connector registry, relay envelope, relay store, graphify handoff, local proof runner — all in `packages/uaos-core/src/gail_ai_operating_system/`
- Current boundary: A1 local no-network (dry-run only, no external calls)
- Command center UI: React TypeScript Vite app in `apps/command-center/`

Freedom is **TypeScript** (Next.js 16). It cannot import Python modules directly.

**Phase 1 objective:** Bridge the A1 local boundary → expose GAIL OS as an HTTP API, define JSON Schema contracts so TypeScript consumers (Freedom, Graphify clients) have typed interfaces.

**`@gail/contracts` is a JSON Schema + generated TypeScript types package** (not Python types in GAIL OS). It lives in `the-freedom-engine-os` or as a standalone package consumed by Freedom.

---

## Per-Chunk Testing Standard

Every Phase 1 code chunk must follow this rule: **no code PR without its test file**.

1. **Test file in the same PR** — every code chunk ships with `tests/test_<module>.py` in the same commit. Writing tests is not a follow-up task.
2. **CI green before merge** — once task 1.0 (GitHub Actions CI) is merged, all subsequent code PRs must show a passing CI run before Adam merges. A PR with failing CI is not review-ready.
3. **Test coverage minimum** — happy path, at least one failure path, and each acceptance criterion that can be tested programmatically.
4. **"All tests pass (`pytest tests/`)"** is a required acceptance criterion for every code chunk.
5. **If CI is not yet in place** (task 1.0 not yet merged) — note in the PR body that tests were not run in CI, and list the command Adam should run locally to validate. This is a temporary exception only.

When the loop opens a code PR and CI fails on something fixable (lint, import order, syntax error) — fix it and repush. When CI fails on a substantive issue (logic error, missing dependency, wrong schema) and three fix attempts don't resolve it — mark the task `blocked` and surface it to Adam per the retry policy in `docs/loop-protocol.md`.

---

## Phase 1 Chunk Map

### Chunk 20 (GAIL OS — Windows) — Local Governed Approval Writes

**Status:** Ready to start (Chunk 20 in GAIL OS `docs/current-build-pathway.md`)
**Budget class:** Medium
**Objective:** Add the first local approval-write actions — mission records that produce auditable local JSON evidence files. Extend the proof runner so a full mission → approval → evidence cycle writes a reviewable artifact.

**Acceptance criteria:**
- [ ] A mission can move from `proposed` → `approved` via local approval action
- [ ] Approval writes a local `EvidencePacket` JSON file with: mission_id, actor, action_type, authority_basis, result, rollback_note, created_at
- [ ] PermissionGate validates approval against current connector registry and authority boundary
- [ ] Evidence files are reference-only (no raw content, no secrets)
- [ ] Tests cover approval path, rejection path, evidence shape, and sensitive-payload rejection
- [ ] No live connector, hosted relay, external call, or UI mutation

**Output files:**
- `packages/uaos-core/src/gail_ai_operating_system/evidence_writer.py`
- `tests/test_evidence_writer.py`
- Updated `local_proof_runner.py` (approval → evidence path)
- Updated `tests/test_local_proof_runner.py`

**Validation:** `python -m unittest discover -s tests`, governance preflight, secret scan, diff check, commit, push

**Stop condition:** Stop before adding HTTP server, external connections, or live M365 work.

---

### Chunk 21 (GAIL OS — Windows) — FastAPI HTTP API Layer

**Status:** Blocked on Chunk 20
**Budget class:** Medium
**Objective:** Wrap the existing Python spine with a FastAPI HTTP layer so Freedom (Linux) and Graphify can call GAIL OS remotely. Minimum viable surface: mission create, action validate, evidence retrieve.

**Acceptance criteria:**
- [ ] `apps/gail-os-api/` FastAPI app exists with router structure
- [ ] `POST /api/v1/missions` — creates and validates a mission envelope, returns mission_id
- [ ] `POST /api/v1/actions` — validates a proposed action against policy gate, returns PolicyDecision
- [ ] `GET /api/v1/evidence/{mission_id}` — returns evidence packet refs for a mission
- [ ] `GET /api/v1/connectors` — returns connector registry status (planning-only profiles)
- [ ] `GET /api/v1/health` — liveness check
- [ ] All endpoints return JSON; no HTML rendering
- [ ] Auth: API key in header (single static key from env, not hardcoded) — Phase 1 only
- [ ] No live M365, no hosted deployment, runs locally on Windows (uvicorn dev server)
- [ ] Tests: integration tests for each endpoint using TestClient, covering happy path + validation failures

**Output files:**
- `apps/gail-os-api/main.py`
- `apps/gail-os-api/routers/missions.py`, `actions.py`, `evidence.py`, `connectors.py`
- `apps/gail-os-api/requirements.txt`
- `tests/test_api_*.py`

**API key handling:** Read from env var `GAIL_OS_API_KEY`. Never hardcode. Never commit. Document in README only as `GAIL_OS_API_KEY=<your-key>`.

**Validation:** `pytest tests/test_api_*.py`, governance preflight, secret scan (confirm no key values in files), diff check, commit, push

**Stop condition:** Stop before connecting to live M365, external databases, or Supabase. Local JSON store only in Phase 1.

---

### Chunk 22 (Control Repo — Linux) — @gail/contracts JSON Schema

**Status:** Blocked on Chunk 21 (need stable API shape before writing contracts)
**Budget class:** Small
**Objective:** Define the canonical cross-language schema for GAIL OS objects as JSON Schema files, then generate TypeScript types from them. This resolves BLK-003 in a language-agnostic way that fits both the Python OS and the TypeScript Freedom consumer.

**Acceptance criteria:**
- [ ] `docs/contracts/` in this control repo (or in `the-freedom-engine-os/packages/contracts/`) contains JSON Schema files for: `Mission`, `Action`, `AuthorityEnvelope`, `EvidencePacket`, `SourceRef`, `Signal`
- [ ] Each schema has: `$schema`, `$id`, `type`, `properties`, `required`, and an `examples` array
- [ ] TypeScript types generated via `json-schema-to-typescript` (or equivalent) into `packages/contracts/src/`
- [ ] R-level and A-level enums defined as TypeScript const enums in the generated package
- [ ] Package is installable as `@gail/contracts` in Freedom's `package.json`
- [ ] No runtime code in contracts — types only

**Output location:** `the-freedom-engine-os/packages/contracts/` (consumes the JSON Schema from this control repo)

**Validation:** `tsc --noEmit` in contracts package, schema lint, `npm pack` dry-run, diff check

**Stop condition:** Stop before connecting contracts to live Freedom runtime or calling GAIL OS API from Freedom.

---

### Chunk 23 (Freedom — Linux) — Freedom → GAIL OS API Bridge

**Status:** Blocked on Chunks 21 + 22
**Budget class:** Medium
**Objective:** Add the first real cross-machine call from Freedom to GAIL OS. Freedom proposes a mission; GAIL OS validates it; Freedom receives a policy decision. This is the first live cross-layer integration.

**Acceptance criteria:**
- [ ] `packages/gail-os-client/` in Freedom — typed HTTP client using `@gail/contracts`
- [ ] `createMission(command, domain)` → calls `POST /api/v1/missions` on GAIL OS
- [ ] `validateAction(action)` → calls `POST /api/v1/actions`
- [ ] Client reads GAIL OS endpoint from env var `GAIL_OS_API_URL` (never hardcoded)
- [ ] Integration test using a local GAIL OS dev server (documents how to run both)
- [ ] Freedom UI: one status indicator showing GAIL OS connection state (connected / unreachable / policy-blocked)
- [ ] No live M365, no production deploy

**Validation:** TypeScript compile, integration test, UI smoke test, secret scan, diff check, commit, push

**Stop condition:** CP-1 gate — stop here and declare Phase 1 complete. Phase 2 (Graphify HTTP API) begins after CP-1 review.

---

## CP-1 Gate Acceptance

Phase 1 is complete when ALL of the following are true:

1. GAIL OS FastAPI server starts locally on Windows and accepts requests
2. Freedom can call `POST /api/v1/missions` and receive a validated mission_id
3. Freedom can call `POST /api/v1/actions` and receive a PolicyDecision
4. `@gail/contracts` TypeScript types compile clean with no errors
5. A full proof: Freedom proposes → GAIL OS validates → evidence packet created → Freedom receives decision
6. All tests pass (Python + TypeScript)
7. No secrets committed, no live connectors activated, no production deployment

After CP-1, Phase 2 begins: Graphify HTTP API + CNS schema extensions.

---

## Phase 1 Risk Notes

| Risk | Mitigation |
|---|---|
| GAIL OS Python API and Freedom TypeScript types drift | JSON Schema is the canonical source; both sides are generated from it |
| Windows dev server not reachable from Linux Freedom | Use `GAIL_OS_API_URL` pointing to Windows local IP or localhost (via SSH tunnel for dev) |
| API key management across machines | Use `.env.master` wrapper for dev; document clearly; never commit values |
| Chunk 20 scope creep into approval UI | Chunk 20 is backend only — no UI mutations until Chunk 21+ |
| FastAPI version conflicts with uaos-core package | Use a separate `requirements.txt` in `apps/gail-os-api/`; do not mix into uaos-core |
