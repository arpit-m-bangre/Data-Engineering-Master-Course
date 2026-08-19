-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — PRACTICE DRILL SET
-- 📅 DATE: 18 AUGUST 2026 (TUESDAY) | BATCH: ONLINE BATCH 15 (DAY 15)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: FOUNDATIONS OF RELATIONAL JOINS, CARTESIAN CROSS-PRODUCTS, SET vs JOIN & ROW COUNT MATH
-- 📁 TOTAL QUESTIONS: 20 COMPREHENSIVE DRILLS (WITH TIER-1 INTERVIEW SUB-QUESTIONS)
-- ====================================================================================================

-- ====================================================================================================
-- 🏛️ SECTION 1: ARCHITECTURAL FOUNDATIONS & CORE THEORY (Q01 - Q05)
-- ====================================================================================================

/*
QUESTION 01: The Mechanical Anatomy of Relational Joins
-------------------------------------------------------------------------------------------------------
a) Explain why a Relational JOIN is mathematically defined as a Cartesian Cross-Product N X M 
   followed by a filter predicate, rather than a simple Venn diagram.
b) What is the fundamental difference between an Equi-Join and a Non-Equi Join?
c) Explain what happens when a query joins two large tables (e.g., 100,000 rows each) without specifying
   any ON condition or WHERE clause.

-- Cap's Submission & Pippo's Review:
-------------------------------------
[Cap]: A: The Venn diagram is used by Set (stack approach: one row below another), whereas Relational
          Join merges tables side by side (horizontal). For uneven row counts, Cartesian product N x M is used.
[Pippo Review]: ⭐ Good intuition on vertical stacking vs horizontal merging! 
                Key technical precision: Venn diagrams represent mathematical sets where each item appears 
                only once. Venn diagrams CANNOT represent duplicates or multiplication (e.g. 3 matching 
                keys multiplying by 2 matching keys to yield 6 rows). Relational Join is physically executed 
                as an unconditional Cartesian Cross-Product (N x M combinations), followed by the ON filter 
                predicate to discard non-matching pairings.

[Cap]: B: No idea.
[Pippo Review & Correct Answer]:
  * Equi-Join: Uses ONLY the equality operator (`=`) in the ON condition (e.g., `ON A.id = B.id`).
  * Non-Equi Join: Uses comparison / range operators OTHER than `=` (e.g., `<`, `>`, `<=`, `>=`, `!=`, 
    `BETWEEN ... AND ...`, e.g., `ON E.Salary BETWEEN G.MinSal AND G.MaxSal`).

[Cap]: C: The join syntax needs ON condition always so without it not possible and about WHERE so it is optional.
[Pippo Review & Correct Answer]:
  * In ANSI SQL (and T-SQL), joining without an ON condition (or using `CROSS JOIN` / comma-separated `FROM A, B`) 
    produces a full Cartesian Cross-Product: 100,000 * 100,000 = 10,000,000,000 (10 BILLION rows!).
  * This causes severe memory exhaustion, massive TempDB disk spill, query timeout, and production outage.
*/


/*
QUESTION 02: Primary Taxonomy of Relational Joins
-------------------------------------------------------------------------------------------------------
Define each of the following four primary join types in terms of their relational logic and explain
how unmatched records are handled in each:
a) INNER JOIN
b) LEFT OUTER JOIN
c) RIGHT OUTER JOIN
d) FULL OUTER JOIN

-- Cap's Submission & Pippo's Review:
-------------------------------------
[Cap]: A: Inner join is like the common from both. Only completely matched come in inner join, NULLs ignored.
[Pippo Review]: ⭐ 100% Correct! Only rows satisfying the ON equality condition are returned.

[Cap]: B: Left join is like all values from inner join and unmatched from right and null also.
[Pippo Review - CORRECTION]: 
  * Inversion error! LEFT JOIN returns all matching rows (INNER JOIN) PLUS all unmatched rows from the 
    **LEFT** table (Table 1). The columns belonging to the right table are padded with NULL.

[Cap]: C: Right join is like all values from inner join and unmatched from left and null also.
[Pippo Review - CORRECTION]: 
  * Inversion error! RIGHT JOIN returns all matching rows (INNER JOIN) PLUS all unmatched rows from the 
    **RIGHT** table (Table 2). The columns belonging to the left table are padded with NULL.

[Cap]: D: Full outer join is like inner join + unmatched left with null + unmatched right with null.
[Pippo Review]: ⭐ 100% Spot on! INNER JOIN + Unmatched Left (with Right NULLs) + Unmatched Right (with Left NULLs).
*/


