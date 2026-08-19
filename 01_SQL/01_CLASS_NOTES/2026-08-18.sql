-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — CLASS NOTES
-- 📅 DATE: 18 AUGUST 2026 (TUESDAY) | BATCH: ONLINE BATCH 15 (DAY 15)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: FOUNDATIONS OF RELATIONAL JOINS, CARTESIAN CROSS-PRODUCTS ($N \times M$), 
--          SET vs JOIN MECHANICS & THE NULL MATCHING LOGIC
-- ====================================================================================================

-- ====================================================================================================
-- 📖 1. EXECUTIVE OVERVIEW & FACULTY INTRODUCTORY REMARKS
-- ====================================================================================================
/*
    FACULTY CONTEXT & ROADMAP:
    --------------------------
    1. Previous Milestone Recap:
       - Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT) & Temporal Functions (DATEDIFF, DATEADD, 
         DATEPART, EOMONTH) were completed in previous classes.
       - Temporal functions are a guaranteed staple in Data Engineering technical interviews.
    
    2. The New Core Pillar: RELATIONAL JOINS
       - JOINS represent one of the single most crucial pillars in SQL and Relational Database Architecture.
       - This deep topic will span AT LEAST 4 intensive classes covering:
         * Class 1 (Today): Conceptual Foundations, Cartesian Products, Venn vs Cross-Product, NULL Traps.
         * Class 2: Standard ANSI Syntax, Table Aliasing, Multi-Table Complex Joins.
         * Class 3: Self Joins, Non-Equi Joins, Cross Joins, Anti-Joins & Semi-Joins.
         * Class 4: Performance Optimization, Hash/Merge/Nested Loop physical join operators & Indexing.
    
    3. The Golden Interview Challenge:
       - "Syntax for JOINS is very easy, but in technical interviews, the real problem is knowing 
         WHAT join to use WHEN, and predicting EXACT output row counts when duplicates and NULLs exist!"
*/

-- ====================================================================================================
-- 🧠 2. VOCABULARY & INTUITIVE REAL-LIFE ANALOGIES
-- ====================================================================================================
/*
    VOCABULARY & TECHNICAL DEFINITIONS:
    -----------------------------------
    1. RELATIONAL JOIN: An operation that combines columns from one or more tables horizontally based 
       on a related column (join key) between them.
    2. CARTESIAN PRODUCT ($N \times M$): An unfiltered multiplication where EVERY single row of Table 1 pairs 
       with EVERY single row of Table 2.
    3. THREE-VALUED LOGIC (3VL): SQL logic system consisting of TRUE, FALSE, and UNKNOWN.
    4. REFERENTIAL INTEGRITY: The consistency and validity of relationships between primary and foreign keys.

    REAL-LIFE ANALOGIES:
    --------------------
    - VENN DIAGRAM vs CARTESIAN PRODUCT:
      * Venn Diagram (Set Theory): Like two circles of friends at a party. The intersection simply lists the 
        people who belong to both circles (deduplicated).
      * Cartesian Cross-Product (Database Join): Like a Speed Dating Event! Every single person in Room A 
        walks up to and shakes hands with EVERY single person in Room B ($N \times M$ handshakes). Then, the bouncer 
        (ON Condition) only allows pairs with matching ID tags to stay in the room!
    
    - SQL NULL vs STRING LITERAL 'NULL':
      * SQL `NULL`: Represents an unknown, missing, or empty state ("I don't know my name"). When two people 
        say "I don't know my name", they DO NOT have the same name (`NULL = NULL` is UNKNOWN / FALSE).
      * String Literal `'NULL'`: A tangible word written on a name tag with ink (`'N'-'U'-'L'-'L'`). 
        When two people wear name tags that literally say "NULL", they match (`'NULL' = 'NULL'` is TRUE)!
*/

