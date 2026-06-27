# Contracts and Integration Points — Guided AI Labs Agentic OS CNS

**Last Updated:** 2026-06-25
**Owner:** Build Agent Orchestrator

This document is the authoritative list of cross-repo contracts. Any change to a contract here requires updating all consuming repos before the change is promoted to production.

---

## 1. Canonical Object Schemas

All schemas are owned by `gail-ai-operating-system-rev-2`. Consuming repos import types or validate against API responses.

### 1.1 Signal
```typescript
interface Signal {
  id: string;
  source: string;           // website | m365 | user | agent | file | api | research
  sourceRef: SourceRef;
  eventType: string;        // e.g. "inquiry.created"
  payload: Record<string, unknown>;
  receivedAt: string;       // ISO-8601
  routedToMission?: string; // Mission ID if classified
}
```

### 1.2 Mission
```typescript
interface Mission {
  id: string;
  title: string;
  status: 'candidate' | 'classified' | 'active' | 'complete' | 'abandoned';
  riskLevel: R0 | R1 | R2 | R3 | R4 | R5;
  autonomyLevel: A0 | A1 | A2 | A3 | A4 | A5 | A6;
  signals: string[];        // Signal IDs
  actions: string[];        // Action IDs
  evidence: string[];       // EvidencePacket IDs
  graphContext?: string[];  // GraphNode IDs from Graphify
  owner: string;
  createdAt: string;
  updatedAt: string;
}
```

### 1.3 Action
```typescript
interface Action {
  id: string;
  missionId: string;
  status: ActionState;      // see state machine below
  riskLevel: R0 | R1 | R2 | R3 | R4 | R5;
  actor: string;            // agent ID or human ID
  sourceRef: SourceRef;
  systemBoundary: string;   // which system is touched
  authorityBasis: string;   // charter ID or approval ID
  approvalState: ApprovalState;
  evidenceId?: string;
  proposedAt: string;
  executedAt?: string;
  evidencedAt?: string;
}

type ActionState =
  | 'observed' | 'proposed' | 'classified'
  | 'approval_requested' | 'approved' | 'rejected' | 'revised' | 'paused'
  | 'claimed' | 'executed' | 'stopped' | 'superseded'
  | 'evidenced' | 'reviewed' | 'learned';
```

### 1.4 AuthorityEnvelope
```typescript
interface AuthorityEnvelope {
  id: string;
  authorityOwner: string;       // human or governance body
  authorizedActor: string;      // Freedom ID, agent ID, or workflow ID
  actionClass: string;          // exact category of permitted actions
  systemBoundary: string[];     // which systems, tenants, APIs in scope
  dataBoundary: string;         // what data may be read/written
  riskLevel: R0 | R1 | R2 | R3 | R4 | R5;
  approvalBasis: string;        // charter, policy, contract, prior delegation
  startDate: string;
  expiryDate: string;
  renewalConditions?: string;
  thresholds?: Record<string, number | string>;
  stopConditions: string[];
  rollbackPath: string;
  evidenceRequirement: string;
  reviewCadence: string;
  humanOverridePath: string;
  status: 'active' | 'expired' | 'suspended' | 'revoked';
}
```

### 1.5 EvidencePacket
```typescript
interface EvidencePacket {
  id: string;
  missionId: string;
  actor: string;
  agentOrToolId: string;
  sourceRefs: SourceRef[];
  graphRefs: string[];          // GraphNode IDs
  riskLevel: R0 | R1 | R2 | R3 | R4 | R5;
  autonomyLevel: A0 | A1 | A2 | A3 | A4 | A5 | A6;
  authorityBasis: string;       // AuthorityEnvelope ID or Approval ID
  approvalRecord: string;       // Approval ID
  actionPerformed: string;
  systemTouched: string;
  outputOrResult: string;
  userVisibleSummary: string;
  rollbackNote?: string;
  reviewOutcome?: string;
  learningUpdate?: string;
  recheckDate?: string;
  createdAt: string;
}
```

### 1.6 SourceRef
```typescript
interface SourceRef {
  id: string;
  title: string;
  url?: string;
  filePath?: string;
  systemOwner: string;          // which system owns this record
  retrievedAt: string;
  contentHash?: string;         // for integrity checking
  expiresAt?: string;
}
```

### 1.7 GraphNode (Graphify)
```typescript
interface GraphNode {
  id: string;
  type: GraphNodeType;
  label: string;
  properties: Record<string, unknown>;
  sourceRefs: string[];
  createdAt: string;
  updatedAt: string;
  confidence?: number;          // 0–1 for inferred nodes
  expiresAt?: string;
}

type GraphNodeType =
  | 'Person' | 'Organization' | 'System' | 'Workflow' | 'Mission'
  | 'Action' | 'Evidence' | 'Risk' | 'Control' | 'Agent' | 'Capability'
  | 'Connector' | 'Research' | 'Code' | 'File' | 'Repo';
```

### 1.8 ResearchClaim (Graphify)
```typescript
interface ResearchClaim {
  id: string;
  sourceTitle: string;
  sourceUrl?: string;
  sourceType: string;
  publicationDate?: string;
  retrievalDate: string;
  claimSummary: string;
  affectedLayer: string;        // Freedom | OS | Graphify | M365 | Product
  affectedRepo?: string;
  confidenceLevel: 'high' | 'medium' | 'low' | 'uncertain';
  uncertaintyNote?: string;
  implementationImplication: string;
  recommendedAction: string;
  revalidationDate: string;
  graphNodeId: string;
  evidencePacketRef?: string;
}
```

---

## 2. Event Vocabulary

