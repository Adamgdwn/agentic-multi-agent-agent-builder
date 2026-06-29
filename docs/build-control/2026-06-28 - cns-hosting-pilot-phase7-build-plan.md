# CNS Hosting Pilot — Phase 7 Build Plan

**Date:** 2026-06-28
**Status:** Draft — awaiting Adam review before execution
**Owner:** Build Agent Orchestrator
**Directive source:** `2026-06-28 - CNS Hosting Pilot Planning and Execution Directive.md`
**Prior state:** Phases 0–6 complete. All seams proven clean (CTP-0/1/2). No open PRs.

---

## 0. Purpose

This document is the execution plan for Phase 7 — the internal Guided AI Labs CNS hosting pilot. It translates the Hosting Pilot Directive into per-repo chunk specs, acceptance criteria, open decisions, and approval gates. No cloud resources are created and no code changes are made until Adam reviews and approves this plan.

---

## 1. Locked Decisions (from Directive)

| Decision | Value |
|---|---|
| Primary region | Azure Canada Central |
| Budget guardrail | Under $300/month |
| GAIL OS + Graphify host | Azure Container Apps |
| Freedom host | Vercel (no change) |
| Supabase | Stays active — product/app data only |
| Model providers | OpenAI + Anthropic, behind a provider abstraction |
| Client target | Internal Guided AI Labs only |
| M365 live writes | Not part of first deployment; H6 gate only |
| No enterprise services | No AKS, API Management, Front Door, Sentinel |

---

## 2. Open Decisions — Adam Input Required Before H1 Execution

| # | Decision | Options | Impact |
|---|---|---|---|
| D1 | **Azure account** | (a) Use personal account `adamgdwn@hotmail.com` with $1,000 Microsoft credits — acceptable for internal pilot, subscription already active; (b) Use or create a business Azure account | Determines who owns the resource group and billing. Credits on personal account are a legitimate pilot path — no governance concern for internal-only use. |
| D2 | **Container registry** | (a) Azure Container Registry (integrates cleanly with ACA, no extra auth wiring); (b) GitHub Container Registry (already have GitHub, free for public, can restrict) | Affects GitHub Actions workflow and ACA pull auth. ACR is simpler for ACA + Key Vault integration. |
| D3 | **IaC tooling** | (a) Azure Bicep (native, no state file, easiest rollback); (b) az CLI scripts (least tooling overhead, simplest for pilot); (c) Terraform (most portable, most complex for small pilot) | H1 choice gates all deployment scaffolding. Recommendation: az CLI scripts for pilot speed, Bicep for repeatability. |
| D4 | **PostgreSQL timing** | (a) Deploy GAIL OS in H2 with JSON file store only — PostgreSQL migration is a separate post-H2 chunk; (b) Include PostgreSQL migration in H2 | Directive explicitly allows file store for H2 pilot start. Option (a) is faster and lower risk. |
| D5 | **Graphify store persistence** | SQLite on a mounted Azure Files share (simplest, single-writer safe) vs migrate to PostgreSQL later | H3 single-replica SQLite + Azure Files is the lowest-risk pilot path. |

---

## 3. Phase Sequence

```
H0 — Hosting Placement Register (docs only, no cloud)
H1 — Azure Foundation Scaffold (IaC/docs only, no resources yet)
       ↓ Adam approves Azure resource creation
H2 — Containerize and deploy GAIL OS API
H3 — Containerize and deploy Graphify CNS API   (can run parallel with H2)
H4 — Connect Freedom on Vercel to Azure core
H5 — Supabase RLS Remediation                   (can run earlier, parallel with H2/H3)
H6 — M365 Live Bridge Readiness                 (docs/prep only; live writes separate gate)
```

---

## 4. Per-Repo Work Breakdown

---

### 4.1 `agentic-multi-agent-agent-builder` — Build Control

**Phases:** H0, H1, ongoing ledger/reports

#### H0 — Hosting Placement Register

**New folder:** `docs/hosting/`

**File: `docs/hosting/2026-06-28 - CNS Hosting Pilot Strategy.md`**
- Summary of locked hosting decisions
- Architecture diagram (text): Vercel → Azure ACA → M365/Entra
- Budget allocation table
- Region confirmation (Canada Central)
- Account/subscription note
- Client scope: internal only
- Rollback posture per service