/*
QUESTION 03: Three-Valued Logic (3VL) & The NULL Equality Dilemma
-------------------------------------------------------------------------------------------------------
In SQL, Boolean expressions can evaluate to TRUE, FALSE, or UNKNOWN.
a) Why does the expression `NULL = NULL` evaluate to UNKNOWN instead of TRUE?
b) How does this three-valued logic directly dictate why `NULL` keys from Table 1 and Table 2 never
   produce an output row in an `INNER JOIN`?
c) If you specifically need two NULL values to match during a join operation, what comparison function
   or coalesce technique must be used?

-- Cap's Submission & Pippo's Review:
-------------------------------------
[Cap]: A: Since in SQL NULL is a keyword and keyword = keyword is not possible and show unknown.
[Pippo Review & Precise Core]:
  * NULL represents an "absence of data" or an "unknown state", NOT a value. Comparing two unknown 
    things (`unknown = unknown`) cannot be proven TRUE or FALSE; it evaluates to UNKNOWN under ANSI 3VL.

[Cap]: B: No idea not getting the question also.
[Pippo Review & Solution]:
  * INNER JOIN output filter strictly requires the ON predicate to evaluate to `TRUE`.
  * Since `NULL = NULL` evaluates to `UNKNOWN` (which is not TRUE), the SQL engine rejects the pairing, 
    so NULL keys never produce an output row in an INNER JOIN.

[Cap]: C: No idea.
[Pippo Review & Solution]:
  * Technique 1 (COALESCE/ISNULL substitution):
    `ON COALESCE(T1.ID, -999) = COALESCE(T2.ID, -999)`
  * Technique 2 (Explicit NULL check):
    `ON (T1.ID = T2.ID OR (T1.ID IS NULL AND T2.ID IS NULL))`
  * Technique 3 (Standard ANSI clause):
    `ON T1.ID IS NOT DISTINCT FROM T2.ID`
*/


/*
QUESTION 04: Outer Padding Mechanics & NULL Injection
-------------------------------------------------------------------------------------------------------
When executing a `LEFT JOIN` or `FULL OUTER JOIN`:
a) What is "Outer Padding", and why does the SQL engine inject NULL values into columns of the non-matching side?
b) If Table A (Left) has 10 columns and Table B (Right) has 15 columns, how many total columns does the
   output table have in a `LEFT JOIN`? What values will be present in the 15 columns of Table B for an
   unmatched Table A record?

-- Cap's Submission & Pippo's Review:
-------------------------------------
[Cap]: A: No idea.
[Pippo Review & Solution]:
  * "Outer Padding" is the relational mechanism where unmatched rows from the preserved table are padded 
    with artificial NULL values across all columns of the non-matching table so that every output tuple 
    matches the combined schema width without throwing a shape mismatch error.

[Cap]: B: I think 25 column.
[Pippo Review]: ⭐ 100% Correct! 10 + 15 = 25 total columns. For an unmatched Table A row, all 15 columns 
                of Table B are populated with NULL.
*/


