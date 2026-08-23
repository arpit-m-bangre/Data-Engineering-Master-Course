# 🧠 CONCEPT MASTERY HEATMAP & REVISION INTELLIGENCE ENGINE

This document tracks every core SQL & Data Engineering technical concept covered across all class notes, classifying them by **Mastery Level**, **Interview Frequency Weight**, **Common Error Bugs**, and **Spaced Revision Counts**.

---

## 📊 SUMMARY HEATMAP DASHBOARD

| Concept Category | Total Topics | Mastered | Needs Revision | High Interview Weight |
| :--- | :---: | :---: | :---: | :---: |
| **1. Database Architecture & DDL/DML** | 8 | 7 | 1 | 🔴 High |
| **2. Filtering, Wildcards & Operators** | 6 | 6 | 0 | 🟡 Medium |
| **3. Aggregates, GROUP BY & HAVING** | 6 | 4 | 2 | 🔴 High |
| **4. Constraints & Data Governance** | 7 | 5 | 2 | 🔴 High |
| **5. Relational Architecture & Foreign Keys** | 5 | 5 | 0 | 🔴 High |
| **6. Dynamic Schema Retrofitting & Metadata** | 4 | 3 | 1 | 🔴 High |
| **7. Temporal Data Types & Date Functions** | 5 | 5 | 0 | 🔴 High |
| **8. Relational Joins & Cartesian Math** | 11 | 11 | 0 | 🔴 High |
| **9. Self Joins & Hierarchical Modeling** | 5 | 5 | 0 | 🔴 High |
| **10. Window Functions & Ranking Engines** | 6 | 6 | 0 | 🔴 High |

---

## 🔍 DETAILED CONCEPT INTELLIGENCE MATRIX

### SECTION 1: DATABASE ARCHITECTURE & DDL/DML MECHANICS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C1.1** | SQL Commands Classification (DDL, DML, DQL, DCL, TCL) | MASTERED | Misclassifying TRUNCATE as DML | 1 | 🟡 Medium |
| **C1.2** | `CREATE TABLE` Data Types (`INT`, `DECIMAL`, `VARCHAR`) | MASTERED | Exceeding `VARCHAR` size limits | 1 | 🟢 Low |
| **C1.3** | Selective Data Extraction & Aliases | MASTERED | Duplicate column alias ambiguity | 1 | 🟢 Low |
| **C1.4** | Data Insertion Patterns & `NULL` Handling | MASTERED | Inserting string into INT column | 1 | 🟢 Low |
| **C1.5** | Arithmetic Operators & Computed Aliases | MASTERED | Division by zero error | 1 | 🟢 Low |
| **C1.6** | `UPDATE` Statement (Single/Multiple Columns) | MASTERED | Running `UPDATE` without `WHERE` clause | 1 | 🔴 High |
| **C1.7** | `DELETE` Statement (Row-level deletion) | MASTERED | `DELETE` without `WHERE` wiping entire table | 1 | 🔴 High |
| **C1.8** | Storage Mechanics: `DELETE` vs `TRUNCATE` vs `DROP` | NEEDS REVISION | Misunderstanding `TRUNCATE` rollback capability inside explicit transactions | 1 | 🔴 High |

---

### SECTION 2: FILTERING OPERATORS & STRING PATTERN MATCHING
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C2.1** | Comparison Operators (`=`, `<>`, `<`, `<=`, `>`, `>=`) | MASTERED | ASCII character string comparisons | 1 | 🟢 Low |
| **C2.2** | Range Filtering (`BETWEEN` / `NOT BETWEEN`) | MASTERED | Boundary value inclusion/exclusion | 1 | 🟡 Medium |
| **C2.3** | List Filtering (`IN` / `NOT IN`) | MASTERED | `NOT IN` failing when list contains `NULL` | 1 | 🔴 High |
| **C2.4** | Nullability Operators (`IS NULL` / `IS NOT NULL`) | MASTERED | Writing `= NULL` instead of `IS NULL` | 1 | 🔴 High |
| **C2.5** | Logical Operators (`AND` / `OR` Precedence) | MASTERED | Missing parentheses in complex `AND`/`OR` | 1 | 🟡 Medium |
| **C2.6** | Wildcards (`LIKE '%'`, `'_'`, `[A-Z]`, `[^A-Z]`) | MASTERED | Case sensitivity settings in SSMS | 1 | 🟡 Medium |

---

