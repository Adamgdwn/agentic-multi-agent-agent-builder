# Cloud Environment Requirements — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-26

This file documents what environment access, credentials, and MCP tools are required for each task type in `docs/build-control/cloud-dispatch.yaml`.

---

## Phase 0 — Documentation Alignment Tasks (`cloud-safe`)

**Required:**
- GitHub MCP with read/write access to `Adamgdwn` org repos

**Scope needed on GitHub token:**
- `repo` scope for private repos (`change-leadership-tools`, `clean-pdf-build`)
- `public_repo` scope is sufficient for all other Phase 0 tasks

**Not required:**
- ANTHROPIC_API_KEY — docs-only work, no model API calls needed
- Supabase, Stripe, Vercel, or Cloudflare access
- Local filesystem access
- Graphify CLI
- Python, Node.js, or any language runtime

**What a cloud agent needs to read:**
- Target repo's `AGENTS.md` and `README.md` via GitHub MCP
- `docs/build-control/master-plan-summary.md` in this control repo (public)

---

## Phase 1 — Core OS Spine (`windows-local`)

**Required:**
- GitHub MCP (same as Phase 0)
- One of the following for test validation:
  - Adam's Windows machine with Python 3.x and `python -m unittest` working
  - OR GitHub Actions CI in `Adamgdwn/gail-ai-operating-system-rev-2` (not yet configured)

**Current gap:** GitHub Actions CI is not configured in GAIL OS Rev 2. Until it is:
- A cloud agent may write Phase 1 code and open a PR marked `[NEEDS-LOCAL-VALIDATION]`
- Adam runs tests on Windows and confirms before merging
- Do not mark Phase 1 tasks `complete` without test confirmation

**To unblock cloud agents for Phase 1 validation:**
Add a GitHub Actions workflow to `gail-ai-operating-system-rev-2`:
```yaml
# .github/workflows/test.yml
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: python -m unittest discover -s tests
```

---

## Phase 2 — Graphify Core Promotion (`linux-local`)

**Required:**
- GitHub MCP
- Graphify CLI running on Adam's Linux machine
- FastAPI server for `graphify-workspace-cockpit`

**Not cloud-safe** until a Graphify HTTP API is exposed (Phase 2 goal 2.6).

---

## Phase 3 — Freedom Operating Cognition (`coordinated`)

**Required:**
- CP-1 gate cleared (GAIL OS HTTP API live)
- GitHub MCP
- Freedom Next.js dev server (Linux)

---

## Phase 4 — M365 Execution Lane (`coordinated`)

**Required:**
- CP-1 gate cleared
- Microsoft Graph app registration in Entra (BLK-005 — currently unconfirmed)
- Windows machine with GAIL OS running

---

## Phase 5 — Product App Integration (`varies`)

**Required per repo:**
- CP-1 event contracts in place
- Each product repo's own runtime (Next.js, FastAPI, etc.)

---

## Secret Handling Rules

- Never commit API keys, tokens, or credentials to any repo
- The master env file is `/home/adamgoodwin/code/.env.master` — Linux-local, never commit, never print
- Cloud agents do not need and must not request the master env file
- MCP tools (GitHub, Supabase, etc.) handle their own auth — use them through the MCP interface
- If a task seems to require secrets, stop and surface it as a blocker — do not guess at credentials

---

## MCP Tool Inventory

| Tool | Required for | Notes |
|---|---|---|
| GitHub MCP | All cloud tasks | Must have `repo` scope for private repos |
| Supabase MCP | Phase 3+ (Freedom DB) | Project: `basbwglynuyfxcqxfyur` |
| Vercel MCP | Phase 3+ (Freedom deploy) | Team: `21VBttxDbchYqj9JvgxZdZ2R` |
| Stripe MCP | Phase 8+ (client billing) | Account: `acct_1T1Y9aRZGqjtWEPT` |
| Cloudflare MCP | Phase 3+ (DNS/edge) | Account: `f17bf3b09810d3ba4d82008c6af77dc2` |
