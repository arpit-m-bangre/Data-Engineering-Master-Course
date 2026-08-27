---
name: pippo_brain_ops
description: >-
  Master class processing and ecosystem synchronization runbook for Pippo in DE COURSE.
  Use when processing raw class notes, creating daily indexes, 7-step revision notes, faculty class tasks,
  14-drill practice sets, milestone projects, and updating the centralized course brain trackers.
---

# 🧠 PIPPO MASTER BRAIN OPS RUNBOOK

This skill defines the complete, zero-miss, step-by-step operating procedure for processing raw class notes and synchronizing the 11-file Data Engineering ecosystem.

---

## ⚡ TRIGGER CONDITIONS
Activate this skill whenever:
- User provides a new class raw note (e.g. `2026-08-22.sql` in `01_CLASS_NOTES/`).
- User asks to process a class note, sync ecosystem, or generate full day materials.

---

## 🛑 PHASE 0: PRE-FLIGHT DISK AUDIT (MANDATORY FIRST STEP)

Before generating or modifying any file:
1. Inspect directory contents of:
   - `01_SQL/01_CLASS_NOTES/` -> Count current class notes ($N_{notes}$)
   - `01_SQL/02_DAILY_INDEX/` -> Count current daily indexes
   - `01_SQL/03_REVISION_NOTES/` -> Count current revision notes
   - `01_SQL/04_CLASS_TASKS/` -> Count current class tasks
   - `01_SQL/05_INDEX_WISE_QUESTIONS/` -> Count current question files
   - `01_SQL/06_PROJECTS/` -> Count current project files ($N_{proj}$)
2. Read `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt` to confirm day sequence number ($N_{day} = N_{notes} + 1$).
3. Read `LEARNING_DIARY/METRICS_AND_STATISTICS.json` to capture baseline metrics.

---

## 📝 PHASE 1: CORE ECOSYSTEM FILE GENERATION (STRICT SEQUENCE)

Execute each step in order. Do NOT skip or batch-reorder.

