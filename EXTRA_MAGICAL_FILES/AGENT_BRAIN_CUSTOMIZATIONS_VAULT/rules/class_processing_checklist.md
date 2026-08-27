# 🔒 MASTER CLASS PROCESSING CHECKLIST
# Zero-Miss Enforcement Protocol — MANDATORY FOR EVERY CLASS FILE
# Aligned with AGENTS.md Supreme Law (14 Questions Standard)

## ⚡ TRIGGER
This checklist is MANDATORY whenever the user provides a new class
raw note file (.sql or .txt) for processing.

---

## 🛑 PRE-FLIGHT AUDIT (STEP 0 — BEFORE WRITING ANY FILE)
1. Physically check all 6 subdirectories in `01_SQL/` using directory inspection.
2. Record current counts:
   - `01_CLASS_NOTES/` -> Count N
   - `02_DAILY_INDEX/` -> Count N + 1 combined
   - `03_REVISION_NOTES/` -> Count N
   - `04_CLASS_TASKS/` -> Count T
   - `05_INDEX_WISE_QUESTIONS/` -> Count N
   - `06_PROJECTS/` -> Count P
3. Read `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt` to confirm day number and pending items.
4. Read `LEARNING_DIARY/METRICS_AND_STATISTICS.json` to confirm current state.

---

## ✅ STEP-BY-STEP EXECUTION ORDER
The agent MUST execute ALL 11 steps in this exact sequence.
No step may be skipped. No step may be reordered.

