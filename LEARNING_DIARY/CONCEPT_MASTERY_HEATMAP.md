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
| **11. CTEs & Zero-Loss Deduplication Pipelines** | 5 | 5 | 0 | 🔴 High |
| **12. Value Window Functions (LEAD/LAG)** | 5 | 5 | 0 | 🔴 High |
| **13. Conditional Logic & CASE Expressions** | 6 | 6 | 0 | 🔴 High |
| **14. Surprise Test & Comprehensive Scenarios** | 5 | 4 | 1 | 🔴 High |
| **15. T-SQL Server String Functions Engine** | 7 | 7 | 0 | 🔴 High |
| **16. Advanced String Slicing & Name Parser** | 6 | 6 | 0 | 🔴 High |
| **17. Transaction Control, NULLs & Subqueries** | 5 | 5 | 0 | 🔴 High |
| **18. Stored Procedures, Views & Indexing** | 6 | 6 | 0 | 🔴 High |

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

### SECTION 11: COMMON TABLE EXPRESSIONS (CTEs) & DEDUPLICATION PIPELINES
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C11.1** | CTE Syntax & In-Memory Pipeline (`WITH CTE AS (...)`) | MASTERED | Missing semicolon `;` before `WITH` keyword | 1 | 🔴 High |
| **C11.2** | CTE Lifecycle & Single-Query Scope Rules | MASTERED | Querying CTE in a second statement | 1 | 🔴 High |
| **C11.3** | Nth Highest Filtering via CTE & `DENSE_RANK()` | MASTERED | Using `ROW_NUMBER()` on tied values | 1 | 🔴 High |
| **C11.4** | Full-Row Deduplication via `ROW_NUMBER()` Partitioning | MASTERED | Partitioning by partial columns | 1 | 🔴 High |
| **C11.5** | In-Place Data Cleansing via `DELETE FROM CTE` | MASTERED | Thinking CTE DELETE fails on virtual views | 1 | 🔴 High |

---

### SECTION 12: VALUE WINDOW FUNCTIONS & RUNNING AGGREGATES
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C12.1** | `LEAD()` Lookahead Mechanics & Offsets | MASTERED | NULL propagation when offset exceeds partition boundary | 1 | 🔴 High |
| **C12.2** | `LAG()` Lookback Mechanics & Defaults | MASTERED | Forgetting default fallback parameter (e.g. `0`) in variance math | 1 | 🔴 High |
| **C12.3** | Inventory Delta & Period-over-Period Pipelines | MASTERED | Using expensive self-joins instead of single-pass window cursors | 1 | 🔴 High |
| **C12.4** | Running / Cumulative Aggregate Windows (`SUM`, `MIN`) | MASTERED | Omitting `ORDER BY` and collapsing window into static partition total | 1 | 🔴 High |
| **C12.5** | Inter-Row Sequence & Boundary Comparison Analytics | MASTERED | Filtering directly in `WHERE` instead of wrapping inside CTE | 1 | 🔴 High |

---

### SECTION 13: CONDITIONAL LOGIC & CASE EXPRESSIONS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C13.1** | Searched CASE vs Simple CASE Syntax & Execution Semantics | MASTERED | Attempting `CASE col WHEN NULL` (fails due to 3-valued logic) | 0 | 🔴 High |
| **C13.2** | Multi-Tier Categorization & Data Type Precedence | MASTERED | Data type conversion conflict across `THEN` vs `ELSE` branches | 0 | 🔴 High |
| **C13.3** | Conditional Aggregations via CTE Pipelining | MASTERED | Attempting to reference SELECT `CASE` alias in `WHERE` or `GROUP BY` | 0 | 🔴 High |
| **C13.4** | NULL Arithmetic Resilience with Custom Fallback Values | MASTERED | `M1 + M2` returning NULL when single operand is NULL | 0 | 🔴 High |
| **C13.5** | Dynamic Custom Priority Sorting via `ORDER BY CASE` | MASTERED | Sorting performance degradation on unindexed billion-row tables | 0 | 🟡 Medium |

---