### Step 1: Restructure Class Note (`01_SQL/01_CLASS_NOTES/YYYY-MM-DD.sql`)
- **Format**: Pure executable T-SQL under **150-220 lines** (Constitutional Law #12).
- **Keywords**: ALL SQL keywords in UPPERCASE (`SELECT`, `FROM`, `WHERE`, `JOIN`, `OVER`, `PARTITION BY`).
- **Comments**: Short 1-2 line `/* Theory: ... */` and `-- inline notes`.
- **Exclusions**: ZERO paragraph essays, ZERO vocabulary sections, ZERO multi-paragraph analogies.
- **Pointer**: Include single line `/* Faculty Homework: see 04_CLASS_TASKS/YYYY-MM-DD_CLASS_TASK.SQL */`.
- **Self-Verification Gate**: Re-read file. Confirm line count <= 220, all keywords uppercase, no bloat.

### Step 2: Create Standalone Daily Index (`01_SQL/02_DAILY_INDEX/YYYY-MM-DD_INDEX.SQL`)
- Numbered breakdown of all topics and subtopics covered in today's class.

### Step 3: Update Master Combined Index (`01_SQL/02_DAILY_INDEX/01_COMBINED_INDEX_ALL_TOPICS.SQL`)
- Update file header module count.
- Append new dated section under Section 1.
- Update Section 2 category mapping if new major topic introduced.

### Step 4: Create 7-Step Revision Note (`01_SQL/03_REVISION_NOTES/YYYY-MM-DD_REVISION.md`)
- **Structure**:
  1. Executive Summary & Vivid Real-Life Analogies
  2. Technical Vocabulary & Definitions
  3. Architecture & Deep Technical Breakdown (Side-by-side matrices)
  4. Practical Code Blueprints & T-SQL Lab
  5. Logical Query Execution Order & Scoping Rules
  6. 10 Bug Traps & Tier-1 Interview Scenarios
  7. Self-Assessment Flashcards & Practice Drills
- **Rules**: 100% Pure Markdown (Zero raw HTML tags: no `<details>`, `<summary>`, `<b>`). 100% Clean ASCII Math (Zero LaTeX delimiters: no `...`, `x`).

### Step 5: Create Faculty Class Tasks (`01_SQL/04_CLASS_TASKS/YYYY-MM-DD_CLASS_TASK.SQL`)
- Phase 0 environment setup tables & seed data.
- Scenario tasks matching faculty lecture problems.
- Blank query blocks below `-- Write your SQL Query below:`.

### Step 6: Create Practice Drill Set (`01_SQL/05_INDEX_WISE_QUESTIONS/YYYY-MM-DD_QUESTIONS.SQL`)
- Phase 0 environment setup tables & seed data.
- **Exactly 14 targeted questions** (Constitutional Law #3).
- Blank query blocks below `-- Write your SQL Query below:`.
- NO pre-filled query solutions in the practice file.

### Step 7: Evaluate Enterprise Project Milestone (`01_SQL/06_PROJECTS/`)
- If today's class introduces a major advanced milestone (Joins, Subqueries, CTEs, Window Functions, Indexing, Stored Procedures):
  * Create `PROJECT<N>.SQL` where $N = N_{proj} + 1$.
  * Full end-to-end multi-table warehouse schema, transactional data seeding, and analytic queries.

---

## 🧠 PHASE 2: CENTRAL COURSE BRAIN SYNCHRONIZATION (DUAL SYNC)

### Step 8: Update `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt`
- Update header date and completion percentage.
- Add Day row to Section 1 / Section 2 Backlog Matrix.
- Update Projects Matrix with exact physical file count.

### Step 9: Update `LEARNING_DIARY/MASTER_LEARNING_TRACKER.md`
- Mirror exact changes from Step 8 into the Markdown SSOT tracker.

### Step 10: Update `LEARNING_DIARY/METRICS_AND_STATISTICS.json`
- Increment `class_notes_processed` by 1.
- Increment `daily_indexes_created` by 1.
- Increment `revision_notes_total` by 1.
- Increment `practice_question_files` by 1.
- Increment `practice_questions_total_drills` by 14.
- If class tasks exist: increment `faculty_class_task_files`.
- If project created: increment `projects_total_scheduled`.
- Update `last_active_date`.
- Verify ALL numbers match physical file counts on disk.

### Step 11: Update `LEARNING_DIARY/CONCEPT_MASTERY_HEATMAP.md`
- Add today's concepts, bug traps, and interview weight classifications.
- Update summary heatmap table.

### Step 12: Append to `LEARNING_DIARY/LEARNING_DIARY.txt`
- Append dated progress log entry. Never overwrite existing entries.

### Step 13: Update `README.md`
- Update project range (`PROJECT1 - <N>`) and course summary.

### Step 14: Synchronize `EXTRA_MAGICAL_FILES/SYSTEM_MAP.md` (Constitutional Law #17)
- Add new files to the master inventory tables with line counts and byte sizes.
- Verify 100% compliance across all 16 Constitutional Laws.
- Update total file counts and certified audit status.

---

## 🚀 PHASE 3: PRODUCTION BUILD & LIVE DEPLOYMENT

### Step 15: Execute Build & Push Pipeline
```powershell
cd "d:\DE COURSE\DASHBOARD" ; node copy_tasks.cjs ; npm run build ; cd "d:\DE COURSE" ; $env:GCM_INTERACTIVE="never" ; git add . ; git commit -m "feat(sql): add Day N ecosystem, SYSTEM_MAP sync & brain synchronization" ; git push origin main
```

---

## 🚨 PHASE 4: POST-FLIGHT AUDIT & VERIFICATION

1. Verify:
   \text{Class Notes Count} = \text{Revision Notes Count} = \text{Questions Count} = \text{Indexes Count}
2. Verify Metrics JSON matches physical disk count.
3. Verify Trackers match physical disk count.
4. Verify `SYSTEM_MAP.md` is 100% synchronized.
5. Verify Git push completed with exit code 0.
