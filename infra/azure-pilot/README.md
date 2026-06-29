# Azure Pilot Infrastructure — CNS Hosting Pilot

**Phase:** H1 — Azure Foundation Scaffold
**IaC method:** az CLI scripts
**Region:** Azure Canada Central (`canadacentral`)
**Account:** `adamgdwn@hotmail.com` (personal, $1,000 Microsoft credits)
**Status:** Scripts ready — DO NOT RUN until Adam explicitly approves resource creation

---

## Resource Naming Convention

| Resource | Name |
|---|---|
| Resource group | `rg-gail-cns-pilot-canadacentral` |
| ACA environment | `aca-env-gail-cns-pilot` |
| Container app — GAIL OS | `aca-gail-os-api` |
| Container app — Graphify | `aca-graphify-cns-api` |
| Azure Container Registry | `acrgailcnspilot` (no hyphens; globally unique — add suffix if taken) |
| Key Vault | `kv-gail-cns-pilot` |
| Storage account | `stgailcnspilot` (no hyphens; globally unique) |
| Azure Files share (Graphify) | `graphify-cns-data` |
| Log Analytics workspace | `law-gail-cns-pilot` |

---

## Prerequisites

Before running any scripts:

1. **Azure CLI installed and logged in**
   ```bash
   az login                          # opens browser for adamgdwn@hotmail.com
   az account show                   # confirm correct subscription
   ```

2. **Subscription set**
   ```bash
   az account set --subscription "<SUBSCRIPTION_ID>"
   ```
   Copy the subscription ID from `az account list --output table`.

3. **Required extensions installed**
   ```bash
   az extension add --name containerapp
   az extension add --name log-analytics
   ```

4. **Parameters file populated**
   Copy `parameters.example.json` → `parameters.local.json` and fill in real values.
   `parameters.local.json` is gitignored — never commit it.

---

## Create Order

Resources must be created in this order (dependencies flow top-to-bottom):

```
1. Resource group
2. Log Analytics workspace
3. Key Vault
4. Storage account + Azure Files share (Graphify SQLite persistence)
5. Azure Container Registry
6. ACA environment (linked to Log Analytics)
7. Container app — GAIL OS
8. Container app — Graphify
```

Exact commands are in [deploy-notes.md](deploy-notes.md).

---

## Cost Guardrail Checklist

Confirm all of these before approving resource creation:

- [ ] No AKS cluster
- [ ] No API Management instance
- [ ] No Azure Front Door
- [ ] No Microsoft Sentinel workspace
- [ ] ACA consumption tier only (no Dedicated plan)
- [ ] Log Analytics daily ingestion cap: 5 GB/day (set in deploy-notes.md)
- [ ] Storage account is LRS standard (not GRS, not premium)
- [ ] ACR tier is Basic
- [ ] Key Vault is standard tier
- [ ] Graphify container app: `max_replicas = 1` (SQLite single-writer constraint)

---

## Destroy / Rollback Instructions

To remove **all** pilot resources (single command, irreversible):

```bash
az group delete \
  --name rg-gail-cns-pilot-canadacentral \
  --yes \
  --no-wait
```

This deletes: ACA environment, both container apps, ACR, Key Vault, Storage account
(including Azure Files share), and Log Analytics workspace.

Before running: back up the Graphify SQLite file from Azure Files if you need to preserve state:

```bash
azcopy copy \
  "https://stgailcnspilot.file.core.windows.net/graphify-cns-data/cns.db<SAS_TOKEN>" \
  "./cns-backup-$(date +%Y%m%d).db"
```

---

## Individual Service Rollback

**GAIL OS — traffic split (zero-downtime):**
```bash
# Route all traffic to previous revision
az containerapp revision list \
  --name aca-gail-os-api \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --output table

az containerapp ingress traffic set \
  --name aca-gail-os-api \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --revision-weight <previous-revision>=100
```

**Graphify — same pattern (single replica, SQLite preserved on Azure Files):**
```bash
az containerapp ingress traffic set \
  --name aca-graphify-cns-api \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --revision-weight <previous-revision>=100
```

**Freedom Vercel — instant:**
Revert `GAIL_OS_API_URL` and `GRAPHIFY_API_URL` to previous values in Vercel dashboard.
No code change required.

---

## Personal-to-Business Account Migration

When a Guided AI Labs business Azure subscription is active:

1. Update `parameters.local.json` with new subscription ID
2. Run the deploy script against new subscription
3. Push container images to new ACR: `az acr import` or re-tag from CI
4. Copy Graphify SQLite data: `azcopy sync` between storage accounts
5. Update Vercel env vars to new ACA URLs
6. Run `az group delete` on the personal-account resource group

Resources cannot be moved across tenant boundaries. This is a re-deploy, not a migration.
Estimated time: 30–60 minutes.
