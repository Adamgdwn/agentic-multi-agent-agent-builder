# Phase 0 Chunk Specs — Cloud Agent Edition

**Last Updated:** 2026-06-26
**Phase:** 0 — Architecture Doctrine + Framing Alignment
**Platform:** cloud-safe (all tasks below)
**Entry point:** `docs/build-control/cloud-dispatch.yaml`

Before starting any task in this file, read `docs/cloud-agent-startup.md` for the cloud operating protocol.

---

## Task 0.2 — Align Freedom repo to executive cognition framing {#task-02}

**Repo:** `Adamgdwn/the-freedom-engine-os`
**Branch:** `cloud/0.2-freedom-framing`
**Budget class:** Tiny
**Type:** Documentation alignment

### Context

Freedom's CNS role: Executive cognition layer — reasons, prioritizes, plans, explains, delegates, orchestrates agents, requests authority, acts as executive AI business partner. CNS analogy: prefrontal cortex.

A CNS role statement was added to `AGENTS.md` on 2026-06-25 (the repo had none before). This task verifies that framing is consistent across all docs.

What to watch for and correct:
- "UI-first" or "dashboard product" framing — Freedom has UI surfaces but is not primarily a frontend
- "App" framing without the cognition context
- Missing reference to the 3-layer CNS model (Freedom + GAIL OS + Graphify)

Source of truth: `docs/build-control/master-plan-summary.md §2` in the control repo (`Adamgdwn/agentic-multi-agent-agent-builder`).

### Acceptance Criteria

- [ ] `AGENTS.md` clearly states Freedom's role as the executive cognition layer in the 3-layer CNS model
- [ ] `README.md` does not frame Freedom as primarily a UI, dashboard, or app product
- [ ] "Executive AI business partner" or equivalent framing is present
- [ ] No conflicting framing found in `/docs` folder (if it exists)
- [ ] PR opened to `main` with description explaining what was verified or changed

### Inputs

1. `Adamgdwn/the-freedom-engine-os` — `AGENTS.md`, `README.md`, and any `/docs` folder
2. `Adamgdwn/agentic-multi-agent-agent-builder` — `docs/build-control/master-plan-summary.md §2`

### Outputs

- Updated `AGENTS.md` or `README.md` (if framing needed correction)
- PR to `main` in `the-freedom-engine-os`
- `cloud-dispatch.yaml` updated in this PR (set `status: ready-for-review`, fill `branch`, `pr_url`)

### Validation

Human review only — no automated test needed (docs task).

### Stop Condition

Stop if repo is inaccessible. Open a `[BLOCKED]` PR in the control repo describing the access issue.

---

## Task 0.3 — Align GAIL OS Rev 2 to deep-brain autonomic management framing {#task-03}

**Repo:** `Adamgdwn/gail-ai-operating-system-rev-2`
**Branch:** `cloud/0.3-gailos-framing`
**Budget class:** Tiny
**Type:** Documentation alignment

### Context

GAIL OS CNS role: Deep-brain / autonomic management — authority envelopes, risk classification, evidence ledger, action state machine, connector + agent registries, policy gate, escalation. CNS analogy: midbrain.

Critical framing correction: GAIL OS is NOT a hand brake, guardian, or blocker on Freedom. It is the enabling layer that makes autonomous action safe and legible. Any "governance-as-restraint" framing must be replaced with "governance-as-enabler."

Source of truth: `docs/build-control/master-plan-summary.md §2, §7` (non-negotiable architecture rules 9 and 10).

### Acceptance Criteria

- [ ] Search docs for: "hand brake", "guardian", "blocker", "limiter", "restricts Freedom" — replace any found
- [ ] `AGENTS.md` states GAIL OS role as autonomic management / authority + evidence layer
- [ ] Framing conveys that the OS *enables* R4 autonomy, not that it prevents action
- [ ] PR opened to `main`

### Inputs

1. `Adamgdwn/gail-ai-operating-system-rev-2` — `AGENTS.md`, `README.md`, `docs/` folder
2. `Adamgdwn/agentic-multi-agent-agent-builder` — `docs/build-control/master-plan-summary.md §2, §7`

### Outputs

- Updated docs with corrected framing
- PR to `main` in `gail-ai-operating-system-rev-2`
- `cloud-dispatch.yaml` updated in this PR

### Validation

Human review. Adam confirms no "hand brake" framing remains.

### Stop Condition

Stop if you cannot find the docs folder or AGENTS.md does not exist. Create a minimal AGENTS.md with CNS role statement instead and note what was missing.

---

## Task 0.4 — Align Graphify to core cognitive infrastructure framing {#task-04}

**Repo:** `Adamgdwn/graphify-workspace-cockpit`
**Branch:** `cloud/0.4-graphify-framing`
**Budget class:** Tiny
**Type:** Documentation alignment

### Context

Graphify CNS role: Relationship intelligence / connectome — maps clients, workflows, repos, agents, source refs, risks, evidence, and research claims. CNS analogy: connectome / association cortex.