**File: `docs/hosting/cns-hosting-placement-register.yaml`**
- Machine-readable register for all five components:
  `gail-os-api`, `graphify-cns-api`, `freedom`, `supabase-product-data`, `model-providers`
- Fields per component: `component`, `repo`, `current_runtime`, `pilot_runtime`, `target_runtime`,
  `region`, `data_owner`, `secret_owner`, `network_exposure`, `auth_model`, `budget_cap`,
  `scale_rule`, `backup_policy`, `promotion_gate`, `rollback_path`
- Must be parseable; validated by YAML lint in CI

**Acceptance criteria:**
- [ ] Both files exist and committed
- [ ] Canada Central recorded as default region
- [ ] Budget guardrail under $300/month recorded
- [ ] Azure core + Vercel Freedom + Supabase product-data posture recorded
- [ ] OpenAI + Anthropic provider strategy recorded
- [ ] Internal-only client target recorded
- [ ] No cloud resources created
- [ ] No secret values in any file

---

#### H1 — Azure Foundation Scaffold

**New folder:** `infra/azure-pilot/`

**File: `infra/azure-pilot/README.md`**
- Resource naming convention: `rg-gail-cns-pilot-canadacentral`, `aca-gail-cns-pilot`, etc.
- IaC method decision (from D3 above)
- Prerequisites: Azure CLI, subscription ID, Container Registry login
- Step-by-step create order (resource group → Key Vault → Storage → Postgres → ACA environment → apps)
- Destroy/rollback instructions
- Cost guardrail checklist (no AKS, no API Management, etc.)

**File: `infra/azure-pilot/parameters.example.json`**
- All required parameters with placeholder values (no real secrets)
- `subscription_id`, `resource_group`, `region`, `container_registry`, `postgres_sku`,
  `log_analytics_daily_cap`, `acr_name`, `keyvault_name`, `storage_account_name`

**File: `infra/azure-pilot/deploy-notes.md`**
- Exact az CLI commands or Bicep deploy commands (matched to D3 decision)
- Expected outputs (resource URLs, endpoints)
- Cost checkpoints at each step
- Note: do not run these commands until Adam explicitly approves resource creation

**Acceptance criteria:**
- [ ] All three files committed
- [ ] No secrets in any file (placeholders only)
- [ ] Destroy/rollback instructions present
- [ ] Cost checklist includes all mandatory no-cost rules from directive
- [ ] Daily logging cap is specified
- [ ] No resources deployed

---

### 4.2 `gail-ai-operating-system-rev-2` — GAIL OS

**Phase:** H2

#### Current state before H2

- FastAPI app at `apps/gail-os-api/main.py`
- 13 routes live and proven (CTP-2)
- Python packages: `packages/uaos-core/src` (must be on PYTHONPATH)
- Evidence store: JSON files at `GAIL_OS_STORE_PATH` (env var, already configurable)
- API key: `GAIL_OS_API_KEY` (env var only)
- No Dockerfile, no container CI, no PostgreSQL

#### H2 Chunk A — Containerization Prep

**File: `apps/gail-os-api/Dockerfile`**
```
Base image: python:3.11-slim
WORKDIR: /app
Copy packages/uaos-core/src → /app/packages/uaos-core/src
Copy apps/gail-os-api → /app/apps/gail-os-api
Install requirements.txt
Set PYTHONPATH=/app/packages/uaos-core/src
Set GAIL_OS_STORE_PATH=/app/data/evidence (override with env var at runtime)
EXPOSE 8123
CMD: uvicorn apps.gail-os-api.main:app --host 0.0.0.0 --port 8123
```
Note: No --reload in container image.

**File: `apps/gail-os-api/.dockerignore`**
- Excludes: `.git`, `__pycache__`, `*.pyc`, `tests/`, `*.env`, `.env*`,
  `data/evidence/` (store mounts at runtime, not baked into image),
  Windows-local scratchpad files

**File: `requirements.txt` (pinned)**
- Review and pin all currently installed packages to exact versions:
  `fastapi`, `uvicorn`, `pydantic`, `msal`, `slowapi`, `python-multipart`, etc.
- Verify `pip install -r requirements.txt` produces a clean install in container

**PYTHONPATH fix:**
- Confirm `PYTHONPATH` is set via `ENV` in Dockerfile, not assumed from shell
- Smoke test: `docker build` + `docker run` → `GET /api/v1/health` returns 200

