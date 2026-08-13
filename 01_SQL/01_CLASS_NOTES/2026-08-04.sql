-- ============================================================
-- SQL NOTES - DAY 2 (4 August 2026)
-- ARITHMETIC OPERATIONS & DML/DDL (UPDATE, DELETE, DROP)
-- ============================================================

-- ============================================================
-- DISPLAY DATA
-- ============================================================

SELECT * FROM employee1;
SELECT * FROM StudentInfo;


-- ============================================================
-- ARITHMETIC OPERATIONS
-- Used with numeric data types such as:
-- INT, FLOAT, DOUBLE, DECIMAL
--
-- Operators:
-- +  Addition
-- -  Subtraction
-- *  Multiplication
-- /  Division
-- ============================================================

SELECT * FROM StudentInfo;


-- ------------------------------------------------------------
-- Creating Temporary Columns (Only in Output)
-- These columns are NOT stored in the table.
-- ------------------------------------------------------------

-- Add 10 marks and Double the marks
SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo;

-- Same query for a specific student
SELECT *,
       New_marks = marks + 10,
       Marks1 = marks * 2
FROM StudentInfo
WHERE roll_no = 110;

-- Subtract 10 marks
SELECT *,
       Less_marks = marks - 10
FROM StudentInfo;

-- Square of marks
SELECT *,
       Square_marks = marks * marks
FROM StudentInfo;

-- Half of marks
SELECT *,
       Half_marks = marks / 2
FROM StudentInfo;


-- ============================================================
-- PRACTICE QUESTIONS
-- ============================================================

-- Question 1 : Increase employee salary by 10%
SELECT *,
       Inc_salary = salary * 1.1
FROM employee1;


-- Question 2 : Decrease employee salary by 30%
SELECT *,
       Dec_salary = salary * 0.7
FROM employee1;


-- Question 3 : Increase student marks by 10%
SELECT *,
       Inc_Marks = marks * 1.1
FROM StudentInfo;


-- Question 4 : Decrease student marks by 40%
SELECT *,
       Dec_Marks = marks * 0.6
FROM StudentInfo;


-- ============================================================
-- DML (DATA MANIPULATION LANGUAGE)
--
-- Statements:
-- 1. INSERT
-- 2. UPDATE
-- 3. DELETE
-- ============================================================


-- ============================================================
-- DELETE STATEMENT
-- ============================================================

-- Syntax:
-- DELETE FROM table_name;

-- Purpose:
-- • Deletes data from a table.
-- • Can delete all rows or selected rows.
-- • WHERE clause is used for specific records.
-- • DELETE can be rolled back (depending on transactions).
-- • Only data is removed.
-- • Table structure remains unchanged.


-- View all tables
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- View employee data
SELECT * FROM employee1;

-- Delete all rows
DELETE FROM employee1;

-- Delete a specific employee using Employee ID
DELETE FROM employee1
WHERE empid = 101;

-- Delete a specific employee using Name
DELETE FROM employee1
WHERE empname = 'Pushpak';


-- ============================================================
-- UPDATE STATEMENT
-- ============================================================

-- Syntax:
-- UPDATE table_name
-- SET column_name = value;


-- ------------------------------------------------------------
-- Update Single Column
-- ------------------------------------------------------------

-- Update the entire Subject column
UPDATE StudentInfo
SET subject = 'Physics';


-- Update subject only where name contains 'i'
UPDATE StudentInfo
SET subject = 'Maths'
WHERE name LIKE '%i%';


-- Using the same column in SET and WHERE
UPDATE StudentInfo
SET subject = 'Computer'
WHERE subject = 'Maths';


-- ------------------------------------------------------------
-- Update Multiple Columns
-- ------------------------------------------------------------

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
-- DEALING WITH NULL VALUES
-- ------------------------------------------------------------

-- Replace NULL with a value
UPDATE StudentInfo
SET city = 'Nashik'
WHERE city IS NULL;


-- Replace a value with NULL
UPDATE StudentInfo
SET city = NULL
WHERE city = 'Nashik';


-- ------------------------------------------------------------
-- Removing Specific Value
-- ------------------------------------------------------------

UPDATE StudentInfo
SET name = ''
WHERE name = 'Rahul';

-- Note:
-- Empty string ('') can be used for character columns.
-- Numeric columns cannot be emptied like this.


SELECT * FROM StudentInfo;


-- ------------------------------------------------------------
-- Practice Questions Using UPDATE + Arithmetic Operators
-- ------------------------------------------------------------

-- Increase marks by 2
UPDATE StudentInfo
SET marks = marks + 2;


-- Decrease marks by 2
UPDATE StudentInfo
SET marks = marks - 2;


-- Double marks of Arpit
UPDATE StudentInfo
SET marks = marks * 2
WHERE name = 'arpit';


-- Increase Nehal's marks by 10%
UPDATE StudentInfo
SET marks = marks * 1.1
WHERE name = 'nehal';


-- View updated data
SELECT * FROM StudentInfo;


-- ============================================================
-- INSERT STATEMENT
-- ============================================================

-- Already covered previously.


-- ============================================================
-- DDL (DATA DEFINITION LANGUAGE) - DROP STATEMENT
-- ============================================================

-- Syntax:
-- DROP TABLE table_name;

-- Purpose:
-- • Deletes the entire table.
-- • Removes data and structure.
-- • Table no longer exists after execution.
-- • WHERE clause is not required.
-- • Rollback depends on the database.
--     SQL Server : Possible under some conditions.
--     Oracle     : Generally not possible after COMMIT.


-- View existing table
SELECT * FROM employee1;


-- Insert sample data
INSERT INTO employee1
VALUES
(1, 'a', NULL, NULL),
(2, 'b', 'tech', 2000);


-- Drop the table
DROP TABLE employee1;


-- After DROP
-- Running the following query will produce:
-- "Invalid object name 'employee1'."

-- SELECT * FROM employee1;


-- ============================================================
-- COMPANY LEVEL NOTE
-- ============================================================

-- In real companies:
--
-- • Database Administrators (DBAs) manage permissions.
-- • Every employee does not get permission to DELETE or DROP tables.
-- • Permissions are controlled at different levels:
--      - Database
--      - Table
--      - Column
--      - Row
-- • Learn both:
--      1. SQL syntax
--      2. Real-world database security and permissions

-- ============================================================
-- END OF DAY 2
-- ============================================================