/*
QUESTION 05: Speed-Dating Analogy & The Combinatorial Matrix
-------------------------------------------------------------------------------------------------------
Using the speed-dating real-life analogy:
a) Explain how N people in Room A and M people in Room B represent the Cartesian Cross-Product.
b) Explain how the "Bouncer with an ID Scanner" represents the `ON T1.id = T2.id` predicate.
c) Explain why duplicate IDs in both rooms cause an explosive multiplication of handshakes.

-- Cap's Submission & Pippo's Review:
-------------------------------------
[Cap]: A: N x M
[Pippo Review]: ⭐ Exactly! Unconditional pairing where every single person in Room A meets every person in Room B.

[Cap]: B: No idea.
[Pippo Review & Solution]:
  * The Bouncer stands between Room A and Room B with a scanner. A handshake is ONLY allowed to count 
    if both badges have matching ID numbers (`T1.ID = T2.ID`). All non-matching pairs are blocked.

[Cap]: C: No idea.
[Pippo Review & Solution]:
  * If 3 people in Room A wear badge #1 and 2 people in Room B wear badge #1, each of the 3 pairs with 
    each of the 2, resulting in 3 * 2 = 6 handshakes for badge #1 alone. Duplicate keys multiply combinations!
*/


-- ====================================================================================================
-- ⚖️ SECTION 2: SET OPERATORS vs RELATIONAL JOINS (Q06 - Q10)
-- ====================================================================================================

/*
QUESTION 06: Vertical vs Horizontal Combination Architectures
-------------------------------------------------------------------------------------------------------
a) Contrast SET operators (`UNION`, `INTERSECT`, `EXCEPT`) with RELATIONAL JOINS in terms of their axis
   of combination (Vertical Stacking vs Horizontal Merging).
b) Explain why SET operators strictly demand identical column counts and compatible data types, while
   RELATIONAL JOINS allow tables with completely disparate schemas and column counts to be combined.

-- Master Solution & Theoretical Breakdown:
--------------------------------------------
a) Axis of Combination:
   - SET Operators = VERTICAL STACKING: Appends rows from Table B underneath Table A. Schema width 
     remains constant; row count increases vertically.
   - RELATIONAL JOINS = HORIZONTAL MERGING: Stitches columns from Table B alongside Table A. Schema width 
     expands horizontally (Width_A + Width_B); row count depends on predicate match cardinality.

b) Schema Compatibility Requirements:
   - SET Operators combine records into a SINGLE shared tuple stream; thus, every column position must 
     match in data type and total count.
   - RELATIONAL JOINS preserve both distinct table structures side-by-side; each column retains its own 
     original data type and name under its respective table alias.
*/


/*
QUESTION 07: INTERSECT vs INNER JOIN Deep-Dive
-------------------------------------------------------------------------------------------------------
Consider two tables:
Table A: [10, 20, NULL]
Table B: [20, 30, NULL]

a) What is the exact output and row count of `SELECT val FROM TableA INTERSECT SELECT val FROM TableB`?
b) What is the exact output and row count of `SELECT TableA.val, TableB.val FROM TableA INNER JOIN TableB ON TableA.val = TableB.val`?
c) Clearly explain why the outputs differ regarding the `NULL` record.

-- Master Solution & Verification:
-----------------------------------
a) `INTERSECT` Output:
   val
   ----
   20
   NULL
   -> Row Count = 2 Rows. (INTERSECT treats NULL as equivalent to NULL and deduplicates).

b) `INNER JOIN` Output:
   TableA.val | TableB.val
   -----------+-----------
   20         | 20
   -> Row Count = 1 Row.

c) Root Cause:
   - `INTERSECT` follows set-theoretic unicity where two NULLs are considered the same distinct member.
   - `INNER JOIN` uses Boolean 3VL where `NULL = NULL` is UNKNOWN, dropping the NULL record from the inner join.
*/