### STEP 1 — FORMAT CLASS NOTES
- File: `01_SQL/01_CLASS_NOTES/YYYY-MM-DD.sql`
- Rules:
  * Maximum file length: strictly 150-220 lines (Constitutional Law #12).
  * Pure executable SQL only. Short 1-2 line `/* Theory: ... */` or `-- inline comment`.
  * ALL SQL keywords in UPPERCASE.
  * NO paragraph essays, NO vocabulary sections, NO multi-paragraph analogies in .sql files (all rich content lives in _REVISION.md).
  * Single line pointer for homework: `/* Faculty Homework: see 04_CLASS_TASKS/YYYY-MM-DD_CLASS_TASK.SQL */`.
  * ZERO data loss — preserve 100% of underlying queries, constraints, and execution flow.
- Post-Write Gate: Re-read file. Verify line count <= 220, all keywords uppercase, zero bloat.

### STEP 2 — CREATE REVISION NOTE
- File: `01_SQL/03_REVISION_NOTES/YYYY-MM-DD_REVISION.md`
- Rules:
  * Use the 7-step interactive framework:
    1. Executive Summary & Real-Life Analogies
    2. Technical Vocabulary & Definitions (Plain English meanings)
    3. Architecture & Deep Technical Breakdown (Side-by-side matrices)
    4. Practical Code Blueprints & T-SQL Lab
    5. Logical Query Execution Order & Scoping Rules
    6. 10 Bug Traps & Tier-1 Interview Scenarios
    7. Self-Assessment Flashcards & Practice Drills
  * 100% Pure GitHub Flavored Markdown (Zero HTML tags: no `<details>`, `<summary>`, `<b>`).
  * 100% Clean ASCII Math (Zero LaTeX delimiters: no `...`, `$...$`, `x`).
- Post-Write Gate: Verify all 7 steps present, no raw HTML, no LaTeX.

### STEP 3 — GENERATE 14 PRACTICE QUESTIONS
- File: `01_SQL/05_INDEX_WISE_QUESTIONS/YYYY-MM-DD_QUESTIONS.SQL`
- Rules:
  * Begin with PHASE 0: ENVIRONMENT SETUP (CREATE TABLE + INSERT rows).
  * Exactly 14 targeted questions (Constitutional Law #3).
  * Enclosed inside comment blocks with blank lines below `-- Write your SQL Query below:`.
  * NO answers pre-filled in the practice file.
  * Clean vertical layout for SSMS side-by-side editing.
- Post-Write Gate: Re-read file. Count questions. Must equal EXACTLY 14.

### STEP 4 — CREATE DAILY INDEX
- File: `01_SQL/02_DAILY_INDEX/YYYY-MM-DD_INDEX.SQL`
- Rules:
  * List every topic and subtopic covered in today's class.
  * Use numbered formatting inside SQL comment blocks.

### STEP 5 — UPDATE COMBINED INDEX
- File: `01_SQL/02_DAILY_INDEX/01_COMBINED_INDEX_ALL_TOPICS.SQL`
- Rules:
  * Update total module/file count header.
  * Append today's topics as a new dated section under Section 1.
  * Update Section 2 category mapping if new category/topic introduced.
  * Never modify or delete previous existing sections.

### STEP 6 — EVALUATE CLASS TASK
- File: `01_SQL/04_CLASS_TASKS/YYYY-MM-DD_CLASS_TASK.SQL`
- Rules:
  * Include Phase 0 setup tables & seed data.
  * Preserve 100% of instructor's scenario requirements and constraint rules.
  * Provide blank query template blocks with `-- Write your SQL Query below:`.

### STEP 7 — EVALUATE PROJECT MILESTONE
- File: `01_SQL/06_PROJECTS/PROJECT<N>.SQL`
- Rules:
  * Only create a new standalone project at true module milestones (Joins, Subqueries, CTEs, Window Functions, Indexing, Stored Procedures).
  * Continuation lessons enhance existing projects or class tasks.
  * Count existing projects on physical disk before naming PROJECT<N>.SQL.

### STEP 8 — UPDATE MASTER LEARNING TRACKER (DUAL SYNC)
- Files:
  1. `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt` (Plain text SSOT)
  2. `LEARNING_DIARY/MASTER_LEARNING_TRACKER.md` (Rich Markdown SSOT)
- Rules:
  * Add new dated row to Section 1 / 2 Backlog Matrix.
  * Update overall completion percentage and date.
  * Update Project Matrix with exact physical file count.
  * Both `.txt` and `.md` MUST be updated in the same turn with identical values.

### STEP 9 — UPDATE METRICS & STATISTICS
- File: `LEARNING_DIARY/METRICS_AND_STATISTICS.json`
- Rules:
  * Increment `class_notes_processed` by 1.
  * Increment `daily_indexes_created` by 1.
  * Increment `revision_notes_total` by 1.
  * Increment `practice_question_files` by 1.
  * Add 14 to `practice_questions_total_drills` (14 questions standard).
  * If a class task exists, increment `faculty_class_task_files`.
  * If a project was created, increment `projects_total_scheduled`.
  * Update `last_active_date` to current date.
  * ALL numbers must match physical file counts on disk.

### STEP 10 — UPDATE CONCEPT MASTERY HEATMAP
- File: `LEARNING_DIARY/CONCEPT_MASTERY_HEATMAP.md`
- Rules:
  * Add today's concepts to the matrix with mastery level and bug traps.
  * Flag high-interview-weight concepts.

### STEP 11 — APPEND TO LEARNING DIARY
- File: `LEARNING_DIARY/LEARNING_DIARY.txt`
- Rules:
  * Append a new dated entry summarizing today's progress.
  * Include: topics covered, files created, and deliverables.
  * NEVER delete or overwrite existing diary entries.

### STEP 12 — UPDATE README (PORTFOLIO HOMEPAGE)
- File: `README.md`
- Rules:
  * Update project range (e.g. PROJECT1 - 6) and file references.

### STEP 13 — BUILD DASHBOARD & COMMIT TO GITHUB
- Pipeline Command:
  ```powershell
  cd "d:\DE COURSE\DASHBOARD" ; node copy_tasks.cjs ; npm run build ; cd "d:\DE COURSE" ; git add . ; git commit -m "feat(sql): add Day N ecosystem & brain sync" ; git push origin main
  ```
- Rules:
  * Vite build MUST complete with exit code 0.
  * Git push MUST complete with exit code 0.

---

## 🚨 POST-FLIGHT AUDIT (MANDATORY BEFORE REPORTING DONE)
After completing all steps, physically verify:
1. `01_CLASS_NOTES/` count == `03_REVISION_NOTES/` count == `05_INDEX_WISE_QUESTIONS/` count.
2. `METRICS_AND_STATISTICS.json` counters match disk counts exactly.
3. `MASTER_LEARNING_TRACKER.txt` and `.md` match disk counts exactly.
4. Git commit pushed successfully to GitHub main.
