# Master Plan Summary — Guided AI Labs Agentic OS CNS

**Version:** 1.0
**Date:** 2026-06-25
**Source:** `guided_ai_labs_agentic_os_cns_master_architecture.md`
**Owner:** Adam Goodwin
**Orchestration home:** `agentic-multi-agent-agent-builder`

---

## 1. What This Is

The **Guided AI Labs Agentic OS CNS** is the internal architecture name for an agentic operating system that lets AI partners observe, reason, act, learn, and improve inside governed authority boundaries. External market name: **Guided AI Labs Agentic Operating System**.

This is not an AI chatbot, dashboard, or workflow automation project. It is a management, governance, memory, relationship-intelligence, and execution architecture for organizations that want AI partners as coordinated operating capacity rather than scattered tools.

---

## 2. The Three Agentic Core Layers

| Layer | CNS Analogy | Role | Primary Repo |
|---|---|---|---|
| **Freedom** | Prefrontal cortex / executive cognition | Reasons, prioritizes, plans, explains, delegates, orchestrates agents, requests authority, acts as executive AI business partner | `the-freedom-engine-os` (Linux) |
| **Guided AI Labs Operating System** | Midbrain / autonomic management | Authority envelopes, risk classification, evidence ledger, action state machine, connector + agent registries, policy gate, escalation | `gail-ai-operating-system-rev-2` (Windows) |
| **Graphify** | Connectome / association cortex | Relationship intelligence, dependency maps, context routing, research ingestion, memory indexing | `graphify-workspace-cockpit` (Linux) + Enhanced Graphify (Windows) |

Everything else (websites, M365, product apps, third-party tools) is the body, sensory system, or motor system around this core.

---

## 3. Repo Inventory

### CNS Core

| Repo | GitHub | Platform | CNS Layer | Status |
|---|---|---|---|---|
| `the-freedom-engine-os` | `Adamgdwn/the-freedom-engine-os` | Linux | Freedom | V1 scaffold, Next.js 16 monorepo, Supabase linked (`basbwglynuyfxcqxfyur`) |
| `gail-ai-operating-system-rev-2` | `Adamgdwn/gail-ai-operating-system-rev-2` | Windows | GAIL OS | Rev 2, active planning + implementation, TypeScript monorepo |
| `graphify-workspace-cockpit` | `Adamgdwn/graphify-workspace-cockpit` | Linux (primary) + Windows (Enhanced) | Graphify | FastAPI + React, decision cockpit, "second video ready" |
| `ag-operations-m365-foundation` | `Adamgdwn/ag-operations-m365-foundation` | Windows (planning docs) | M365 Foundation | Stages 1–9 documented, agentic bridge readiness in Stage 9 |

### Product Apps / Circuits

| Repo | GitHub | Platform | CNS Role |
|---|---|---|---|
| `guided-ai-journey-website-and-tools` | `Adamgdwn/guided-ai-journey-website-and-tools` | Linux | Diagnostic sensory + readiness pathway |
| `oldskoolai.com` | `Adamgdwn/oldskoolai.com` | Linux | Learning + capability signal layer |
| `bowtie_risk_program` | `Adamgdwn/bowtie_risk_program` | Linux | Risk + control modelling circuit |
| `change-leadership-tools` | `Adamgdwn/change-leadership-tools` | TBD | Adoption + organizational change circuit |
| `clean-pdf-build` | `Adamgdwn/clean-pdf-build` | Linux | Document-production motor circuit (EasyDraft Docs) |
| `guided-ai-labs-website` | `Adamgdwn/guided-ai-labs-website` | Linux | Front door + commercial signal |

### Support / Infrastructure

| Repo | GitHub | Platform | Role |
|---|---|---|---|
| `agentic-multi-agent-agent-builder` | (this repo) | Linux | Build orchestration + coordination control plane |
| `guided-ai-labs-funding-and-benefits` | `Adamgdwn/guided-ai-labs-funding-and-benefits` | Linux | Business infrastructure |

### Superseded / Reference

| Repo | Status |
|---|---|
| `user-ai-operating-system` (Linux) | Superseded by GAIL OS Rev 2 as of 2026-06-21. Reference only. |

---

## 4. Governance Model

### Authority Ladder R0–R5

| Level | Name | Meaning |
|---:|---|---|
| R0 | Observe | Read-only, no external effect |
| R1 | Propose | Draft, recommend, prepare — no external effect |
| R2 | Internal approved action | Reversible internal write with named approval |
| R3 | Restricted action | External send, production release, irreversible change |
| R4 | Delegated autonomous restricted action | Inside a valid pre-approved authority charter |
| R5 | Blocked / human-only | Agent may analyze only; human decides |