/*
QUESTION 08: Duplicate Key Handling: UNION ALL vs Cartesian JOIN
-------------------------------------------------------------------------------------------------------
Table A has four rows: `[1, 1, 1, 1]`. Table B has three rows: `[1, 1, 1]`.
a) How many rows are returned by `SELECT val FROM TableA UNION SELECT val FROM TableB`?
b) How many rows are returned by `SELECT val FROM TableA UNION ALL SELECT val FROM TableB`?
c) How many rows are returned by `SELECT A.val, B.val FROM TableA A INNER JOIN TableB B ON A.val = B.val`?
d) Formulate a rule summarizing how duplicates are handled in Set operations vs Join operations.

-- Master Solution & Calculations:
-----------------------------------
a) `UNION`     = 1 Row  (Complete deduplication of distinct values).
b) `UNION ALL` = 7 Rows (Vertical addition: 4 + 3 = 7).
c) `INNER JOIN` = 12 Rows (Horizontal Cartesian multiplication: 4 * 3 = 12).
d) Golden Law:
   - SET operations either condense duplicates to 1 (UNION) or ADD them linearly (UNION ALL = N + M).
   - JOIN operations MULTIPLY duplicate matching keys exponentially (JOIN = N * M).
*/


/*
QUESTION 09: Column Name Inheritance & Aliasing Rules
-------------------------------------------------------------------------------------------------------
a) In a `UNION` query between `Employees` (columns: `EmpID, EmpName`) and `Contractors` (columns: `ContractorID, FullName`),
   what are the column headers of the final result set?
b) In an `INNER JOIN` between `Employees` and `Departments`, how are identically named columns (e.g. `DepartmentID`)
   disambiguated and referenced in the SELECT clause?

-- Master Solution & Syntax Rules:
-----------------------------------
a) In a `UNION` query, column headers are strictly inherited from the FIRST (top) SELECT query (`EmpID`, `EmpName`).
b) In a `JOIN` query, identically named columns must be qualified with their table name or table alias:
   `SELECT e.DepartmentID AS EmpDeptID, d.DepartmentID AS DeptID FROM Employees e INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;`
*/


/*
QUESTION 10: Mathematical Proof of The Full Outer Join Identity
-------------------------------------------------------------------------------------------------------
Prove mathematically and logically why the row count of a `FULL OUTER JOIN` can always be computed as:
Count(FULL OUTER JOIN) = Count(INNER JOIN) + Unmatched_T1 + Unmatched_T2
Explain what each term represents and why no rows are double-counted.

-- Master Solution & Logic Proof:
----------------------------------
* Mathematical Proof:
  Every row in a FULL OUTER JOIN belongs to exactly ONE of three mutually exclusive partitions:
  1. `Count(INNER JOIN)`: All pairs where `T1.Key = T2.Key` evaluates to TRUE (multiplied N x M matches).
  2. `Unmatched_T1`: Rows in Table 1 having no matching Key in Table 2 (padded with Right NULLs).
  3. `Unmatched_T2`: Rows in Table 2 having no matching Key in Table 1 (padded with Left NULLs).

  Since a key cannot simultaneously be matched (TRUE) and unmatched (NO MATCH), the intersection between 
  these three subsets is EMPTY. Thus:
  Count(FULL OUTER JOIN) = Count(INNER JOIN) + Unmatched_T1 + Unmatched_T2. (Zero double counting!).
*/


-- ====================================================================================================
-- 🎯 SECTION 3: TIER-1 INTERVIEW ROW-COUNT DRILLS (Q11 - Q15)
-- ====================================================================================================

