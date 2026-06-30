# 2026-06-29 - TurboQuant Memory Compression Research Note

Document type: experimental idea
Status: research-only
Owner: Adam Goodwin
Audience: Adam, Codex, Claude, future CNS architecture reviewers

## Experimental-Ideas Flag

This note is not an active build instruction, approved architecture decision, or
implementation plan. It captures a possible future optimization lane for memory
pressure in local or controlled AI inference runtimes.

Do not treat TurboQuant as a requirement for Freedom, GAIL OS, Graphify, or the
M365 bridge unless Adam explicitly promotes this note into an active research
spike or ADR.

Adam has ChatGPT Pro running a separate deep-research pass on this topic. Future
agents should compare that output against this note before recommending any
implementation.

## Short Answer

TurboQuant is worth researching, but it should not become a foundation
assumption yet.

The current evidence says TurboQuant is a software/algorithmic vector
compression method, not a Google hardware requirement and not quantum computing.
It is aimed mainly at:

- LLM key-value cache compression during inference.
- High-dimensional vector search indexes.
- Memory-bound long-context or high-concurrency local serving.

It does not directly solve:

- Hosted API context limits.
- Codex or ChatGPT session memory.
- Poor context hygiene.
- Oversized handoff documents.
- M365 information-flow design.
- GAIL OS/Freedom/Graphify routing boundaries.

For those, the stronger default strategy remains small evidence packets,
bounded retrieval, repo-specific instruction separation, and active context
discipline.

## Can We Just Use It?

Not as a universal switch.

Hosted APIs:
There is no customer-facing "turn on TurboQuant" control for hosted API calls.
If a provider uses TurboQuant internally, it is hidden behind the service.

Current local Ollama lane:
Ollama does not appear to expose TurboQuant directly. It does expose lower-risk
KV-cache quantization controls that are more practical to test first:

- `OLLAMA_FLASH_ATTENTION=1`
- `OLLAMA_KV_CACHE_TYPE=q8_0`
- `OLLAMA_KV_CACHE_TYPE=q4_0`

Controlled vLLM lane:
vLLM has TurboQuant-related attention backend support and documented presets.
This makes TurboQuant plausible in a lab runtime, but it is a deliberate
serving-stack experiment, not a quiet repo config change.

Closest runnable ancestor:
QJL has public code and is one of the methods TurboQuant builds on. It may be
useful for understanding kernels, measurement strategy, and failure modes, but
it should not be mistaken for a drop-in TurboQuant implementation.

## Current Read

TurboQuant's best potential value for this ecosystem is as an optional
inference-layer accelerator when we control the runtime and can measure the
tradeoffs.

Possible future fit:

- Local model serving for long-context research and coding support.
- Graphify-adjacent vector search if relationship-memory indexes become large
  enough to become memory-bound.
- High-concurrency local helper agents where KV cache capacity becomes the
  actual limiter.

Poor fit:

- Current M365 bridge planning.
- Freedom-to-GAIL task routing.
- Document governance.
- Hosted model calls where the runtime is not ours.
- Any situation where correctness is more important than throughput and no
  benchmark has been run.

## Research Before Implementation

Do not implement TurboQuant until a bounded spike answers these questions:

1. What is the real bottleneck?
   Measure system RAM, VRAM, KV-cache size, context length, retrieval size,
   token throughput, latency, and concurrency.

2. Does the simpler control already solve it?
   Test Ollama `q8_0` KV cache first, then carefully test `q4_0`.

3. Does vLLM FP8 beat TurboQuant for our workload?
   vLLM's own published guidance suggests FP8 KV cache remains the best default
   for many deployments. TurboQuant may increase capacity but can trade away
   latency, throughput, or accuracy.

4. What accuracy tasks matter here?
   At minimum benchmark:
   - long repo handoff recall
   - Graphify relationship retrieval
   - coding/tool JSON reliability
   - needle-in-haystack retrieval
   - multi-step planning summaries
   - M365 evidence packet summarization

5. What are the failure boundaries?
   Record when compression causes missed facts, malformed tool calls,
   degraded reasoning, or false confidence.

## Recommended Spike Shape

Target state: Draft complete, not Integration complete.

Scope:

- Create a small benchmark harness against real local workloads.
- Compare baseline Ollama, Ollama `q8_0`, Ollama `q4_0`, vLLM FP8, and vLLM
  TurboQuant if the hardware/runtime setup is practical.
- Keep all measurements local and secret-free.
- Produce an evidence packet with commands, hardware, model, context length,
  throughput, memory, and quality results.

Non-goals:

- No production runtime change.
- No new default model-serving path.
- No automatic Graphify ingestion.
- No M365/Freedom/GAIL route change.
- No claim of "quantum speed" without measured local evidence.

Promotion rule:

Only promote this idea into an ADR or active implementation chunk if the spike
shows a clear workload-specific win without unacceptable accuracy degradation.

## Sources To Recheck

- Google Research TurboQuant blog, 2026-03-24:
  <https://research.google/blog/turboquant-redefining-ai-efficiency-with-extreme-compression/>
- TurboQuant paper, arXiv:2504.19874:
  <https://arxiv.org/abs/2504.19874>
- QJL paper, arXiv:2406.03482:
  <https://arxiv.org/abs/2406.03482>
- QJL reference code:
  <https://github.com/amirzandieh/QJL>
- vLLM TurboQuant evaluation blog, 2026-05-11:
  <https://vllm.ai/blog/2026-05-11-turboquant>
- vLLM TurboQuant attention backend docs:
  <https://docs.vllm.ai/en/stable/api/vllm/v1/attention/backends/turboquant_attn/>
- Ollama FAQ for flash attention and KV-cache quantization:
  <https://github.com/ollama/ollama/blob/main/docs/faq.mdx>
