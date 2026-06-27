# ChatGPT Pro — CNS Four-Repo Plan Realignment Prompt

**Date:** 2026-06-27
**Purpose:** Structured briefing prompt for ChatGPT Pro to read four repo zip files and produce a revised, integrated build plan for the Guided AI Labs Agentic OS CNS.
**How to use:** Copy everything below the horizontal rule into ChatGPT Pro, attach the four zip files, and send. Modify the [ADAM NOTES] fields before sending.

---

---

## PROMPT BEGINS HERE

You are being asked to read four GitHub repository zip files and produce a revised, integrated build plan for an agentic AI operating system called the **Guided AI Labs Agentic OS CNS**.

Before you read the files, I am going to give you the architectural history, the decisions that are locked, the current state, and exactly what I need you to produce. Read this briefing fully before touching the zip files.

---

### What This System Is

This is a three-layer cognitive stack — soon to be four layers — designed to give AI agents the ability to act in an enterprise environment with enforced governance, full auditability, and a persistent relationship memory.

The metaphor that shapes every design decision: a **central nervous system**.

- The executive brain decides what to try.
- The autonomic system governs whether it's allowed, at what authority level, and by whom.
- The connectome holds the relationship memory — what everything is connected to, what has happened before.
- The enterprise body is where actions actually land: emails sent, documents created, calendar events scheduled, SharePoint updated.

The system is not built to move fast and break things. It is built to move deliberately and leave a complete record.

---

### The Four Repos (one zip each)

**1. `the-freedom-engine-os` — Freedom (Linux)**
- Role: Executive cognition layer. Observes signals. Proposes missions. Does not act directly.
- Stack: TypeScript, Next.js
- Current state: CNS role statement in AGENTS.md. No HTTP calls to GAIL OS yet. Awaiting `@gail/contracts` TypeScript types and GAIL OS HTTP API before code work begins.
- What to look for: AGENTS.md (role statement), any existing mission proposal logic, current dependency structure

**2. `gail-ai-operating-system-rev-2` — GAIL OS (Windows)**
- Role: Autonomic management layer. Validates all actions against authority envelopes. Runs the 12-stage action lifecycle. Produces evidence packets.
- Stack: Python. FastAPI HTTP API in progress.
- Current state: Full schema foundation complete (7 merged PRs, 59 tests, CI green). Modules: `mission_spine.py`, `connector_registry.py`, `relay_envelope.py`, `relay_store.py`, `graphify_handoff.py`, `local_proof_runner.py`, `mission.py`, `authority_envelope.py`, `evidence_packet.py`, `action.py`. FastAPI HTTP layer is the next chunk.
- What to look for: `packages/uaos-core/src/gail_ai_operating_system/`, `docs/current-build-pathway.md`, `docs/build-control/` if present, existing test suite

**3. `graphify-workspace-cockpit` — Graphify (Linux)**
- Role: Connectome layer. Relationship intelligence. Persistent queryable graph of every entity and relationship in the workspace.
- Stack: Python (extraction + HTTP API), SQLite store
- Current state: Phase 2 complete as of 2026-06-27. SQLite CNS store, 6 HTTP endpoints on port 8001, all speed SLAs verified (sub-100ms per query on 12,687-entity graph). BLK-002 (Freedom cannot query Graphify) is closed. Containerized, cloud-ready.
- What to look for: `cns_store/`, `cns_api/`, `docs/specs/`, `Dockerfile.cns-api`, any existing extraction pipeline modules

**4. `ag-operations-m365-foundation` — AG Operations / M365 (Windows)**
- Role: First-class enterprise body. This is where the bulk of real-world inputs arrive (emails, Teams messages, SharePoint events, calendar) and where the bulk of outputs land (send email, create document, update list, schedule meeting).
- Stack: Review the repo — this is the one I know least about from a current-state standpoint.
- Current state: Previously treated as a Phase 4 integration. Now being elevated to a first-class participant. Has been informed that integration is coming.
- What to look for: What connectors or M365 integrations already exist, what the data model looks like, what events it can emit or receive, what authentication is in place (app registration status), any existing GAIL OS or CNS references