/*
QUESTION 11: The Duplicate Binary Quiz (Faculty Class Drill 1)
-------------------------------------------------------------------------------------------------------
Given two single-column tables:
Table 1 (T1): [1, 1, 1, NULL]
Table 2 (T2): [1, 1, NULL, NULL]

Calculate the EXACT output row counts and show the full step-by-step mathematical breakdown for:
a) INNER JOIN
b) LEFT OUTER JOIN
c) RIGHT OUTER JOIN
d) FULL OUTER JOIN
e) CROSS JOIN

-- Master Step-by-Step Breakdown:
----------------------------------
* Frequency Map:
  - Key '1'  : T1 = 3 | T2 = 2 | Matches = 3 * 2 = 6 rows
  - Key NULL : T1 = 1 | T2 = 2 | Matches = 0 rows (NULL = NULL is UNKNOWN)
  - Unmatched Left  (T1) = 1 (the 1 NULL)
  - Unmatched Right (T2) = 2 (the 2 NULLs)

* Output Counts:
  a) INNER JOIN      = 6 Rows
  b) LEFT OUTER JOIN = 6 + 1 = 7 Rows
  c) RIGHT OUTER JOIN= 6 + 2 = 8 Rows
  d) FULL OUTER JOIN = 6 + 1 + 2 = 9 Rows
  e) CROSS JOIN      = Total_T1 * Total_T2 = 4 * 4 = 16 Rows
*/


/*
QUESTION 12: Multi-Duplicate Integers Quiz (Faculty Class Drill 2)
-------------------------------------------------------------------------------------------------------
Given two single-column tables:
Table 1 (T1): [1, 2, 2, 3, 3, 3, NULL, 2]   (Total: 8 rows -> 1: 1x, 2: 3x, 3: 3x, NULL: 1x)
Table 2 (T2): [1, 1, 3, 3, NULL, 4, 4, 1]   (Total: 8 rows -> 1: 3x, 3: 2x, 4: 2x, NULL: 1x)

Step 1: Construct the Frequency Map for distinct values (1, 2, 3, 4, NULL) in both tables.
Step 2: Calculate the exact output row counts for:
a) INNER JOIN
b) LEFT OUTER JOIN
c) RIGHT OUTER JOIN
d) FULL OUTER JOIN

-- Master Step-by-Step Breakdown:
----------------------------------
* Step 1: Frequency & Multiplication Map:
  - Key '1'  : T1 count = 1 | T2 count = 3 | Inner matches = 1 * 3 = 3 rows
  - Key '2'  : T1 count = 3 | T2 count = 0 | Inner matches = 3 * 0 = 0 rows (Unmatched T1 = 3 rows)
  - Key '3'  : T1 count = 3 | T2 count = 2 | Inner matches = 3 * 2 = 6 rows
  - Key '4'  : T1 count = 0 | T2 count = 2 | Inner matches = 0 * 2 = 0 rows (Unmatched T2 = 2 rows)
  - Key NULL : T1 count = 1 | T2 count = 1 | Inner matches = 0 rows (Unmatched T1=1, T2=1)

* Step 2: Final Row Counts:
  a) INNER JOIN      = 3 ('1's) + 6 ('3's) = 9 Rows.
  b) LEFT OUTER JOIN = 9 (Inner) + 4 (Unmatched T1: 3 of '2' + 1 NULL) = 13 Rows.
  c) RIGHT OUTER JOIN= 9 (Inner) + 3 (Unmatched T2: 2 of '4' + 1 NULL) = 12 Rows.
  d) FULL OUTER JOIN = 9 (Inner) + 4 (Left) + 3 (Right) = 16 Rows.
*/


