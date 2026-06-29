# Vercel + Local Environment Setup — CNS Hosting Pilot

**Last Updated:** 2026-06-28
**Status:** URLs live and verified. API keys set in Azure Key Vault — apply manually per instructions below.

---

## Live Azure URLs (confirmed 2026-06-28)

| Service | URL |
|---|---|
| GAIL OS API | `https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` |
| Graphify CNS API | `https://aca-graphify-cns-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` |

---

## Environment Variables to Set

### In Vercel (Freedom project → Settings → Environment Variables)

Set for **Production** and **Preview** environments:

| Variable | Value | Notes |
|---|---|---|
| `GAIL_OS_API_URL` | `https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` | Non-sensitive; safe to set |
| `NEXT_PUBLIC_GAIL_OS_API_URL` | `https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` | Client-side status component |
| `GRAPHIFY_API_URL` | `https://aca-graphify-cns-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io` | Non-sensitive; safe to set |
| `GAIL_OS_API_KEY` | From `kv-gail-cns-pilot/gail-os-api-key` | **Sensitive** — get from Windows/KV only |
| `GRAPHIFY_API_KEY` | From `kv-gail-cns-pilot/cns-api-key` | **Sensitive** — get from Windows/KV only |

**Security rule:** Never commit key values. Set via Vercel dashboard UI only.

### To retrieve key values from Windows

```powershell
# Run on Windows (az authenticated as adamgdwn@hotmail.com)
$GAIL_KEY = az keyvault secret show `
  --vault-name kv-gail-cns-pilot `
  --name gail-os-api-key `
  --query value --output tsv

$CNS_KEY = az keyvault secret show `
  --vault-name kv-gail-cns-pilot `
  --name cns-api-key `
  --query value --output tsv

Write-Output "GAIL_OS_API_KEY: $GAIL_KEY"
Write-Output "GRAPHIFY_API_KEY: $CNS_KEY"
```

Copy values directly into Vercel dashboard. Do not write to Exchange or any file.

---

## Local Development (.env.local)

These are set in `the-freedom-engine-os/.env.local` for local Freedom ↔ Azure testing:

```
GAIL_OS_API_URL=https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io
NEXT_PUBLIC_GAIL_OS_API_URL=https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io
GRAPHIFY_API_URL=https://aca-graphify-cns-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io
# GAIL_OS_API_KEY=<from kv-gail-cns-pilot/gail-os-api-key — get from Windows>
# GRAPHIFY_API_KEY=<from kv-gail-cns-pilot/cns-api-key — get from Windows>
```

The URL vars allow unauthenticated health checks to work immediately.
The key vars enable authenticated endpoints (proposeMission, listConnectors, etc.).

---

## Vercel Project Status

As of 2026-06-28, Freedom Engine OS does not have a `.vercel/project.json`.
If Freedom is linked to a Vercel project, confirm the project ID and link locally:

```bash
cd /home/adamgoodwin/code/agents/the-freedom-engine-os
vercel link --project <project-name-or-id>
```

Then push env vars via CLI:

```bash
vercel env add GAIL_OS_API_URL production
vercel env add GRAPHIFY_API_URL production
```

---

## Health Check Verification

After setting env vars and redeploying Freedom:

```bash
# Test GAIL OS health from local Freedom next server
curl http://localhost:3000/api/gail-os/health

# Direct ACA health checks (no API key required)
curl https://aca-gail-os-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io/api/v1/health
curl https://aca-graphify-cns-api.ambitiousforest-f57e95ff.canadacentral.azurecontainerapps.io/health
```

---

## Rollback

To revert Freedom to previous (local/dev) endpoints:
- In Vercel: update `GAIL_OS_API_URL` and `GRAPHIFY_API_URL` back to previous values
- Locally: restore `.env.local` entries
- No code changes required
