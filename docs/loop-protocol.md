# CNS Build Coordination Loop Protocol

Last Updated: 2026-06-27
Scope: Local Claude Code sessions running `/loop coordinate CNS build` in this repo.
Not for: Cloud agents — see `docs/cloud-agent-startup.md`.

---

## Critical: Repo Boundaries

**This control repo** (`agentic-multi-agent-agent-builder`) is the only repo that exists locally. All reads and writes to this repo use local filesystem tools (Read, Edit, Write, git).

**All subject repos** (`the-freedom-engine-os`, `gail-ai-operating-system-rev-2`, `graphify-workspace-cockpit`, `ag-operations-m365-foundation`, and all product repos) exist on GitHub only under `Adamgdwn/`. Never search for them in local folders. All subject repo operations — reading files, creating branches, writing files, opening PRs — go through `mcp__github__*` tools exclusively.

If you find yourself looking at local filesystem paths for a subject repo, stop. Use `mcp__github__get_file_contents` to read, `mcp__github__create_or_update_file` to write, `mcp__github__create_branch` to branch, `mcp__github__create_pull_request` to open PRs.

---

## Purpose

This protocol drives autonomous coordination of the Guided AI Labs Agentic OS CNS build across all subject repos and all phases. Each loop iteration reads current state, picks the next available task, executes it, updates the handoff, and either continues or schedules a fresh context to resume.

The loop runs until all tasks in the current phase are complete or a stop condition is reached. It handles staggered completion across repos naturally — each task is independent until phase gates require sequential ordering.

---

## Entry Point

The user types in this repo session:

```
/loop coordinate CNS build
```

Each `ScheduleWakeup` re-fires with the same prompt string. Each fresh context reads this protocol and resumes from the `## Loop State` block in `docs/build-control/handoff-state.md`.

This protocol is also usable manually: any agent can follow it step by step without `/loop` mode, using the same iteration structure.

---

## Iteration Startup (every fresh context or manual entry)

1. Run `git status --short` — confirm clean working tree or identify uncommitted work from a prior interrupted iteration
2. Read `docs/build-control/handoff-state.md` → check `## Loop State` block:
   - If `active: true` and `step` is set → resume mid-task from that exact step (do not re-start the task)
   - If `active: false` or no loop state → proceed to task selection
3. Read `docs/build-control/cloud-dispatch.yaml` → scan all tasks for `status: available`
4. If any tasks show `status: claimed` with `claimed_by: claude-code-local` → we own that claim; check if branch/PR already exists and resume from there
5. Check for three or more consecutive `blocked` tasks → surface to Adam and pause before continuing

---

## Task Selection

Read `docs/build-control/cloud-dispatch.yaml`. Select by priority:

1. Phase 0 tasks before Phase 1 and later
2. `status: available` only — skip `claimed`, `complete`, `review`, `blocked`
3. Lowest task ID first (0.2 before 0.3, 1.1 before 1.2, etc.)
4. Platform match:
   - `cloud-safe` → always eligible in a local Claude Code session (GitHub MCP + local git both available)
   - `windows-local` → eligible for code-writing and PR creation; flag that test validation needs Windows machine or GitHub Actions CI
   - `coordinated` → skip unless both machines confirmed available; log the skip reason in loop state

Before claiming:
- Check `branch` field in dispatch — if set and `claimed_by` is not null, another agent owns it; skip
- If branch exists but `claimed_by` is null and PR is open → update task to `status: review`; move to next task
- If branch exists, `claimed_by` is null, and no PR → take the claim; resume from the existing branch

---

## Claiming a Task

These steps are the atomic claim lock. Do them in order, do not skip:

1. Update `cloud-dispatch.yaml`: set `claimed_by: "claude-code-local"`, `claimed_at: <today YYYY-MM-DD>`, `status: "claimed"`, `branch: "cloud/{task_id}-{short-slug}"`
2. Write `## Loop State` block to `docs/build-control/handoff-state.md` with `active: true` and `step: "claimed"` (see Loop State Format below)
3. Commit both files: `"Loop: claim task {id} - {short title}"`
4. Push

