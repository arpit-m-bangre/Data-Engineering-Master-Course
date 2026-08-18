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
a) Explain why a Relational JOIN is mathematically defined as a Cartesian Cross-Product ($N \times M$)
   followed by a filter predicate, rather than a simple Venn diagram.
b) What is the fundamental difference between an Equi-Join and a Non-Equi Join?
c) Explain what happens when a query joins two large tables (e.g., 100,000 rows each) without specifying
   any ON condition or WHERE clause.

-- Write your Theoretical Explanation & Mental Breakdown below:

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

-- Write your Theoretical Explanation & Mental Breakdown below:

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

-- Write your Theoretical Explanation & Mental Breakdown below:

*/


/*
QUESTION 04: Outer Padding Mechanics & NULL Injection
-------------------------------------------------------------------------------------------------------
When executing a `LEFT JOIN` or `FULL OUTER JOIN`:
a) What is "Outer Padding", and why does the SQL engine inject NULL values into columns of the non-matching side?
b) If Table A (Left) has 10 columns and Table B (Right) has 15 columns, how many total columns does the
   output table have in a `LEFT JOIN`? What values will be present in the 15 columns of Table B for an
   unmatched Table A record?

-- Write your Theoretical Explanation & Mental Breakdown below:

*/


/*
QUESTION 05: Speed-Dating Analogy & The Combinatorial Matrix
-------------------------------------------------------------------------------------------------------
Using the speed-dating real-life analogy:
a) Explain how $N$ people in Room A and $M$ people in Room B represent the Cartesian Cross-Product.
b) Explain how the "Bouncer with an ID Scanner" represents the `ON T1.id = T2.id` predicate.
c) Explain why duplicate IDs in both rooms cause an explosive multiplication of handshakes.

-- Write your Theoretical Explanation & Mental Breakdown below:

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

-- Write your Theoretical Explanation & Mental Breakdown below:

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

-- Write your Theoretical Explanation & Mental Breakdown below:

*/


/*
QUESTION 08: Duplicate Key Handling: UNION ALL vs Cartesian JOIN
-------------------------------------------------------------------------------------------------------
Table A has four rows: `[1, 1, 1, 1]`. Table B has three rows: `[1, 1, 1]`.
a) How many rows are returned by `SELECT val FROM TableA UNION SELECT val FROM TableB`?
b) How many rows are returned by `SELECT val FROM TableA UNION ALL SELECT val FROM TableB`?
c) How many rows are returned by `SELECT A.val, B.val FROM TableA A INNER JOIN TableB B ON A.val = B.val`?
d) Formulate a rule summarizing how duplicates are handled in Set operations vs Join operations.

-- Write your Theoretical Explanation & Mental Breakdown below:

*/


/*
QUESTION 09: Column Name Inheritance & Aliasing Rules
-------------------------------------------------------------------------------------------------------
a) In a `UNION` query between `Employees` (columns: `EmpID, EmpName`) and `Contractors` (columns: `ContractorID, FullName`),
   what are the column headers of the final result set?
b) In an `INNER JOIN` between `Employees` and `Departments`, how are identically named columns (e.g. `DepartmentID`)
   disambiguated and referenced in the SELECT clause?

-- Write your Theoretical Explanation & Mental Breakdown below:

*/


/*
QUESTION 10: Mathematical Proof of The Full Outer Join Identity
-------------------------------------------------------------------------------------------------------
Prove mathematically and logically why the row count of a `FULL OUTER JOIN` can always be computed as:
$$\text{Count}(\text{FULL OUTER}) = \text{Count}(\text{INNER JOIN}) + \text{Unmatched}_{T1} + \text{Unmatched}_{T2}$$
Explain what each term represents and why no rows are double-counted.

-- Write your Theoretical Explanation & Mental Breakdown below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

*/


/*
QUESTION 12: Multi-Duplicate Integers Quiz (Faculty Class Drill 2)
-------------------------------------------------------------------------------------------------------
Given two single-column tables:
Table 1 (T1): [1, 2, 2, 3, 3, 3, NULL, 2]   (Total: 8 rows)
Table 2 (T2): [1, 1, 3, 3, NULL, 4, 4, 1]   (Total: 8 rows)

Step 1: Construct the Frequency Map for distinct values (1, 2, 3, 4, NULL) in both tables.
Step 2: Calculate the exact output row counts for:
a) INNER JOIN
b) LEFT OUTER JOIN
c) RIGHT OUTER JOIN
d) FULL OUTER JOIN

-- Write your Frequency Map, Step-by-Step Multiplication & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

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

-- Write your Step-by-Step Calculation & Final Row Counts below:

*/


/*
QUESTION 19: The Master Row-Count Derivation Formula for Data Pipelines
-------------------------------------------------------------------------------------------------------
As a Lead Data Engineer designing a high-throughput ETL pipeline:
a) Write the mathematical formula used to predict the MAXIMUM possible row count of an `INNER JOIN`
   between Table 1 (size $N$) and Table 2 (size $M$). Under what data distribution does this maximum occur?
b) Write the formula for the MINIMUM possible row count of an `INNER JOIN`.
c) Write the formula for the MAXIMUM possible row count of a `FULL OUTER JOIN`.

-- Write your Mathematical Formulas & Pipeline Optimization Strategy below:

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

-- Write your Analytical Breakdown & Business Logic below:

*/

-- ====================================================================================================
-- 🏁 END OF PRACTICE QUESTIONS — 18 AUGUST 2026
-- ====================================================================================================