**Owner:** `gail-ai-operating-system-rev-2` — canonical event type definitions
**Transport:** To be determined (EventBridge / Supabase Realtime / webhook / internal queue)

### Core OS Events
```
signal.created
mission.candidate.created
mission.classified
graph.context.attached
action.proposed
action.classified
authority.envelope.created
approval.requested
approval.granted
approval.rejected
approval.override_requested
approval.override_granted
action.claimed
action.executed
action.stopped
evidence.logged
review.completed
learning.consolidated
```

### Graphify Events
```
graph.edge.created
graph.edge.updated
research.claim.created
research.claim.validated
```

### Agent / Capability Events
```
capability.requested
agent.called
agent.evaluated
agent.promoted
agent.retired
connector.registered
connector.suspended
```

### Website Events (per site)
```
// guidedailabs.com
inquiry.created
demo_requested
product_interest.created
intro_booked

// guidedaijourney.com
readiness.completed
workflow_friction.logged
use_case.scored
pilot_candidate.created

// oldskoolai.com
lesson.completed
safe_use_check.completed
role_path.selected
team_signal.created
```

---

## 3. API Integration Points

### 3.1 GAIL OS API (Windows → exposed to Linux)

| Endpoint | Method | Purpose | Auth |
|---|---|---|---|
| `/api/missions` | POST | Create mission candidate | Agent identity |
| `/api/missions/{id}` | GET | Get mission state | Agent identity |
| `/api/actions` | POST | Propose action | Agent identity |
| `/api/actions/{id}/state` | PATCH | Advance action state | Agent identity + authority |
| `/api/authority-envelopes` | GET | List valid envelopes for actor | Agent identity |
| `/api/evidence` | POST | Log evidence packet | Agent identity |
| `/api/agents` | GET | List registered agents | Agent identity |
| `/api/connectors` | GET | List registered connectors | Agent identity |

Status: **Not yet implemented.** Phase 1 deliverable.

### 3.2 Graphify API (Linux → exposed to Freedom + OS)

| Endpoint | Method | Purpose |
|---|---|---|
| `/api/query` | POST | `graphify query` over active graph |
| `/api/path` | POST | `graphify path` between two nodes |
| `/api/explain` | POST | `graphify explain` concept |
| `/api/nodes` | POST | Create/update graph node |
| `/api/edges` | POST | Create/update graph edge |
| `/api/research-claims` | POST | Ingest research claim |
| `/api/context` | POST | Get context neighbourhood for mission/action |

Status: **Partial.** Cockpit has internal graph routes. Named HTTP API for external Freedom/OS use is Phase 2.6 deliverable.

### 3.3 M365 Bridge (Windows, via GAIL OS)

| Resource | Operation | Required Permission | Evidence Required |
|---|---|---|---|
| SharePoint Lists | Read | Sites.Read.All | R0 — no |
| SharePoint Lists | Write row | Sites.ReadWrite.All | R2 — yes |
| Planner | Read tasks | Tasks.Read | R0 — no |
| Planner | Create task | Tasks.ReadWrite | R2 — yes |
| Teams | Read messages | ChannelMessage.Read.All | R0 — no |
| Teams | Send message | ChannelMessage.Send | R3 — yes + approval |
| Exchange | Read emails | Mail.Read | R0 — no |
| Exchange | Send email | Mail.Send | R3 — yes + approval |
| Entra | Register agent | Application.ReadWrite.All | R5 — human only |

Status: **Planned.** Stage 2 identity foundation + Stage 9 bridge readiness documented. Phase 4 deliverable.

---

## 4. Shared Package Strategy

**Recommended:** Extract shared types into a cross-platform NPM package.

```
@gail/contracts
  ├── types/
  │   ├── mission.ts
  │   ├── action.ts
  │   ├── authority-envelope.ts
  │   ├── evidence-packet.ts
  │   ├── source-ref.ts
  │   └── events.ts
  ├── enums/
  │   ├── r-levels.ts      (R0–R5)
  │   └── a-levels.ts      (A0–A6)
  └── index.ts
```

- Published from `gail-ai-operating-system-rev-2/packages/`
- Consumed by: Freedom, Graphify cockpit, all product apps
- Version-pinned in each consumer's `package.json`

Status: **Not yet created.** Phase 0 / Phase 1 decision. Existing `packages/shared` in Freedom Engine has governance types — check for overlap before creating new package.

---

## 5. Auth and Identity Contracts

| Actor type | Identity pattern | Authority basis |
|---|---|---|
| Freedom | App registration (Entra), agent ID in GAIL OS registry | Authority envelope + mission context |
| GAIL OS itself | Service principal, internal admin identity | Policy-level — not user-delegated |
| Graphify | Read-only service identity; write gated by OS | OS connector registration |
| M365 agents | Entra app registration, least-privilege permissions per IDENTITY_NAMING_STANDARD.md | M365 bridge contract |
| Product apps | App registration per app, webhook credentials | Connector registry + event contracts |
| Human users | Microsoft identity (admin@agoperations.ca tenant) | R5 actions, R4 charter grants, overrides |

Reference: `ag-operations-m365-foundation/IDENTITY_NAMING_STANDARD.md`

---

## 6. Contract Change Control

Before changing any contract in this document:

1. Identify all repos consuming the contract (see §2 consumer table in dependency-graph.md).
2. Draft the change in GAIL OS Rev 2 as a versioned schema.
3. Open a cross-repo coordination note in `decisions-log.md`.
4. Update all consuming repos in the same PR window.
5. Do not merge breaking contract changes without downstream compatibility confirmed.