/*
QUESTION 13: String Literal 'NULL' vs SQL NULL Keyword Trap (Faculty Class Drill 3)
-------------------------------------------------------------------------------------------------------
Given two tables with mixed characters, string literals, and database NULLs:
Table 1 (T1): ['A', 'B', 'C', 'C', 'C', 'NULL', NULL, 'B']                (Total: 8 rows)
Table 2 (T2): ['A', 'A', 'B', 'B', 'NULL', 'NULL', NULL, 'D', 'D']        (Total: 9 rows)
*(Note: 'NULL' is a 4-character VARCHAR literal string; NULL is the SQL keyword)*

Calculate the EXACT output row counts and explain the matching logic for:
a) INNER JOIN
b) LEFT OUTER JOIN
c) RIGHT OUTER JOIN
d) FULL OUTER JOIN

-- Master Step-by-Step Breakdown:
----------------------------------
* Frequency & Matching Map:
  - Key 'A'      : T1 = 1 | T2 = 2 | Inner = 1 * 2 = 2 rows
  - Key 'B'      : T1 = 2 | T2 = 2 | Inner = 2 * 2 = 4 rows
  - Key 'C'      : T1 = 3 | T2 = 0 | Inner = 3 * 0 = 0 rows (Unmatched T1 = 3 rows)
  - Key ''NULL'' : T1 = 1 | T2 = 2 | Inner = 1 * 2 = 2 rows (STRING MATCH!)
  - Key NULL     : T1 = 1 | T2 = 1 | Inner = 0 rows (SQL KEYWORD NULL -> NO MATCH!)
  - Key 'D'      : T1 = 0 | T2 = 2 | Inner = 0 * 2 = 0 rows (Unmatched T2 = 2 rows)

* Final Row Counts:
  a) INNER JOIN      = 2 ('A') + 4 ('B') + 2 (''NULL'') = 8 Rows.
  b) LEFT OUTER JOIN = 8 (Inner) + 4 (Unmatched T1: 3 of 'C' + 1 SQL NULL) = 12 Rows.
  c) RIGHT OUTER JOIN= 8 (Inner) + 3 (Unmatched T2: 2 of 'D' + 1 SQL NULL) = 11 Rows.
  d) FULL OUTER JOIN = 8 (Inner) + 4 (Left) + 3 (Right) = 15 Rows.
*/


/*
QUESTION 14: The 100% Unmatched Disjoint Sets
-------------------------------------------------------------------------------------------------------
Table A has 15 rows with IDs ranging from 1 to 15 (all distinct).
Table B has 10 rows with IDs ranging from 101 to 110 (all distinct).

Calculate the row count for:
a) INNER JOIN on A.ID = B.ID
b) LEFT JOIN on A.ID = B.ID
c) RIGHT JOIN on A.ID = B.ID
d) FULL OUTER JOIN on A.ID = B.ID
e) CROSS JOIN

-- Master Calculations:
------------------------
a) INNER JOIN      = 0 Rows  (No overlapping IDs).
b) LEFT JOIN       = 0 (Inner) + 15 (Unmatched A) = 15 Rows.
c) RIGHT JOIN      = 0 (Inner) + 10 (Unmatched B) = 10 Rows.
d) FULL OUTER JOIN = 0 + 15 + 10 = 25 Rows.
e) CROSS JOIN      = 15 * 10 = 150 Rows.
*/


/*
QUESTION 15: The All-Identical Key Multiplication
-------------------------------------------------------------------------------------------------------
Table A has 6 rows, all containing the integer `500`.
Table B has 8 rows, all containing the integer `500`.

Calculate the row count for:
a) INNER JOIN on A.ID = B.ID
b) LEFT JOIN on A.ID = B.ID
c) RIGHT JOIN on A.ID = B.ID
d) FULL OUTER JOIN on A.ID = B.ID
e) What would be the row count if Table A had 1 additional row containing `NULL`?

-- Master Calculations:
------------------------
a) INNER JOIN      = 6 * 8 = 48 Rows.
b) LEFT JOIN       = 48 (Inner) + 0 (Unmatched A) = 48 Rows.
c) RIGHT JOIN      = 48 (Inner) + 0 (Unmatched B) = 48 Rows.
d) FULL OUTER JOIN = 48 + 0 + 0 = 48 Rows.
e) If Table A has 1 additional NULL row (Total 7 rows):
   - INNER JOIN      = 48 Rows
   - LEFT JOIN       = 48 + 1 (Unmatched NULL) = 49 Rows
   - RIGHT JOIN      = 48 Rows
   - FULL OUTER JOIN = 48 + 1 + 0 = 49 Rows
*/


-- ====================================================================================================
-- ⚡ SECTION 4: ADVANCED EDGE CASES, MULTI-KEY MATRIX & PIPELINES (Q16 - Q20)
-- ====================================================================================================

