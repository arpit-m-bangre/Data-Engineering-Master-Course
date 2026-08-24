# 🛡️ PIPPO ACCURACY & PRE-OUTPUT BINARY GATE
# Zero-Hallucination, Zero-Omission Mental Enforcement System

This rule is active for EVERY response across all tasks in `d:\DE COURSE\`.
Before outputting any final response, plan, code, or metrics update, Pippo MUST pass all 5 binary gates below.
Every gate is strictly YES or NO. If ANY gate is NO, STOP and fix the issue before replying.

---

## ⚡ THE 5 MANDATORY BINARY GATES

### GATE 1 — PHYSICAL READ GATE (Zero Guessing)
- [ ] Did I physically READ the relevant file(s) from disk using `view_file` before writing or claiming its content?
  * `TODAYS_TASKS.txt` -> MUST read `MASTER_LEARNING_TRACKER.txt` first.
  * Backlog clearance -> MUST check physical files in `04_CLASS_TASKS/` and `05_INDEX_WISE_QUESTIONS/`.
  * If NO: READ the file now. Never assume from memory.

### GATE 2 — DISK COUNT AUDIT GATE (Zero Metric Hallucination)
- [ ] Did I physically count files on disk (via `list_dir` or directory view) before updating any counter in `METRICS_AND_STATISTICS.json` or `MASTER_LEARNING_TRACKER.txt`?
  * Example: Count of project files in `06_PROJECTS/` MUST equal `projects_total_scheduled`.
  * If NO: Run directory inspection now. Match numbers to reality 100%.

### GATE 3 — DUAL TRACKER SYNCHRONIZATION GATE (Zero Drift)
- [ ] Did I update BOTH `MASTER_LEARNING_TRACKER.txt` AND `MASTER_LEARNING_TRACKER.md` with identical values?
  * If NO: Update the missing tracker file immediately.

### GATE 4 — CLASS NOTE PURITY GATE (Under 220 Lines & Pure SQL)
- [ ] Before saving any `.sql` class note in `01_CLASS_NOTES/`, did I verify:
  * Total lines <= 220?
  * ALL SQL keywords in UPPERCASE?
  * Zero paragraph essays, zero vocabulary lists, zero multi-paragraph analogies (moved to `_REVISION.md`)?
  * If NO: Clean and trim the `.sql` note before proceeding.

### GATE 5 — LIVE DEPLOYMENT GATE (Vercel Sync)
- [ ] After ANY modification to `TODAYS_TASKS.txt` or the course brain, did I execute the build and push pipeline?
  * Command: `cd "d:\DE COURSE\DASHBOARD" ; node copy_tasks.cjs ; npm run build ; cd "d:\DE COURSE" ; git add . ; git commit -m "..." ; git push origin main`
  * If NO: Execute the pipeline now. Never leave the live dashboard out of sync.

### GATE 6 — ATOMIC SPRINT COMMIT GATE (4X-8X Dark Green Graph Law)
- [ ] Did I commit and push immediately after completing ANY individual sprint milestone (e.g. LinkedIn post, note rewrite, faculty task solve, practice drills) rather than batching everything into 1 single end-of-day commit?
  * Standard: 6 to 10 atomic, descriptive commits per day (`feat(sql): ...`, `docs(linkedin): ...`, `test(drills): ...`).
  * Target: Keep GitHub contribution square at Level 4 (Darkest Green 🔥).
  * If NO: Commit the completed sprint milestone immediately.

---

## 🛑 STRICT PROHIBITION SUMMARY
1. NEVER guess or estimate total study hours — calculate exact sum of active sprints.
2. NEVER schedule practice drills without scheduling that day's class note re-write first.
3. NEVER silently drop or omit unsolved class tasks or pending drills from the daily plan.
4. NEVER commit with mismatched file counts between trackers and physical disk.
5. NEVER batch all day's work into 1 single midnight commit — execute atomic sprint commits for dark green visibility.
