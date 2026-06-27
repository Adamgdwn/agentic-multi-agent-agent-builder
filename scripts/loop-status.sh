#!/usr/bin/env bash
# scripts/loop-status.sh — CNS loop progress dashboard
#
# Usage (one-shot):
#   bash scripts/loop-status.sh
#
# Usage (live, refresh every 30s):
#   watch -n 30 bash scripts/loop-status.sh

set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

python3 - <<'PYEOF'
import re, datetime
from pathlib import Path

RESET  = "\033[0m"
BOLD   = "\033[1m"
DIM    = "\033[2m"
GREEN  = "\033[32m"
YELLOW = "\033[33m"
RED    = "\033[31m"
BLUE   = "\033[34m"

STATUS_DISPLAY = {
    "available":        ("⬜", DIM,    "available"),
    "claimed":          ("🔄", YELLOW, "active   "),
    "ready-for-review": ("✅", GREEN,  "PR open  "),
    "complete":         ("✔ ", GREEN,  "merged   "),
    "blocked":          ("🚫", RED,    "blocked  "),
    "coordinated":      ("🤝", BLUE,   "coordi'd "),
}

def col(text, c): return f"{c}{text}{RESET}" if c else text

# ── parse dispatch ──
raw = Path("docs/build-control/cloud-dispatch.yaml").read_text()
tasks, cur = [], {}
for line in raw.splitlines():
    if re.match(r"  - id:", line):
        if cur: tasks.append(cur)
        m = re.match(r'  - id:\s*["\']?([^"\'#\s]+)', line)
        cur = {"id": m.group(1)} if m else {}
        continue
    for key in ("title", "status", "repo", "pr_url", "phase"):
        m = re.match(rf'    {key}:\s*["\']?([^"\'#\n]+?)["\']?\s*$', line)
        if m:
            val = m.group(1).strip()
            cur[key] = None if val == "null" else val
if cur:
    tasks.append(cur)

phase0 = [t for t in tasks if str(t.get("phase","")) == "0"]
phase1 = [t for t in tasks if str(t.get("phase","")) == "1"]
p0_review   = sum(1 for t in phase0 if t.get("status") in ("ready-for-review","complete"))
p0_active   = sum(1 for t in phase0 if t.get("status") == "claimed")
p0_done     = sum(1 for t in phase0 if t.get("status") == "complete")

bar_filled  = "█" * p0_review
bar_active  = "░" * p0_active
bar_empty   = "·" * (len(phase0) - p0_review - p0_active)
progress_bar = col(bar_filled, GREEN) + col(bar_active, YELLOW) + col(bar_empty, DIM)

print(f"\n{BOLD}  CNS Build Loop — Phase 0 Progress{RESET}")
print(f"  {progress_bar}  {col(str(p0_review), GREEN)}/{len(phase0)} in review   {col(str(p0_active), YELLOW)} active   {col(str(p0_done), GREEN)} merged\n")

print(f"  {BOLD}{'ID':<6} {'STATUS':<12} {'REPO':<36} PR{RESET}")
print(f"  {'─'*6} {'─'*12} {'─'*36} {'─'*22}")
for t in phase0:
    s = t.get("status","?")
    icon, c, label = STATUS_DISPLAY.get(s, ("?", "", s))
    repo  = t.get("repo","").replace("Adamgdwn/","")
    pr    = t.get("pr_url") or ""
    pr_s  = re.sub(r"https://github.com/Adamgdwn/[^/]+/pull/(\d+)", r"PR #\1", pr) if pr else ""
    print(f"  {t.get('id',''):<6} {col(icon+' '+label, c):<22} {repo:<36} {col(pr_s, DIM)}")

# ── phase 1 summary ──
if any(t.get("status") not in ("blocked",) for t in phase1):
    print(f"\n  {BOLD}Phase 1 (windows-local){RESET}")
    for t in phase1:
        s = t.get("status","?")
        icon, c, label = STATUS_DISPLAY.get(s, ("?","",s))
        print(f"  {t.get('id',''):<6} {col(icon+' '+label, c):<22} {t.get('title','')[:55]}")

# ── active loop state ──
handoff = Path("docs/build-control/handoff-state.md").read_text()
m = re.search(r"## Loop State\n+([\s\S]+?)(?=\n---)", handoff)
if m:
    block = m.group(1)
    def grab(pattern):
        x = re.search(pattern, block, re.M)
        return x.group(1).strip().strip('"\'') if x else None

    active   = grab(r"^active:\s*(\S+)")
    task_id  = grab(r"^current_task_id:\s*(.+)")
    task_ttl = grab(r"^current_task_title:\s*(.+)")
    step     = grab(r"^step:\s*(.+)")
    nxt_step = grab(r"^exact_next_step:\s*(.+)")
    c_count  = grab(r"^compaction_count:\s*(\d+)")

    print(f"\n  {BOLD}Active session{RESET}")
    print(f"  {'─'*55}")
    if active == "true":
        print(f"  Task:         {col(task_id or '?', YELLOW)}  —  {(task_ttl or '')[:50]}")
        print(f"  Step:         {step or '?'}")
        if nxt_step:
            print(f"  Next action:  {nxt_step[:75]}")
        print(f"  Compactions:  {c_count or '0'}")
    else:
        nxt = grab(r"^next_task:\s*(.+)")
        last = grab(r"^last_completed_task:\s*(.+)")
        print(f"  Idle — last completed: {last or 'none'}   next: {col(nxt or '?', YELLOW)}")

ts = datetime.datetime.now().strftime("%H:%M:%S")
print(f"\n  {DIM}Updated: {ts}   |   Live view: watch -n 30 bash scripts/loop-status.sh{RESET}\n")
PYEOF