-- ====================================================================================================
-- 🏛️ 3. TAXONOMY OF RELATIONAL JOINS
-- ====================================================================================================
/*
    PRIMARY JOIN CLASSIFICATION:
    ----------------------------
    1. INNER JOIN:
       - Returns only matching records present in BOTH tables where the join predicate evaluates to TRUE.
       - Formula: Matches where `T1.Key = T2.Key`.

    2. OUTER JOINS:
       - Preserves unmatched records from one or both tables by padding missing values with NULLs.
       2.1 LEFT OUTER JOIN (LEFT JOIN):
           - Returns ALL records from Left Table (T1) + matching records from Right Table (T2).
           - Unmatched Left Table rows have NULL values for all Right Table columns.
       2.2 RIGHT OUTER JOIN (RIGHT JOIN):
           - Returns ALL records from Right Table (T2) + matching records from Left Table (T1).
           - Unmatched Right Table rows have NULL values for all Left Table columns.
       2.3 FULL OUTER JOIN (FULL JOIN):
           - Returns ALL records when there is a match in EITHER left or right table.
           - Mathematically: `INNER JOIN + Left Unmatched (with NULLs) + Right Unmatched (with NULLs)`.
*/

-- ====================================================================================================
-- ⚖️ 4. DEEP ARCHITECTURAL COMPARISON: SET OPERATORS vs RELATIONAL JOINS
-- ====================================================================================================
/*
    +-------------------------+------------------------------------+------------------------------------+
    | FEATURE / DIMENSION     | SET OPERATORS (UNION, INTERSECT)   | RELATIONAL JOINS (INNER, LEFT,...) |
    +-------------------------+------------------------------------+------------------------------------+
    | Combination Axis        | VERTICAL (Appends rows below)      | HORIZONTAL (Appends columns beside)|
    | Schema Compatibility    | STRICT: Same column count & types  | FLEXIBLE: Any table schemas        |
    | Duplication Behavior    | Deduplicates by default (Set math) | Multiplies duplicates (N x M)      |
    | NULL = NULL Evaluation  | TRUE (INTERSECT includes NULL)     | UNKNOWN (INNER JOIN drops NULL)    |
    | Underlying Operation    | Set-theoretic membership           | Cartesian Product + Filter Predicate|
    +-------------------------+------------------------------------+------------------------------------+

    CORE JOIN EQUATION:
    JOIN = (Cartesian Cross-Product N x M) + (ON Filter Predicate)
*/

-- ====================================================================================================
-- 🔬 5. CASE STUDY 1: BASIC DISTINCT SET vs JOIN COMPARISON
-- ====================================================================================================
/*
    DATASETS:
    Table 1 (T1): [1, 2, 3, 4, NULL]   (5 rows)
    Table 2 (T2): [3, 4, 5, 6, NULL]   (5 rows)

    ----------------------------------------------------------------------------------------------------
    A. INTERSECT (Set Operator):
    ----------------------------------------------------------------------------------------------------
    Output: 3, 4, NULL (3 distinct values)
    -> Rationale: INTERSECT identifies elements present in both sets. It treats NULL as equal to NULL!

    ----------------------------------------------------------------------------------------------------
    B. CARTESIAN CROSS-PRODUCT (T1 x T2):
    ----------------------------------------------------------------------------------------------------
    Total Generated Pairs = 5 x 5 = 25 pairs:
    (1,3), (1,4), (1,5), (1,6), (1,NULL)
    (2,3), (2,4), (2,5), (2,6), (2,NULL)
    (3,3), (3,4), (3,5), (3,6), (3,NULL)  --> (3,3) evaluates to 3=3 (TRUE)
    (4,3), (4,4), (4,5), (4,6), (4,NULL)  --> (4,4) evaluates to 4=4 (TRUE)
    (NULL,3), (NULL,4), (NULL,5), (NULL,6), (NULL,NULL) --> NULL=NULL evaluates to UNKNOWN (DROPPED)

    ----------------------------------------------------------------------------------------------------
    C. JOIN OUTPUTS:
    ----------------------------------------------------------------------------------------------------
    * INNER JOIN:
      Output: (3, 3), (4, 4) -> Count = 2 Rows.
      (NULL is excluded because SQL comparison `NULL = NULL` yields UNKNOWN).

    * LEFT JOIN:
      Output: (3,3), (4,4), (1,NULL), (2,NULL), (NULL,NULL) -> Count = 5 Rows.
      (2 Inner Matches + 3 Unmatched Left Rows: 1, 2, NULL).

    * RIGHT JOIN:
      Output: (3,3), (4,4), (NULL,5), (NULL,6), (NULL,NULL) -> Count = 5 Rows.
      (2 Inner Matches + 3 Unmatched Right Rows: 5, 6, NULL).

    * FULL OUTER JOIN:
      Output: (3,3), (4,4), (1,NULL), (2,NULL), (NULL_left, NULL), (NULL,5), (NULL,6), (NULL, NULL_right)
      Count = 8 Rows (Inner 2 + Left Unmatched 3 + Right Unmatched 3 = 8).
*/

