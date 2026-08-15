/* ================================================================================
   SQL CLASS NOTES - 14 AUGUST 2026 (DAY 13)
   TOPICS: SET OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT), VALIDATION RULES
   ================================================================================ */

-- ------------------------------------------------------------
-- 📖 THEORY: SET OPERATORS (Row-based merging)
-- ------------------------------------------------------------
-- Unlike JOINs (which connect tables side-by-side/column-wise), 
-- Set Operators merge tables top-to-bottom/row-wise.

-- 1. UNION (Combines results and removes duplicate rows)
-- Math: A = {1, 2, 3}, B = {3, 4} -> A UNION B = {1, 2, 3, 4}

-- 2. UNION ALL (Combines results and keeps all duplicate rows. Faster!)
-- Math: A = {1, 2, 3}, B = {3, 4} -> A UNION ALL B = {1, 2, 3, 3, 4}

-- 3. INTERSECT (Returns only common rows present in both queries)
-- Math: A = {1, 2, 3}, B = {3, 4} -> A INTERSECT B = {3}

-- 4. EXCEPT (Returns rows in first query NOT present in second query)
-- Math: A = {1, 2, 3}, B = {3, 4} -> A EXCEPT B = {1, 2}

-- ------------------------------------------------------------
-- 📖 Set Operator Validation Rules
-- ------------------------------------------------------------
-- Rule 1: The SELECT statements must have the EXACT same number of columns.
-- Rule 2: Corresponding columns must have compatible data types in the exact same order.

-- Real-World Scenario: Merging customer databases from different bank branches (identical schema).

-- ------------------------------------------------------------
-- 💻 PRACTICE: SET OPERATIONS
-- ------------------------------------------------------------

CREATE TABLE Newset1 (
    id INT,
    name VARCHAR(10)
);

CREATE TABLE Newset2 (
    custid INT,
    dept VARCHAR(10)
);

INSERT INTO Newset1 VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D');
INSERT INTO Newset2 VALUES (2, 'HR'), (3, 'Entc'), (4, NULL), (5, NULL);

SELECT * FROM Newset1;
SELECT * FROM Newset2;

-- UNION on all columns (Row-wide evaluation includes duplicates due to name/dept differences)
SELECT * FROM Newset1 
UNION 
SELECT * FROM Newset2; 

-- UNION on single column (removes duplicate IDs)
SELECT id FROM Newset1 
UNION 
SELECT custid FROM Newset2;

-- UNION ALL (Combines all rows directly without checking for duplicates. Faster!)
SELECT * FROM Newset1 
UNION ALL 
SELECT * FROM Newset2; 

-- INTERSECT: Finds common IDs
SELECT id FROM Newset1 
INTERSECT 
SELECT custid FROM Newset2; 

-- EXCEPT: Elements in table 1 not in table 2
SELECT id FROM Newset1 
EXCEPT 
SELECT custid FROM Newset2;\n