---

### Decisions That Are Locked — Do Not Reopen

These are architectural decisions already made and enforced in code. Do not suggest alternatives to these. Design around them.

**1. The 12-stage action lifecycle (MissionStatus)**
Every action must travel: `OBSERVED → PROPOSED → CLASSIFIED → APPROVAL_REQUESTED → APPROVED / REJECTED → CLAIMED → EXECUTED / STOPPED → EVIDENCED → REVIEWED → LEARNED`
Illegal transitions are hard errors. Terminal states (`REJECTED`, `LEARNED`) cannot transition further. This is enforced in the Python state machine, not a convention.

**2. Authority ladder: R0–R5 and A0–A6**
- R0 = public / no restriction. R5 = human-only authorization required.
- A0 = human does everything. A6 = fully autonomous (future state, not current production).
- Current production boundary: A1 (local, no-network, dry-run only). A2 is the next autonomy level to unlock.
- Every action carries an `AuthorityEnvelope` specifying the R-level required and the A-level granted.

**3. Graphify: extraction writes, API reads**
The extraction pipeline is the only write path to the store in Phase 2. The HTTP API is read-only. No write path through the API. This is a hard design rule.

**4. Store: SQLite first, cloud migration path designed in**
Phase 2 SQLite. Migration path to Turso or PostgreSQL is designed into the schema. Do not require Turso or PostgreSQL in Phase 2.

**5. Cloud-first API design**
All HTTP APIs (GAIL OS FastAPI, Graphify CNS API) are containerized, env-var configured, no local path assumptions. They start local and deploy to cloud — they do not need to be rebuilt for cloud deployment.

**6. Language split**
- GAIL OS: Python
- Freedom: TypeScript (Next.js)
- Graphify: Python (extraction + API)
- M365 Foundation: [check the repo]
- `@gail/contracts` is a JSON Schema → generated TypeScript types package. It bridges Python (GAIL OS) to TypeScript (Freedom). It does not contain Python types.

**7. CP-1 gate definition**
CP-1 (Checkpoint 1) is the first full cognitive cycle: Freedom proposes a mission → GAIL OS validates and issues a PolicyDecision → Freedom receives the decision → an EvidencePacket is written. CP-1 does not require Graphify Phase 2 (already complete) or M365 integration. It requires: GAIL OS HTTP API live (Chunk 21), `@gail/contracts` TypeScript types (Chunk 22), Freedom → GAIL OS HTTP call (Chunk 23).

**8. Windows / Linux machine split**
- GAIL OS runs on Windows
- Freedom runs on Linux
- Graphify runs on Linux (primary) with Windows as an extraction node
- M365 Foundation runs on Windows
- GitHub is the primary cross-machine transport

**9. A1 local boundary (current)**
GAIL OS is currently at A1: local, no external network calls, no live M365 connectors, no Supabase. This boundary is held until CP-1 is proven. Do not suggest crossing it before CP-1.

---

### What Has Been Completed

**Phase 0 (complete):**
- CNS role statements added to all repos (Freedom, GAIL OS, Graphify, and 7 satellite repos)
- Shared vocabulary established: authority ladder, autonomy levels, 12-stage lifecycle

**Phase 1 — GAIL OS schema foundation (complete):**
- CI gate (GitHub Actions, Python 3.11 + pytest) — PR #3
- `MissionStatus` 12-stage enum — PR #4
- `AuthorityEnvelope` frozen dataclass (14 fields) — PR #5
- `EvidencePacket` frozen dataclass (12 fields) — PR #6
- `Action` frozen dataclass + `VALID_TRANSITIONS` state machine — PR #7
- 59 tests total, all passing, CI green