#### H2 Chunk B — GitHub Actions CI for Container

**File: `.github/workflows/container-build.yml`**
- Trigger: push to `main`, PR targeting `main`
- Steps:
  1. Checkout
  2. Set up Docker Buildx
  3. Log in to Container Registry (ACR or GHCR — matches D2 decision)
  4. Build image: `gail-os-api:latest` and `gail-os-api:<sha>`
  5. Push on merge to main only (not on PR)
- No secrets committed — registry credentials via GitHub Actions secrets

#### H2 Chunk C — Environment Variable and Secret Audit

All env vars that GAIL OS reads at runtime:

| Variable | Purpose | Source in pilot | Notes |
|---|---|---|---|
| `GAIL_OS_API_KEY` | Auth for all endpoints | Azure Key Vault reference or ACA secret | Never in image |
| `GAIL_OS_STORE_PATH` | Evidence JSON file store | ACA volume mount path | Default `/app/data/evidence` |
| `AZURE_TENANT_ID` | M365 Graph auth | Key Vault (Phase H6 only) | Not set by default |
| `AZURE_CLIENT_ID` | M365 Graph auth | Key Vault (Phase H6 only) | Not set by default |
| `AZURE_CLIENT_SECRET` | M365 Graph auth | Key Vault (Phase H6 only) | Not set by default |

**Stop condition:** Do not set `AZURE_*` vars by default. M365 live writes remain disabled until H6 gate.

#### H2 Chunk D — Container Smoke Test Script

**File: `scripts/smoke-test-container.sh`**
- Starts local container via `docker run` with test env vars
- Runs: `GET /api/v1/health`, `POST /api/v1/missions`, `GET /api/v1/agents`, `GET /api/v1/connectors`
- Asserts 200 responses
- Stops container after test
- For use both locally and in CI

#### H2 Acceptance Criteria (full)

- [ ] `docker build` completes without error
- [ ] `docker run` starts the server without error
- [ ] `GET /health` returns 200 from container
- [ ] `POST /api/v1/missions` works
- [ ] `POST /api/v1/actions/validate` works
- [ ] `GET /api/v1/agents` returns 6 agents
- [ ] `GET /api/v1/connectors` works
- [ ] Evidence store path is env-var-driven, not hardcoded
- [ ] No hardcoded Windows paths in any source file
- [ ] No `--reload` flag in container CMD
- [ ] `GAIL_OS_API_KEY` comes from env, not image
- [ ] `AZURE_*` vars are absent by default (live M365 disabled)
- [ ] CI workflow builds image on push
- [ ] No secrets in repo

#### H2 Post-Pilot: PostgreSQL Migration Chunk (future, not H2)

Not part of H2. Will be a separate chunk after the container pilot is stable. When that chunk runs:
- Add `psycopg2-binary` (or `asyncpg`) to requirements
- Replace JSON file store with PostgreSQL-backed store for missions, actions, evidence index, OKPs
- Connection string via `DATABASE_URL` env var → Key Vault reference
- Migration scripts in `db/migrations/`

---

### 4.3 `graphify-workspace-cockpit` — Graphify CNS API

**Phase:** H3

#### Current state before H3

- FastAPI app at `cns_api/app.py`
- SQLite store at `CNS_STORE_PATH` (env var, already configurable)
- 300/300 Python tests passing
- No Dockerfile, no container CI
- Single-writer assumption: one uvicorn process, one SQLite writer

#### H3 Chunk A — Containerization Prep

**File: `Dockerfile`** (repo root or `cns_api/Dockerfile`)
```
Base image: python:3.11-slim
WORKDIR: /app
Copy requirements.txt → install
Copy cns_api/ → /app/cns_api/
Copy cns_store/ → /app/cns_store/
Set CNS_STORE_PATH=/app/data/cns.db (override with env var at runtime)
EXPOSE 8001
CMD: uvicorn cns_api.app:app --host 0.0.0.0 --port 8001
```

**File: `.dockerignore`**
- Excludes: `.git`, `__pycache__`, `*.pyc`, `tests/`, `workspace/`, `*.env`,
  existing graph files that should not be baked into the image

