/* ================================================================================
   SQL CLASS NOTES - 04 AUGUST 2026 (DAY 4)
   TOPICS: ARITHMETIC OPERATORS, UPDATE & DELETE (DML), DROP TABLE (DDL), SECURITY
   ================================================================================ */

-- 1. DISPLAY DATA
SELECT * FROM employee1;
SELECT * FROM StudentInfo;

-- ------------------------------------------------------------
-- ARITHMETIC OPERATIONS (Output-Only / Temporary Columns)
-- ------------------------------------------------------------
-- Used with numeric types (INT, FLOAT, DECIMAL).
-- These calculations do NOT alter the actual table data! They only show in the output.

-- Add 10 marks and Double the marks (creating temporary aliases)
SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo;

-- Apply arithmetic to a single filtered row
SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo
WHERE roll_no = 110;

-- Subtraction, multiplication, and division
SELECT *, Less_marks = marks - 10 FROM StudentInfo;
SELECT *, Square_marks = marks * marks FROM StudentInfo;
SELECT *, Half_marks = marks / 2 FROM StudentInfo;

-- PRACTICE DRILLS (Read-only projections)
SELECT *, Inc_salary = salary * 1.1 FROM employee1;   -- Salary + 10%
SELECT *, Dec_salary = salary * 0.7 FROM employee1;   -- Salary - 30%
SELECT *, Inc_Marks = marks * 1.1 FROM StudentInfo;    -- Marks + 10%
SELECT *, Dec_Marks = marks * 0.6 FROM StudentInfo;    -- Marks - 40%

-- ------------------------------------------------------------
-- DML: DELETE (Clearing rows, keeping the table structure)
-- ------------------------------------------------------------
-- Analogy: Emptying folders in a filing cabinet. The cabinet remains.
-- DELETE can be rolled back inside transactions.

SELECT * FROM employee1;

-- ❌ DANGEROUS: Deletes ALL rows from the table!
-- DELETE FROM employee1;

-- ✔️ SAFE: Delete specific rows using WHERE filters
DELETE FROM employee1 WHERE empid = 101;
DELETE FROM employee1 WHERE empname = 'Pushpak';

-- ------------------------------------------------------------
-- DML: UPDATE (Modifying specific cells in place)
-- ------------------------------------------------------------
-- UPDATE changes actual values inside the database!

-- Example A: Update entire column (All rows modified!)
UPDATE StudentInfo
SET subject = 'Physics';

-- Example B: Update with WHERE filter
UPDATE StudentInfo
SET subject = 'Maths'
WHERE name LIKE '%i%';

-- Example C: Self-update (using target column to filter and set)
UPDATE StudentInfo
SET subject = 'Computer'
WHERE subject = 'Maths';

-- Example D: Update multiple columns in one statement
UPDATE StudentInfo
SET subject = 'Art',
    marks   = 90,
    age     = 23
WHERE mobile_no = 992342352;

UPDATE StudentInfo
SET name = 'Nehal',
    age  = 22
WHERE name = 'Neha';

-- ------------------------------------------------------------
-- WORKING WITH NULLS & EMPTY VALUES IN UPDATE
-- ------------------------------------------------------------

-- Replace NULL with a default value
UPDATE StudentInfo
SET city = 'Nashik'
WHERE city IS NULL;

-- Replace a value with NULL
UPDATE StudentInfo
SET city = NULL
WHERE city = 'Nashik';

-- Note: Character columns accept empty strings (''), but numeric columns cannot!
UPDATE StudentInfo
SET name = ''
WHERE name = 'Rahul';

SELECT * FROM StudentInfo;

-- ------------------------------------------------------------
-- MATH MODIFICATIONS (Writing updates back to disk)
-- ------------------------------------------------------------
UPDATE StudentInfo SET marks = marks + 2;
UPDATE StudentInfo SET marks = marks - 2;
UPDATE StudentInfo SET marks = marks * 2 WHERE name = 'arpit';
UPDATE StudentInfo SET marks = marks * 1.1 WHERE name = 'nehal';

SELECT * FROM StudentInfo;

-- ------------------------------------------------------------
-- DDL: DROP TABLE (Complete Destruction)
-- ------------------------------------------------------------
-- Analogy: Demolishing the entire filing cabinet. Structure and data are both gone!
-- In SQL Server, DROP can be rolled back ONLY under active transactions.

-- Set up test data
INSERT INTO employee1 VALUES (1, 'a', NULL, NULL), (2, 'b', 'tech', 2000);

-- Destroy table
DROP TABLE employee1;

-- Running the query below now fails with: "Invalid object name 'employee1'."
-- SELECT * FROM employee1;

-- ------------------------------------------------------------
-- DE ENTERPRISE SECURITY NOTE
-- ------------------------------------------------------------
-- In real companies, permissions are restricted by DBAs. 
-- Normal engineers rarely get DELETE or DROP permissions in production.
-- Security applies at: Database -> Table -> Column -> Row level.
