-- ============================================================
-- DAY 4 - AUGUST 6
-- SQL CLAUSES & AGGREGATE FUNCTIONS
-- ============================================================

-- SQL Clauses Covered:
-- -------------------
-- 1. WHERE
-- 2. GROUP BY
-- 3. HAVING
-- 4. ORDER BY

-- WHERE:
-- -----
-- Already completed in previous sessions.


-- ============================================================
-- GROUP BY & AGGREGATE FUNCTIONS
-- ============================================================

-- GROUP BY is always used with Aggregate Functions.

-- Aggregate Functions:
-- --------------------
-- 1. MIN()
-- 2. MAX()
-- 3. SUM()
-- 4. AVG()
-- 5. COUNT()

-- Other Topics:
-- -------------
-- DISTINCT
-- TOP


-- ------------------------------------------------------------
-- Sample Tables
-- ------------------------------------------------------------

SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM emp;


-- ------------------------------------------------------------
-- IMPORTANT NOTE
-- ------------------------------------------------------------

-- SUM() and AVG() require the backend data type
-- to be numeric (INT, FLOAT, DECIMAL, etc.).


-- ============================================================
-- 1. MIN()
-- ============================================================

SELECT MIN(salary) AS min_salary
FROM emp;

-- 'AS' is optional.

-- NOTE:
-- Aggregate functions return a single value,
-- therefore SELECT * cannot be used with them.

SELECT MIN(empname) AS min_name
FROM emp;


-- ============================================================
-- 2. MAX()
-- ============================================================

SELECT MAX(salary) AS max_salary
FROM emp;

SELECT MAX(empname) AS max_name
FROM emp;


-- ============================================================
-- 3. SUM()
-- ============================================================

SELECT SUM(salary) AS sum_salary
FROM emp;

SELECT SUM(empname) AS sum_name
FROM emp;

-- Error:
-- Operand data type varchar is invalid
-- for SUM operator.


-- ============================================================
-- 4. AVG()
-- ============================================================

SELECT AVG(salary) AS avg_salary
FROM emp;


-- ------------------------------------------------------------
-- Multiple Aggregate Functions
-- ------------------------------------------------------------

SELECT
    AVG(salary) AS avg_salary,
    SUM(salary) AS sum_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary
FROM emp;


-- ------------------------------------------------------------
-- IMPORTANT NOTE ABOUT AVG()
-- ------------------------------------------------------------

-- Example Data:
-- 20
-- 30
-- NULL
-- 30

-- Total = 80
-- AVG = 80 / 3

-- NULL values are ignored by AVG().


-- ============================================================
-- 5. COUNT()
-- ============================================================

SELECT COUNT(org_id)
FROM emp;

-- COUNT(column_name) ignores NULL values.

SELECT COUNT(empname)
FROM emp;

SELECT COUNT(*)
FROM emp;

-- COUNT(*) counts every row,
-- including rows containing NULL values.


-- ------------------------------------------------------------
-- NULL Example
-- ------------------------------------------------------------

CREATE TABLE dummy
(
    id INT
);

INSERT INTO dummy
VALUES
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL);

SELECT *
FROM dummy;

SELECT COUNT(*)
FROM dummy;

-- COUNT(*) considers all rows,
-- even if every value is NULL.


-- ============================================================
-- DISTINCT
-- ============================================================

-- DISTINCT returns unique values only.

SELECT DISTINCT(org_id)
FROM emp;

SELECT DISTINCT(empname)
FROM emp;

SELECT *
FROM emp;


-- ------------------------------------------------------------
-- COUNT(DISTINCT)
-- ------------------------------------------------------------

SELECT COUNT(DISTINCT(org_id))
FROM emp;

-- Counts the number of unique org_id values.


-- ------------------------------------------------------------
-- IMPORTANT NOTES
-- ------------------------------------------------------------

-- 1. Aggregate functions generally work with HAVING
--    when filtering aggregated results.

-- 2. Do not write:
-- SELECT DISTINCT(empname), DISTINCT(org_id) FROM emp;
-- This is invalid syntax.

/*
Example:

SELECT DISTINCT
       empname,
       org_id,
       salary,
       age,
       empid
FROM emp;

This applies DISTINCT to the entire row,
not to each individual column.

Every column can have different unique values,
so applying DISTINCT separately to each column
does not make practical sense.
*/


-- ============================================================
-- TOP
-- ============================================================

SELECT TOP 2 *
FROM emp;

-- SQL Server supports TOP.
-- There is no BOTTOM keyword.

SELECT TOP 3 salary
FROM emp;

-- TOP simply returns the first N rows.
-- NULL values may also appear.


-- ------------------------------------------------------------
-- Real-World Example
-- ------------------------------------------------------------

-- Example: Amazon Product Table
-- Product_Name    Quantity
-- Arrange Quantity in descending order
-- and use TOP to get the highest-selling products.
-- (ORDER BY will be covered later.)


-- ============================================================
-- GROUP BY
-- ============================================================

-- GROUP BY and Aggregate Functions always work together.

/*
Example Data:

Department    Salary
HR            ...
NULL          ...
HR            ...
ENTC          ...
HR            ...
HR            ...
Civil         ...
ENTC          ...
ENTC          ...
NULL          ...

After GROUP BY:
HR
ENTC
Civil
NULL

All identical values are grouped together.
By default, GROUP BY returns groups in ascending order.
*/


-- ------------------------------------------------------------
-- GROUP BY with AVG()
-- ------------------------------------------------------------

SELECT
    org_id,
    AVG(salary) AS avg_salary
FROM emp
GROUP BY org_id;

-- Single-column GROUP BY.


-- ------------------------------------------------------------
-- GROUP BY with COUNT()
-- ------------------------------------------------------------

SELECT
    org_id,
    COUNT(salary) AS total_salary_records
FROM emp
GROUP BY org_id;


-- Invalid Example:
-- SELECT org_id, DISTINCT(AVG(salary)) FROM emp GROUP BY org_id;
-- DISTINCT cannot be used like this.


-- ============================================================
-- SUMMARY & IMPORTANT NOTES
-- ============================================================

-- GROUP BY works with:
-- ✔ MIN()
-- ✔ MAX()
-- ✔ SUM()
-- ✔ AVG()
-- ✔ COUNT()

-- These five aggregate functions are commonly
-- used together with GROUP BY.

-- HAVING clause is used to filter grouped results
-- (to be covered next).
-- ============================================================