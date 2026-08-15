/*================================================================
   SQL CLASS NOTES - 06 AUGUST 2026 (DAY 6)
   TOPICS: AGGREGATE FUNCTIONS (MIN, MAX, SUM, AVG, COUNT), DISTINCT, TOP, GROUP BY
==================================================================*/


/*================================================================
1. AGGREGATE FUNCTIONS (MIN, MAX, SUM, AVG)
==================================================================*/

/*----------------------------------------------------------------
Theory:
These functions return a SINGLE summary value. 
Thus, you cannot query individual columns (like SELECT *) alongside them.
------------------------------------------------------------------*/

SELECT * FROM emp;


-- MIN() & MAX() (Finds smallest/largest values. Works on numbers and text)
SELECT MIN(salary) AS min_salary FROM emp;

SELECT MIN(empname) AS min_name FROM emp;

SELECT MAX(salary) AS max_salary FROM emp;

SELECT MAX(empname) AS max_name FROM emp;


-- SUM() & AVG() (Only works on numeric types!)
SELECT SUM(salary) AS sum_salary FROM emp;


-- SELECT SUM(empname) FROM emp;
/*----------------------------------------------------------------
Error:
❌ Fails: Operand data type varchar is invalid for SUM operator.
------------------------------------------------------------------*/


SELECT AVG(salary) AS avg_salary FROM emp;


SELECT AVG(salary) AS avg_salary,
       SUM(salary) AS sum_salary,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM emp;

/*----------------------------------------------------------------
Note:
AVG() ignores NULL values completely!
If you have: 20, 30, NULL, 30 -> Average is 80 / 3 (ignores NULL row).
------------------------------------------------------------------*/


/*================================================================
2. COUNT() (Row Counter)
==================================================================*/

SELECT COUNT(org_id) FROM emp;  -- COUNT(column) ignores NULLs

SELECT COUNT(empname) FROM emp;

SELECT COUNT(*) FROM emp;       -- COUNT(*) counts all rows, including NULL rows!


-- Proof: Table with only NULLs
CREATE TABLE dummy (id INT);

INSERT INTO dummy VALUES (NULL), (NULL), (NULL);


SELECT COUNT(*) FROM dummy;     -- Returns 3 (row count)

SELECT COUNT(id) FROM dummy;    -- Returns 0 (ignores NULL values)


DROP TABLE dummy;


/*================================================================
3. DISTINCT
==================================================================*/

-- DISTINCT: Filters out duplicate rows.
-- Note: DISTINCT applies to the entire row structure, not columns separately.
SELECT DISTINCT(org_id) FROM emp;

SELECT DISTINCT empname, org_id FROM emp;


-- COUNT(DISTINCT): Counts unique non-null entries
SELECT COUNT(DISTINCT(org_id)) FROM emp;


/*================================================================
4. TOP
==================================================================*/

-- TOP N: Returns the first N rows in the output. (No BOTTOM keyword exists!).
SELECT TOP 2 * FROM emp;

SELECT TOP 3 salary FROM emp;


/*================================================================
5. GROUP BY
==================================================================*/

/*----------------------------------------------------------------
Theory:
GROUP BY groups identical values into buckets (e.g. org_id buckets).
Rule: Every column in the SELECT clause that is NOT aggregated must be in the GROUP BY!
------------------------------------------------------------------*/

SELECT org_id, AVG(salary) AS avg_salary
FROM emp
GROUP BY org_id;


SELECT org_id, COUNT(salary) AS total_employees
FROM emp
GROUP BY org_id;\n