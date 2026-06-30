# CNS Phase 5 + 6 Build Specification
## Operating Knowledge Intake and R4 Autonomy

**Date:** 2026-06-28
**Status:** historical-complete — superseded for forward planning by `docs/build-control/handoff-state.md` and `docs/build-control/2026-06-29 - Forward Plan Refactor - Freedom Executive Capability.md`
**Owner:** Build Agent Orchestrator

**2026-06-29 status update:** Phases 5 and 6 are complete. This document is retained as implementation evidence and historical chunk specification. Do not use its unchecked acceptance boxes, open blockers, or risk register as current next-task authority.

**Supersedes (for Phase 5/6 planning):**
- `2026-06-28 - Phase 5 Phase 6 CNS Planning and Execution Directive.md` (GPT Pro input doc — absorbed here)
- Forward-looking Phase 5/6 sections of `2026-06-28 - cns-phase0-phase4-complete-turnover.md`
- Phase 5 rows in `repo-workstream-board.md` (update the board in Chunk 5.0)

**Remains authoritative:**
- `handoff-state.md` — session restart pointer
- `repo-workstream-board.md` — task state tracking (update via Chunk 5.0)
- `master-plan-summary.md` — architectural reference

---

## 0. How to Use This Document

This document is written for both full-capability and lower-capability build agents. Do not infer scope beyond what is written. Do not improvise product integrations. Follow each chunk's objective, output files, acceptance criteria, validation, and stop conditions exactly.

**Agent startup sequence for any Phase 5/6 chunk:**

1. Read this document.
2. Read the target repo `AGENTS.md`.
3. Check `git status --short`.
4. Execute only the named chunk's scope.
5. Validate → commit → push → write repo report → update master ledger.
6. Apply context reset/wake rule if a pause gate is reached.

**Four core repos — all Phase 5/6 work stays inside these:**

```
Adamgdwn/gail-ai-operating-system-rev-2     (Python / FastAPI / Windows)
Adamgdwn/the-freedom-engine-os              (TypeScript / Next.js / Linux)
Adamgdwn/graphify-workspace-cockpit         (Python / FastAPI + SQLite / Linux)
Adamgdwn/ag-operations-m365-foundation      (Docs / planning / Windows)
```

Product repos may be touched **only** for Chunk 5.1 abandonment notes. No PRs. No main branch changes. No product event-emitter code.

---

## 1. Locked Decisions

| Decision | Direction |
|---|---|
| Four-repo boundary | All Phase 5/6 implementation in the four core repos only. No code in product repos. |
| Phase 5 name | Operating Knowledge Intake and Relationship Mesh |
| Phase 5 architecture | Modified Option B — GAIL OS and Graphify ingest controlled operating knowledge from internal sources. No product repo polling. No product repo code injection. |
| OKP / EvidencePacket | OKP wraps EvidencePacket. EvidencePacket stays unchanged. Every EvidencePacket auto-converts to an OKP of type `evidence.created`. |
| Signal Gravity | Real implementation in Phase 5. All 9 factors required. GAIL OS and Freedom own the weights. They reason through adjustments autonomously and escalate to Adam when blocked. |
| OKP record types | All 18 record types defined and validated at launch. |
| Synaptic Proof Chain | Dual format — machine-readable JSON + human-readable markdown. Review note: if this becomes document-heavy in live use, Adam will readdress. |
| First R4 charter | Internal Graphify stale-claim maintenance. Not live M365. Not product repos. |
| CNS naming | Central Nervous System (never "Cognitive"). |
| CP-4 framing | Dry-run M365 execution proof only. Live M365 not active until BLK-005 + approval + named scope. |
| M365 status ladder | pending → proven → approved → active. A live test is not permission for live writes. |
| Phase 6.5 gate | Blocked until Adam explicitly approves. |

---

## 2. Architecture Contracts

### 2.1 OKP and EvidencePacket Relationship

```
EvidencePacket (Phase 4, PR #18)
  ↓ converted by EvidencePacketToOkpConverter
OperatingKnowledgePacket (type=evidence.created)
  ↓ stored in GAIL OS OKP store
  ↓ ingested by Graphify as OKP node
  ↓ consumed by Freedom for executive brief
```

**EvidencePacket remains unchanged.** OKP is a richer envelope that:
- Adds authority/autonomy classification (R0–R5, A0–A6)
- Adds Signal Gravity score
- Adds data classification and fingerprint
- Links to the source EvidencePacket via `related_evidence_id`
- Tracks OKP lifecycle (`observed → accepted → learned → superseded`)

No changes to existing EvidencePacket schema, store, or API endpoints from Phase 4.

### 2.2 Signal Gravity — 9-Factor Adaptive Scoring

Signal Gravity is a prioritization score (0.0–1.0) on each OKP. It answers: **how much weight should the CNS give this signal right now?**

#### The 9 factors and their data sources

| # | Factor | Data source | Layer |
|---|---|---|---|
| 1 | Recent evidence | `created_at` / `observed_at` decay curve | L1 (GAIL OS) |
| 2 | Unresolved risk | `risk_tier` (1–5 normalized) | L1 (GAIL OS) |
| 3 | High operational value | `confidence` field (0.0–1.0) | L1 (GAIL OS) |
| 4 | Repeated recurrence | Graphify edge count — same `source_system` + `record_type` cluster | L2 (Graphify) |
| 5 | Pending authority | `status == review_required` or `authority_level in R3/R4` | L1 (GAIL OS) |
| 6 | Connected blockers | Graphify edges to blocker nodes | L2 (Graphify) |
| 7 | Client/customer impact | `source_system` classification + OKP tag derived from mission metadata | L2 (Graphify) |
| 8 | Relation to prior failures | Graphify edges to evidence of failed/blocked actions | L2 (Graphify) |
| 9 | Strategic alignment | OKP `related_mission_id` + active charter alignment from GAIL OS | L2 (Graphify) |

**Layer 1 (GAIL OS):** Calculated at ingest time from OKP metadata alone. Fast. Available immediately.

**Layer 2 (Graphify):** Calculated from graph topology after OKP node is ingested. Richer. Freedom prefers L2; falls back to L1 if Graphify is unavailable.

#### Weight system and adaptive reasoning

