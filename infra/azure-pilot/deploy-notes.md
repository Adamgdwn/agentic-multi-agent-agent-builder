# Azure Pilot Deploy Notes

**IaC method:** az CLI scripts
**DO NOT RUN these commands until Adam explicitly approves resource creation (H1 gate).**

---

## Step 0 — Prerequisites

```bash
# Log in as adamgdwn@hotmail.com
az login

# Set the personal account subscription
az account set --subscription "YOUR_SUBSCRIPTION_ID"

# Install required extensions
az extension add --name containerapp --upgrade
az extension add --name log-analytics --upgrade

# Verify
az account show --output table
```

---

## Step 1 — Resource Group

```bash
az group create \
  --name rg-gail-cns-pilot-canadacentral \
  --location canadacentral \
  --tags project=gail-cns-pilot phase=7 owner=adamgdwn
```

Cost checkpoint: Resource groups are free.

---

## Step 2 — Log Analytics Workspace

```bash
az monitor log-analytics workspace create \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --workspace-name law-gail-cns-pilot \
  --location canadacentral \
  --sku PerGB2018

# Set 5 GB/day ingestion cap (cost guardrail)
az monitor log-analytics workspace update \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --workspace-name law-gail-cns-pilot \
  --quota 5

LAW_ID=$(az monitor log-analytics workspace show \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --workspace-name law-gail-cns-pilot \
  --query id --output tsv)
```

Cost checkpoint: ~$0–$10/month at 5 GB/day cap.

---

## Step 3 — Key Vault

```bash
az keyvault create \
  --name kv-gail-cns-pilot \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --location canadacentral \
  --sku standard \
  --enable-soft-delete true \
  --retention-days 7

# Store API keys (replace placeholder values at runtime — never commit real values)
az keyvault secret set \
  --vault-name kv-gail-cns-pilot \
  --name gail-os-api-key \
  --value "REPLACE_AT_RUNTIME_NEVER_COMMIT"

az keyvault secret set \
  --vault-name kv-gail-cns-pilot \
  --name cns-api-key \
  --value "REPLACE_AT_RUNTIME_NEVER_COMMIT"
```

Cost checkpoint: ~$0–$2/month (per-operation pricing, minimal ops).

---

## Step 4 — Storage Account + Azure Files Share (Graphify SQLite)

```bash
az storage account create \
  --name stgailcnspilot \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --location canadacentral \
  --sku Standard_LRS \
  --kind StorageV2 \
  --allow-blob-public-access false

STORAGE_KEY=$(az storage account keys list \
  --account-name stgailcnspilot \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --query "[0].value" --output tsv)

az storage share create \
  --name graphify-cns-data \
  --account-name stgailcnspilot \
  --account-key "$STORAGE_KEY" \
  --quota 10
```

Cost checkpoint: ~$1–$3/month for 10 GB LRS standard.

---

## Step 5 — Azure Container Registry

```bash
az acr create \
  --name acrgailcnspilot \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --location canadacentral \
  --sku Basic \
  --admin-enabled true

ACR_SERVER=$(az acr show \
  --name acrgailcnspilot \
  --query loginServer --output tsv)

ACR_PASS=$(az acr credential show \
  --name acrgailcnspilot \
  --query "passwords[0].value" --output tsv)
```

Cost checkpoint: ~$5/month Basic SKU.

---

## Step 6 — ACA Environment

```bash
az containerapp env create \
  --name aca-env-gail-cns-pilot \
  --resource-group rg-gail-cns-pilot-canadacentral \
  --location canadacentral \
  --logs-workspace-id "$LAW_ID"
```

Cost checkpoint: ACA environment itself is free (consumption tier); costs are per-app.

---

## Step 7 — GAIL OS Container App

This step requires the GAIL OS image to be pushed to ACR first (H2 chunk).
Run after H2 image is built and pushed.

Note: secrets are passed directly (not via Key Vault runtime reference) to avoid
managed-identity RBAC setup. Upgrade to KV refs after pilot validates connectivity.

```powershell
# Get values from existing Azure resources
$ACR_PASS = az acr credential show `
  --name acrgailcnspilot `
  --query "passwords[0].value" --output tsv

$GAIL_KEY = az keyvault secret show `
  --vault-name kv-gail-cns-pilot `
  --name gail-os-api-key `
  --query value --output tsv