### SECTION 3: AGGREGATES, GROUP BY & CLAUSE EXECUTION FLOW
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C3.1** | Aggregate Functions (`MIN`, `MAX`, `SUM`, `AVG`, `COUNT`) | MASTERED | Attempting `SUM()` on `VARCHAR` column | 1 | 🟡 Medium |
| **C3.2** | `NULL` Handling in Aggregates | MASTERED | Forgetting `AVG()` ignores `NULL` while `COUNT(*)` counts `NULL` | 1 | 🔴 High |
| **C3.3** | `DISTINCT` & `COUNT(DISTINCT)` | MASTERED | Syntax placement of `DISTINCT` inside aggregate | 1 | 🟡 Medium |
| **C3.4** | 6-Stage Logical Execution Sequence | MASTERED | Scoping errors: using aliases in `WHERE` | 1 | 🔴 High |
| **C3.5** | `WHERE` vs `HAVING` Filtering Mechanics | NEEDS REVISION | Pre-filtering row performance on 1M rows (`WHERE` vs `HAVING`) | 1 | 🔴 High |
| **C3.6** | `ORDER BY` Sorting Rules & Alias Scoping | MASTERED | Sorting by column position numbers | 1 | 🟢 Low |

---

### SECTION 4: CONSTRAINTS, DATA GOVERNANCE & SCHEMA RETROFITTING
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C4.1** | `PRIMARY KEY` (Uniqueness + NOT NULL) | MASTERED | Trying to create multiple PKs per table | 1 | 🔴 High |
| **C4.2** | `UNIQUE` Constraint (Single NULL support) | MASTERED | Error Msg 1750 on duplicate key values | 1 | 🟡 Medium |
| **C4.3** | Column Property (`NOT NULL`) vs Table Constraint | NEEDS REVISION | Using `ADD CONSTRAINT` for `NOT NULL` instead of `ALTER COLUMN` | 1 | 🔴 High |
| **C4.4** | `CHECK` Constraint & Range/Negation Expressions | MASTERED | Conflict with existing table data | 1 | 🟡 Medium |
| **C4.5** | `DEFAULT` Constraint & In-Class Task Syntax | MASTERED | Forgetting `FOR column_name` in `ALTER TABLE` | 1 | 🟡 Medium |
| **C4.6** | `IDENTITY` Auto-Increment Rules & Seed/Step | MASTERED | Attempting `IDENTITY` on populated existing column | 1 | 🔴 High |
| **C4.7** | Pre-Cleaning Strategy Before Retrofitting Constraints | NEEDS REVISION | Running `ALTER TABLE` before deleting `NULL`s | 1 | 🔴 High |

---

### SECTION 5: RELATIONAL ARCHITECTURE & FOREIGN KEYS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C5.1** | Parent-Child Table Relationships | MASTERED | Attempting FK to non-PK column | 1 | 🔴 High |
| **C5.2** | Foreign Key Validation Logic & Insertions | MASTERED | Orphan key insertion error | 1 | 🔴 High |
| **C5.3** | Destruction Rules: `DELETE` on Referenced Parent | MASTERED | Foreign Key reference violation error | 1 | 🔴 High |
| **C5.4** | Destruction Rules: `TRUNCATE` on Referenced Parent | MASTERED | `TRUNCATE` failing even if child table has 0 rows | 1 | 🔴 High |
| **C5.5** | Destruction Rules: `DROP` & Bottom-Up Teardown | MASTERED | Incorrect teardown order (Parent before Child) | 1 | 🔴 High |

---

### SECTION 7: TEMPORAL DATA TYPES & DATE FUNCTIONS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C7.1** | `GETDATE()` Live Timestamp Retrieval | MASTERED | Time zone differences vs UTC | 1 | 🟢 Low |
| **C7.2** | `DATEDIFF()` Interval Differences & Boundary Crossing | MASTERED | Counting boundary crossing vs continuous elapsed time | 1 | 🔴 High |
| **C7.3** | `DATEDIFF()` Integer Overflow with High Precision (`MS`) | MASTERED | Msg 535 overflow when interval exceeds ~24.8 days | 1 | 🔴 High |
| **C7.4** | `DATEPART()` Component Extraction (`WEEKDAY`, `QQ`, etc.) | MASTERED | Misinterpreting 1-based Sunday weekday index | 1 | 🟡 Medium |
| **C7.5** | `DATEADD()` & `EOMONTH()` Horizon & Cycle Calculations | MASTERED | Invalid date string conversions (Msg 241) | 1 | 🔴 High |