**SQLite persistence plan:**
- `CNS_STORE_PATH` points to a mounted Azure Files share path
- Single container replica ensures single writer
- Azure Files share is created in H1 (storage account)
- ACA volume mount: `cns-store` → `/app/data/`
- If Azure Files is unavailable in pilot: ephemeral SQLite inside container is acceptable for
  initial smoke test, but not for persistent pilot use

#### H3 Chunk B — GitHub Actions CI for Container

**File: `.github/workflows/container-build.yml`**
- Same pattern as GAIL OS: build on push, push image on merge to main
- Image: `graphify-cns-api:latest` and `graphify-cns-api:<sha>`

#### H3 Chunk C — Environment Variable Audit

| Variable | Purpose | Source in pilot | Notes |
|---|---|---|---|
| `CNS_STORE_PATH` | SQLite DB path | ACA volume mount | Default `/app/data/cns.db` |
| `GRAPHIFY_API_KEY` | Auth (if implemented) | Key Vault or ACA secret | Confirm current auth model |
| `CNS_API_PORT` | Port override | ACA env | Default 8001 |

#### H3 Chunk D — Container Smoke Test Script

**File: `scripts/smoke-test-container.sh`**
- `docker run` with test CNS_STORE_PATH
- `GET /health`, `GET /api/cns/health` (aliased route proven in CTP-1)
- One relationship query test
- Assert 200 responses

#### H3 Acceptance Criteria (full)

- [ ] `docker build` completes without error
- [ ] `docker run` starts the server without error
- [ ] `GET /health` returns 200
- [ ] `GET /api/cns/health` returns 200 (Freedom probes this route)
- [ ] Relationship query endpoint works
- [ ] OKP ingest endpoint works through approved path
- [ ] `CNS_STORE_PATH` is env-var-driven
- [ ] Single-replica posture documented; max replicas set to 1 in ACA config
- [ ] No approval/execution authority added (read/ingest only)
- [ ] CI workflow builds image on push
- [ ] No secrets in repo

#### H3 Network and Proximity Notes

- Graphify and GAIL OS should be in the same ACA environment (same virtual network)
- Graphify's ingest path from GAIL OS uses internal URL (no public ingress required for that call)
- Freedom calls Graphify from Vercel — Graphify needs restricted external ingress (not fully public)

---

### 4.4 `the-freedom-engine-os` — Freedom

**Phase:** H4 (connect to Azure), H5 (Supabase RLS)

#### Current state before H4

- Deployed on Vercel
- `GAIL_OS_API_URL` = local address (e.g. `http://10.77.77.1:8123`)
- `GRAPHIFY_API_URL` = local address (e.g. `http://localhost:8001`)
- All integration tests use `fake` transport by default; HTTP transport uses env vars
- Degraded state handling exists (Phase 3/6 work)

#### H4 Chunk A — Vercel Environment Variable Update

**Files to update (no secrets committed):**

**New file: `docs/hosting/vercel-env-setup.md`**
- Documents which Vercel project env vars to set
- `GAIL_OS_API_URL` → Azure Container App URL (e.g. `https://gail-os.{env}.azurecontainerapps.io`)
- `GAIL_OS_API_KEY` → Value from Key Vault (set in Vercel env, not in repo)
- `GRAPHIFY_API_URL` → Azure Container App URL
- `GRAPHIFY_API_KEY` → Value from Key Vault (set in Vercel env, not in repo)
- Instructions for setting in Vercel dashboard (Production + Preview environments)
- Warning: do not commit values; set via Vercel dashboard or Vercel CLI

**No change to source code for H4.** The env vars are already consumed correctly. The only change is the URL values in Vercel project settings.

**Adam action required:** Log in to Vercel → Project → Settings → Environment Variables → update URLs and keys.

#### H4 Chunk B — Smoke Test Against Cloud Endpoints

- Run existing Freedom integration tests with `GAIL_OS_API_URL` pointing to Azure
- Verify: health check, proposeMission, validateAction, listConnectors
- Verify: Graphify entity context query works against Azure Graphify
- Verify: executive brief works end-to-end
- Verify: degraded state displays correctly if one service is temporarily down

**Acceptance criteria:**
- [ ] `GAIL_OS_API_URL` and `GRAPHIFY_API_URL` are updated in Vercel (not committed)
- [ ] Freedom health check passes against Azure GAIL OS
- [ ] Freedom proposeMission passes against Azure GAIL OS
- [ ] Freedom Graphify entity context passes against Azure Graphify
- [ ] Executive brief works end-to-end via cloud services
- [ ] Degraded state visible if Azure service is down
- [ ] No authority/evidence stored in Vercel or Supabase
- [ ] No secrets committed to repo