A CNS role section was prepended to `AGENTS.md` on 2026-06-25. This task verifies the cockpit's own documentation (README, any `/docs` folder) frames Graphify as core cognitive infrastructure, not just a "workspace visualization" tool or "nice-to-have graph viewer."

Key framing to establish:
- Graphify is one of three core CNS layers, not a product spoke
- It provides relationship intelligence that Freedom and GAIL OS query — not just a visualization
- Phase 2 goal is to expose Graphify as a queryable API, not just a visual cockpit

### Acceptance Criteria

- [ ] `AGENTS.md` CNS role section present and accurate (verify from 2026-06-25 addition)
- [ ] `README.md` does not frame Graphify as "workspace visualization" only
- [ ] Any cockpit docs in `/docs` reflect relationship-intelligence framing
- [ ] PR opened to `main`

### Inputs

1. `Adamgdwn/graphify-workspace-cockpit` — `AGENTS.md`, `README.md`, `/docs` folder
2. `Adamgdwn/agentic-multi-agent-agent-builder` — `docs/build-control/master-plan-summary.md §2, §8`

### Outputs

- Updated docs with corrected framing
- PR to `main` in `graphify-workspace-cockpit`
- `cloud-dispatch.yaml` updated in this PR

### Validation

Human review.

---

## Task 0.5 — Document R0-R5 and A0-A6 authority ladders in GAIL OS {#task-05}

**Repo:** `Adamgdwn/gail-ai-operating-system-rev-2`
**Branch:** `cloud/0.5-authority-ladders`
**Budget class:** Small
**Type:** New documentation file

### Context

The R0-R5 authority ladder and A0-A6 autonomy maturity ladder are the canonical governance model for the entire CNS. Their source of truth must live in `gail-ai-operating-system-rev-2` — the OS is the authority and evidence layer.

Create a new file: `docs/governance/authority-ladders.md`

This file must exactly match the definitions in `docs/build-control/master-plan-summary.md §4` from the control repo. Do not invent new definitions — copy and attribute.

### Acceptance Criteria

- [ ] `docs/governance/authority-ladders.md` created in GAIL OS Rev 2
- [ ] R0-R5 table present with all six levels, names, and meanings
- [ ] A0-A6 table present with all seven levels and descriptions
- [ ] File notes that the source of truth is `agentic-multi-agent-agent-builder/docs/build-control/master-plan-summary.md`
- [ ] File notes that A6 is future-state, NOT current production authority
- [ ] File cross-references the mandatory action state machine
- [ ] PR opened to `main`

### Inputs

1. `Adamgdwn/agentic-multi-agent-agent-builder` — `docs/build-control/master-plan-summary.md §4`

### Outputs

- New file: `docs/governance/authority-ladders.md` in `gail-ai-operating-system-rev-2`
- PR to `main`
- `cloud-dispatch.yaml` updated in this PR

### Content to include

**R-levels (from master-plan-summary.md §4):**

| Level | Name | Meaning |
|---:|---|---|
| R0 | Observe | Read-only, no external effect |
| R1 | Propose | Draft, recommend, prepare — no external effect |
| R2 | Internal approved action | Reversible internal write with named approval |
| R3 | Restricted action | External send, production release, irreversible change |
| R4 | Delegated autonomous restricted action | Inside a valid pre-approved authority charter |
| R5 | Blocked / human-only | Agent may analyze only; human decides |

**A-levels (from master-plan-summary.md §4):**

A0 (Manual) → A1 (Assisted) → A2 (Supervised) → A3 (Delegated narrow) → A4 (Adaptive) → A5 (Self-expanding under strict governance) → A6 (Minimal governance — future state, NOT current authority)

**Mandatory action state machine:**
`observed → proposed → classified → approval_requested → approved/rejected → claimed → executed/stopped → evidenced → reviewed → learned`

### Validation

Human review. Adam confirms ladders match master architecture exactly.

---

## Task 0.6 — Align M365 Foundation to first-class enterprise body framing {#task-06}

**Repo:** `Adamgdwn/ag-operations-m365-foundation`
**Branch:** `cloud/0.6-m365-framing`
**Budget class:** Tiny
**Type:** Documentation alignment / new AGENTS.md

### Context

M365 Foundation CNS role: First-class enterprise body — Microsoft 365 as a primary execution and data lane (not a secondary integration or bolt-on). The M365 Foundation is not a "plugin" to the CNS — it is an enterprise-grade execution motor with its own governance, auth, and evidence expectations.

Stage 9 of the M365 Foundation docs already establishes the agentic bridge readiness. This task adds a CNS role statement and confirms the broader framing.

### Acceptance Criteria

- [ ] `AGENTS.md` exists (create if absent) with CNS role section stating M365 Foundation's role
- [ ] Framing positions M365 as "first-class enterprise body" not "integration"
- [ ] Stage 9 doc framing is consistent (check `docs/stage-9*` or equivalent)
- [ ] PR opened to `main`

### Inputs