/*
QUESTION 16: The Completely Empty Table Edge Case
-------------------------------------------------------------------------------------------------------
Table A contains 50 active customer records.
Table B contains 0 rows (it is an empty staging table with identical schema).

Calculate the exact output row count when joining Table A and Table B on CustomerID:
a) INNER JOIN
b) LEFT OUTER JOIN (Table A LEFT JOIN Table B)
c) RIGHT OUTER JOIN (Table A RIGHT JOIN Table B)
d) FULL OUTER JOIN
e) CROSS JOIN

-- Master Calculations:
------------------------
a) INNER JOIN      = 0 Rows.
b) LEFT OUTER JOIN = 50 Rows (All Table A records preserved with NULLs for Table B).
c) RIGHT OUTER JOIN= 0 Rows (Table B has 0 rows, so 0 rows preserved).
d) FULL OUTER JOIN = 50 Rows (50 from Left + 0 from Right).
e) CROSS JOIN      = 50 * 0 = 0 Rows.
*/


/*
QUESTION 17: All-NULL Tables Interaction
-------------------------------------------------------------------------------------------------------
Table A has 5 rows, where EVERY row contains `NULL` in the join key column.
Table B has 7 rows, where EVERY row contains `NULL` in the join key column.

Calculate the exact output row counts for:
a) INNER JOIN on A.Key = B.Key
b) LEFT OUTER JOIN on A.Key = B.Key
c) RIGHT OUTER JOIN on A.Key = B.Key
d) FULL OUTER JOIN on A.Key = B.Key
e) CROSS JOIN

-- Master Calculations:
------------------------
a) INNER JOIN      = 0 Rows (NULL = NULL evaluates to UNKNOWN).
b) LEFT OUTER JOIN = 5 Rows (5 unmatched Left rows preserved with Right NULLs).
c) RIGHT OUTER JOIN= 7 Rows (7 unmatched Right rows preserved with Left NULLs).
d) FULL OUTER JOIN = 0 (Inner) + 5 (Left) + 7 (Right) = 12 Rows.
e) CROSS JOIN      = 5 * 7 = 35 Rows (CROSS JOIN ignores ON predicate and pairs unconditionally!).
*/


/*
QUESTION 18: The Composite Multi-Column Join Key Drill
-------------------------------------------------------------------------------------------------------
Suppose Table 1 and Table 2 are joined on TWO columns: `ON T1.DeptID = T2.DeptID AND T1.RoleID = T2.RoleID`.

Table 1:
- Row 1: (Dept: 10, Role: 1)
- Row 2: (Dept: 10, Role: 1)
- Row 3: (Dept: 10, Role: 2)
- Row 4: (Dept: 20, Role: NULL)

Table 2:
- Row 1: (Dept: 10, Role: 1)
- Row 2: (Dept: 10, Role: 1)
- Row 3: (Dept: 10, Role: NULL)
- Row 4: (Dept: 20, Role: NULL)

Calculate the output row counts for:
a) INNER JOIN
b) LEFT JOIN
c) Explain why `(Dept: 20, Role: NULL)` fails to match between T1 and T2 in the INNER JOIN.

-- Master Calculations & Proof:
--------------------------------
* Composite Key Matching:
  - Key (10, 1)   : T1 count = 2 | T2 count = 2 | Inner matches = 2 * 2 = 4 rows.
  - Key (10, 2)   : T1 count = 1 | T2 count = 0 | Unmatched T1 = 1 row.
  - Key (10, NULL): T1 count = 0 | T2 count = 1 | Unmatched T2 = 1 row.
  - Key (20, NULL): DeptID matches (20=20 is TRUE), BUT RoleID comparison (`NULL = NULL`) is UNKNOWN.
    `TRUE AND UNKNOWN` = `UNKNOWN` (fails match!). Unmatched T1 = 1 row, Unmatched T2 = 1 row.

* Final Row Counts:
  a) INNER JOIN = 4 Rows.
  b) LEFT JOIN  = 4 (Inner) + 2 (Unmatched T1: (10,2) and (20,NULL)) = 6 Rows.
  c) Rationale: In SQL, for composite keys connected by `AND`, ALL column conditions must evaluate to `TRUE`. 
     Since `RoleID` comparison is `UNKNOWN`, the overall compound expression evaluates to `UNKNOWN`.
*/


