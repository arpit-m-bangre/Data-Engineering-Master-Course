# 🔒 MASTER CLASS PROCESSING CHECKLIST
# Zero-Miss Enforcement Protocol — MANDATORY FOR EVERY CLASS FILE

## ⚡ TRIGGER
This checklist is MANDATORY whenever the user provides a new class
raw note file (.sql or .txt) for processing.

---

## ✅ STEP-BY-STEP EXECUTION ORDER
The agent MUST execute ALL 11 steps in this exact sequence.
No step may be skipped. No step may be reordered.

### STEP 1 — FORMAT CLASS NOTES
- File: `01_SQL/01_CLASS_NOTES/YYYY-MM-DD.sql`
- Rules:
  * SQL queries FIRST, success/failure description BELOW them.
  * ALL SQL keywords in UPPERCASE.
  * All comments wrapped to max 80 characters per line.
  * Add real-world analogy explanations for every new concept.
  * Double equal-sign dividers for major sections.
  * Single hyphen dividers for tips, notes, execution flow.
  * ZERO data loss — preserve every query, value, and comment.

### STEP 2 — CREATE REVISION NOTE
- File: `01_SQL/03_REVISION_NOTES/YYYY-MM-DD_REVISION.md`
- Rules:
  * Use the 7-step interactive framework:
    1. What did we learn today? (Topic Summary)
    2. Why does it matter? (Real-world relevance)
    3. Key Syntax & Rules (Code blocks)
    4. Analogy Corner (Simple real-life comparison)
    5. Common Mistakes & Traps (What to avoid)
    6. Vocabulary & Definitions (Plain English meanings)
    7. Quick Self-Quiz (3–5 concept-check questions)
  * Language must be extremely simple and conversational.
  * Must include a dedicated Vocabulary section.

### STEP 3 — GENERATE 20 PRACTICE QUESTIONS
- File: `01_SQL/05_INDEX_WISE_QUESTIONS/YYYY-MM-DD_QUESTIONS.SQL`
- Rules:
  * Begin with PHASE 0: ENVIRONMENT SETUP (CREATE TABLE + INSERT rows)
  * Exactly 20 questions, divided into 4 phases of 5 questions each:
    - Phase 1 (Q1–Q5):  Basic Syntax Drills
    - Phase 2 (Q6–Q10): Cumulative Revision (previous topics)
    - Phase 3 (Q11–Q15): Enterprise Scenario Challenges
                         (use multi-part subquestions Q11.1, Q11.2...)
    - Phase 4 (Q16–Q20): Logic Builder & Debug broken SQL
  * Every question must have a blank line below
    `-- Write your SQL Query below:` for the user to write freely.
  * Comments wrapped to max 45–50 characters (SSMS side-by-side).
  * NO answers pre-filled — practice only.

### STEP 4 — CREATE DAILY INDEX
- File: `01_SQL/02_DAILY_INDEX/YYYY-MM-DD_INDEX.SQL`
- Rules:
  * List every topic and subtopic covered in today's class.
  * Use numbered formatting inside SQL comment blocks.

### STEP 5 — UPDATE COMBINED INDEX
- File: `01_SQL/02_DAILY_INDEX/01_COMBINED_INDEX_ALL_TOPICS.SQL`
- Rules:
  * Append today's topics as a new dated section.
  * Never modify or delete existing sections.

### STEP 6 — EVALUATE CLASS TASK
- File: `01_SQL/04_CLASS_TASKS/YYYY-MM-DD_CLASS_TASK.SQL`
  (Only if instructor assigned tasks during class)
- Rules:
  * Preserve 100% of the instructor's original question wording.
  * NO simplification or rewording of instructor text.
  * Add space below each question for user answers.

### STEP 7 — EVALUATE PROJECT MILESTONE
- File: `01_SQL/06_PROJECTS/PROJECT<N>.SQL`
  (Only if today's topic introduces a new major milestone)
- Milestones: Joins, Subqueries, CTEs, Window Functions,
              Indexing, Stored Procedures.
- Rules:
  * Only create a new PROJECT<N>.SQL at a true milestone.
  * Do NOT create a redundant project file for continuation lessons.

### STEP 8 — UPDATE MASTER LEARNING TRACKER
- File: `LEARNING_DIARY/MASTER_LEARNING_TRACKER.txt`
- Rules:
  * Add a new row to Section 2 (Recovery Plan) for this date.
  * Mark the status of each deliverable (Notes, Revision, Q, Task).
  * Update the dashboard counters at the top.

### STEP 9 — UPDATE METRICS & STATISTICS
- File: `LEARNING_DIARY/METRICS_AND_STATISTICS.json`
- Rules:
  * Increment `class_notes_processed` by 1.
  * Increment `daily_indexes_created` by 1.
  * Increment `revision_notes_total` by 1.
  * Increment `practice_question_files` by 1.
  * Add 20 to `practice_questions_total_drills`.
  * If a class task exists, increment `faculty_class_task_files`.
  * If a project was created, increment `projects_total_scheduled`.
  * Update `last_active_date` to today.

### STEP 10 — UPDATE CONCEPT MASTERY HEATMAP
- File: `LEARNING_DIARY/CONCEPT_MASTERY_HEATMAP.md`
- Rules:
  * Add today's concepts to the matrix with mastery level.
  * Flag high-interview-weight concepts.

### STEP 11 — COMMIT & PUSH TO GITHUB
- Command: `git add . && git commit -m "..." && git push origin main`
- Rules:
  * Commit message must clearly list ALL files changed.
  * Verify push with git status after push.
  * This MUST be the LAST step — never commit mid-flow.

---

## 🚨 PRE-FLIGHT AUDIT (BEFORE CONFIRMING DONE)
After completing all 11 steps, the agent MUST run a physical
directory count and confirm:
- `01_CLASS_NOTES/`    → N files
- `03_REVISION_NOTES/` → N files  ← (MUST match class notes count)
- `05_INDEX_WISE_QUESTIONS/` → N files ← (MUST match class notes count)
- `02_DAILY_INDEX/`    → N daily index files + 1 combined
- `04_CLASS_TASKS/`    → only on task days
- `06_PROJECTS/`       → only on milestone days

If ANY count is mismatched, the agent MUST fix before committing.

---

## ❌ WHAT IS NEVER ALLOWED
1. Skipping the Revision Note (Step 2) — it is NOT optional.
2. Skipping the Metrics update (Step 9) — numbers must stay live.
3. Committing before all 11 steps are verified complete.
4. Deleting or overwriting directories with recursive commands.
5. Pre-filling answers in the Questions file.
6. Rewording instructor task questions.
7. Hallucinating file counts — always check disk physically.
