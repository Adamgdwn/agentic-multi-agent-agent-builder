# Phase 5 and Phase 6 Reset Decision

**Date:** 2026-06-28
**Author:** Build Agent Orchestrator (Chunk 5.0)
**Status:** Locked
**Approved by:** Adam Goodwin (verbal, 2026-06-28 session)

---

## Context

After CP-4 was proven (dry-run M365 Planner task write with OS evidence and Graphify update), the build agent began Phase 5 work by interpreting the workstream board literally. The board listed six product repos as the Phase 5 implementation targets. This was a scoping error. Adam stopped the work and confirmed the correct direction.

This document locks the corrected Phase 5 and Phase 6 direction and supersedes the prior Phase 5/6 workstream board rows and the forward-looking sections of the Phase 0–4 complete turnover document.

---

## Phase 5 Reset

### New Name
**Phase 5 — Operating Knowledge Intake and Relationship Mesh**

(Prior name: "Product App + Website Integration" — retired.)

### Architecture: Modified Option B

GAIL OS and Graphify ingest controlled operating knowledge from internal CNS sources only.

- No product repo polling.
- No product repo code injection.
- No external event-emitter code in product repos.
- No CNS-to-product integration in Phase 5.

Product repos (guided-ai-journey, oldskoolai.com, bowtie_risk_program, change-leadership-tools, clean-pdf-build, guided-ai-labs-website) are sensory and product circuits. They are not current implementation targets for CNS event-emitter code.

### Four-Repo Boundary (Non-Negotiable)

All Phase 5/6 implementation work stays inside these four repos:

```
Adamgdwn/gail-ai-operating-system-rev-2      (Python / FastAPI / Windows)
Adamgdwn/the-freedom-engine-os               (TypeScript / Next.js / Linux)
Adamgdwn/graphify-workspace-cockpit          (Python / FastAPI + SQLite / Linux)
Adamgdwn/ag-operations-m365-foundation       (Docs / planning / Windows)
```

Product repos may be touched **only** for Chunk 5.1 abandonment notes (docs only, no PRs, no main changes).

### Product Branch Abandonment

Six product repo branches were created in error during the Phase 5 misinterpretation. They have no PRs and no main-branch contamination. They are being marked abandoned via Chunk 5.1. Do not continue these branches without explicit Adam authorization.

Branches:
```
guided-ai-journey-website-and-tools  phase5/5.1-5.7-gai-journey-events
oldskoolai.com                       phase5/5.2-5.8-oldskool-events
bowtie_risk_program                  phase5/5.3-bowtie-events
change-leadership-tools              phase5/5.4-change-leadership-events
clean-pdf-build                      phase5/5.5-easydraft-events
guided-ai-labs-website               phase5/5.6-gail-labs-events
```

---

## Locked Technical Decisions

### OKP / EvidencePacket Relationship