### SECTION 14: SURPRISE ASSESSMENT: ADVANCED SQL & SCENARIO LAB
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C14.1** | Percentage Growth Analytics via `LAG()` | MASTERED | First row NULL evaluation failing in `WHERE Salary > PrevSalary * 1.3` | 0 | 🔴 High |
| **C14.2** | Multi-Event Rolling Window Detection (>2 in 90d) | MASTERED | Counting unchanged price logs instead of true price changes (`Price <> PrevPrice`) | 0 | 🔴 High |
| **C14.3** | Calendar Completeness via `COUNT(DISTINCT MONTH)` | MASTERED | Using `COUNT(MONTH)` instead of `COUNT(DISTINCT MONTH)` | 0 | 🔴 High |
| **C14.4** | Self Join Pairing & Mirror Permutation Pruning | MASTERED | Using `<>` instead of `<` causing 2x mirror duplicate pairs `(A, B)` and `(B, A)` | 0 | 🔴 High |
| **C14.5** | Geo-Temporal Bank Fraud Collision Detection | MASTERED | Matching transaction against itself (missing `t1.TxnID < t2.TxnID`) | 0 | 🔴 High |

---

### SECTION 15: T-SQL SERVER STRING FUNCTIONS & DATA CLEANSING ENGINE
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C15.1** | `UPPER()` & `LOWER()` Case Normalization | MASTERED | Assuming SELECT projection permanently alters disk data | 0 | 🟢 Low |
| **C15.2** | Case Sensitivity in CHECK Constraints (Collation Trap) | MASTERED | Default `CI_AS` collation evaluating `a = UPPER(a)` as true | 0 | 🔴 High |
| **C15.3** | `LEN()` vs `DATALENGTH()` Storage Measurement | MASTERED | `LEN()` silently stripping trailing whitespace | 0 | 🔴 High |
| **C15.4** | `CONCAT()` vs `+` Operator Null Propagation | MASTERED | `+` operator turning whole concatenated string to NULL | 0 | 🔴 High |
| **C15.5** | `SUBSTRING()` 1-Based Indexing & Positional Extraction | MASTERED | Starting at index 0 and dropping 1st character | 0 | 🔴 High |
| **C15.6** | Substring Frequency Counting Formula | MASTERED | `(LEN(str) - LEN(REPLACE(str, ch, ''))) / LEN(ch)` math error | 0 | 🔴 High |
| **C15.7** | Dynamic PII Masking via `REPLICATE()` & `SUBSTRING()` | MASTERED | Negative length in `REPLICATE()` when string is short | 0 | 🔴 High |

---

### SECTION 16: ADVANCED STRING SLICING, TYPE CONVERSION & PARSING ENGINE
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C16.1** | `LEFT()` & `RIGHT()` Fixed-Width Boundary Extraction | MASTERED | Trailing spaces altering right boundary without `TRIM()` | 0 | 🟡 Medium |
| **C16.2** | `TRIM()`, `LTRIM()`, `RTRIM()` Whitespace Cleansing | MASTERED | Unclean tabs `\t` escaping basic space checks | 0 | 🟡 Medium |
| **C16.3** | `CAST()` vs `CONVERT()` Runtime Datatype Conversion | MASTERED | Assuming SELECT projection permanently alters column schema | 0 | 🔴 High |
| **C16.4** | T-SQL Date Style Formatting (101, 103, 112, 120) | MASTERED | 2-digit year truncation ambiguity (Style 1 vs 101) | 0 | 🔴 High |
| **C16.5** | Dynamic Name Parsing via `CHARINDEX()` & `LEFT`/`SUBSTRING` | MASTERED | Msg 537 crash on single-word names (0 - 1 = -1 length parameter) | 0 | 🔴 High |
| **C16.6** | Non-Sargable Predicates via Function Wrapping | MASTERED | `WHERE CONVERT(...)` destroying B-Tree index seeks | 0 | 🔴 High |

---

### SECTION 17: TRANSACTION CONTROL (TCL), NULL HANDLING & SUBQUERIES VS CTES
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C17.1** | `BEGIN TRANSACTION`, `COMMIT` & `ROLLBACK` Lifecycle | MASTERED | Msg 3903 on executing ROLLBACK without active transaction or after COMMIT | 0 | 🔴 High |
| **C17.2** | SQL Server DDL Rollback (`DROP TABLE`, `TRUNCATE TABLE`) | MASTERED | Assuming DDL causes implicit commit like MySQL/Oracle | 0 | 🔴 High |
| **C17.3** | `ISNULL()` vs `COALESCE()` Null Substitution | MASTERED | `ISNULL` string truncation due to first argument datatype precedence | 0 | 🔴 High |
| **C17.4** | Scalar Subqueries vs CTE + `DENSE_RANK()` for Nth Value | MASTERED | Nested subquery table scan bottlenecks vs single-pass window ranking | 0 | 🔴 High |
| **C17.5** | `IN (Subquery)` vs `INNER JOIN` / `EXISTS` Set Optimization | MASTERED | `NOT IN` failing silently with 0 rows when subquery dataset contains NULL | 0 | 🔴 High |