GAIL OS stores Signal Gravity weights in `local_store/signal_gravity_config.json`. Initial weights are set by the implementing agent's best judgment using the factor descriptions above and available research. **GAIL OS and Freedom are expected to reason about weight quality and propose adjustments — they are not constrained to the initial values.**

```json
{
  "version": 1,
  "weights": {
    "recent_evidence": 0.0,
    "unresolved_risk": 0.0,
    "operational_value": 0.0,
    "repeated_recurrence": 0.0,
    "pending_authority": 0.0,
    "connected_blockers": 0.0,
    "client_impact": 0.0,
    "prior_failure_relation": 0.0,
    "strategic_alignment": 0.0
  },
  "note": "Weights set by implementing agent. GAIL OS and Freedom may propose adjustments via signal_gravity_calibration_proposals.json."
}
```

The nine weights must sum to 1.0.

#### Calibration protocol

When GAIL OS or Freedom observes that a factor is producing consistently low-signal results (high score, low resolution correlation), it may:

1. Write a calibration proposal to `local_store/signal_gravity_calibration_proposals.json`
2. Include the proposal in the next Freedom executive brief under a `signal_gravity_health` field
3. Flag to Adam if the proposed delta exceeds ±0.05 on any single factor

Adam reviews and approves or modifies the proposal. Approved proposals update `signal_gravity_config.json` with a version bump and rationale.

GAIL OS and Freedom **do not self-approve weight changes above ±0.05 per factor without Adam's review.**

### 2.3 Synaptic Proof Chain — Dual Format

The Synaptic Proof Chain is the complete auditable review path from signal to learning outcome.

```
source signal
  → classification (record_type, data_classification, source_ref)
  → OKP creation (okp_id, fingerprint, authority_level, gravity_score_l1)
  → Graphify ingestion (entity_id, edge_count, gravity_score_l2)
  → Freedom brief (brief_id, gravity_score_used, recommendation, source_refs_visible)
  → decision or non-decision record
  → evidence (evidence_id if action taken)
  → learning update (okp_status → learned)
```

**Machine-readable format:** JSON object produced by each layer. GAIL OS ingest produces a `chain_stub`. Graphify enriches it. Freedom appends the brief summary. The completed chain is a single JSON document retrievable via `GET /api/v1/okp/{okp_id}/proof-chain`.

**Human-readable format:** Markdown doc artifact generated by Freedom's CP-5 proof run. Answers: Why did the CNS prioritize this? What did it know? What was unknown? Who/what approved it? What evidence exists? What changed?

**Document-heavy review note:** If Synaptic Proof Chain documentation becomes a volume burden during live use, the format will be revisited. The human-readable doc is a Phase 5 quality artifact, not a permanent per-OKP requirement. The machine-readable chain is always produced.

### 2.4 Capability Gap Record

When the CNS hits a limit it cannot self-resolve, it must not bypass controls. It creates a Capability Gap Record and surfaces it to Freedom.

A Capability Gap Record is the governed way to "build the door through the wall."

Required fields: `gap_id`, `detected_by`, `description`, `blocked_objective`, `missing_capability`, `affected_systems`, `risk_if_ignored`, `recommended_door`, `requires_new_connector`, `requires_new_agent`, `requires_human_approval`, `evidence_refs`, `status`.

Status lifecycle: `proposed → approved → rejected → built → retired`

### 2.5 CharterProfile (Phase 6)

A CharterProfile pre-authorizes a narrow class of autonomous actions without per-action human approval.

Required fields: `charter_id`, `title`, `authority_level` (max R4), `autonomy_level`, `allowed_action_types`, `target_resources`, `connector_scope`, `agent_scope`, `max_actions`, `expiry`, `stop_conditions`, `rollback_path`, `review_cadence`, `evidence_requirements`.

R4 charters require: stop conditions, rollback path, max action count, expiry, review cadence, and evidence requirements. Charter cannot grant R5. Charter cannot exceed connector or agent permissions.

---

## 3. OKP Schema Reference

### 3.1 OperatingKnowledgePacket

```python
# Required fields
okp_id: str              # "okp-" prefix + uuid4
source_system: str       # registerd source identifier
source_ref: str          # specific record/file/endpoint reference
record_type: OkpRecordType  # closed vocabulary (18 types)
summary: str             # max 1000 chars
authority_level: str     # R0|R1|R2|R3|R4|R5
autonomy_level: str      # A0|A1|A2|A3|A4|A5|A6
risk_tier: int           # 1–5
data_classification: str # public|internal|synthetic|restricted
status: str              # observed|accepted|rejected|superseded|review_required|learned
created_at: datetime
observed_at: datetime
confidence: float        # 0.0–1.0
fingerprint: str         # deterministic hash of source_ref + record_type + summary
raw_payload_retained: bool  # always False; reject if True

# Optional links
related_mission_id: str | None
related_action_id: str | None
related_evidence_id: str | None   # populated when OKP wraps EvidencePacket
related_connector_id: str | None
related_agent_id: str | None

# Scoring (populated by GAIL OS; enriched by Graphify)
gravity_score_l1: float | None    # calculated at ingest (metadata only)
gravity_score_l2: float | None    # enriched by Graphify (graph topology)
gravity_score_used: float | None  # whichever layer was used in last brief
```

### 3.2 OKP Record Types (18)

```python
class OkpRecordType(str, Enum):
    # Action lifecycle
    ACTION_VALIDATED        = "action.validated"
    ACTION_BLOCKED          = "action.blocked"
    # Authority
    AUTHORITY_OVERRIDE_REQ  = "authority.override_requested"
    # Evidence
    EVIDENCE_CREATED        = "evidence.created"
    # Mission
    MISSION_CREATED         = "mission.created"
    MISSION_REVIEWED        = "mission.reviewed"
    # Graph / relationship
    GRAPH_RELATIONSHIP      = "graph.relationship_detected"
    GRAPH_CLAIM_STALE       = "graph.claim_stale_candidate"
    # M365
    M365_SIGNAL_OBSERVED    = "m365.signal_observed"
    M365_ACTION_LOG         = "m365.action_log_observed"
    # Freedom
    FREEDOM_BRIEF           = "freedom.brief_created"
    # Build
    BUILD_BRANCH_ABANDONED  = "build.branch_abandoned"
    BUILD_BLOCKER_DETECTED  = "build.blocker_detected"
    # Capability
    CAPABILITY_GAP          = "capability.gap_detected"
    # Charter (Phase 6)
    CHARTER_PROPOSED        = "charter.proposed"
    CHARTER_EXECUTED        = "charter.executed"
    # Signal Gravity
    GRAVITY_CALIBRATION     = "gravity.calibration_proposed"
```