### Autonomy Maturity Ladder A0–A6

A0 (Manual) → A1 (Assisted) → A2 (Supervised) → A3 (Delegated narrow) → A4 (Adaptive) → A5 (Self-expanding under strict governance) → A6 (Minimal governance — future state, not current authority)

### Mandatory Action State Machine

`observed → proposed → classified → approval_requested → approved/rejected → claimed → executed/stopped → evidenced → reviewed → learned`

---

## 5. Canonical Object Model

`Signal`, `Mission`, `Action`, `AuthorityEnvelope`, `Approval`, `EvidencePacket`, `Agent`, `Capability`, `Connector`, `SourceRef`, `GraphNode`, `GraphEdge`, `ResearchClaim`, `Evaluation`, `LearningUpdate`

---

## 6. Phased Build Plan

| Phase | Name | Primary Objective |
|---:|---|---|
| 0 | Architecture doctrine + contract consolidation | Lock CNS model, R/A ladders, object model, source-of-truth ownership. All repos aligned. |
| 1 | Core operating spine | Mission state, authority envelope, evidence packet, connector + agent registry, event contracts |
| 2 | Graphify core promotion | Graphify as relationship intelligence: maps clients, workflows, repos, agents, source refs, risks, evidence, research |
| 3 | Freedom operating cognition | Connect Freedom to mission state, Graphify context, authority requests, agent routing, briefings |
| 4 | M365 first-class execution lane | Governed M365 writeback with source refs and evidence through the OS |
| 5 | Product app + website integration | GAI Journey, OldSkoolAI, Bowtie, Change Leadership, EasyDraft, websites emit/consume structured events |
| 6 | Delegated R4 autonomy | First R4 charter: narrow, useful, restricted action with evidence and review |
| 7 | Recursive learning loop | Outcomes → memory, graph, SOP, capability proposals |
| 8 | Client-ready operating package | Packaged for enterprise onboarding, governance review, M365 path, training, support |
| 9 | R&D edge | A5/A6, future learning methods, formal eval loops, advanced agentic research |

---

## 7. Non-Negotiable Architecture Rules (Summary)

1. No single-axis brain language — Freedom, GAIL OS, Graphify are all three core layers.
2. No unmanaged write path — classify, authorize, bridge, evidence.
3. No hidden autonomy — R-level and A-level always visible.
4. No R4 without a charter.
5. No R5 execution by agents.
6. No duplicate source of truth.
7. No raw secret import.
8. No unregistered agents.
9. No governance-as-handbrake framing — OS enables autonomy.
10. No A6 as current production authority.

---

## 8. Graphify Cross-Machine Decision (RESOLVED 2026-06-25)

**Decision:** Single canonical graph, Linux as primary authority, Windows Enhanced Graphify as extraction/ingestion node.

| Component | Machine | Role |
|---|---|---|
| `graphify-workspace-cockpit` | Linux (primary) | Visualization, query, decision surface, API endpoint for CNS queries |
| Enhanced Graphify | Windows | Extraction over Windows repos (GAIL OS Rev 2, M365 Foundation, AG Operations Workspace). Pushes graph data via GitHub sync. |
| Workspace graph | GitHub | Single source of truth for `graph.json`. Both machines pull/push via git. |
| Future Graphify API | Cloud (Phase 2+) | Shared Graphify service endpoint that Freedom and the OS query. Cockpit becomes admin/visualization layer. |

**Rationale:** Prevents graph fragmentation. Linux cockpit is already at "second video ready" maturity. Windows Enhanced Graphify handles Windows-native file extraction that Linux cannot run natively.

---

## 9. Infrastructure References

- Supabase Org: `gudzhmrtcbxfvteqtasbgud`
- Vercel Team: `21VBttxDbchYqj9JvgxZdZ2R`
- Stripe Account: `acct_1T1Y9aRZGqjtWEPT`
- Cloudflare Account: `f17bf3b09810d3ba4d82008c6af77dc2`
- Freedom Supabase Project: `basbwglynuyfxcqxfyur` (West US / Oregon)
- Master env file: `/home/adamgoodwin/code/.env.master` (Linux, never commit)

---

## 10. Build Orchestration Home

This repo (`agentic-multi-agent-agent-builder`) is the cross-repo coordination layer. All build control artifacts live in `docs/build-control/`. GitHub is the primary cross-machine coordination transport. Direct link (Windows/Linux cable) is last resort only.
