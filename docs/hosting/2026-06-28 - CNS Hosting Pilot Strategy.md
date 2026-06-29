# CNS Hosting Pilot Strategy

**Date:** 2026-06-28
**Status:** H0 complete — decisions locked, execution approved
**Phase:** 7 — Internal Guided AI Labs CNS Hosting Pilot
**Directive:** `docs/build-control/2026-06-28 - CNS Hosting Pilot Planning and Execution Directive.md`

---

## Locked Decisions

| Decision | Value |
|---|---|
| Primary region | Azure Canada Central |
| Budget guardrail | Under $300/month |
| GAIL OS host | Azure Container Apps (consumption tier) |
| Graphify CNS API host | Azure Container Apps (consumption tier) |
| Freedom host | Vercel (unchanged) |
| Supabase | Active — product/app data only; no graph state |
| Model providers | OpenAI + Anthropic behind provider abstraction; not Azure-only |
| Container registry | Azure Container Registry (ACR) |
| IaC tooling | az CLI scripts |
| PostgreSQL timing | Post-H2 separate chunk (H2 uses JSON file store) |
| Graphify persistence | SQLite on Azure Files share, single-writer, max replicas = 1 |
| Client scope | Internal Guided AI Labs only |
| M365 live writes | Not in pilot; H6 documents readiness gate only |
| Enterprise services excluded | No AKS, no API Management, no Front Door, no Sentinel |
| Azure account | Personal `adamgdwn@hotmail.com` with $1,000 Microsoft credits |

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│  CLIENT (internal only)                                 │
└───────────────────────┬─────────────────────────────────┘
                        │ HTTPS
┌───────────────────────▼─────────────────────────────────┐
│  FREEDOM ENGINE  (Vercel — unchanged)                   │
│  Next.js + TypeScript                                   │
│  GAIL_OS_API_URL → Azure ACA                            │
│  GRAPHIFY_API_URL → Azure ACA                           │
└─────────────────┬─────────────────┬─────────────────────┘
                  │                 │
     ┌────────────▼──┐   ┌──────────▼────────────┐
     │  GAIL OS API  │   │  GRAPHIFY CNS API      │
     │  Azure ACA    │   │  Azure ACA             │
     │  Canada Central│   │  Canada Central        │
     │  Port 8123    │   │  Port 8001             │
     │  min=0 max=2  │   │  min=0 max=1 (SQLite)  │
     └───────┬───────┘   └──────────┬─────────────┘
             │                      │ Azure Files
             │                 ┌────▼──────────┐
             │                 │  cns.db        │
             │                 │  (SQLite file) │
             │                 └───────────────┘
             │
    ┌────────▼───────────────────────────────┐
    │  M365 Foundation  (Windows / Entra)    │
    │  A1 boundary — dry-run only in pilot   │
    │  Live writes: separate gate after H6   │
    └────────────────────────────────────────┘

    ┌────────────────────────────────────────┐
    │  Supabase  (product/app data)          │
    │  Referenced by Freedom directly        │
    │  RLS remediation: H5                   │
    └────────────────────────────────────────┘

    ┌────────────────────────────────────────┐
    │  Model Providers                       │
    │  OpenAI + Anthropic                    │
    │  Behind Freedom provider abstraction   │
    │  Not hardwired to Azure models         │
    └────────────────────────────────────────┘
```

---

## Budget Allocation

| Resource | Estimated Monthly Cost | Notes |
|---|---|---|
| ACA — GAIL OS (consumption) | $5–25 | Scale-to-zero; min replicas = 0 |
| ACA — Graphify (consumption) | $3–15 | Scale-to-zero; min replicas = 0 |
| Azure Container Registry (Basic) | $5 | Shared by both images |
| Azure Files (LRS, standard) | $1–3 | ~10GB Graphify SQLite share |
| Log Analytics workspace | $0–10 | Daily cap enforced (5 GB/day) |
| Azure Key Vault | $0–2 | Per-secret pricing |
| **Total estimate** | **$14–60** | Well under $300/month guardrail |

**Cost guardrails enforced:**
- No AKS, no API Management, no Front Door, no Sentinel
- ACA consumption tier only (no Dedicated plan)
- Log Analytics daily ingestion cap set at 5 GB/day
- All non-essential resources set to delete-able via single `az group delete`

---

## Region Confirmation

**Azure Canada Central** — all pilot resources deployed here.

Rationale: Canadian data residency for internal Guided AI Labs use; lowest latency from Calgary.

---

## Provider Strategy

OpenAI and Anthropic remain as active model providers behind Freedom's provider abstraction layer. Azure OpenAI is not used in the pilot. No rewiring of the model router is required for Phase 7.

---

## Rollback Posture

| Service | Rollback Action |
|---|---|
| GAIL OS on ACA | `az containerapp update --revision-weight old=100 new=0` |
| Graphify on ACA | Same traffic split; SQLite file state preserved on Azure Files |
| Freedom Vercel | Revert `GAIL_OS_API_URL` + `GRAPHIFY_API_URL` to previous values; instant |
| Azure resource group | `az group delete --name rg-gail-cns-pilot-canadacentral` — removes all pilot resources |
| Supabase RLS | Rollback migration: `DISABLE ROW LEVEL SECURITY` per table (H5 includes rollback SQL) |

---

## Personal-to-Business Account Migration Path

The pilot runs under personal account `adamgdwn@hotmail.com` (Microsoft consumer tenant) using $1,000 in credits. When a Guided AI Labs business Azure subscription is active:

1. **Run az CLI scripts against the new subscription** — same scripts, new `--subscription` flag. Estimated re-deploy: 30–60 minutes.
2. **Push container images to new ACR** — `az acr import` or re-tag and push from CI.
3. **Copy Azure Files share** — `azcopy sync` from old storage account to new.
4. **Update Vercel env vars** — point at new ACA URLs.
5. **Delete old resource group** — stops billing on personal account.

Resources cannot be moved across tenant boundaries (personal ↔ business). IaC-first approach (az CLI scripts) makes this a planned re-deploy, not a migration blocker.

---

## H0 Acceptance Criteria

- [x] This strategy doc committed
- [x] Canada Central recorded as default region
- [x] Budget guardrail under $300/month recorded
- [x] Azure core + Vercel Freedom + Supabase product-data posture recorded
- [x] OpenAI + Anthropic provider strategy recorded
- [x] Internal-only client target recorded
- [x] Migration path from personal to business account documented
- [x] No cloud resources created
- [x] No secret values in any file
