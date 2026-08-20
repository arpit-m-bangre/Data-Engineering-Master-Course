/*================================================================
   SQL CLASS NOTES - 19 AUGUST 2026 (DAY 16)
   TOPICS: ANSI SQL JOINS, COLUMN AMBIGUITY, ANTI-JOINS, GROUP BY WITH JOINS
==================================================================*/


/*================================================================
1. SETUP: SET1 (EMPLOYEES) & SET2 (PAYROLL)
==================================================================*/

IF OBJECT_ID('set1', 'U') IS NOT NULL DROP TABLE set1;
IF OBJECT_ID('set2', 'U') IS NOT NULL DROP TABLE set2;

CREATE TABLE set1
(
    id   INT,
    name VARCHAR(50),
    dept VARCHAR(50)
);

CREATE TABLE set2
(
    id     INT,
    salary DECIMAL(10,2),
    age    INT
);

INSERT INTO set1 (id, name, dept) VALUES
(1, 'Arjun',  'IT'),
(2, 'Priya',  'HR'),
(3, 'Rahul',  'Finance'),
(4, 'Sneha',  'Marketing'),
(5, 'Vikas',  'IT'),
(6, 'Neha',   'Sales'),
(7, 'Amit',   'Finance'),
(8, 'Pooja',  'HR');

INSERT INTO set2 (id, salary, age) VALUES
(1,  45000.00, 24),
(2,  52000.00, 27),
(3,  60000.00, 29),
(4,  48000.00, 25),
(5,  55000.00, 28),
(6,  42000.00, 23),
(9,  70000.00, 31),
(10, 65000.00, 30);

-- Observation: set1 has IDs 1-8. set2 has IDs 1-6, 9, 10.
-- Common: 1-6 (6 rows). Only in set1: 7,8. Only in set2: 9,10.

SELECT * FROM set1;
SELECT * FROM set2;


/*================================================================
2. ANSI JOIN SYNTAX (set1 & set2)
==================================================================*/

-- INNER JOIN: Only common matching rows (6 rows)
SELECT *
FROM set1
JOIN set2
    ON set1.id = set2.id;

-- LEFT JOIN: All of set1 + matched set2 rows (8 rows, NULLs for IDs 7 & 8)
SELECT *
FROM set1
LEFT JOIN set2
    ON set1.id = set2.id;

-- RIGHT JOIN: All of set2 + matched set1 rows (8 rows, NULLs for IDs 9 & 10)
SELECT *
FROM set1
RIGHT JOIN set2
    ON set1.id = set2.id;

-- FULL OUTER JOIN: All rows from both tables (10 rows)
SELECT *
FROM set1
FULL JOIN set2
    ON set1.id = set2.id;


/*================================================================
3. TABLE A & B: DIFFERENT KEY NAMES, SP_RENAME & COLUMN AMBIGUITY
==================================================================*/

IF OBJECT_ID('A', 'U') IS NOT NULL DROP TABLE A;
IF OBJECT_ID('B', 'U') IS NOT NULL DROP TABLE B;

CREATE TABLE A (id INT, name VARCHAR(10));
CREATE TABLE B (custid INT, dept VARCHAR(10));

INSERT INTO A (id, name) VALUES
(1, 'Amit'), (2, 'Rahul'), (3, 'Priya'),
(4, 'Sneha'), (5, 'Vikas'), (6, 'Neha'),
(7, 'Arjun'), (8, 'Pooja');

INSERT INTO B (custid, dept) VALUES
(1, 'IT'), (2, 'HR'), (3, 'Sales'),
(4, 'Finance'), (5, 'IT'), (6, 'HR'),
(9, 'Admin'), (10, 'IT');

SELECT * FROM A;
SELECT * FROM B;

-- Joins when key names differ (id vs custid)
SELECT * FROM A JOIN  B ON A.id = B.custid;
SELECT * FROM A LEFT  JOIN B ON A.id = B.custid;
SELECT * FROM A RIGHT JOIN B ON A.id = B.custid;
SELECT * FROM A FULL  JOIN B ON A.id = B.custid;