-- ====================================================================================================
-- 🎯 6. IN-CLASS QUIZ 1: DUPLICATE ONES & NULLS (THE CROSS-PRODUCT GAME)
-- ====================================================================================================
/*
    DATASETS:
    Table 1 (T1): [1, 1, 1, NULL]        (3 ones, 1 NULL -> Total 4 rows)
    Table 2 (T2): [1, 1, NULL, NULL]     (2 ones, 2 NULLs -> Total 4 rows)

    STEP-BY-STEP CALCULATION:
    -------------------------
    1. Matching '1's:
       - Table 1 has three 1s: 1_a, 1_b, 1_c
       - Table 2 has two 1s: 1_x, 1_y
       - Combinations = 3 * 2 = 6 matching rows:
         (1_a, 1_x), (1_a, 1_y), (1_b, 1_x), (1_b, 1_y), (1_c, 1_x), (1_c, 1_y)
    
    2. Matching NULLs:
       - Table 1 has 1 NULL. Table 2 has 2 NULLs.
       - In JOIN ON condition: `NULL = NULL` is UNKNOWN -> 0 matches!

    SUMMARY COUNTS:
    ---------------
    * INNER JOIN Count      = 6 Rows
    * LEFT JOIN Count       = 6 (Inner) + 1 (Unmatched T1 NULL) = 7 Rows
    * RIGHT JOIN Count      = 6 (Inner) + 2 (Unmatched T2 NULLs) = 8 Rows
    * FULL OUTER JOIN Count = 6 (Inner) + 1 (T1 NULL) + 2 (T2 NULLs) = 9 Rows
*/

-- ====================================================================================================
-- 🎯 7. IN-CLASS QUIZ 2: MULTI-DUPLICATE VALUES & CROSS-MATCHING MATRIX
-- ====================================================================================================
/*
    DATASETS:
    Table 1 (T1): [1, 2, 2, 3, 3, 3, NULL, 2]   (Total: 8 Rows -> 1: 1x, 2: 3x, 3: 3x, NULL: 1x)
    Table 2 (T2): [1, 1, 3, 3, NULL, 4, 4, 1]   (Total: 8 Rows -> 1: 3x, 3: 2x, 4: 2x, NULL: 1x)

    FREQUENCY & CARTESIAN MULTIPLICATION MAP:
    -----------------------------------------
    Key '1'  : T1 count = 1 | T2 count = 3 | Inner matches = 1 * 3 = 3 rows
    Key '2'  : T1 count = 3 | T2 count = 0 | Inner matches = 3 * 0 = 0 rows (Unmatched in T1 = 3 rows)
    Key '3'  : T1 count = 3 | T2 count = 2 | Inner matches = 3 * 2 = 6 rows
    Key '4'  : T1 count = 0 | T2 count = 2 | Inner matches = 0 * 2 = 0 rows (Unmatched in T2 = 2 rows)
    Key NULL : T1 count = 1 | T2 count = 1 | Inner matches = 0 rows (Unmatched T1=1, T2=1)

    FINAL COUNT CALCULATIONS:
    -------------------------
    * INNER JOIN Count:
      = 3 (from 1s) + 6 (from 3s)
      = 9 Rows.

    * LEFT JOIN Count:
      = Inner Matches (9) + Unmatched T1 Rows (3 of key '2' + 1 of key NULL)
      = 9 + 4 = 13 Rows.

    * RIGHT JOIN Count:
      = Inner Matches (9) + Unmatched T2 Rows (2 of key '4' + 1 of key NULL)
      = 9 + 3 = 12 Rows.

    * FULL OUTER JOIN Count:
      = Inner Matches (9) + Unmatched Left (4) + Unmatched Right (3)
      = 9 + 4 + 3 = 16 Rows.
*/

