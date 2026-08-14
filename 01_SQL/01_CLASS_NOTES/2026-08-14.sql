-- ==============================================================================
-- DATE: 2026-08-14
-- TOPIC: SET OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT)
-- ==============================================================================

-- Topics till now were fundamental (DDL/DML, clauses), but starting today, 
-- topics are crucial for interview scenarios and query optimization.

-- ==============================================================================
-- SECTION 1: SET OPERATORS INTRODUCTION
-- ==============================================================================
-- 1. UNION 
-- 2. UNION ALL 
-- 3. INTERSECT 
-- 4. EXCEPT 

-- ==============================================================================
-- 1. UNION
-- ==============================================================================
-- Combines values from two queries, BUT automatically removes duplicates.
/*
Example:
A = {1, 2, 3, 4}
B = {3, 4, 5, 6}
A UNION B = {1, 2, 3, 4, 5, 6} 
(Note: 3 and 4 appear only once)
*/

-- ==============================================================================
-- 2. UNION ALL
-- ==============================================================================
-- Combines values from two queries WITH duplicates included.
/*
Example:
A = {1, 2, 3, 4}
B = {3, 4, 5, 6}
A UNION ALL B = {1, 2, 3, 4, 3, 4, 5, 6} 
(Note: 3 and 4 appear twice)
*/

-- ==============================================================================
-- 3. INTERSECT
-- ==============================================================================
-- Returns ONLY the common values present in both tables.
/*
Example:
A = {1, 2, 3, 4}
B = {3, 4, 5, 6}
A INTERSECT B = {3, 4} 
*/

-- ==============================================================================
-- 4. EXCEPT
-- ==============================================================================
-- Similar to mathematical MINUS. Returns records from the first query that are 
-- NOT present in the second query.
/*
Example:
A = {1, 2, 3, 4}
B = {3, 4, 5, 6}
A EXCEPT B = {1, 2}
B EXCEPT A = {5, 6} 
*/

-- ==============================================================================
-- SECTION 2: VALIDATION RULES FOR SET OPERATIONS
-- ==============================================================================
-- Rule 1: Must have the SAME number of columns in both SELECT statements.
-- Rule 2: Columns must have the SAME data type in the SAME sequence.
-- Note: Set operations are rarely used because finding two tables with the exact 
-- same structure is rare, except in specific scenarios like merging bank branches.

/*
Real-World Scenario:
Bank table structures are mostly identical.
Columns: cust_id, cust_name, account_no, address, mob, email, balance

If we want to combine customer lists from BOI XYZ Branch and BOI ABC Branch, 
we can use UNION to get a combined, deduped customer list.
*/

-- ==============================================================================
-- SECTION 3: PRACTICAL IMPLEMENTATION
-- ==============================================================================

-- Create Sample Tables
CREATE TABLE Newset1 (
    id INT,
    name VARCHAR(10)
);

CREATE TABLE Newset2 (
    custid INT,
    dept VARCHAR(10)
);

-- Insert Sample Data
INSERT INTO Newset1 VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D');
INSERT INTO Newset2 VALUES (2, 'HR'), (3, 'Entc'), (4, NULL), (5, NULL);

-- View Tables
SELECT * FROM Newset1;
SELECT * FROM Newset2;

-- ------------------------------------------------------------------------------
-- UNION EXAMPLES
-- ------------------------------------------------------------------------------
-- Using UNION on all columns (*) will include duplicates because the whole row 
-- is evaluated, and the names/depts are different even if IDs match.
SELECT * FROM Newset1 
UNION 
SELECT * FROM Newset2; 

-- Using UNION on just the ID column will remove duplicate IDs.
SELECT id FROM Newset1 
UNION 
SELECT custid FROM Newset2;

-- ------------------------------------------------------------------------------
-- UNION ALL EXAMPLES
-- ------------------------------------------------------------------------------
SELECT * FROM Newset1 
UNION ALL 
SELECT * FROM Newset2; 

-- ------------------------------------------------------------------------------
-- INTERSECT EXAMPLES
-- ------------------------------------------------------------------------------
SELECT * FROM Newset1 
INTERSECT 
SELECT * FROM Newset2; 

SELECT id FROM Newset1 
INTERSECT 
SELECT custid FROM Newset2; 

-- ------------------------------------------------------------------------------
-- EXCEPT EXAMPLES
-- ------------------------------------------------------------------------------
SELECT * FROM Newset1 
EXCEPT 
SELECT * FROM Newset2; 

SELECT id FROM Newset1 
EXCEPT 
SELECT custid FROM Newset2;

-- ==============================================================================
-- NOTE: SQL test sent via Google Form. The test focuses on SQL Clauses.
-- ==============================================================================