**Graphify Phase 2 (complete):**
- SQLite CNS store schema + connection layer (Chunk 2.1)
- JSON graph importer (Chunk 2.2)
- 6 CNS query patterns (Chunk 2.3)
- FastAPI skeleton + health endpoint (Chunk 2.4)
- GAIL OS query endpoints: connector scope validation, entity neighborhood, authority chain (Chunk 2.5)
- Freedom query endpoints: entity context, domain mapping, recent mission context (Chunk 2.6)
- Extraction write path + on-demand ingest trigger (Chunk 2.7)
- Performance validation: 12,687 entities, 19,477 relationships, all SLAs <100ms (Chunk 2.8)
- Cloud-readiness hardening: containerized, env-var configured, Docker Compose (Chunk 2.9)
- BLK-002 closed: Graphify is externally callable via HTTP

**Freedom Phase 0 (complete):**
- CNS role statement in AGENTS.md
- No code work started (correctly blocked on GAIL OS HTTP API)

---

### Active Blockers

| ID | Description | Resolved by |
|---|---|---|
| BLK-001 | GAIL OS not exposed as HTTP API — Freedom cannot call it | Chunk 21 (FastAPI) |
| BLK-002 | Graphify not externally callable | **CLOSED** — Graphify Phase 2 complete |
| BLK-003 | `@gail/contracts` TypeScript types not yet created | Chunk 22 |
| BLK-004 | Windows Enhanced Graphify extraction hasn't run | Resolved architecturally — any extraction node uses same schema |
| BLK-005 | M365 app registration status unknown | Needs verification before M365 connector work begins |

---

### What Changed That Requires This Realignment

The original plan treated M365 (`ag-operations-m365-foundation`) as a Phase 4 integration — after the internal cognition stack was proven. That framing is now wrong.

M365 is where the bulk of real-world inputs arrive and where the bulk of outputs land. If the system observes an email thread and proposes a reply, the I/O surface is M365, not some internal test fixture. M365 is not a late integration — it is the enterprise body. The cognitive cycle is not complete without it.

M365 needs to be elevated from Phase 4 to a first-class participant in the plan, with its own chunk specifications starting from where the repo actually is today.

---

### What I Need You to Produce

Read the four zip files. Then produce the following, in order:

**1. Current State Assessment (one section per repo)**
For each repo: what is actually in it, what phase it is at, what the next logical chunk of work is, and what it is blocked on. Be specific — name files, modules, what's wired up and what isn't.

**2. Revised Phase Map**
A phase-by-phase plan that treats all four repos as first-class participants. Each phase should have:
- A phase gate (what must be true before the next phase begins)
- Which repos are active in that phase
- What the sequencing dependencies are between repos in that phase

**3. Next 6–8 Chunk Specifications**
For the most urgent next chunks across all four repos, write a chunk spec in this format:

```
### Chunk [N] ([Repo] — [Platform]) — [Short Title]

**Status:** [Ready / Blocked on: X]
**Objective:** [One sentence]

**Acceptance criteria:**
- [ ] ...

**Output files:**
- ...

**Validation:** [How to confirm it's done]

**Unblocks:** [What this enables next]
```

Chunks should be sequenced by dependency — what must ship before what. Call out cross-repo dependencies explicitly.

**4. Risk and Gap Register**
What is the most likely thing to go wrong in the next phase? What assumptions are built into the plan that could be wrong? Flag M365 app registration (BLK-005) specifically — this is the one unknown that could stall M365 integration before it starts.

**5. Open Questions for Adam**
A short list of questions where the answer changes the plan. Not design questions — questions about the current state of the repos that only Adam can answer.

---

### Formatting Rules

- Use the chunk spec format above exactly — it will be pasted into existing build-control docs
- Do not reopen locked decisions
- Do not suggest TypeScript for GAIL OS or Python for Freedom
- Do not suggest removing the 12-stage lifecycle or simplifying the authority ladder
- Do not recommend skipping CP-1 or redefining it
- Name specific files when you reference code — "the connector registry" is less useful than "`connector_registry.py`"
- If you find something in the repos that contradicts what I've described above, flag it — don't silently override my briefing

[ADAM NOTES: Add anything you want ChatGPT to pay special attention to, or any current state detail you know that isn't in the repos yet. E.g., "GAIL OS on Windows has been pulled to main as of [date]" or "M365 app registration is live as of [date]" if BLK-005 is resolved.]

---

## PROMPT ENDS HERE