- **OKP wraps EvidencePacket.** EvidencePacket is unchanged (schema, store, and API from Phase 4 PRs #17–#18 remain untouched).
- Every EvidencePacket auto-converts to an `OperatingKnowledgePacket` of type `evidence.created` via `EvidencePacketToOkpConverter`.
- OKP adds: authority/autonomy classification (R0–R5, A0–A6), Signal Gravity score, data classification, fingerprint, OKP lifecycle, and optional links to mission/action/evidence/connector/agent.
- `related_evidence_id` is populated on any OKP that wraps an EvidencePacket.

### Signal Gravity

- **Real implementation in Phase 5.** All 9 factors required. No stub, no deferred placeholder.
- Two layers: L1 (GAIL OS, metadata-based, at ingest), L2 (Graphify, graph-topology, post-ingest).
- Freedom uses L2 if available, falls back to L1.
- **GAIL OS and Freedom own the weight configuration.** They reason through adjustments autonomously. Weights are stored in `signal_gravity_config.json`.
- Calibration proposals are written to `signal_gravity_calibration_proposals.json` and surfaced in the Freedom brief `signal_gravity_health` field.
- Adam reviews changes where the proposed delta exceeds ±0.05 per factor.
- Weights must sum to 1.0.

### OKP Record Types

- **All 18 record types defined and validated at launch** (closed enum, no additions by implementing agents without a decision doc update).
- See the full enum in `docs/build-control/2026-06-28 - cns-phase5-phase6-build-specification.md` §3.2.

### Synaptic Proof Chain

- **Dual format.** Machine-readable JSON is always produced per OKP (accessible via `GET /api/cns/okp/{okp_id}/proof-chain`). Human-readable markdown is committed as a docs artifact at CP-5 and for significant OKPs.
- Review note: if the human-readable artifact becomes document-heavy in live use, Adam will readdress the format and frequency.

### CNS Naming

- **Central Nervous System** throughout. Never "Cognitive Nervous System."

### CP-4 Framing

- CP-4 is **dry-run M365 execution proof only.** Live M365 is not active.
- M365 status ladder: `pending → proven → approved → active`. CP-4 = proven. Active requires BLK-005 (Entra app registration by Adam/Windows) + named scope + explicit approval.
- A live dry-run test is not permission for live writes.

---

## Phase 6 Reset

### Gate

Phase 6 begins only after CP-5 is closed.

### First R4 Charter

`R4-001 — Graphify Stale Claim Review Charter`

**Allowed:**
- Identify stale relationship/research claims (graph age + confidence analysis)
- Mark stale claims as `review_required` in the graph store
- Create an EvidencePacket for each marking action
- Produce rollback data (list of claim IDs + prior status)
- Report to Freedom via OkpBrief

**Not allowed (explicit exclusions):**
- Delete graph nodes
- Modify client records
- Live M365 writes
- Alter authority levels on any OKP or EvidencePacket
- Approve actions
- Suppress evidence
- Change product repos

**Simulation before mutation:** Chunk 6.4 (dry-run simulation) must be proven before Chunk 6.5 (limited internal execution).

### Phase 6.5 Gate

**2026-06-29 update:** This gate closed on 2026-06-28. Adam explicitly approved Chunk 6.5, and R4 limited internal execution completed. The original rule remains the precedent for future R4/R5-adjacent work: no live autonomous execution begins without explicit named approval.

---

## Workstream Board Corrections

### Phase 1 GAIL OS Task State

Tasks 1.1–1.5 in the workstream board were listed as `independent` (not started). This was stale. Per git log and the handoff-state Phase 1 completion entries, these are all complete:

| Task | Status | Evidence |
|---|---|---|
| 1.1 Mission schema | complete | GAIL OS PR #4 merged 2026-06-27 |
| 1.2 Action + state machine | complete | GAIL OS PR #7 merged 2026-06-28 |
| 1.3 AuthorityEnvelope | complete | GAIL OS PR #5 merged 2026-06-27 |
| 1.4 EvidencePacket | complete | GAIL OS PR #6 merged 2026-06-27 |
| 1.5 Connector registry | complete | GAIL OS PR #11 merged 2026-06-28 |

**CP-1 proven:** 4/4 integration tests against live GAIL OS server via direct Windows-Linux cable link (Freedom PR #27, merged 2026-06-28).

### Phase 1 Task 1.7 Reconciliation

Task 1.7 (canonical event vocabulary as TypeScript types) was listed for `gail-ai-operating-system-rev-2`. Freedom PR #33 merged TypeScript event types into `the-freedom-engine-os`. Both satisfy different needs:
- Freedom PR #33: TypeScript wire types — satisfied the TypeScript contract side.
- GAIL OS Python-side `OkpRecordType` enum: addressed in Chunk 5.2 (part of the OKP schema).

Board updated to reflect this split.

---

## Reference

Full Phase 5 and Phase 6 execution plan (all chunks with specs, acceptance criteria, validation, stop conditions):

`docs/build-control/2026-06-28 - cns-phase5-phase6-build-specification.md`

This document supersedes for Phase 5/6 planning purposes:
- The GPT Pro directive `2026-06-28 - Phase 5 Phase 6 CNS Planning and Execution Directive.md`
- Forward-looking Phase 5/6 sections of `2026-06-28 - cns-phase0-phase4-complete-turnover.md`
- Prior Phase 5 product-repo rows in `repo-workstream-board.md`