1. `Adamgdwn/ag-operations-m365-foundation` — all existing docs
2. `Adamgdwn/agentic-multi-agent-agent-builder` — `docs/build-control/master-plan-summary.md §3`

### CNS Role Statement to add to AGENTS.md

```
## CNS Role

This repository is the M365 Foundation layer of the Guided AI Labs Agentic OS CNS.

**CNS role:** First-class enterprise body — Microsoft 365 as a primary execution motor,
data lane, and enterprise integration surface. Not a secondary integration or plugin.

**In the 3-layer CNS model:**
- GAIL OS classifies and authorizes actions
- M365 Foundation executes approved enterprise actions (List writes, Planner tasks,
  SharePoint updates, Teams messages) and returns evidence
- Stage 9 (agentic bridge readiness) enables GAIL OS Connector registration

**Authority:** All M365 writebacks must flow through the OS Connector registry with
source refs, authority envelopes, and evidence packets. No unregistered write paths.

**Blocker:** BLK-005 — M365 app registration status in Entra is unconfirmed.
Resolve before Phase 4 implementation begins.
```

### Outputs

- New or updated `AGENTS.md` in `ag-operations-m365-foundation`
- PR to `main`
- `cloud-dispatch.yaml` updated in this PR

### Validation

Human review.

---

## Task 0.7 — CNS role statements in product repos {#task-07}

**Repos:** See individual dispatch entries (0.7a–0.7f)
**Branch per repo:** `cloud/0.7{letter}-{repo-slug}-cns-role`
**Budget class:** Tiny per repo
**Type:** New documentation (AGENTS.md creation or update)

### Context

Each product repo operates as a circuit in the CNS body:

| Dispatch ID | Repo | CNS Role |
|---|---|---|
| 0.7a | `guided-ai-journey-website-and-tools` | Diagnostic sensory + readiness pathway circuit |
| 0.7b | `oldskoolai.com` | Learning + capability signal layer |
| 0.7c | `bowtie_risk_program` | Risk + control modelling circuit |
| 0.7d | `change-leadership-tools` | Adoption + organizational change circuit |
| 0.7e | `clean-pdf-build` | Document-production motor circuit (EasyDraft Docs) |
| 0.7f | `guided-ai-labs-website` | Front door + commercial signal layer |

Each task (0.7a–0.7f) is a separate dispatch entry and should be a separate PR. Do not bundle them.

### Acceptance Criteria (per repo)

- [ ] `AGENTS.md` exists (create if absent)
- [ ] CNS Role section added stating the repo's circuit role in the CNS body
- [ ] Section references the 3-layer model (Freedom + GAIL OS + Graphify) as the core
- [ ] Notes that Phase 5 integration is planned (emit structured events to OS)
- [ ] Notes CP-1 as the prerequisite for Phase 5 work
- [ ] PR opened to `main` in the target repo

### CNS Role Section Template

Use this template, filling in `{REPO_ROLE}` and `{REPO_EVENTS}` from the table below:

```markdown
## CNS Role

This repository is a product circuit in the Guided AI Labs Agentic OS CNS body.

**CNS role:** {REPO_ROLE}

**Relationship to the 3-layer core:**
- Freedom (executive cognition) orchestrates cross-circuit decisions
- GAIL OS (autonomic management) classifies and authorizes all structured events from this circuit
- Graphify (relationship intelligence) maps this circuit's entities and signals

**Phase 5 integration (planned):** This repo will emit structured events to GAIL OS:
{REPO_EVENTS}

**Prerequisite:** CP-1 (GAIL OS HTTP API + event contracts) must be cleared before
Phase 5 integration begins. Do not implement event emission until CP-1 is confirmed.
```

### Role and Events by Repo

**0.7a — guided-ai-journey-website-and-tools:**
- Role: Diagnostic sensory + readiness pathway circuit
- Events: `readiness.completed`, `pilot_candidate.created`, `inquiry.created`

**0.7b — oldskoolai.com:**
- Role: Learning + capability signal layer
- Events: `lesson.completed`, `role_path.selected`, `capability.signal_emitted`

**0.7c — bowtie_risk_program:**
- Role: Risk + control modelling circuit
- Events: `risk.identified`, `control.applied`, `risk_program.updated`

**0.7d — change-leadership-tools:**
- Role: Adoption + organizational change circuit
- Events: `stakeholder.engagement_recorded`, `adoption.milestone_reached`

**0.7e — clean-pdf-build:**
- Role: Document-production motor circuit (EasyDraft Docs)
- Events: `document.generated`, `document.evidence_attached`

**0.7f — guided-ai-labs-website:**
- Role: Front door + commercial signal layer
- Events: `inquiry.created`, `demo_requested`, `lead.qualified`

### Validation

Human review per repo. Confirm framing is consistent with master-plan-summary.md §3.

### Stop Condition

0.7d and 0.7e are private repos. If access is denied, open a `[BLOCKED]` PR in the control repo. Do not skip — surface the access issue explicitly.