### SECTION 8: RELATIONAL JOINS, CARTESIAN PRODUCTS & ADVANCED PATTERNS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C8.1** | Cartesian Cross-Product (N x M) & Join Engine Model | MASTERED | Unbounded join runaway explosion on unindexed tables | 1 | 🔴 High |
| **C8.2** | Three-Valued Logic in Equi-Joins (`NULL = NULL` is UNKNOWN) | MASTERED | Assuming `NULL` matches `NULL` in `INNER JOIN` | 1 | 🔴 High |
| **C8.3** | `INTERSECT` vs `INNER JOIN` Architectural Divergence | MASTERED | Confusing deduplicated Set intersection with Cartesian multiplication | 1 | 🔴 High |
| **C8.4** | String Literal `'NULL'` vs SQL Keyword `NULL` | MASTERED | Quoted string `'NULL'` matching other strings vs keyword NULL | 1 | 🔴 High |
| **C8.5** | Master Mathematical Row-Count Formulas for Joins | MASTERED | Incorrectly double-counting unmatched rows in `FULL OUTER JOIN` | 1 | 🔴 High |
| **C8.6** | ANSI Join Syntax & Column Ambiguity Resolution | MASTERED | Msg 209 Ambiguous column name error | 1 | 🔴 High |
| **C8.7** | Anti-Join Pattern (`LEFT JOIN ... WHERE key IS NULL`) | MASTERED | Accidentally filtering on LEFT table key instead of RIGHT | 1 | 🔴 High |
| **C8.8** | Relational Joins with `GROUP BY` Aggregations | MASTERED | Using `INNER JOIN` and dropping empty entities from reports | 1 | 🔴 High |
| **C8.9** | Multi-Table Chained Joins (3+ Tables) & Granularity | MASTERED | Joining on wrong table key in 3-way chain | 1 | 🔴 High |
| **C8.10** | ANSI `CROSS JOIN` Combinations & Round-Robin Matrix | MASTERED | Accidental Cartesian explosion on large datasets | 1 | 🟡 Medium |
| **C8.11** | Non-ANSI Legacy Comma Joins vs ANSI SQL-92 | MASTERED | Missing WHERE clause causing unintended Cartesian product | 1 | 🔴 High |

---

### SECTION 9: SELF JOINS, HIERARCHICAL TREES & FRAUD ANOMALY DETECTION
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C9.1** | Self Join Virtual Table Aliasing Architecture | MASTERED | Msg 209 Ambiguous column name without explicit prefix | 1 | 🔴 High |
| **C9.2** | Employee-Manager Hierarchical Join (`e.MID = m.EmpID`) | MASTERED | Inverted join logic (`e.EmpID = m.MID`) | 1 | 🔴 High |
| **C9.3** | Root Manager Nullability & `LEFT JOIN` Handling | MASTERED | CEO disappearing from `INNER JOIN` report due to NULL MID | 1 | 🔴 High |
| **C9.4** | Same-Table Pairing & Symmetric Deduplication (`<` vs `<>`) | MASTERED | Using `<>` and generating 2x mirror duplicate pairs | 1 | 🔴 High |
| **C9.5** | Geo-Temporal Window Anomaly & Banking Fraud Detection | MASTERED | Incorrect timestamp interval window in `DATEDIFF()` | 1 | 🔴 High |

### SECTION 10: WINDOW FUNCTIONS & RANKING ENGINES
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C10.1** | `OVER()` Clause & Window Taxonomy (Ranking/Value/Aggregate) | MASTERED | Missing parentheses after `OVER` | 1 | 🔴 High |
| **C10.2** | `ROW_NUMBER()` Sequential Generation & Deterministic Ties | MASTERED | Non-deterministic ordering without unique secondary tie-breaker | 1 | 🔴 High |
| **C10.3** | `DENSE_RANK()` Continuous Ranking without Gaps | MASTERED | Using `RANK()` instead of `DENSE_RANK()` for Nth highest salary | 1 | 🔴 High |
| **C10.4** | `RANK()` Positional Ranking with Gaps on Ties | MASTERED | Miscalculating gap jumps after multi-row ties | 1 | 🔴 High |
| **C10.5** | `PARTITION BY` Sub-Grouping Mechanics | MASTERED | Confusing `PARTITION BY` with `GROUP BY` row collapsing | 1 | 🔴 High |
| **C10.6** | Window Function Query Execution Order & Scoping | MASTERED | Msg 4108: Attempting to use window functions directly in `WHERE` | 1 | 🔴 High |

---

## 🎯 TOP 5 WEAK SPOTS & REVISION TARGETS

1. **`TRUNCATE` Rollback Behavior inside Explicit Transactions**:
   - *Key Rule*: In SQL Server, `TRUNCATE TABLE` is a log-header DDL operation. Although metadata-based, page deallocations ARE logged and CAN be rolled back inside `BEGIN TRANSACTION ... ROLLBACK`!
2. **Column Property (`NOT NULL`) vs Named Constraints Syntax**:
   - *Key Rule*: `NOT NULL` is a structural column property modified via `ALTER TABLE t ALTER COLUMN c INT NOT NULL`. Table constraints (`PK`, `FK`, `UNIQUE`, `CHECK`, `DEFAULT`) use `ALTER TABLE t ADD CONSTRAINT k_name ...`.
3. **`WHERE` vs `HAVING` Performance Optimization on Large Datasets**:
   - *Key Rule*: Pre-filtering rows via `WHERE` before grouping reduces rows processed by `GROUP BY` and accelerates queries. `HAVING` should be reserved strictly for aggregate group thresholds.
4. **Data Sanitization Before Retrofitting Constraints**:
   - *Key Rule*: Always execute pre-cleaning queries (`DELETE ... WHERE col IS NULL`) prior to running `ALTER TABLE ADD CONSTRAINT` to avoid Error Msg 1750.
5. **The Cartesian Duplicate Explosion in Production ETL Pipelines**:
   - *Key Rule*: Always verify join key cardinality and deduplicate staging tables before joining to avoid accidental N x M Cartesian runaway row explosions.