---

## 4. Phase 5 Execution Plan

### Execution order

```
5.0  Corrections + board reconciliation    cloud-safe
5.1  Product branch abandonment notes      cloud-safe   ← may run parallel with 5.0
────────────────────────────────────────────────────────
5.2  OKP schema + EvidencePacket wrapper   cloud-safe
────────────────────────────────────────────────────────
5.3  OKP ingest + Signal Gravity L1        cloud-safe   ← parallel
5.4  Graphify OKP nodes + Signal Gravity L2 cloud-safe  ← parallel
5.5  M365 CNS source surface map           cloud-safe   ← parallel (fully independent)
────────────────────────────────────────────────────────
5.6  Freedom OKP briefing + Signal Gravity cloud-safe
────────────────────────────────────────────────────────
5.7  CP-5 dry-run proof (dual format)      cloud-safe
```

---

### Chunk 5.0 — Corrections + Board Reconciliation

**Repo:** `agentic-multi-agent-agent-builder` (build-control docs)
**Platform:** cloud-safe
**Prerequisites:** None
**Unblocks:** All Phase 5/6 chunks

**Objective:** Record Phase 5/6 decisions, correct stale state, and reconcile the workstream board so the Phase 5 execution surface is clean.

**Output files:**
```
docs/decisions/2026-06-28 - Phase 5 and Phase 6 Reset Decision.md
```
(Update in place, not new file: `docs/build-control/repo-workstream-board.md`)
(Update in place: `docs/build-control/handoff-state.md`)

**Acceptance criteria:**
- [ ] Decision doc created: Phase 5 renamed, Modified Option B recorded, product-repo implementation explicitly stopped, first R4 = Graphify stale-claim maintenance, OKP wraps EvidencePacket, Signal Gravity real in Phase 5 (9 factors, adaptive), Synaptic Proof Chain dual-format.
- [ ] CP-4 labelled as dry-run proof only. Live M365 status ladder applied.
- [ ] CNS expansion corrected to Central Nervous System throughout active docs.
- [ ] Workstream board Phase 1 GAIL OS tasks 1.1–1.5 marked `complete` (PRs were merged, CP-1 proven).
- [ ] Workstream board task 1.7 reconciled: Freedom PR #33 satisfied the TypeScript event vocabulary; GAIL OS Python side TBD in Phase 5.2+.
- [ ] Workstream board Phase 5 rows replaced with new Phase 5 chunk list (5.0–5.8) in four core repos.
- [ ] Workstream board Phase 6 rows replaced with new Phase 6 chunk list (6.0–6.5).
- [ ] `handoff-state.md` `next_task` updated to point to Chunk 5.1.
- [ ] No stale "Phase 5 blocked by CP-1" language remains in `handoff-state.md`.

**Validation:**
- Grep for "Phase 5 blocked by CP-1" in active docs → 0 results
- Grep for "Cognitive Nervous System" → 0 results
- Git diff --check

**Stop condition:** Stop if any existing plan document explicitly references an active build instruction that contradicts a locked decision above and cannot be resolved by amendment.

---

### Chunk 5.1 — Product Branch Abandonment Notes

**Repos:** Six product repos (GitHub MCP only — no local checkout)
**Platform:** cloud-safe (GitHub MCP)
**Prerequisites:** 5.0 (decision doc must exist before we reference it in the notes)
**Unblocks:** Clean Phase 5 reset

**Objective:** Leave a clear, dated abandonment note on each mistaken product Phase 5 branch. No PRs, no main branch changes.

**Branches to annotate:**
```
guided-ai-journey-website-and-tools  / phase5/5.1-5.7-gai-journey-events
oldskoolai.com                       / phase5/5.2-5.8-oldskool-events
bowtie_risk_program                  / phase5/5.3-bowtie-events
change-leadership-tools              / phase5/5.4-change-leadership-events
clean-pdf-build                      / phase5/5.5-easydraft-events
guided-ai-labs-website               / phase5/5.6-gail-labs-events
```

**File to add on each branch:**
`docs/2026-06-28 - Phase 5 Branch Abandoned.md`

**Content:**
```markdown
# Phase 5 Branch Abandoned

Date: 2026-06-28

This branch is intentionally abandoned and must not be opened as a PR.

Reason: The Phase 5 workstream was interpreted too broadly. Adam has confirmed
that Phase 5 CNS work must remain inside the four core CNS repos. Product repos
are sensory/product circuits but are not current implementation targets for CNS
event-emitter code.

Current direction: Phase 5 is Operating Knowledge Intake and Relationship Mesh,
implemented in gail-ai-operating-system-rev-2, graphify-workspace-cockpit,
the-freedom-engine-os, and ag-operations-m365-foundation.

Do not continue this branch unless Adam explicitly reauthorizes product-repo
implementation.

Reference: docs/build-control/2026-06-28 - cns-phase5-phase6-build-specification.md
```

**Acceptance criteria:**
- [ ] Abandonment note file exists on each branch (or branch absence is documented in ledger).
- [ ] No PR opened on any product repo.
- [ ] No main branch touched on any product repo.
- [ ] Branch list and outcome recorded in repo report.

**Stop condition:** Stop and flag to Adam if any product branch already has an open PR or shows main-branch contamination.

---

### Chunk 5.2 — OKP Schema + EvidencePacket Wrapper

**Repo:** `gail-ai-operating-system-rev-2`
**Platform:** cloud-safe for code; windows-local for live server test only
**Prerequisites:** 5.0
**Unblocks:** 5.3, 5.4, 5.6

**Objective:** Define the canonical OperatingKnowledgePacket schema, all 18 record types, and the EvidencePacket-to-OKP converter. This is the foundational schema for all Phase 5/6 operating knowledge work.

**Output files:**
```
packages/uaos-core/src/gail_ai_operating_system/operating_knowledge.py
tests/test_operating_knowledge.py
```