az containerapp create `
  --name aca-gail-os-api `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --environment aca-env-gail-cns-pilot `
  --image "acrgailcnspilot.azurecr.io/gail-os-api:latest" `
  --registry-server "acrgailcnspilot.azurecr.io" `
  --registry-username acrgailcnspilot `
  --registry-password $ACR_PASS `
  --target-port 8123 `
  --ingress external `
  --min-replicas 0 `
  --max-replicas 2 `
  --cpu 0.5 `
  --memory 1Gi `
  --secrets "gail-os-api-key=$GAIL_KEY" `
  --env-vars `
    "GAIL_OS_API_KEY=secretref:gail-os-api-key" `
    "GAIL_OS_STORE_PATH=/app/data/evidence" `
    "PYTHONPATH=/app/packages/uaos-core/src"

$GAIL_OS_URL = az containerapp show `
  --name aca-gail-os-api `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --query "properties.configuration.ingress.fqdn" --output tsv

Write-Output "GAIL OS URL: https://$GAIL_OS_URL"
```

Cost checkpoint: ~$5–$25/month at typical traffic; scale-to-zero when idle.

---

## Step 8 — Graphify Container App

This step requires the Graphify image to be pushed to ACR first (H3 chunk).
Run after H3 image is built and pushed.

Note: Azure Files volume mount uses the correct two-step pattern:
1. Register storage on the ACA environment
2. Reference via volume in the container app

```powershell
$ACR_PASS = az acr credential show `
  --name acrgailcnspilot `
  --query "passwords[0].value" --output tsv

$CNS_KEY = az keyvault secret show `
  --vault-name kv-gail-cns-pilot `
  --name cns-api-key `
  --query value --output tsv

$STORAGE_KEY = az storage account keys list `
  --account-name stgailcnspilot `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --query "[0].value" --output tsv

# Step 8a — Register Azure Files storage on the ACA environment
az containerapp env storage set `
  --name aca-env-gail-cns-pilot `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --storage-name graphify-files `
  --azure-file-account-name stgailcnspilot `
  --azure-file-account-key $STORAGE_KEY `
  --azure-file-share-name graphify-cns-data `
  --access-mode ReadWrite

# Step 8b — Create container app referencing the registered storage
az containerapp create `
  --name aca-graphify-cns-api `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --environment aca-env-gail-cns-pilot `
  --image "acrgailcnspilot.azurecr.io/graphify-cns-api:latest" `
  --registry-server "acrgailcnspilot.azurecr.io" `
  --registry-username acrgailcnspilot `
  --registry-password $ACR_PASS `
  --target-port 8001 `
  --ingress external `
  --min-replicas 0 `
  --max-replicas 1 `
  --cpu 0.5 `
  --memory 1Gi `
  --secrets "cns-api-key=$CNS_KEY" `
  --env-vars `
    "CNS_API_KEY=secretref:cns-api-key" `
    "CNS_STORE_PATH=/app/data/cns.db" `
  --volume "name=graphifyvol,storage-name=graphify-files,storage-type=AzureFile" `
  --volume-mount "volume-name=graphifyvol,mount-path=/app/data"

$GRAPHIFY_URL = az containerapp show `
  --name aca-graphify-cns-api `
  --resource-group rg-gail-cns-pilot-canadacentral `
  --query "properties.configuration.ingress.fqdn" --output tsv

Write-Output "Graphify URL: https://$GRAPHIFY_URL"
```

Cost checkpoint: ~$3–$15/month; scale-to-zero when idle. SQLite single-writer enforced by max_replicas=1.

---

## Expected Outputs After Full Deployment

```
GAIL OS API:  https://aca-gail-os-api.<hash>.canadacentral.azurecontainerapps.io
Graphify API: https://aca-graphify-cns-api.<hash>.canadacentral.azurecontainerapps.io
```

These URLs go into Freedom Vercel env vars (H4 gate — Adam approves before applying):
- `GAIL_OS_API_URL` = GAIL OS URL above
- `GRAPHIFY_API_URL` = Graphify URL above

---

## Full Destroy (All Pilot Resources)

```bash
# Removes EVERYTHING in the resource group — irreversible
az group delete \
  --name rg-gail-cns-pilot-canadacentral \
  --yes \
  --no-wait

echo "Resource group deletion queued. Takes ~5 minutes to complete."
```

Back up Graphify SQLite before running:

```bash
azcopy copy \
  "https://stgailcnspilot.file.core.windows.net/graphify-cns-data/cns.db?<SAS_TOKEN>" \
  "./cns-backup-$(date +%Y%m%d).db"
```