-- Rename custid to id in Table B (so both tables now have column 'id')
-- Syntax: EXEC sp_rename '<table>.<old_col>', '<new_col>', 'COLUMN'
EXEC sp_rename 'B.custid', 'id', 'COLUMN';


-- Column Ambiguity Error (after rename):
-- SELECT id, name, dept FROM A JOIN B ON A.id = B.id;
-- ERROR: Msg 209 - Ambiguous column name 'id'
-- Both A and B have 'id'. SQL Server cannot guess which one.

-- Fix 1: Prefix with table name
SELECT
    A.id   AS employee_id,
    A.name,
    B.dept
FROM A
JOIN B
    ON A.id = B.id;

-- Fix 2 (Best Practice): Use table aliases
SELECT
    t1.id   AS emp_id,
    t1.name AS emp_name,
    t2.dept AS department_name
FROM A AS t1
JOIN B AS t2
    ON t1.id = t2.id;


/*================================================================
4. DOCTOR-PATIENT ANTI-JOIN PATTERN
==================================================================*/

IF OBJECT_ID('D_info', 'U') IS NOT NULL DROP TABLE D_info;
IF OBJECT_ID('p_info', 'U') IS NOT NULL DROP TABLE p_info;

CREATE TABLE p_info (p_id INT, pname VARCHAR(50));
CREATE TABLE D_info (p_id INT, d_id INT, Dname VARCHAR(50));

INSERT INTO p_info (p_id, pname) VALUES
(101, 'Ramesh Kumar'),
(102, 'Sita Sharma'),
(103, 'Gopal Das'),
(104, 'Anita Desai');

INSERT INTO D_info (p_id, d_id, Dname) VALUES
(101, 1, 'Dr. Batra'),
(102, 2, 'Dr. Trehan'),
(105, 3, 'Dr. Mukherjee');

SELECT * FROM p_info;
SELECT * FROM D_info;

-- Q1: Patients WITH an assigned doctor (INNER JOIN)
SELECT p.pname, d.Dname
FROM p_info AS p
JOIN D_info AS d
    ON p.p_id = d.p_id;

-- Q2: Patients with NO doctor assigned (Anti-Join: LEFT JOIN + WHERE IS NULL)
SELECT p.p_id, p.pname
FROM p_info AS p
LEFT JOIN D_info AS d
    ON p.p_id = d.p_id
WHERE d.Dname IS NULL;

-- Q3: Doctors with NO patient assigned (Right Anti-Join)
SELECT d.d_id, d.Dname
FROM p_info AS p
RIGHT JOIN D_info AS d
    ON p.p_id = d.p_id
WHERE p.pname IS NULL;


/*================================================================
5. JOINS + AGGREGATIONS: DEPT-WISE AVERAGE SALARY
==================================================================*/

/*----------------------------------------------------------------
Rule:
Use LEFT JOIN (not INNER JOIN) when aggregating so that departments
with ZERO salary records are NOT silently dropped from the result.
------------------------------------------------------------------*/

-- INNER JOIN version (drops depts with no matching salary rows)
SELECT
    s1.dept,
    AVG(s2.salary) AS avg_salary
FROM set1 AS s1
JOIN set2 AS s2
    ON s1.id = s2.id
GROUP BY s1.dept;

-- LEFT JOIN version (preserves ALL departments)
SELECT
    s1.dept,
    AVG(s2.salary)    AS avg_salary,
    COUNT(s1.id)      AS total_employees,
    COUNT(s2.salary)  AS employees_with_salary
FROM set1 AS s1
LEFT JOIN set2 AS s2
    ON s1.id = s2.id
GROUP BY s1.dept;


/*----------------------------------------------------------------
Faculty Homework (Full solutions in: 04_CLASS_TASKS/2026-08-19_CLASS_TASK.SQL):
  Task 1: Month-wise Average Sales across customer orders.
  Task 2: Customers who did NOT order anything (Anti-Join).
  Task 3: Customer Name, Month Name, Product ID, Order Amount.
------------------------------------------------------------------*/