**Key implementation notes:**
- `OkpRecordType` is a closed enum with exactly 18 values (see Section 3.2 above).
- `OperatingKnowledgePacket` is a Pydantic model with all fields in Section 3.1.
- `raw_payload_retained` must default to `False` and reject `True` on construction.
- `fingerprint` is a deterministic SHA-256 hash of `source_ref + record_type + summary` (hex string, truncated to 32 chars).
- `EvidencePacketToOkpConverter.convert(evidence_packet) → OperatingKnowledgePacket` maps EvidencePacket fields to OKP fields. Sets `record_type = OkpRecordType.EVIDENCE_CREATED`, `related_evidence_id = evidence_packet.evidence_id`.
- Unsafe source refs must be rejected: `.env`, absolute paths outside approved prefixes, `secret`, `token`, `password` substrings in source_ref.
- `authority_level` validates against `["R0","R1","R2","R3","R4","R5"]`.
- `autonomy_level` validates against `["A0","A1","A2","A3","A4","A5","A6"]`.
- `risk_tier` validates as int in range 1–5.
- `data_classification` validates against `["public","internal","synthetic","restricted"]`.
- Duplicate fingerprints: return the existing OKP with `status=superseded` if different content, or return existing unchanged if identical content.
- Update `packages/uaos-core/src/gail_ai_operating_system/__init__.py` to export new symbols.

**Acceptance criteria:**
- [ ] `OperatingKnowledgePacket` schema exists with all fields.
- [ ] All 18 `OkpRecordType` values exist and validate.
- [ ] `EvidencePacketToOkpConverter.convert()` produces a valid OKP from a Phase 4 EvidencePacket.
- [ ] `raw_payload_retained=True` raises `ValueError`.
- [ ] Unsafe source refs raise `ValueError`.
- [ ] `authority_level` outside R0–R5 raises `ValueError`.
- [ ] Deterministic fingerprint matches across identical inputs.
- [ ] Package exports updated.
- [ ] Minimum 12 tests covering: schema construction, all required fields, EvidencePacket conversion, OkpRecordType enum coverage, fingerprint determinism, unsafe ref rejection, raw payload rejection, authority validation, autonomy validation, risk_tier bounds.

**Validation:**
```bash
cd gail-ai-operating-system-rev-2
python -m pytest tests/test_operating_knowledge.py -v
python -c "from gail_ai_operating_system.operating_knowledge import OperatingKnowledgePacket, OkpRecordType; print('import ok')"
git diff --check
```

**Stop condition:** Stop before adding any ingest endpoint, API route, Graphify call, or M365 read. Schema only.

---

### Chunk 5.3 — OKP Local Ingest Service + Signal Gravity Layer 1

**Repo:** `gail-ai-operating-system-rev-2`
**Platform:** cloud-safe for code; windows-local for live server test only
**Prerequisites:** 5.2
**Parallel with:** 5.4 (different repo)
**Unblocks:** 5.7

**Objective:** Build the GAIL OS service layer for creating, storing, and retrieving OKPs. Implement Signal Gravity Layer 1 — the metadata-based score calculated at ingest time.

**Output files:**
```
packages/uaos-core/src/gail_ai_operating_system/operating_knowledge_store.py
packages/uaos-core/src/gail_ai_operating_system/signal_gravity.py
local_store/signal_gravity_config.json         (created at first run, not committed)
apps/gail-os-api/routers/okp.py
tests/test_operating_knowledge_store.py
tests/test_signal_gravity.py
```

**Key implementation notes for OKP store:**
- `OkpStore.save(okp: OperatingKnowledgePacket) → str` writes OKP as JSON to `{GAIL_OS_STORE_PATH}/okp/{okp_id}.json`. Returns `okp_id`.
- `OkpStore.get(okp_id: str) → OperatingKnowledgePacket | None`.
- `OkpStore.list_by_record_type(record_type: str) → list[OperatingKnowledgePacket]`.
- Duplicate fingerprint handling: if fingerprint exists, update status to `superseded` on old OKP, save new OKP.
- `store_path` param for test isolation.

**Key implementation notes for Signal Gravity Layer 1:**
- `SignalGravityL1Calculator.calculate(okp: OperatingKnowledgePacket, weights: dict) → float` returns a 0.0–1.0 score.
- Weight file: `{GAIL_OS_STORE_PATH}/signal_gravity_config.json`. If absent, use reasonable defaults. The implementing agent must reason about and set good initial default weights for all 9 factors based on the factor descriptions in Section 2.2.
- Layer 1 uses factors 1, 2, 3, 5 directly from OKP metadata. Factors 4, 6, 7, 8, 9 use placeholder values (0.5) at Layer 1 — Graphify provides the real values at Layer 2.
- `CalibrationProposal` schema: `proposal_id`, `factor_name`, `current_weight`, `proposed_weight`, `delta`, `rationale`, `created_at`.
- `SignalGravityL1Calculator.propose_calibration(factor_name, proposed_weight, rationale) → CalibrationProposal` writes proposal to `{GAIL_OS_STORE_PATH}/signal_gravity_calibration_proposals.json`.
- API route `POST /api/v1/okp` — accepts OKP fields, validates, calculates L1 gravity, stores, returns `{okp_id, gravity_score_l1, fingerprint}`.
- API route `GET /api/v1/okp/{okp_id}` — returns OKP with all fields including L1 score.
- Update `apps/gail-os-api/main.py` to register `okp` router.

**Acceptance criteria:**
- [ ] `OkpStore.save()` persists OKP to local store.
- [ ] `OkpStore.get()` retrieves OKP by ID.
- [ ] `OkpStore.list_by_record_type()` filters correctly.
- [ ] Duplicate fingerprint creates supersession correctly.
- [ ] Signal Gravity L1 score is calculated and stored on each OKP.
- [ ] L1 score is in range 0.0–1.0.
- [ ] `signal_gravity_config.json` is created with reasoned initial weights summing to 1.0.
- [ ] Calibration proposal can be written.
- [ ] `POST /api/v1/okp` returns 201 with `okp_id` and `gravity_score_l1`.
- [ ] `GET /api/v1/okp/{okp_id}` returns 200 with full OKP.
- [ ] `GET /api/v1/okp/missing` returns 404.
- [ ] Minimum 15 tests: store roundtrip, list filter, fingerprint dedup, gravity score bounds, weight config load, calibration proposal write, unsafe input rejection, API 201, API 200, API 404, L1 factors 1/2/3/5 calculated correctly.

