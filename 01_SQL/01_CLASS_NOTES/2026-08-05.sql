/* ================================================================================
   SQL CLASS NOTES - 05 AUGUST 2026 (DAY 5)
   TOPICS: TRUNCATE VS DELETE VS DROP (DDL VS DML), ALTER TABLE (ADD, DROP, ALTER), SP_RENAME
   ================================================================================ */

-- ------------------------------------------------------------
-- DML VS DDL COMPARISON (DELETE, TRUNCATE, DROP)
-- ------------------------------------------------------------
-- 📖 THE NOTEBOOK ANALOGY:
-- Imagine your table is a spiral notebook.
-- 1. DELETE (DML): Eraser method. Erases text line-by-line (WHERE filter allowed). Slower.
-- 2. TRUNCATE (DDL): Page-ripping method. Rips out all pages (WHERE not allowed). Resets IDENTITY. Faster.
-- 3. DROP (DDL): Demolition method. Burns down the whole notebook (data + cover are gone!).

SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * FROM employee1;

-- Clean out table
TRUNCATE TABLE employee1;

-- ------------------------------------------------------------
-- ALTER TABLE (DDL: Modifying active table structures)
-- ------------------------------------------------------------

-- 1. ADD COLUMN (New fields default to NULL)
ALTER TABLE employee1
ADD city  VARCHAR(10),
    age   INT,
    marks INT;

SELECT * FROM employee1;

UPDATE employee1 SET city = 'Pune', age = 30, marks = 40;
UPDATE employee1 SET city = 'Nagpur' WHERE empname LIKE 'a%';

ALTER TABLE employee1 ADD mobile_no VARCHAR(20);
UPDATE employee1 SET mobile_no = '9923423527';

-- 2. DROP COLUMN (Removes structural field completely from disk)
ALTER TABLE employee1 DROP COLUMN city, marks;
ALTER TABLE employee1 DROP COLUMN mobile_no;

SELECT * FROM employee1;

ALTER TABLE employee1 ADD gender CHAR;
SELECT * FROM employee1;
ALTER TABLE employee1 DROP COLUMN gender;

-- 3. ALTER COLUMN (Changing data types and length)
-- Change INT to VARCHAR
ALTER TABLE employee ALTER COLUMN empid VARCHAR(10);
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;

-- Flip column data type back and forth
ALTER TABLE employee1 ALTER COLUMN age VARCHAR(10);   -- INT -> VARCHAR (Valid)
ALTER TABLE employee1 ALTER COLUMN age INT;           -- VARCHAR -> INT (Valid)

-- Increase column length
ALTER TABLE employee1 ALTER COLUMN empname VARCHAR(60);

-- Decrease column length
-- Note: Fails if active data in the table is longer than target length!
ALTER TABLE employee1 ALTER COLUMN empname VARCHAR(10);
-- ALTER TABLE employee1 ALTER COLUMN empname VARCHAR(3); -- (Produces truncation error!)

-- 4. RENAME TABLE (Using system stored procedure)
SELECT * FROM employee1;
EXECUTE sp_rename 'employee1', 'emp';
SELECT * FROM emp;
EXECUTE sp_rename 'emp', 'employee1';

-- 5. RENAME COLUMN (Syntax: 'table.old_col', 'new_col')
-- Note: Run on active table/column names.
-- EXECUTE sp_rename 'employee1.dept', 'org_id';