---

#### H5 — Supabase RLS Remediation

**Status:** Can run before or after H4; does not require Azure to be live.

**New file: `docs/security/2026-06-28 - Supabase RLS Remediation Plan.md`**
- Audit of all 20 public tables with RLS disabled
- For each table: purpose, freedom usage, RLS recommendation, policy spec
- Categories:
  - Tables that need RLS enabled with explicit policies
  - Tables that should be server-side-only (no public anon access)
  - Tables that are intentionally read-public (rare)
- Confirm no GAIL OS authority/evidence tables exist in Supabase

**Migration file (if repo supports it):** `supabase/migrations/<date>_enable_rls.sql`
- `ALTER TABLE <name> ENABLE ROW LEVEL SECURITY;`
- `CREATE POLICY` statements per table
- Rollback: `ALTER TABLE <name> DISABLE ROW LEVEL SECURITY;` (explicit, tested)

**Adam approval required before applying migration to production Supabase.**

**Acceptance criteria:**
- [ ] All 20 public tables audited and documented
- [ ] RLS plan documented for each
- [ ] Migration SQL written and reviewed
- [ ] No GAIL OS authority/evidence in Supabase confirmed
- [ ] Service role key usage confirmed as server-side only
- [ ] Adam approves migration before applying

---

### 4.5 `ag-operations-m365-foundation` — M365 Foundation

**Phase:** H6 (docs/prep only — no live writes in first pilot deployment)

#### H6 — M365 Live Bridge Readiness

**Files to update:**

**M365 source surface map** (update existing doc or create):
- BLK-005 status: Entra app registration confirmed / not confirmed
- Tenant ID, Client ID documented (values in Key Vault — not in repo)
- Current delegated scopes: `User.Read`, `Flows.Read.All`, `User`, `user_impersonation`
- Scopes needed for first live write target (to be named)
- State for each potential live surface:

| Surface | State | Approved scope | Notes |
|---|---|---|---|
| Power Automate (Flows) | Proven (delegated read) | Read only | DeviceCode auth confirmed |
| Planner | Dry-run proven | None yet | Live write needs explicit approval |
| SharePoint | Not proven | None | Separate Entra expansion required |
| Teams | Not proven | None | Out of scope for pilot |
| Exchange | Not proven | None | Not allowed as first live scope |

**Not in H6:**
- Live M365 Graph writes
- Entra permission expansion
- Client tenant writes
- Any external-facing M365 surface

**H6 acceptance criteria:**
- [ ] BLK-005 status updated
- [ ] M365 source surface map updated with current state
- [ ] First candidate live-write scope named (even if not approved)
- [ ] Rollback path documented for any future live scope
- [ ] Live M365 execution remains disabled

---

## 5. Approval Gate Summary

| Gate | Adam approval required? | Notes |
|---|---:|---|
| Write H0 placement register | No | Documentation only |
| Write H1 scaffold docs + IaC | No | No cloud changes |
| Create Azure resources (H1 execution) | **Yes** | Resource group + paid services |
| Deploy GAIL OS to ACA (H2) | **Yes** | Cloud resource change |
| Deploy Graphify to ACA (H3) | **Yes** | Cloud resource change |
| Update Vercel env vars (H4) | **Yes** | Live environment change |
| Apply Supabase RLS (H5) | **Yes** | Could affect live app |
| Activate live M365 writes (H6) | **Yes, explicit named scope** | Not in first pilot |
| Add ACR / GHCR registry | Covered by H1 resource approval | Name registry in H1 |
| Add API Management / AKS | **No** (blocked by directive) | Not in pilot |

---

## 6. Budget Risk Map

| Service | Monthly risk | Control |
|---|---|---|
| Azure Container Apps | Low (consumption, scale-to-zero) | min_replicas=0; max=1-2 |
| PostgreSQL Flexible Server | Main fixed cost | Smallest burstable SKU; HA off |
| Azure Blob Storage | Low | LRS only; evidence artifacts only |
| Azure Key Vault | Low | Avoid polling loops; secrets cached at app start |
| Log Analytics / App Insights | Controlled | Daily cap required in H1 scaffold |
| Azure Container Registry | Low | Basic tier sufficient |
| Azure Files (Graphify store) | Very low | Small share; single writer |
| Vercel | Existing | No change; monitor usage |
| Supabase | Existing | Product data only; no uncontrolled growth |
| Model providers (OpenAI/Anthropic) | Variable | Track separately; can exceed infra if uncontrolled |

