/*================================================================
   SQL CLASS NOTES - 04 AUGUST 2026 (DAY 4)
   TOPICS: ARITHMETIC OPERATORS, UPDATE & DELETE (DML), DROP TABLE (DDL)
==================================================================*/


/*================================================================
1. ARITHMETIC OPERATIONS (Output-Only / Temporary Columns)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Used with numeric types. These calculations do NOT alter table data!
------------------------------------------------------------------*/

SELECT * FROM employee1;

SELECT * FROM StudentInfo;


-- Add 10 marks and Double the marks (creates temporary columns in output)
SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo;


SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo
WHERE roll_no = 110;


SELECT *, Less_marks = marks - 10 FROM StudentInfo;

SELECT *, Square_marks = marks * marks FROM StudentInfo;

SELECT *, Half_marks = marks / 2 FROM StudentInfo;


-- PRACTICE DRILLS (Read-only output projection)
SELECT *, Inc_salary = salary * 1.1 FROM employee1;   -- Salary + 10%

SELECT *, Dec_salary = salary * 0.7 FROM employee1;   -- Salary - 30%

SELECT *, Inc_Marks = marks * 1.1 FROM StudentInfo;    -- Marks + 10%

SELECT *, Dec_Marks = marks * 0.6 FROM StudentInfo;    -- Marks - 40%


/*================================================================
2. DELETE STATEMENT (DML: Clearing rows, keeping table structure)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Analogy: Emptying folders in a filing cabinet. The cabinet remains.
DELETE can be rolled back inside transactions.
------------------------------------------------------------------*/

SELECT * FROM employee1;


-- DELETE FROM employee1;
/*----------------------------------------------------------------
⚠️ WARNING: Deletes ALL rows from the table!
------------------------------------------------------------------*/


DELETE FROM employee1 WHERE empid = 101;

DELETE FROM employee1 WHERE empname = 'Pushpak';


/*================================================================
3. UPDATE STATEMENT (DML: Modifying cell values in place)
==================================================================*/

/*----------------------------------------------------------------
Theory:
UPDATE changes actual values inside the database.
------------------------------------------------------------------*/

-- Example A: Update entire column (All rows modified!)
UPDATE StudentInfo
SET subject = 'Physics';


-- Example B: Update with WHERE filter
UPDATE StudentInfo
SET subject = 'Maths'
WHERE name LIKE '%i%';


-- Example C: Self-update (referencing current column value)
UPDATE StudentInfo
SET subject = 'Computer'
WHERE subject = 'Maths';


-- Example D: Update multiple columns in one query
UPDATE StudentInfo
SET subject = 'Art',
    marks   = 90,
    age     = 23
WHERE mobile_no = 992342352;


UPDATE StudentInfo
SET name = 'Nehal',
    age  = 22
WHERE name = 'Neha';


/*================================================================
4. WORKING WITH NULLS & EMPTY VALUES
==================================================================*/

-- Replace NULL with city default
UPDATE StudentInfo
SET city = 'Nashik'
WHERE city IS NULL;


-- Replace active city with NULL
UPDATE StudentInfo
SET city = NULL
WHERE city = 'Nashik';


UPDATE StudentInfo
SET name = ''
WHERE name = 'Rahul';

/*----------------------------------------------------------------
Note:
Character columns accept empty strings (''), but numeric columns cannot!
------------------------------------------------------------------*/

SELECT * FROM StudentInfo;


-- Math modifications written back to disk
UPDATE StudentInfo SET marks = marks + 2;

UPDATE StudentInfo SET marks = marks - 2;

UPDATE StudentInfo SET marks = marks * 2 WHERE name = 'arpit';

UPDATE StudentInfo SET marks = marks * 1.1 WHERE name = 'nehal';

SELECT * FROM StudentInfo;


/*================================================================
5. DROP TABLE (DDL: Complete Destruction)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Analogy: Burning down the entire filing cabinet. Cover and files are gone!
------------------------------------------------------------------*/

INSERT INTO employee1 VALUES (1, 'a', NULL, NULL), (2, 'b', 'tech', 2000);


DROP TABLE employee1;


-- SELECT * FROM employee1;
/*----------------------------------------------------------------
Error:
❌ Fails: Invalid object name 'employee1' (Table no longer exists).
------------------------------------------------------------------*/


/*================================================================
6. DE ENTERPRISE SECURITY NOTE
==================================================================*/

/*----------------------------------------------------------------
Note:
Database Administrators (DBAs) restrict delete/drop permissions.
Normal engineers rarely get DELETE or DROP permissions in production DBs.
------------------------------------------------------------------*/\n