-- ====================================================================================================
-- 🎯 8. IN-CLASS QUIZ 3: STRING LITERAL 'NULL' vs SQL NULL KEYWORD TRAP
-- ====================================================================================================
/*
    CRITICAL INTERVIEW TRAP:
    ------------------------
    - `'NULL'` (enclosed in quotes) is a VARCHAR string literal. It behaves like any normal string.
    - `NULL` (without quotes) is the special SQL keyword representing an absent / unknown value.
    - `'NULL' = 'NULL'` evaluates to TRUE (Two strings with characters 'N','U','L','L' match!).
    - `NULL = NULL` evaluates to UNKNOWN (Dropped in Inner Join).

    DATASETS:
    Table 1 (T1): ['A', 'B', 'C', 'C', 'C', ''NULL'', NULL, 'B']
    -> Frequency T1: 'A': 1x, 'B': 2x, 'C': 3x, ''NULL'': 1x, NULL: 1x  (Total: 8 rows)

    Table 2 (T2): ['A', 'A', 'B', 'B', ''NULL'', ''NULL'', NULL, 'D', 'D']
    -> Frequency T2: 'A': 2x, 'B': 2x, ''NULL'': 2x, NULL: 1x, 'D': 2x  (Total: 9 rows)

    FREQUENCY & INNER MULTIPLICATION MAP:
    -------------------------------------
    Key 'A'       : 1 (in T1) * 2 (in T2) = 2 rows
    Key 'B'       : 2 (in T1) * 2 (in T2) = 4 rows
    Key 'C'       : 3 (in T1) * 0 (in T2) = 0 rows (Unmatched in T1 = 3 rows)
    Key ''NULL''  : 1 (in T1) * 2 (in T2) = 2 rows (STRING MATCH!)
    Key NULL      : 1 (in T1) * 1 (in T2) = 0 rows (KEYWORD NULL -> NO MATCH)
    Key 'D'       : 0 (in T1) * 2 (in T2) = 0 rows (Unmatched in T2 = 2 rows)

    FINAL COUNT CALCULATIONS:
    -------------------------
    * INNER JOIN Count:
      = 2 ('A') + 4 ('B') + 2 (''NULL'')
      = 8 Rows.

    * LEFT JOIN Count:
      = Inner Matches (8) + Unmatched T1 (3 of 'C' + 1 SQL NULL)
      = 8 + 4 = 12 Rows.

    * RIGHT JOIN Count:
      = Inner Matches (8) + Unmatched T2 (2 of 'D' + 1 SQL NULL)
      = 8 + 3 = 11 Rows.

    * FULL OUTER JOIN Count:
      = Inner Matches (8) + Unmatched Left (4) + Unmatched Right (3)
      = 8 + 4 + 3 = 15 Rows.
*/

-- ====================================================================================================
-- ⚡ 9. THE DATA ENGINEER'S MASTER ROW-COUNT FORMULAS
-- ====================================================================================================
/*
    MASTER FORMULAS TO MEMORIZE FOR TIER-1 INTERVIEWS:
    --------------------------------------------------
    1. For every distinct value 'k' present in both tables:
       InnerMatch(k) = Count_T1(k) * Count_T2(k)
       (Note: Exclude SQL NULL keyword from InnerMatch)

    2. Total Inner Join Count:
       Count(INNER JOIN) = Sum of InnerMatch(k) for all matching keys 'k'

    3. Total Left Join Count:
       Count(LEFT JOIN) = Count(INNER JOIN) + Count(Unmatched Rows in T1)

    4. Total Right Join Count:
       Count(RIGHT JOIN) = Count(INNER JOIN) + Count(Unmatched Rows in T2)

    5. Total Full Outer Join Count:
       Count(FULL OUTER JOIN) = Count(INNER JOIN) + Unmatched_T1 + Unmatched_T2

    6. Total Cross Join Count:
       Count(CROSS JOIN) = TotalRows(T1) * TotalRows(T2)
*/

-- ====================================================================================================
-- 🏁 END OF CLASS NOTES — 18 AUGUST 2026
-- ====================================================================================================