# 🔁 REVISION RECOMMENDER ENGINE & SPACED REPETITION SYSTEM

This recommender engine uses **Spaced Repetition Principles** and **Interview Frequency Weighting** to tell you exactly *what* to revise next and *how often* to revisit core topics.

---

## 🚦 SPACED REPETITION INTERVAL RULES

- **Interval 1 (Immediate)**: Same day as live class (Read Revision Note `.md`).
- **Interval 2 (Day + 1)**: Solve Index-Wise Practice Questions `.SQL`.
- **Interval 3 (Day + 3)**: Review Weak Spot Bug Traps & Error Analysis.
- **Interval 4 (Day + 7)**: Execute Enterprise Project `.SQL` incorporating the milestone.
- **Interval 5 (Day + 14 / Pre-Interview)**: Final Rapid Recall Check via Concept Heatmap.

---

## 🔴 HIGH-PRIORITY REVISION QUEUE (FOCUS THIS WEEK)

### 1. Topic: Column Property (`NOT NULL`) vs Table Constraint Syntax
- **Priority**: 🔴 CRITICAL
- **Reason**: Common syntax mistake in live tests & interviews.
- **Action**: Review [`03_REVISION_NOTES/2026-08-13_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-13_REVISION.md#step-2--concept-understanding).
- **Key Code**:
  ```sql
  -- Column Property:
  ALTER TABLE table_name ALTER COLUMN column_name datatype NOT NULL;
  
  -- Table Constraint:
  ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column_name);
  ```

### 2. Topic: Transactional `TRUNCATE` Rollback Mechanics
- **Priority**: 🔴 CRITICAL
- **Reason**: Offline SQL Test Question 12 misconception.
- **Action**: Review [`03_REVISION_NOTES/2026-08-13_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-13_REVISION.md#step-5--common-mistakes--debugging).
- **Key Code**:
  ```sql
  BEGIN TRANSACTION;
      TRUNCATE TABLE Employee; -- Deallocates data pages via log header
  ROLLBACK; -- 100% of rows ARE restored in SQL Server!
  ```

### 3. Topic: Logical Execution Sequence & Column Alias Scoping
- **Priority**: 🔴 CRITICAL
- **Reason**: Core Data Engineering query execution foundation.
- **Action**: Review [`03_REVISION_NOTES/2026-08-07_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-07_REVISION.md).
- **Sequence**:
  $$\text{FROM} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{SELECT} \longrightarrow \text{ORDER BY}$$

### 4. Topic: Parent vs Child Table Destruction Protection Rules
- **Priority**: 🔴 CRITICAL
- **Reason**: Database Administrator (DBA) & ETL safety validation.
- **Action**: Review [`03_REVISION_NOTES/2026-08-12_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-12_REVISION.md).

---

## 🟡 MEDIUM-PRIORITY REVISION QUEUE (MAINTENANCE)

1. **Pattern Matching & LIKE Wildcards** (`%`, `_`, `[A-Z]`, `[^A-Z]`) — Review [`2026-08-02_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-02_REVISION.md) & [`2026-08-03_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-03_REVISION.md).
2. **`NULL` Handling in Aggregate Functions** (`AVG` vs `COUNT(*)`) — Review [`2026-08-06_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-06_REVISION.md).
3. **10 Data Insertion Patterns & `IDENTITY` Seed/Step** — Review [`2026-08-11_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-11_REVISION.md).

---

## 🟢 LOW-PRIORITY REVISION QUEUE (STABLE CONCEPTS)

1. **Basic SQL Command Types** (DDL, DML, DQL) — [`2026-08-01_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-01_REVISION.md).
2. **Computed Column Aliases & Arithmetic Operations** — [`2026-08-04_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-04_REVISION.md).
3. **Renaming Objects via `sp_rename`** — [`2026-08-05_REVISION.md`](file:///d:/DE%20COURSE/01_SQL/03_REVISION_NOTES/2026-08-05_REVISION.md).
