# Decisions Log — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-25
**Owner:** Build Agent Orchestrator

Add a row for every meaningful architecture, design, or contract decision. Include the date, decision, rationale, and affected repos. Do not delete rows — mark superseded decisions as SUPERSEDED.

---

## Format

| Field | What to record |
|---|---|
| **ID** | DEC-NNN |
| **Date** | YYYY-MM-DD |
| **Decision** | What was decided, stated as a fact |
| **Rationale** | Why — constraint, evidence, tradeoff, or master plan mandate |
| **Affects** | Which repos / contracts / phases |
| **Status** | Active \| Superseded \| Under review |

---

## 2026-06-25

### DEC-001 — Master architecture name locked
- **Decision:** Internal name is "Guided AI Labs Agentic OS CNS." External market name is "Guided AI Labs Agentic Operating System."
- **Rationale:** Master plan §20 locks this. Prior "Option C" language created ambiguity between Freedom, the GAIL OS, and Graphify.
- **Affects:** All repos, all public-facing content, all agent instructions
- **Status:** Active

### DEC-002 — Three agentic core layers, not one brain
- **Decision:** Freedom, GAIL OS, and Graphify are three distinct and co-equal agentic core layers. No single-axis "brain" framing.
- **Rationale:** Master plan §1, §5. Prior Option C wording created architectural confusion.
- **Affects:** All AGENTS.md files, all README files, Freedom repo, GAIL OS repo, Graphify repo
- **Status:** Active

### DEC-003 — Graphify is core cognitive infrastructure, not a product spoke
- **Decision:** Graphify promoted to core CNS layer (connectome / association cortex). Not a developer tool. Not a product.
- **Rationale:** Master plan §5.3. Without Graphify, Freedom reasons over isolated facts. The architecture requires relationship intelligence at the core.
- **Affects:** `graphify-workspace-cockpit`, all repos that currently treat Graphify as optional
- **Status:** Active

### DEC-004 — GAIL OS Rev 2 is the canonical OS implementation (not user-ai-operating-system)
- **Decision:** `gail-ai-operating-system-rev-2` (Windows) is the active OS. `user-ai-operating-system` (Linux) is superseded reference only as of 2026-06-21.
- **Rationale:** Supersession recorded in `user-ai-operating-system/SUPERSEDED_BY_GAIL_AI_OPERATING_SYSTEM_REV_2.md`.
- **Affects:** All agents: do not start new OS work in Linux Rev 1.
- **Status:** Active

### DEC-005 — Graphify cross-machine architecture (Linux primary, Windows extraction node)
- **Decision:** Single canonical graph. Linux `graphify-workspace-cockpit` is the primary Graphify API, visualization, and decision surface. Windows Enhanced Graphify extracts Windows-side repos and pushes graph updates to GitHub. Graph.json sync via GitHub.
- **Rationale:** Prevents graph fragmentation. Linux cockpit is at "second video ready" maturity. Windows Enhanced Graphify handles Windows-native extraction that Linux cannot run natively. One graph avoids two competing relationship models.
- **Affects:** `graphify-workspace-cockpit`, Enhanced Graphify (Windows), cross-machine sync workflow
- **Status:** Active

### DEC-006 — GitHub as primary cross-machine coordination transport
- **Decision:** GitHub is the primary coordination channel between Linux and Windows machines. Direct link (Ethernet cable) is last resort — token-heavy and session-fragile.
- **Rationale:** Both machines have GitHub remotes. GitHub is reliable, version-controlled, and session-independent.
- **Affects:** All cross-machine work: GAIL OS Rev 2 (Windows → GitHub), Freedom (Linux → GitHub), Graphify (both → GitHub)
- **Status:** Active

### DEC-007 — R0–R5 authority ladder (5 is blocked/human-only, not 4)
- **Decision:** R5 is the new blocked/human-only level. Original R4 (blocked) becomes R5. R4 is now "delegated autonomous restricted action under charter."
- **Rationale:** Master plan §9.1, §20. The old R0–R4 framing collapsed charter-based autonomy and human-only into the same bucket.
- **Affects:** GAIL OS Rev 2 (authority ladder enum), Freedom (action classification), all consuming repos
- **Status:** Active

### DEC-008 — A6 is future-state, not current production authority
- **Decision:** A6 (minimal-governance capability expansion) is not current production authority. It requires future safety, evidence, and trust maturity before activation.
- **Rationale:** Master plan §10, §20. Prevents premature autonomy claims.
- **Affects:** All repos — no code or config should grant A6 authority
- **Status:** Active

### DEC-009 — M365 is first-class enterprise body and first proof execution lane
- **Decision:** M365 is not a minor integration. It is the primary enterprise operating environment and the first proof that the OS can control a governed action, produce evidence, and update Graphify.
- **Rationale:** Master plan §7. Enterprise clients live in M365. First proof must happen there.
- **Affects:** `ag-operations-m365-foundation`, `gail-ai-operating-system-rev-2` (Phase 4)
- **Status:** Active

### DEC-010 — Agentic-multi-agent-agent-builder is the build orchestration control plane
- **Decision:** This repo hosts all cross-repo coordination artifacts: master-plan-summary, dependency-graph, workstream board, contracts, decisions log, risks, handoff state.
- **Rationale:** Neutral repo that is not Freedom, OS, or Graphify. Already configured with governance scaffolding. Agreed with Adam in session 2026-06-25.
- **Affects:** This repo only
- **Status:** Active

### DEC-011 — @gail/contracts shared types package to be created in GAIL OS Rev 2
- **Decision:** Cross-repo TypeScript types for Mission, Action, AuthorityEnvelope, EvidencePacket, SourceRef, events, R/A level enums will be extracted into `@gail/contracts` published from `gail-ai-operating-system-rev-2/packages/`.
- **Rationale:** Prevents type drift across Freedom, Graphify, and product apps. Contracts document defines the schema.
- **Affects:** `gail-ai-operating-system-rev-2`, `the-freedom-engine-os`, `graphify-workspace-cockpit`, all product repos
- **Status:** Active — not yet implemented (Phase 1 / Phase 0 task)

### DEC-012 — Research role included in this agent's mandate
- **Decision:** The build orchestration agent (this repo) is also responsible for researching relevant architecture, standards, vendor patterns, and emerging agentic AI design as needed to inform the build.
- **Rationale:** Adam confirmed 2026-06-25: "I want this agent to be researching where necessary as well."
- **Affects:** This repo — agent behavior and task scope
- **Status:** Active