/*
QUESTION 19: The Master Row-Count Derivation Formula for Data Pipelines
-------------------------------------------------------------------------------------------------------
As a Lead Data Engineer designing a high-throughput ETL pipeline:
a) Write the mathematical formula used to predict the MAXIMUM possible row count of an `INNER JOIN`
   between Table 1 (size N) and Table 2 (size M). Under what data distribution does this maximum occur?
b) Write the formula for the MINIMUM possible row count of an `INNER JOIN`.
c) Write the formula for the MAXIMUM possible row count of a `FULL OUTER JOIN`.

-- Master Formulas & Pipeline Optimization Strategy:
-----------------------------------------------------
a) Maximum INNER JOIN Row Count:
   Formula: Max(INNER JOIN) = N * M
   Distribution: Occurs when every single row in Table 1 and Table 2 shares the EXACT SAME non-NULL key value.
b) Minimum INNER JOIN Row Count:
   Formula: Min(INNER JOIN) = 0
   Distribution: Occurs when the tables are 100% disjoint (no common keys) or all join keys are NULL.
c) Maximum FULL OUTER JOIN Row Count:
   Formula: Max(FULL OUTER JOIN) = N * M (when all keys share the same identical value) 
            OR (N + M) (when all keys are 100% disjoint or NULL).
*/


/*
QUESTION 20: Real-World Business Scenario Analysis
-------------------------------------------------------------------------------------------------------
You are analyzing an enterprise Retail Data Warehouse with two core datasets:
- `Customers` table (Primary Key: `CustomerID`, 10,000 total customers).
- `Orders` table (Foreign Key: `CustomerID`, 50,000 total orders placed over 1 year).
- Business context: 8,000 customers have placed at least 1 order. 2,000 customers have never placed an order.
  All orders belong to valid registered customers (no orphaned orders).

a) If you run `FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID`, what is the exact row count?
b) If you run `FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID`, what is the exact row count?
c) If you run `FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID`, what is the exact row count?
d) Which join type would you use if the Marketing VP asks: "List all customers who have NEVER placed an order"?
   Explain how the WHERE clause filters the result.

-- Master Business Breakdown & Query Solution:
-----------------------------------------------
a) `INNER JOIN` Count:
   = 50,000 Rows. (Every single order matches its corresponding 1 registered customer).

b) `LEFT JOIN` Count (Customers LEFT JOIN Orders):
   = 50,000 (matched orders for 8,000 active customers) + 2,000 (unmatched customers with NULL order columns)
   = 52,000 Rows.

c) `RIGHT JOIN` Count (Customers RIGHT JOIN Orders):
   = 50,000 Rows. (Because there are 0 orphaned orders; every order matches a customer).

d) Marketing Churn Query (Anti-Join Pattern):
   Use a `LEFT JOIN` combined with `WHERE o.CustomerID IS NULL`:

   ```sql
   SELECT 
       c.CustomerID,
       c.CustomerName
   FROM Customers c
   LEFT JOIN Orders o 
       ON c.CustomerID = o.CustomerID
   WHERE o.CustomerID IS NULL;
   ```
   *Explanation*: The LEFT JOIN includes all 10,000 customers. For the 2,000 non-ordering customers, 
   the `Orders` columns are padded with NULL. The `WHERE o.CustomerID IS NULL` filter discards the 50,000 
   matched order rows, returning exactly the 2,000 customers who never placed an order.
*/

-- ====================================================================================================
-- 🏁 END OF PRACTICE QUESTIONS — 18 AUGUST 2026
-- ====================================================================================================
