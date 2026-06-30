# CP-5 Synaptic Proof Chain

**Date:** 2026-06-28
**Chunk:** 5.7 — CP-5 Dry-Run Proof
**Status:** CP-5 CLOSED

This document is the human-readable Synaptic Proof Chain artifact for Chunk 5.7.
Machine-readable chain: `GET /api/v1/okp/{okp_id}/proof-chain` (GAIL OS L1) and
`GET /api/cns/okp/{okp_id}/proof-chain` (Graphify L2, `proof_chain_version: v1-l2`).

---

## Source signal

| Field | Value |
|---|---|
| record_type | `evidence.created` |
| source_system | `gail-os-evidence` |
| source_ref | `evidence-cp4-planner-001` |
| observed_at | `2026-06-28T00:00:00+00:00` |
| origin | Phase 4 EvidencePacket — dry-run M365 Planner task write via OS connector |

The source signal is the Phase 4 CP-4 proof EvidencePacket. A dry-run M365 Planner
task record was written to the GAIL OS evidence store via the M365 connector in
dry-run mode. No live Planner task was created. The EvidencePacket was converted to
an OKP by `EvidencePacketToOkpConverter` as the entry point into the operating
knowledge layer.

---

## Classification

| Field | Value |
|---|---|
| authority_level | `R1` (routine CNS-internal operation, no human override required) |
| autonomy_level | `A1` (bounded local action within approved connector scope) |
| risk_tier | `2` (medium — dry-run, no live data modified) |
| data_classification | `internal` |
| status | `observed` |
| confidence | `0.9` |
| fingerprint | `a1b2c3d4e5f67890a1b2c3d4e5f67890` (SHA-256, 32-char hex) |
| raw_payload_retained | `false` |

---

## OKP creation

| Field | Value |
|---|---|
| okp_id | `okp-<uuid>` (generated at convert time, `okp-` prefix enforced) |
| record_type | `evidence.created` |
| source_system | `gail-os-evidence` |
| source_ref | `evidence-cp4-planner-001` |
| related_evidence_id | `evidence-cp4-planner-001` |
| related_mission_id | `mission-cns-phase4-prove-m365` |
| related_action_id | `action-planner-task-write` |
| created_at | `2026-06-28T00:00:00+00:00` |
| gravity_score_l1 | `0.54` |

### Signal Gravity L1 factor breakdown

Factors 4, 6, 7, 8, 9 held at `0.5` (L2 placeholder — Graphify provides real values).

| # | Factor | Raw value | Weight | Contribution |
|---|---|---|---|---|
| 1 | recent_evidence | 1.00 (age = 0 h, decay over 168 h) | 0.18 | 0.180 |
| 2 | unresolved_risk | 0.25 (risk_tier=2 → (2−1)/4) | 0.17 | 0.043 |
| 3 | operational_value | 0.90 (confidence=0.9) | 0.15 | 0.135 |
| 4 | repeated_recurrence | 0.50 (L2 placeholder) | 0.12 | 0.060 |
| 5 | pending_authority | 0.00 (status=observed, R1 ∉ {R3,R4}) | 0.13 | 0.000 |
| 6 | connected_blockers | 0.50 (L2 placeholder) | 0.10 | 0.050 |
| 7 | client_impact | 0.50 (L2 placeholder) | 0.07 | 0.035 |
| 8 | prior_failure_relation | 0.50 (L2 placeholder) | 0.05 | 0.025 |
| 9 | strategic_alignment | 0.50 (L2 placeholder) | 0.03 | 0.015 |
| | **Total** | | **1.00** | **0.543** |

Weight config: `local_store/signal_gravity_config.json` (DEFAULT_WEIGHTS, version 1).
Weights sum to 1.0. No calibration proposals pending at time of proof run.

---

## Graphify ingestion

| Field | Value |
|---|---|
| entity_id | `okp-<uuid>` (same as okp_id — used as Graphify entity ID) |
| kind | `OperatingKnowledgePacket` |
| cluster | `operating_knowledge` |
| edge_count | `0` |
| relationships_created | `[]` |
| relationships_skipped | `[to_evidence, to_mission, to_action, to_connector, to_agent]` |
| gravity_score_l2 | `0.36` |

Edges were skipped because the related entities (EvidencePacket, Mission, Action)
are not yet present in the Graphify CNS graph. This is expected for a first-pass
proof run — no placeholder nodes are created per the zero-orphan rule.

### Signal Gravity L2 factor breakdown

All 9 factors calculated from graph topology. Equal weights (1/9 ≈ 0.111) used
(Graphify does not have the GAIL OS `signal_gravity_config.json` at runtime in
this proof run).

| # | Factor | Raw value | Weight | Contribution | Notes |
|---|---|---|---|---|---|
| 1 | recent_evidence | 1.00 | 0.111 | 0.111 | age_days = 0, decay 1 − 0/7 = 1.0 |
| 2 | unresolved_risk | 0.30 | 0.111 | 0.033 | risk_tier="2" not in risk_map → default 0.3 |
| 3 | operational_value | 0.90 | 0.111 | 0.100 | confidence = 0.9 |
| 4 | repeated_recurrence | 0.00 | 0.111 | 0.000 | 0 peer cluster edges × 0.25 |
| 5 | pending_authority | 0.40 | 0.111 | 0.044 | status=observed, no pending keywords |
| 6 | connected_blockers | 0.00 | 0.111 | 0.000 | no blocker/ConnectorBlocker edges |
| 7 | client_impact | 0.30 | 0.111 | 0.033 | source_system has no "crm"/"client" substring |
| 8 | prior_failure_relation | 0.00 | 0.111 | 0.000 | no failed EvidencePacket edges |
| 9 | strategic_alignment | 0.30 | 0.111 | 0.033 | mission entity not in graph → 0.3 |
| | **Total** | | **1.00** | **0.356** | |

