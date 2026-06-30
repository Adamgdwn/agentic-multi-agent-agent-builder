# 2026-06-29 - Graphify Connective Layer Boundary Note

Status: active architecture guidance
Owner: Adam Goodwin
Audience: Agentic multi-agent agent builder sessions, Freedom builders, GAIL OS builders, Graphify builders, and cloud/local coordination agents

## Purpose

This note records Adam's 2026-06-29 refinement to the CNS architecture:

Graphify is the highway, electrical connection layer, communication loop, and neuronal/quantum-level connective tissue of the Guided AI Labs Agentic OS CNS. It is not a thing that must sit inside every component.

Future builder work must preserve Graphify as relationship and routing infrastructure instead of imposing it as mandatory runtime ballast across every feature.

## Core Boundary

| Layer | Owns | Must Not Become |
|---|---|---|
| Freedom | Executive cognition, reasoning, prioritization, orchestration, operator-facing AI capability | A bypass around GAIL OS authority |
| GAIL OS | Authority, evidence, action state, connector registry, approval boundary | A passive database or UI helper |
| Graphify | Relationship intelligence, context routing, dependency maps, source references, learning connections | The authority layer, execution engine, file store, or embedded dependency inside every app |

Graphify connects the CNS. It does not swallow the CNS.

## Operating Rules For Builder Agents

1. Treat Graphify as connective infrastructure, not product payload.
   - Prefer graph IDs, source refs, context refs, and bounded query responses.
   - Do not bundle full graph artifacts into mobile, web, or routine runtime paths.

2. Keep Graphify off the hot path unless relationship intelligence is needed.
   - Use active file context, recent conversation, focused repo search, and cached summaries first when they are sufficient.
   - Use Graphify when the work needs dependency tracing, entity neighborhoods, cross-repo routing, memory stitching, provenance, or relationship reasoning.

3. Preserve graceful degradation.
   - Freedom and GAIL OS should keep useful reduced behavior when Graphify is unavailable.
   - Degraded mode should be explicit: "relationship context unavailable" is acceptable; hidden failure or total lockup is not.

4. Do not duplicate GAIL OS authority inside Graphify.
   - Graphify may inform decisions.
   - GAIL OS classifies, approves, records evidence, and owns action state.
   - Freedom reasons and proposes through those boundaries.

5. Keep write paths narrow and governed.
   - Graph writes should come from approved extraction, evidence ingestion, learning updates, or OS-governed flows.
   - Do not create ad hoc write paths from arbitrary product apps directly into Graphify unless a contract and authority route exist.

6. Explain any hard dependency.
   - If a future chunk makes a component require Graphify to function, the spec must state the user-visible capability that justifies the hard dependency and the fallback behavior when Graphify is down.

## Retrieval Policy Shape

Use a tiered context path:

| Tier | Role | Examples |
|---|---|---|
| Hot | Instant local context | Active files, recent conversation, focused `rg`, small repo-intelligence reads, cached summaries |
| Warm | Relationship query | Graphify entity context, path lookup, dependency map, source-reference expansion |
| Cold | Background maintenance | Graph extraction, graph update, large semantic refresh, cross-machine graph merge |
| External | Outside ecosystem research | Perplexity/OpenAI/API research through approved provider and authority boundaries |

The system should stop at the cheapest tier that gives enough confidence for the current task.

## Immediate Application To Freedom Capability Work

The Freedom executive capability gap should not be solved by making Graphify a giant object that Freedom carries around.

Freedom should be able to:

- infer relevant repo/file context from the conversation;
- search and read approved local files quickly;
- ask Graphify for relationship context when connections matter;
- preserve useful findings as learning inputs through the OS/Graphify path;
- escalate to outside research only when local ecosystem knowledge is insufficient.

Graphify should make Freedom faster and more connected, not heavier.

## Acceptance Criteria For Future Specs

When a build chunk touches Graphify, its spec should answer:

- Is Graphify hot-path, warm-path, cold-path, or external-context-adjacent for this feature?
- What bounded query or reference is needed?
- What is the timeout, token, file, or result budget?
- What happens if Graphify is unavailable?
- Does any write route pass through GAIL OS authority/evidence where required?
- Does the design avoid embedding graph artifacts into unrelated app bundles?

## Validation Note

Created during a local builder-control documentation session on 2026-06-29.

Governance preflight was run before this note and reported two pre-existing control-repo validation errors: `risk_tier: strategic` and `repository_model: multi-repo-coordination` are present in `project-control.yaml` but not accepted by the current preflight validator. This note does not change those governance values.