**Validation:**
```bash
python -m pytest tests/test_operating_knowledge_store.py tests/test_signal_gravity.py -v
git diff --check
```

**Stop condition:** Stop before HTTP calls to Graphify, live M365 reads, Supabase writes, or product repo references. Local store and API only.

---

### Chunk 5.4 — Graphify OKP Nodes + Signal Gravity Layer 2

**Repo:** `graphify-workspace-cockpit`
**Platform:** cloud-safe for code; linux-local for full runtime validation
**Prerequisites:** 5.2
**Parallel with:** 5.3 (different repo)
**Unblocks:** 5.6, 5.7, 6.2

**Objective:** Add OKP node type and edges to Graphify. Implement Signal Gravity Layer 2 — the graph-topology-based enrichment of the gravity score. All 9 factors are calculated here.

**Output files:**
```
cns_store/operating_knowledge_writer.py
cns_api/routes/operating_knowledge.py
tests/test_operating_knowledge_writer.py
tests/test_operating_knowledge_api.py
```
(Adjust paths if actual repo uses different conventions — check existing `cns_store/` and `cns_api/routes/` structure.)

**Key implementation notes for OKP writer:**
- `ingest_okp_entity(okp_data: dict) → dict` upserts OKP as a Graphify entity (`kind='OperatingKnowledgePacket'`, `cluster='operating_knowledge'`).
- Creates relationship edges to: mission (if `related_mission_id` exists in graph), action, evidence (EvidencePacket node), connector, agent, blocker nodes.
- `get_okp_entity(okp_id: str) → dict | None`.
- `get_okp_neighborhood(okp_id: str) → dict` — returns OKP node + all 1-hop edges.

**Key implementation notes for Signal Gravity Layer 2:**
- `SignalGravityL2Enricher.enrich(okp_id: str, g: Graph) → dict` — reads OKP node + edges, calculates all 9 factors using actual graph data, returns `{gravity_score_l2, factor_scores, factor_weights_used}`.
- Factor sources at L2: Factor 4 = same source_system/record_type edge count. Factor 6 = edges to `kind='blocker'` nodes. Factor 7 = OKP `source_system` tag + mission client-impact flag. Factor 8 = edges to failed-action evidence nodes. Factor 9 = mission alignment + charter alignment from GAIL OS agent registry.
- `factor_weights_used` must reflect the current `signal_gravity_config.json` weights from GAIL OS (pass in as parameter or use a sensible default if not available).
- L2 gravity score replaces L1 on the OKP node once calculated.

**Key implementation notes for API:**
- `POST /api/cns/okp` — ingests OKP, creates node and edges, calculates L2 gravity, returns `{entity_id, gravity_score_l2, edge_count, relationships_created}`.
- `GET /api/cns/okp/{okp_id}` — returns OKP entity with gravity score.
- `GET /api/cns/okp/{okp_id}/proof-chain` — returns Synaptic Proof Chain stub enriched with Graphify data (see Chunk 5.7 for the Freedom layer).
- `GET /api/cns/okp/{okp_id}/neighborhood` — returns OKP + neighbors.

**Acceptance criteria:**
- [ ] OKP node type exists in Graphify entity store.
- [ ] Edges created to related entity types when they exist.
- [ ] Missing related entities do not create placeholder nodes.
- [ ] L2 gravity score covers all 9 factors.
- [ ] L2 gravity score is in range 0.0–1.0.
- [ ] `factor_scores` field shows per-factor breakdown.
- [ ] `POST /api/cns/okp` returns 201 with `entity_id` and `gravity_score_l2`.
- [ ] `GET /api/cns/okp/{okp_id}` returns 200.
- [ ] `GET /api/cns/okp/missing` returns 404.
- [ ] Graphify does not gain approval or execution authority.
- [ ] Minimum 12 tests: node creation, edge formation, missing-entity edge skip, L2 all-9-factors calculation, gravity score bounds, API 201/200/404, neighborhood endpoint, proof-chain stub endpoint.

**Validation:**
```bash
python -m pytest tests/test_operating_knowledge_writer.py tests/test_operating_knowledge_api.py -v
git diff --check
```

**Stop condition:** Stop before adding any mutation authority, approval endpoint, product repo call, or live M365 connector. Graphify is relationship intelligence only.

---

### Chunk 5.5 — M365 CNS Source Surface Map

**Repo:** `ag-operations-m365-foundation`
**Platform:** cloud-safe (documentation only)
**Prerequisites:** None (fully independent)
**Parallel with:** 5.2, 5.3, 5.4

**Objective:** Map each M365 operating surface into CNS source categories. Update BLK-005 status. No live writes.

**Output file:**
```
docs/2026-06-28 - M365 CNS Source Surface Map.md
```

**Surfaces to document (one section each):**
CRM New Signals, Agent Action Log, Decision Register, Planner, SharePoint evidence libraries, Teams alert lane, Forms, Bookings.

**For each surface, document:**
- Owner (person/team)
- Read posture (current permission state)
- Write posture (current permission state, dry-run vs live vs not configured)
- CNS OKP record type(s) applicable
- Evidence refs expected
- Rollback expectations
- Approval boundary (what requires Adam sign-off before live)
- BLK-005 dependency (yes/no)

**BLK-005 section:** Update with current known status of Azure Entra app registration. If unknown, document as `status: unknown — Windows operator action required`.

**One-writer rule:** Confirm each surface has a single designated writer (no dual write paths).

**Acceptance criteria:**
- [ ] All 8 surfaces documented.
- [ ] BLK-005 status updated.
- [ ] Each surface has approval boundary clearly stated.
- [ ] No new tenant writes performed.
- [ ] No app registration, consent grant, or permission change made.

**Validation:**
- Document review
- Grep for any script execution or API call → 0 results
- Git diff --check

**Stop condition:** Stop before any app registration, consent grant, Exchange RBAC, live Graph read/write, flow mutation, or tenant policy change.

---

### Chunk 5.6 — Freedom OKP Briefing + Signal Gravity

**Repo:** `the-freedom-engine-os`
**Platform:** cloud-safe for code; linux-local for full runtime
**Prerequisites:** 5.3, 5.4
**Unblocks:** 5.7

**Objective:** Allow Freedom to brief operating knowledge context with real Signal Gravity scores, source refs, authority paths, and calibration health. Existing executive brief and CNS gate tests must remain clean.

