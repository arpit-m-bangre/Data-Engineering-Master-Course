-- ============================================================
-- DAY 3 - AUGUST 5
-- SQL DDL & DML COMMANDS (DELETE, DROP, TRUNCATE, ALTER, RENAME)
-- ============================================================

-- ============================================================
-- DML (Data Manipulation Language) - DELETE
-- ============================================================

-- DELETE
-- Syntax:
-- DELETE FROM table_name;
--
-- Features:
-- • Deletes all rows or specific rows (using WHERE clause)
-- • Table structure remains unchanged
-- • Slower than TRUNCATE
-- • Can be rolled back (if transaction is not committed)

-- Example:
DELETE FROM table_name;


-- ============================================================
-- DDL (Data Definition Language) - DROP & TRUNCATE
-- ============================================================

-- DROP
-- Syntax:
-- DROP TABLE table_name;
--
-- Features:
-- • Deletes the entire table along with its structure
-- • Table no longer exists after execution
-- • Rollback depends on the database being used

DROP TABLE table_name;


-- TRUNCATE
-- Syntax:
-- TRUNCATE TABLE table_name;
--
-- Features:
-- • Deletes all rows from a table
-- • Table structure remains unchanged
-- • Faster than DELETE
-- • WHERE clause cannot be used
-- • Rollback depends on the database being used

TRUNCATE TABLE table_name;


-- ============================================================
-- INFORMATION_SCHEMA
-- ============================================================

SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM employee1;

TRUNCATE TABLE employee1;


-- ============================================================
-- DIFFERENCE: DELETE vs TRUNCATE
-- ============================================================

-- DELETE
-- • DML Command
-- • Can delete specific rows using WHERE clause
-- • Slower
-- • Table structure remains unchanged

-- TRUNCATE
-- • DDL Command
-- • Deletes all rows only (no WHERE clause)
-- • Faster than DELETE
-- • Table structure remains unchanged

-- Key Difference:
-- DELETE can remove specific rows.
-- TRUNCATE removes all rows and is faster.


-- ============================================================
-- ALTER TABLE
-- Used to modify the structure of an existing table.
-- ============================================================

-- ------------------------------------------------------------
-- 1. ADD COLUMN
-- ------------------------------------------------------------

SELECT * FROM employee1;

ALTER TABLE employee1
ADD city  VARCHAR(10),
    age   INT,
    marks INT;

UPDATE employee1
SET city  = 'Pune',
    age   = 30,
    marks = 40;

UPDATE employee1
SET city = 'Nagpur'
WHERE empname LIKE 'a%';


ALTER TABLE employee1
ADD mobile_no VARCHAR(20);

UPDATE employee1
SET mobile_no = '9923423527';


-- ------------------------------------------------------------
-- 2. DROP COLUMN
-- ------------------------------------------------------------

-- Syntax:
-- ALTER TABLE table_name
-- DROP COLUMN column_name1, column_name2;

ALTER TABLE employee1
DROP COLUMN city, marks;

-- Note:
-- DROP COLUMN is used because columns are part of the table structure (DDL).
-- DELETE removes data, whereas DROP COLUMN removes the column itself.

ALTER TABLE employee1
DROP COLUMN mobile_no;

SELECT * FROM employee1;


ALTER TABLE employee1
ADD gender CHAR;

SELECT * FROM employee1;

ALTER TABLE employee1
DROP COLUMN gender;


-- ------------------------------------------------------------
-- 3. CHANGE DATA TYPE / COLUMN LENGTH
-- ------------------------------------------------------------

-- Change INT to VARCHAR
ALTER TABLE employee
ALTER COLUMN empid VARCHAR(10);

SELECT * FROM INFORMATION_SCHEMA.COLUMNS;


ALTER TABLE employee1
ALTER COLUMN age VARCHAR(10);   -- INT → VARCHAR (Valid)

ALTER TABLE employee1
ALTER COLUMN age INT;           -- VARCHAR → INT (Valid)

ALTER TABLE employee
ALTER COLUMN city INT;
-- Error:
-- ALTER TABLE ALTER COLUMN failed because column 'city'
-- does not exist in table 'employee'.


-- Increase column length
ALTER TABLE employee1
ALTER COLUMN empname VARCHAR(60);

-- Decrease column length
ALTER TABLE employee1
ALTER COLUMN empname VARCHAR(10);

ALTER TABLE employee1
ALTER COLUMN empname VARCHAR(3);
-- Error:
-- String or binary data would be truncated.

-- Note:
-- Data type or length can only be changed if the existing data
-- is compatible with the new data type/size.


-- ------------------------------------------------------------
-- 4. RENAME TABLE
-- ------------------------------------------------------------

SELECT * FROM employee1;

EXECUTE sp_rename 'employee1', 'emp';

SELECT * FROM emp;

EXECUTE sp_rename 'emp', 'employee1';


-- ------------------------------------------------------------
-- 5. RENAME COLUMN
-- ------------------------------------------------------------

EXECUTE sp_rename 'emp.dept', 'org_id';


-- ============================================================
-- QUICK REVISION
-- ============================================================

-- DELETE
-- • DML
-- • Deletes specific/all rows
-- • WHERE clause allowed
-- • Slower
-- • Structure remains unchanged

-- TRUNCATE
-- • DDL
-- • Deletes all rows only
-- • WHERE clause not allowed
-- • Faster
-- • Structure remains unchanged

-- DROP
-- • DDL
-- • Deletes entire table (data + structure)

-- ALTER
-- • Used to modify table structure
-- • Add columns
-- • Drop columns
-- • Change data types
-- • Rename tables/columns