---

## 7. What Does Not Change in Phase 7

- Freedom's executive cognition, brief generation, CNS gate — no code changes for H0-H4
- GAIL OS API surface (13 routes) — no new routes for containerization
- Graphify relationship intelligence — no new routes for containerization
- Authority ladders (R0-R5, A0-A6) — unchanged
- Evidence packet schema — unchanged
- R4 charter doctrine — unchanged
- OpenAI / Anthropic model routing — existing abstraction, no change

---

## 8. Files Created Per Phase (Summary)

| Phase | Repo | Files |
|---|---|---|
| H0 | build-control | `docs/hosting/2026-06-28 - CNS Hosting Pilot Strategy.md`, `docs/hosting/cns-hosting-placement-register.yaml` |
| H1 | build-control | `infra/azure-pilot/README.md`, `infra/azure-pilot/parameters.example.json`, `infra/azure-pilot/deploy-notes.md` |
| H2 | gail-ai-operating-system-rev-2 | `apps/gail-os-api/Dockerfile`, `apps/gail-os-api/.dockerignore`, `requirements.txt` (pinned), `.github/workflows/container-build.yml`, `scripts/smoke-test-container.sh` |
| H3 | graphify-workspace-cockpit | `Dockerfile`, `.dockerignore`, `.github/workflows/container-build.yml`, `scripts/smoke-test-container.sh` |
| H4 | the-freedom-engine-os | `docs/hosting/vercel-env-setup.md` |
| H5 | the-freedom-engine-os | `docs/security/2026-06-28 - Supabase RLS Remediation Plan.md`, `supabase/migrations/<date>_enable_rls.sql` |
| H6 | ag-operations-m365-foundation | M365 source surface map update |

---

## 9. Azure Account Note

Microsoft issued $1,000 in credits to the **personal account** (`adamgdwn@hotmail.com`), not the business account. For an **internal pilot** at the scope described here (single resource group, <$300/month target, no client data, no external traffic), using the personal subscription is a legitimate path — the credits reduce pilot cost to near-zero.

**Decision required (D1 above):** Confirm whether to use personal account with credits or set up a dedicated business subscription. This gates H1 resource creation — not H0 or H1 documentation.

If using personal account: the resource group owner will be `adamgdwn@hotmail.com`. That is acceptable for an internal pilot. For enterprise client readiness (future phase), a business subscription with proper tenant separation would be the promotion gate.

---

## 10. Execution Ready Checklist

Before the first execution chunk starts, confirm:

- [ ] Adam has reviewed and approved this plan
- [ ] D1 (Azure account) decision made
- [ ] D2 (Container registry) decision made
- [ ] D3 (IaC tooling) decision made
- [ ] D4 (PostgreSQL timing) decision made — recommendation: post-H2 separate chunk
- [ ] D5 (Graphify store persistence) decision made — recommendation: Azure Files for pilot
- [ ] No cloud resources created before approval

---

## 11. Definition of Done — Phase 7

Phase 7 (Hosting Pilot) is complete when:

- [ ] Hosting placement register and pilot strategy docs committed (H0)
- [ ] Azure foundation scaffold committed (H1)
- [ ] GAIL OS API running in Azure Container Apps, all 13 routes responding (H2)
- [ ] Graphify CNS API running in Azure Container Apps, health + query proven (H3)
- [ ] Freedom on Vercel calling Azure GAIL OS and Graphify successfully (H4)
- [ ] Supabase RLS remediation plan written and applied with Adam approval (H5)
- [ ] M365 live bridge readiness documented; live writes remain disabled (H6)
- [ ] Budget confirmed under $300/month
- [ ] No secrets committed
- [ ] No live M365 writes without explicit separate approval
- [ ] Phase report committed for each H phase
- [ ] Master Hosting Pilot Report committed

Phase 7 does not include: multi-tenant client separation, AKS, API Management, enterprise Entra federation, live M365 writes (separate gate).