**Output files:**
```
packages/gail-os-client/src/operatingKnowledge.ts
packages/graphify-client/src/operatingKnowledge.ts
src/lib/operatingKnowledgeBrief.ts
```
(Add tests to existing test files or create new test files matching existing conventions.)

**Key implementation notes:**
- `GailOsClient.getOkp(okpId: string) → Promise<OkpRecord>` — calls `GET /api/v1/okp/{okp_id}`.
- `GailOsClient.listOkpByRecordType(recordType: string) → Promise<OkpRecord[]>`.
- `GraphifyClient.getOkpGravity(okpId: string) → Promise<GravityResult>` — calls `GET /api/cns/okp/{okp_id}` and returns gravity breakdown.
- `GraphifyClient.getOkpProofChain(okpId: string) → Promise<SynapticProofChainStub>`.
- `generateOperatingKnowledgeBrief(params, clients) → Promise<OkpBrief>`:
  - Fetches top N OKPs by gravity score from GAIL OS.
  - Enriches each with L2 gravity from Graphify (falls back to L1 if Graphify unavailable; marks brief with `graphify_degraded: true`).
  - Produces `OkpBrief` with: `okp_summaries`, `top_signal` (highest gravity), `signal_gravity_health` (calibration proposals if any), `source_refs_visible`, `authority_path`, `risk_summary`.
- `signal_gravity_health` field must surface any pending calibration proposals from GAIL OS.
- Brief must show per-factor gravity breakdown for the top signal (not just the final score).
- If no OKPs exist, brief returns `{okp_summaries: [], top_signal: null, graphify_degraded: false, note: "No operating knowledge ingested yet"}`.

**Acceptance criteria:**
- [ ] `GailOsClient` exports OKP query methods.
- [ ] `GraphifyClient` exports gravity and proof-chain methods.
- [ ] `generateOperatingKnowledgeBrief()` produces brief with gravity scores and source refs.
- [ ] Degraded mode works (Graphify unavailable → L1 score used, `graphify_degraded: true`).
- [ ] Empty OKP store produces safe empty brief.
- [ ] `signal_gravity_health` surfaces calibration proposals.
- [ ] All existing executive brief tests remain green (`executiveBriefGenerator.test.ts`).
- [ ] All existing CNS gate tests remain green (`cnsActionGate.test.ts`).
- [ ] Minimum 10 new tests: brief with OKPs, empty brief, degraded mode, gravity breakdown, source refs visible, calibration health field, top signal selection, authority path in brief, L1 fallback score.

**Validation:**
```bash
npm test -- packages/gail-os-client/src/index.test.ts packages/graphify-client/src/index.test.ts
npm run typecheck
git diff --check
```

**Stop condition:** Stop before adding execution behavior, live M365 calls, persistent evidence storage outside GAIL OS, or self-authorization of any kind.

---

### Chunk 5.7 — CP-5 Dry-Run Proof (Dual Format)

**Repos:** `gail-ai-operating-system-rev-2`, `graphify-workspace-cockpit`, `the-freedom-engine-os`
**Platform:** cloud-safe (test suite proof)
**Prerequisites:** 5.2, 5.3, 5.4, 5.5, 5.6
**Unblocks:** Phase 6

**Objective:** Demonstrate one complete operating knowledge flow — source record to Graphify relationship to Freedom brief — with Signal Gravity visible and the Synaptic Proof Chain documented in both formats.

**Proof flow:**
```
Existing Phase 4 EvidencePacket (dry-run M365 Planner task)
  → EvidencePacketToOkpConverter → OperatingKnowledgePacket (evidence.created)
  → OkpStore.save() → gravity_score_l1 calculated
  → GraphifyClient.ingest() → entity_id + gravity_score_l2 (all 9 factors)
  → generateOperatingKnowledgeBrief() → OkpBrief with gravity breakdown
  → Synaptic Proof Chain machine-readable JSON
  → Synaptic Proof Chain markdown artifact
```

**Output artifacts:**
```
# Machine-readable (generated by test / stored to proof-chain endpoint):
Accessible via GET /api/cns/okp/{okp_id}/proof-chain

# Human-readable (generated by Freedom proof run):
docs/build-control/2026-06-28 - CP5 Synaptic Proof Chain.md
```

**Proof chain markdown structure:**
```markdown
# CP-5 Synaptic Proof Chain

## Source signal
[record type, source_system, source_ref, observed_at]

## Classification
[authority_level, autonomy_level, risk_tier, data_classification, fingerprint]

## OKP creation
[okp_id, status, created_at, gravity_score_l1, factor breakdown]

## Graphify ingestion
[entity_id, edge_count, relationships created, gravity_score_l2, factor breakdown]

## Freedom brief
[brief summary, top_signal, source_refs visible, recommendation, graphify_degraded]

## What the CNS knew
[source refs, related mission/evidence/connector IDs, confidence]

## What was unknown
[degraded or missing factors, N/A fields]

## Decision / non-decision
[action taken or not, evidence ref if any]

## Calibration note
[signal_gravity_health status]

---
Review note: if this proof chain format becomes document-heavy in live use, the
human-readable artifact frequency will be revisited. Machine-readable chain is
always produced per OKP.
```

**Acceptance criteria:**
- [ ] Synthetic or existing EvidencePacket converts to valid OKP.
- [ ] OKP is stored with L1 gravity score.
- [ ] OKP is ingested into Graphify with L2 gravity (all 9 factors scored).
- [ ] Freedom produces an OkpBrief using the OKP.
- [ ] Gravity score is visible and has per-factor breakdown.
- [ ] Source refs are visible in the brief.
- [ ] Synaptic Proof Chain machine-readable JSON is accessible.
- [ ] Synaptic Proof Chain markdown artifact is committed.
- [ ] No product repo changes.
- [ ] No live M365 write.
- [ ] No Supabase authority/evidence writes.
- [ ] All three repos' test suites pass.

**Validation:**
```
GAIL OS: python -m pytest tests/ -v
Graphify: python -m pytest tests/ -v
Freedom: npm test
Proof chain markdown artifact committed and readable
```

**CP-5 gate criteria:** Operating knowledge flows from source record → Graphify relationship → Freedom brief with Signal Gravity and Synaptic Proof Chain. **CP-5 CLOSED when this chunk passes.**

---

### Chunk 5.8 — Windows Graphify Extraction Status Update