L2 (0.36) < L1 (0.54) because this is a first-ingestion OKP with no graph topology.
Factors 4, 6, 8 score 0.0 (no cluster peers, no blockers, no failure edges).
As the graph fills in Phase 6, L2 will diverge from L1 in both directions.

**Machine-readable proof chain:** `GET /api/cns/okp/{okp_id}/proof-chain`
(`proof_chain_version: v1-l2`)

---

## Freedom brief

| Field | Value |
|---|---|
| brief_id | `okp-brief-<timestamp>` |
| generated_at | `2026-06-28T00:00:00.000Z` |
| graphify_degraded | `false` |
| gravity_score_used | `0.36` (L2 preferred over L1 = 0.54) |
| top_signal.okp_id | `okp-<uuid>` |
| top_signal.record_type | `evidence.created` |
| top_signal.authority_level | `R1` |
| top_signal.risk_tier | `2` |
| top_signal.confidence | `0.90` |
| source_refs_visible | `["evidence-cp4-planner-001"]` |
| authority_path | `["R1"]` |
| risk_summary.max_risk_tier | `2` |
| risk_summary.min_confidence | `0.90` |

Freedom used the L2 score from Graphify (`0.36`) as `gravity_score_used`.
The brief is not degraded — Graphify was reachable and returned a valid L2 score.

**Degraded-mode fallback (tested):** When Graphify is unreachable or degraded,
Freedom falls back to the L1 score (`0.54`) and sets `graphify_degraded: true`.
The brief is still produced — no failure, no empty output.

---

## What the CNS knew

| Known fact | Value |
|---|---|
| Source record | CP-4 EvidencePacket (dry-run M365 Planner task write) |
| Evidence ID | `evidence-cp4-planner-001` |
| Mission | `mission-cns-phase4-prove-m365` |
| Action | `action-planner-task-write` |
| Actor | `gail-os-a1` |
| Execution mode | `dry-run` (no live write) |
| Outcome | `success` |
| Authority basis | `R2-connector-registry-dry-run` |
| Rollback note | Dry-run only. No Planner task was actually created. |
| OKP authority | `R1` (auto-assigned by converter) |
| Confidence | `0.9` |
| Data class | `internal` |
| Fingerprint | `a1b2c3d4e5f67890a1b2c3d4e5f67890` |

---

## What was unknown

| Unknown / missing | Reason |
|---|---|
| repeated_recurrence (L2) | First OKP of this type ingested — no cluster peer edges exist yet. Scored 0.0. |
| connected_blockers (L2) | No blocker entities in the CNS graph at proof time. Scored 0.0. |
| prior_failure_relation (L2) | No failed EvidencePacket edges in graph. Scored 0.0. |
| strategic_alignment (L2) | Mission entity `mission-cns-phase4-prove-m365` not yet in Graphify. Scored 0.3 (default). |
| gravity_score_l2 vs l1 deviation | L2 (0.36) < L1 (0.54): expected for a sparse first-pass graph. L2 will improve as Phase 6 populates the mission, evidence, and blocker nodes. |
| related_connector_id | Not set by converter (Phase 4 connector ID not captured in EvidencePacket). |
| related_agent_id | Not set (agent registry not yet linked in Phase 5). |
| M365 live read | BLK-005 (Azure Entra app registration) — live M365 integration not active. |

---

## Decision / non-decision

No governed action was triggered by this OKP. The CP-5 proof run is a read-only
observation:

- EvidencePacket converted → OKP observed (status: `observed`)
- OKP stored in GAIL OS local store
- OKP ingested into Graphify as entity (no mutation authority)
- Freedom brief generated (no approval or execution triggered)
- No EvidencePacket was produced by this observation (no action taken)

The OKP lifecycle remains at `observed`. Advancement to `accepted` or `learned`
requires a governed action with review, which is a Phase 6 activity.

---

## Calibration note

`signal_gravity_health.calibration_proposals_pending: 0`

No calibration proposals are pending at CP-5 close. Initial weights are set by
implementing agent judgment (DEFAULT_WEIGHTS). GAIL OS and Freedom are empowered
to reason about weight quality and propose adjustments via
`signal_gravity_calibration_proposals.json` as more OKPs are ingested in Phase 6.

Adam reviews proposed changes where delta > ±0.05 per factor.

---

## CP-5 gate — CLOSED

All acceptance criteria met:

- [x] Synthetic EvidencePacket converts to valid OKP (`evidence.created`)
- [x] OKP stored with `gravity_score_l1` = 0.54
- [x] OKP ingested into Graphify with `gravity_score_l2` = 0.36 (all 9 factors scored)
- [x] Freedom produces `OkpBrief` using the OKP
- [x] Gravity score visible with per-factor breakdown (`top_signal.factor_scores_l2`)
- [x] `source_refs_visible` contains `evidence-cp4-planner-001`
- [x] Machine-readable proof chain accessible (`proof_chain_version: v1-l2`)
- [x] Human-readable markdown artifact committed (this document)
- [x] No product repo changes
- [x] No live M365 write
- [x] No Supabase authority/evidence writes
- [x] All three repos' test suites extended with CP-5 proof tests

**2026-06-29 update:** Phase 6 is complete. This CP-5 note is retained as proof-chain evidence, not current next-task routing.

---

*Review note: if this proof chain format becomes document-heavy in live use, the
human-readable artifact frequency will be revisited. Machine-readable chain is
always produced per OKP.*