The push is the lock. If two agents race, the second push will see the first agent's claim and should abort and re-select.

---

## Execution by Task Type

### Phase 0 — Documentation and framing tasks in subject repos (cloud-safe)

These are the most common tasks. Use GitHub MCP throughout:

1. Read the chunk spec: `docs/build-control/2026-06-26 - phase-0-chunk-specs.md` → find the section for this task ID
2. Update loop state: `step: "reading_spec"`
3. `mcp__github__create_branch` → create `cloud/{task_id}-{slug}` in the target repo
4. Update loop state: `step: "branch_created"`
5. For each output file listed in the spec:
   - `mcp__github__get_file_contents` → read existing file if it exists (do not assume it doesn't exist)
   - Compose the new or updated content per spec acceptance criteria
   - `mcp__github__create_or_update_file` → write to the branch
   - Update loop state: `step: "file_written:{filename}"`
6. `mcp__github__create_pull_request` → open PR:
   - Title: `[CNS Task {id}] {title}`
   - Body: include task spec reference, acceptance criteria checklist, and note "Opened by claude-code-local loop"
7. Update loop state: `step: "pr_open"`, `pr_url: <url>`
8. Update `cloud-dispatch.yaml`: `status: "review"`, `pr_url: <url>`, `claimed_by: null`
9. Update `docs/build-control/handoff-state.md` session log: add dated entry for what was done
10. Commit + push changes to THIS repo (control repo)
11. Update loop state: `active: false`, `last_completed_task: "{id}"`, `next_task: "{next_id}"`
12. Commit + push final state

### Phase 0 — Documentation tasks in THIS repo (control repo)

For tasks that update files in `agentic-multi-agent-agent-builder` itself, use the same branch + PR pattern as subject repos — do NOT push directly to `main`:

1. Read chunk spec
2. Create a local feature branch: `git checkout -b cloud/{task_id}-{short-slug}`
3. Update loop state: `step: "branch_created"`, `branch: "cloud/{task_id}-{short-slug}"`
4. Edit files locally (Edit tool)
5. `git add <files> && git commit -m "[CNS Task {id}] {title}"` then `git push -u origin cloud/{task_id}-{short-slug}`
6. Update loop state: `step: "branch_pushed"`
7. Open PR via `mcp__github__create_pull_request` against `Adamgdwn/agentic-multi-agent-agent-builder` base `main`:
   - Title: `[CNS Task {id}] {title}`
   - Body: acceptance criteria checklist + "Opened by claude-code-local loop"
8. Update `cloud-dispatch.yaml` task: `status: "ready-for-review"`, `pr_url: <url>`
9. Update `handoff-state.md` session log with dated entry
10. Commit + push `cloud-dispatch.yaml` and `handoff-state.md` on the same branch
11. Update loop state: `active: false`, `last_completed_task: "{id}"`

### Phase 1 — Code tasks (windows-local)

A local Claude Code session CAN write code and open PRs. It CANNOT run tests on Windows. Proceed:

1. Read chunk spec: `docs/build-control/2026-06-25 - phase-1-chunk-specs.md`
2. Via GitHub MCP: create branch, write Python or TypeScript files per spec
3. Open PR — include in body:
   - "Code written by claude-code-local loop"
   - "⚠️ Test validation pending: requires Windows machine (`python -m unittest discover -s tests`) or GitHub Actions CI (not yet configured in this repo)"
   - All acceptance criteria as unchecked boxes (Adam validates before merge)
4. Update `cloud-dispatch.yaml`: `status: "review"`, add `notes: "code written, tests not run"`
5. Add flag to `handoff-state.md`: Phase 1 task {id} PR open, needs Windows validation

### Coordinated tasks (0.8 and later cross-machine tasks)

Skip for now. Write to loop state:

```
skipped_tasks:
  - id: "0.8"
    reason: "coordinated — requires Q2 answer (Enhanced Graphify definition) and both machines active"
```

Continue to next available task. Do not block the loop on coordinated tasks.

---

## Compaction — The Core Continuity Mechanism

Compaction is not a close-out ritual. It is a mandatory maintenance step inside the work loop. Without it, context quality degrades over hours and task fidelity collapses. Compaction is what keeps this loop running for hours across all phases of the CNS build — through Phase 0, Phase 1, and every recursive phase as the system learns from itself.

The invariant, on every runtime surface:

```
checkpoint → compact → rehydrate → continue
```

The loop must not stop merely because compaction occurred. Compaction is neutral maintenance — not task completion. Every time compaction fires, the loop picks up exactly where it left off.

### Compaction Threshold

Target: 100,000 input tokens. Do not wait until the window is nearly exhausted — context fidelity degrades well before the hard limit is hit. Compact at the next safe checkpoint boundary after this threshold is crossed.

### Runtime-Specific Mechanism

**Local Claude Code CLI with `/loop` mode (primary runtime for this loop):**

1. Complete the current atomic operation — never interrupt a file write, PR creation, or commit sequence
2. Write the full checkpoint to `## Loop State` in `docs/build-control/handoff-state.md` (see Checkpoint Format below)
3. Commit: `"Loop: checkpoint before compaction — task {id} step {step}"`
4. Push
5. Call `ScheduleWakeup(delaySeconds: 60, reason: "CNS loop compaction — resuming task {id} step {step}", prompt: "/loop coordinate CNS build")`
6. End turn — the 60-second wakeup fires with a fresh context window and resumes from checkpoint

**Claude Code web (auto-compaction):**

Auto-compaction fires automatically near the configured token limit. The loop must write a checkpoint BEFORE auto-compaction triggers:

1. At each task close-out and each major step boundary, write the checkpoint to `handoff-state.md` and immediately commit + push
2. After auto-compaction fires, the `SessionStart (compact)` hook or the loop startup sequence rehydrates from the latest checkpoint
3. Continue with `exact_next_step` from the checkpoint

Recommended Claude Code web environment settings:

```bash
CLAUDE_CODE_AUTO_COMPACT_WINDOW=125000
CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=80
```

This targets auto-compaction near 100,000 input tokens.

### Safe Checkpoint Boundary

Compact only at a safe boundary. Compaction must NOT interrupt:

- a file write in progress
- a branch creation or PR update
- a multi-file edit halfway through its atomic change
- a commit/push sequence

A boundary is safe when:
- the current subtask state is explainable in one sentence
- changed files are committed, staged, or explicitly listed as WIP in the checkpoint
- `exact_next_step` can be stated in one sentence

### Trigger Signals (any one is sufficient — compact at the next safe boundary)

- Completed one full task (PR opened or control repo commit done)
- Context approaching 100,000 input tokens
- More than 20 GitHub MCP calls made in this turn
- More than 5 large files written (>200 lines each) in this turn
- Task is unexpectedly complex and context is heavy mid-task

---

## Rehydration — Minimum Context After Compaction

After compaction, the loop must reload the minimum required context before continuing. Broad rescans waste tokens and slow recovery. Load only what the next step needs.

**Minimum rehydration set:**

1. `docs/build-control/handoff-state.md` → `## Loop State` checkpoint — this is the resume anchor
2. This protocol (`docs/loop-protocol.md`) — task selection, execution, stop conditions
3. Active task spec: the relevant section of `docs/build-control/2026-06-26 - phase-0-chunk-specs.md` (Phase 0) or `docs/build-control/2026-06-25 - phase-1-chunk-specs.md` (Phase 1)
4. `docs/build-control/cloud-dispatch.yaml` → current task entry only
5. Current branch and git state
6. `exact_next_step` from the checkpoint

**Do NOT reload after compaction** unless the checkpoint's `required_context_on_resume` field explicitly lists it:

- Full master architecture doc
- All chunk specs (load only the active task's section)
- `repo-workstream-board.md` (only if the next action requires board updates)
- Any subject repo's files (use GitHub MCP to fetch specific files on demand)

The checkpoint is the memory. The repository is the persistent store. The agent rents context only for what the next step needs.

---

## Chunk Close-Out (after every task)

1. Verify `cloud-dispatch.yaml` task is `review` or `complete`
2. Verify `handoff-state.md` session log has a dated entry for this task
3. Push all changes to this repo
4. Clear loop state: `active: false`, `last_completed_task: "{id}"`, `next_task: "{next_id}"`
5. Commit: `"Loop: task {id} complete — {short title}"`
6. Push

If more tasks remain and context is healthy → proceed immediately to next task selection without a ScheduleWakeup.

If context is large → use the refresh procedure above (ScheduleWakeup) before starting the next task.

---

## Stop Conditions

| Condition | Action |
|---|---|
| All Phase 0 tasks are `complete` or `review` | Stop. Write final handoff. Surface CP-0: "All Phase 0 PRs are open or merged — ready for Adam's review." Do not start Phase 1 without Adam confirmation. |
| A task returns access denied or repo not found | Mark task `blocked` in dispatch. Open a `[BLOCKED]` issue or PR in THIS control repo titled `[BLOCKED] Task {id} — {reason}`. Continue to next task. |
| Task spec is ambiguous or contradicts master plan | Do not guess. Write a `[NEEDS CLARIFICATION]` note in loop state. Skip the task and continue. Surface to Adam at end of session. |
| All remaining tasks are `windows-local` or `coordinated` | Pause loop. Write handoff: "Phase 0 complete. Phase 1 tasks are `windows-local` and require Windows test validation. Pausing until Windows session or GitHub Actions CI is set up in GAIL OS Rev 2." |
| Three consecutive tasks blocked | Stop. Write handoff summarizing all blockers. Do not continue past three consecutive failures. |
| Adam signals stop | Finish current atomic operation. Write handoff immediately. Do not start new tasks. |

---

## Retry and Stop Policy

The loop works through normal friction automatically. It stops only when it has genuinely run out of moves on a specific problem.

### Work through these — do not count as failures

- GitHub API transient errors, rate limits, network timeouts → wait briefly, retry the same call
- File SHA mismatch on `create_or_update_file` → re-read the file, get current SHA, retry the write
- Branch already exists but no PR → take the branch, continue from there
- PR template missing → open PR without template, include acceptance criteria in body
- Fixable CI failures: lint, formatting, import order, missing blank line → read the failure output, apply the fix, repush
- Merge conflict on a docs file → read both versions, produce a clean merge, retry

### These count toward the retry limit

- Test failure not resolvable from available context (wrong architecture, missing dependency that can't be inferred)
- Spec says X but the existing code does Y in an incompatible way — genuine design ambiguity
- Access denied after one retry (private repo, wrong token scope, permission error)
- The same error class appears on the third attempt to fix the same problem
- A required file, function, or module named in the spec does not exist and cannot be safely inferred

### Limit: 3 attempts per substantive blocker

After three failed attempts on the same substantive issue:

1. Update `cloud-dispatch.yaml`: set `status: "blocked"`, note the reason in `notes`
2. Update Loop State `blockers:` in `handoff-state.md` — describe what was tried (3 attempts), what failed, what decision or access is needed
3. Open a `[BLOCKED]` issue in `Adamgdwn/agentic-multi-agent-agent-builder`:
   - Title: `[BLOCKED] Task {id} — {one-line reason}`
   - Body: attempt 1, attempt 2, attempt 3 summaries + exactly what Adam needs to provide
4. Set `paused: true` in Loop State, `pause_reason: "[BLOCKED] Task {id} — {reason}"`
5. Commit + push dispatch and handoff state
6. Surface to Adam and stop — do not try a fourth approach

Do not use the retry count for trivial mechanical retries (SHA mismatch, rate limit). Use it only when the same conceptual blocker recurs.

### Retry tracking in checkpoint

```yaml
retry_counts:
  "1.1": 2
```

Reset a task's count when it is successfully completed or when Adam explicitly re-opens it after resolving the blocker.

---

## Checkpoint Format

This block lives in `## Loop State` in `docs/build-control/handoff-state.md`. Write the full checkpoint before every compaction and update it at each step change. The checkpoint must be complete enough for a fresh context to resume without reading the chat transcript.

**Mid-task (active):**

```yaml
active: true
current_task_id: "0.4"
current_task_title: "Align Graphify to core cognitive infrastructure framing"
target_repo: "graphify-workspace-cockpit"
branch: "cloud/0.4-graphify-framing"
pr_url: null
started_at: "2026-06-26"
compaction_count: 1
current_phase: "implementation"
step: "branch_created"
exact_next_step: "Write AGENTS.md CNS role section via mcp__github__create_or_update_file"
acceptance_criteria:
  met:
    - "Branch created"
  remaining:
    - "AGENTS.md CNS role section written"
    - "README updated"
    - "PR opened"
decisions:
  - "Prepend CNS role section to existing AGENTS.md rather than replacing it"
validation:
  run: []
  not_run:
    - "Human PR review — pending Adam merge"
required_context_on_resume:
  - "docs/loop-protocol.md"
  - "docs/build-control/2026-06-26 - phase-0-chunk-specs.md (task 0.4 section)"
  - "docs/build-control/handoff-state.md"
blockers: []
refresh_reason: "context budget"
```

**Between tasks (idle):**

```yaml
active: false
last_completed_task: "0.4"
next_task: "0.5"
skipped_tasks: []
compaction_count: 2
```

**Paused (stop condition):**

```yaml
active: false
paused: true
pause_reason: "All Phase 0 PRs open — awaiting Adam review and merge for CP-0 gate"
last_completed_task: "0.7f"
next_task: "Phase 1 — windows-local"
compaction_count: 8
```

---

## Staggered Completion Across Repos

Subject repos complete Phase 0 at different times. This is by design:

- Phase 0 tasks are all independent of each other — different target repos, no ordering constraint within Phase 0
- A task marked `review` is done from the loop's perspective — Adam merges it when ready; the loop does not wait
- Phase 1 tasks in `gail-ai-operating-system-rev-2` ARE sequenced — respect task ID order (1.1 before 1.2)
- When Adam merges PRs between loop sessions, a fresh iteration detects `review` tasks and skips them cleanly

As more repos are added (fourth, fifth, etc.), add them to `cloud-dispatch.yaml` with task IDs continuing the sequence. The loop will pick them up automatically.

---

## Phase Transitions

### Phase 0 → Phase 1

Trigger: all Phase 0 tasks `review` or `complete`

1. Loop pauses and surfaces CP-0 to Adam
2. Adam reviews and merges PRs
3. Adam updates dispatch tasks to `complete`
4. Next loop session → Phase 1 tasks become available (windows-local — loop writes code + PR; Windows validates)

### Phase 1 → Phase 2

Trigger: CP-1 gate met (one action through full state machine, API reachable)

1. Phase 2 tasks (Graphify schema extension) become available
2. Many are `cloud-safe` again — the loop can run them autonomously
3. Coordinated tasks (2.7, 2.8) require Windows Enhanced Graphify extraction first

### Later Phases

The dispatch file is the source of truth. Add new tasks as phases are planned. The loop adapts automatically — it reads what's available and runs it.

---

## Notes for Multi-Hour Sessions

- The loop may run for hours across many context refreshes. Each refresh is ~60 seconds of downtime.
- Context refresh is not failure — it is the mechanism. The handoff docs in this repo are the persistent memory.
- If a wakeup fires and nothing is in progress (all tasks `review` or `complete`), the loop surfaces a status summary and pauses gracefully — it does not spin uselessly.
- If you (Adam) interrupt mid-loop, the current task's loop state is written to disk. The next manual or loop session resumes from there.
- The three subject repos (Freedom, GAIL OS, Graphify) plus M365 and however many product repos are added will all progress in parallel through Phase 0. Phase 1+ has sequencing — the loop enforces it via task ID ordering and `status` checks.