**Repo:** `graphify-workspace-cockpit` + Windows extraction environment
**Platform:** windows-local
**Status:** Blocked until Windows operator action
**Objective:** Resolve or document BLK-004 — Windows GAIL OS and M365 Foundation repo extraction.

Does not block 5.2–5.7. Record outcome when available.

---

## 5. Phase 6 Execution Plan

Phase 6 begins after CP-5 is closed.

### Execution order

```
6.0  R4 Charter Doctrine                      cloud-safe
6.1  CharterProfile Schema                    cloud-safe
6.2  Graphify Charter Nodes                   cloud-safe   ← parallel with 6.3
6.3  Freedom Charter Discovery + Briefing     cloud-safe   ← parallel with 6.2
──────────────────────────────────────────────────────────
6.4  R4 Dry-Run Simulation                    mixed
──────────────────────────────────────────────────────────
6.5  R4 Limited Internal Execution            BLOCKED — explicit Adam approval required
```

---

### Chunk 6.0 — R4 Charter Doctrine

**Repo:** `gail-ai-operating-system-rev-2` (docs)
**Platform:** cloud-safe
**Prerequisites:** CP-5 closed
**Unblocks:** 6.1

**Output file:**
```
docs/decisions/2026-06-28 - R4 Charter Doctrine and First Internal Autonomy Candidate.md
```

**Required content:**
- R4 = delegated autonomous action under pre-approved charter. R5 = human-only.
- R4 requires: narrow scope, named target resources, max action count, expiry, stop conditions, rollback path, review cadence, evidence.
- First R4 candidate: `R4-001 — Graphify Stale Claim Review Charter`.
- Allowed: identify stale claims, mark as `review_required`, create evidence, produce rollback data, report to Freedom.
- Not allowed: delete graph nodes, modify client records, live M365 writes, alter authority levels, approve actions, suppress evidence, change product repos.
- Live M365 is excluded from first R4 charter.
- Simulation must happen before real mutation (6.4 before 6.5).

**Acceptance criteria:**
- [ ] R4/R5 distinction explicit.
- [ ] First R4 candidate documented with scope, exclusions, rollback.
- [ ] Charter doctrine fields enumerated (see Section 2.5).
- [ ] Document approved by — field left for Adam signature.

---

### Chunk 6.1 — CharterProfile Schema

**Repo:** `gail-ai-operating-system-rev-2`
**Platform:** cloud-safe
**Prerequisites:** 6.0
**Unblocks:** 6.2, 6.3, 6.4

**Output files:**
```
packages/uaos-core/src/gail_ai_operating_system/charter_profile.py
tests/test_charter_profile.py
```

**Key implementation notes:**
- `CharterProfile` Pydantic model with all fields from Section 2.5.
- Charter cannot grant R5 (raise `ValueError`).
- Charter cannot exceed associated connector or agent permissions.
- `charter_id`: "charter-" prefix.
- `expiry`: required for R4; validate not in past.
- `stop_conditions`: required non-empty list for R4.
- `rollback_path`: required non-empty string for R4.
- Links to `AuthorityEnvelope` via reference (not embedded).
- Expired charter validation: `is_expired()` method.
- Invalid charter raises `ValueError` with clear message.
- Update package exports.

**Acceptance criteria:**
- [ ] `CharterProfile` schema exists with all required fields.
- [ ] R4 charter requires stop conditions, rollback, max actions, expiry.
- [ ] R5 grant raises `ValueError`.
- [ ] Expired charter fails `is_expired()` check.
- [ ] Minimum 12 tests.

---

### Chunk 6.2 — Graphify Charter Nodes

**Repo:** `graphify-workspace-cockpit`
**Platform:** cloud-safe
**Prerequisites:** 6.1
**Parallel with:** 6.3
**Unblocks:** 6.4

**Output files:**
```
cns_store/charter_writer.py
cns_api/routes/charters.py
tests/test_charter_writer.py
tests/test_charter_api.py
```

**Acceptance criteria:**
- [ ] Charter node type in graph store.
- [ ] Charter edges to mission, agent, evidence, source refs, OKPs, affected nodes.
- [ ] Charter execution records visible as graph edges.
- [ ] Graphify gains no approval or execution authority.
- [ ] `POST /api/cns/charters` — ingest charter.
- [ ] `GET /api/cns/charters/{charter_id}` — retrieve charter context.
- [ ] Minimum 10 tests.

---

### Chunk 6.3 — Freedom Charter Discovery + Briefing

**Repo:** `the-freedom-engine-os`
**Platform:** cloud-safe
**Prerequisites:** 6.1
**Parallel with:** 6.2
**Unblocks:** 6.4

**Objective:** Freedom can list active charters, explain their scope, and incorporate charter status into executive briefs and CNS gate output.

**Acceptance criteria:**
- [ ] `GailOsClient.listCharters()` and `getCharter(charterId)`.
- [ ] Freedom executive brief includes `charter_context` section.
- [ ] Freedom can explain why an action is: permitted (in charter), pending (awaiting charter), blocked (outside charter), or not-chartered.
- [ ] Freedom cannot self-approve charter changes.
- [ ] Operator sees charter status in gate output.
- [ ] Existing executive brief and CNS gate tests remain green.
- [ ] Minimum 8 new tests.

---

### Chunk 6.4 — R4 Dry-Run Simulation

**Repos:** All three active CNS code repos
**Platform:** mixed
**Prerequisites:** 6.1, 6.2, 6.3
**Unblocks:** 6.5 (after Adam approval)

**Objective:** Simulate Graphify stale-claim charter R4-001 without mutating production graph state. Produce evidence, rollback data, and Freedom summary.

**Proof flow:**
```
Synthetic stale claim candidates (from controlled graph data)
  → GAIL OS validates charter authority (R4-001 scope check)
  → Simulation run: mark candidates as review_required (dry-run only)
  → EvidencePacket generated
  → OKP created (record_type=charter.executed, status=observed)
  → Graphify preview: shows intended changes without committing
  → Freedom brief: charter execution summary
  → Rollback data: list of claim IDs + prior status
```