---

### SECTION 18: STORED PROCEDURES, VIEWS & INDEXING ARCHITECTURE
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C18.1** | Stored Procedures (`CREATE`/`ALTER PROCEDURE`) & `SET NOCOUNT ON` | MASTERED | Dropping SP instead of altering, causing permission and dependency loss | 0 | 🔴 High |
| **C18.2** | Automated Deduplication Pipeline via SP + CTE + `ROW_NUMBER()` | MASTERED | Omitting `WHERE row_occurrence > 1` filter returning valid original rows | 0 | 🔴 High |
| **C18.3** | Views as Virtual Tables (`CREATE VIEW` / `ALTER VIEW`) | MASTERED | Expecting standard view to physically persist rows and accelerate slow scans | 0 | 🔴 High |
| **C18.4** | Standard Virtual Views vs Materialized (Indexed) Views | MASTERED | Creating indexed view without `WITH SCHEMABINDING` and unique clustered index | 0 | 🔴 High |
| **C18.5** | Non-Clustered Indexes (`CREATE NONCLUSTERED INDEX` & `sp_helpindex`) | MASTERED | Over-indexing on high-DML tables slowing down bulk ETL throughput | 0 | 🔴 High |
| **C18.6** | Clustered Index Mechanics (PK Auto-Clustering vs Heap Table `p12`) | MASTERED | Msg 1902 attempting to create more than one clustered index per table | 0 | 🔴 High |

---

### SECTION 19: DATABASE-LEVEL DDL & TABLE-LEVEL DML TRIGGERS
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C19.1** | DDL Triggers on DATABASE Scope (`CREATE_TABLE`, `ALTER_TABLE`) | MASTERED | Attempting to drop DDL trigger without `ON DATABASE` clause | 0 | 🔴 High |
| **C19.2** | Schema Immutability & Access Denial via `ROLLBACK TRANSACTION` | MASTERED | Infinite recursive trigger execution without recursion checks | 0 | 🔴 High |
| **C19.3** | DML Triggers: `AFTER` (FOR) vs `INSTEAD OF` Execution Timing | MASTERED | Assuming triggers execute once per row instead of once per statement | 0 | 🔴 High |
| **C19.4** | Magic Tables (`INSERTED` vs `DELETED`) Multi-Row Joins | MASTERED | Using scalar subquery on `INSERTED` causing Msg 512 on multi-row batches | 0 | 🔴 High |
| **C19.5** | Column Change Detection via `IF UPDATE(col)` | MASTERED | Evaluating `UPDATE(col)` to true even when assigned same value | 0 | 🟡 Medium |

---

### SECTION 20: ETL PIPELINES & MEDALLION LAKEHOUSE ARCHITECTURE
| ID | Topic Name | Status | Error Code / Bug Traps | Spaced Revision Count | Interview Weight |
| :---: | :--- | :---: | :--- | :---: | :---: |
| **C20.1** | ETL vs ELT Architecture & Compute Optimization | MASTERED | Running heavy transform queries directly on production OLTP DB | 0 | 🔴 High |
| **C20.2** | 4-Tier Enterprise Data Architecture (Source -> Staging -> EDW -> BI) | MASTERED | Bypassing staging zone and loading unvalidated dirty data into EDW | 0 | 🔴 High |
| **C20.3** | Medallion Sub-Layers (Bronze Raw -> Silver Cleansed -> Gold Marts) | MASTERED | Storing raw un-aggregated transactional rows in Gold tier | 0 | 🔴 High |
| **C20.4** | Pipeline Idempotency & Failure Recovery Strategies | MASTERED | Duplicate row insertion on pipeline retry without MERGE/Upsert | 0 | 🔴 High |
| **C20.5** | Batch Windows vs Real-Time Streaming & Historical Telecom Paradigm | MASTERED | Hardcoded batch window boundaries causing data loss across timezones | 0 | 🔴 High |

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