**Acceptance criteria:**
- [ ] Stale claim candidates identified.
- [ ] GAIL OS charter authority validated.
- [ ] Dry-run execution — no real graph mutations.
- [ ] EvidencePacket produced.
- [ ] OKP of type `charter.executed` created.
- [ ] Graphify preview visible without commit.
- [ ] Rollback data generated.
- [ ] Freedom produces charter execution brief.
- [ ] No live mutation.
- [ ] No product repo changes.
- [ ] No live M365 calls.

---

### Chunk 6.5 — R4 Limited Internal Execution

**Status:** BLOCKED — explicit Adam approval required before starting.

**Prerequisites:** 6.4 passed + Adam explicit approval.

**Scope:** Execute charter R4-001 for real. Narrow. Reversible. Evidenced. Graphify only. No M365. No product repos.

**Stop conditions (hard stops during execution):**
- Charter scope becomes unclear → stop.
- Mutation target outside charter → stop.
- Rollback fails → stop.
- Evidence creation fails → stop.
- Max action count reached → stop.

Do not begin this chunk on agent judgment. Adam approval is the gate.

---

## 6. Risk Register

| Risk | Severity | Control |
|---|---|---|
| Product repo scope creep returns | High | Four-core-repo boundary locked; branch abandonment notes done |
| Dry-run M365 treated as live authority | High | CP-4 relabelled; M365 status ladder enforced |
| OKP becomes accidental EvidencePacket replacement | High | EvidencePacket unchanged; OKP wraps it via converter |
| Graphify gains approval authority | High | Graphify is relationship intelligence only; no approval endpoints |
| Freedom self-authorizes | High | Freedom proposes; GAIL OS validates |
| Supabase becomes evidence ledger | High | GAIL OS owns evidence and OKP store |
| Signal Gravity weight drift (unreviewed) | Medium/High | Calibration proposals require Adam review above ±0.05/factor |
| R4 jumps to live M365 | High | First R4 is internal Graphify only |
| Context poisoning via OKP ingest | High | Source ref validation; unsafe content rejection; data_classification required |
| MCP/connector boundary erosion | Medium/High | Allowlist, sandbox, provenance, identity, logging via connector registry |
| Synaptic Proof Chain becomes doc burden | Medium | Review note in CP-5 format; Adam will revisit if needed |
| Windows Graphify extraction undone | Medium | BLK-004 tracked; does not block 5.2–5.7 |
| Abandoned product branches accidentally PRed | Medium | Note-only; no PRs; check before 5.1 |
| Supabase RLS | Closed | H5/H5-apply complete: 21 legacy public tables covered; hosted migration applied 2026-06-28 with 0 new policies. |

---

## 7. Open Blockers

| ID | Item | Status | Required action |
|---|---|---|---|
| BLK-004 | Windows Enhanced Graphify extraction | Queued-secondary | Adam / Windows operator: run extraction on GAIL OS + M365 repos, push graph.json when useful. Not a hot-path blocker for Freedom capability work. |
| BLK-005 | M365 Azure Entra app registration | Closed | App registration and expanded scopes confirmed 2026-06-28; live writes remain gated by named approval. |
| SUPABASE-RLS | 21 public Freedom Supabase tables | Closed | Hosted RLS migration applied 2026-06-28. |
| R4-FIRST | First R4 charter | Complete | R4-001 Graphify stale claim review selected, simulated, and executed. |
| PHASE6-GATE | 6.5 execution approval | Complete | Adam approval received; Phase 6.5 complete. |

---

## 8. Definition of Done

### Phase 5 complete when:
- Turnover corrections and board reconciliation done (5.0).
- Product branch abandonment notes complete or all branches documented as absent (5.1).
- OKP schema with all 18 record types exists and tests pass (5.2).
- EvidencePacket-to-OKP converter works and tests pass (5.2).
- OKP ingest service + Signal Gravity L1 + calibration protocol exist and tests pass (5.3).
- Graphify OKP nodes + Signal Gravity L2 (all 9 factors) exist and tests pass (5.4).
- M365 source surface map documented with BLK-005 status updated (5.5).
- Freedom OKP brief with gravity score and degraded-mode fallback exists and tests pass (5.6).
- CP-5 proof: one operating knowledge flow demonstrated end-to-end; both proof chain formats committed (5.7).
- No product repos modified (except abandonment notes).
- No live M365 write occurred unless separately approved and recorded.

### Phase 6 dry-run complete when:
- R4 doctrine documented (6.0).
- CharterProfile schema exists and tests pass (6.1).
- Graphify charter nodes exist and tests pass (6.2).
- Freedom charter briefing exists and tests pass (6.3).
- R4 stale-claim simulation produces evidence and rollback data (6.4).
- No live graph mutation before 6.5 approval.

### Phase 6 execution complete when (gated by Adam):
- Adam approves 6.5.
- One narrow internal R4 charter action executes.
- Evidence exists.
- Rollback path exists and is tested.
- Freedom produces post-run brief.
- Graphify updates are within charter scope.
- No live M365 action.

---

## 9. Agent Execution Rules

### Per-chunk loop
1. Read this document.
2. Read target repo `AGENTS.md`.
3. `git status --short`.
4. Execute only the named chunk's scope.
5. Validate (run tests, typecheck, diff check, secret scan).
6. Commit with clear message referencing chunk number.
7. Push.
8. Write repo report (see template below).
9. Update master ledger.
10. Apply Non-Disruptive Context Reset Rule (see `docs/standards/context-hygiene-standard.md`) at natural pause gates.

### Repo report template
```markdown
# Repo Report — <repo>

Date: YYYY-MM-DD
Chunk: <chunk number and name>
Status: complete | blocked | partial

## What changed
## Files changed
## Validation (test counts, typecheck, diff check)
## What was deliberately not changed
## Risks / blockers
## Commit / push evidence
## Next action
```

### What to do when a Signal Gravity factor is unclear
Do not guess. Write a `CalibrationProposal` via `SignalGravityL1Calculator.propose_calibration()` with a clear rationale. Surface it in the next Freedom brief's `signal_gravity_health` field. If the factor blocks proceeding, create a `CapabilityGapRecord` and flag to Adam.

### What to do when uncertain about scope
Stop at the current chunk's stop condition. Do not expand into the next chunk without confirming prerequisites are met.

### Secrets
Never print, commit, or log: `.env` contents, GAIL_OS_API_KEY, AZURE_CLIENT_ID/SECRET/TENANT_ID, Supabase keys, any credential pattern. Stop immediately if a scan finds a potential secret in a diff.
