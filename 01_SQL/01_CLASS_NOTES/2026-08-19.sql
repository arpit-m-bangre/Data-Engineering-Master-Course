-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — CLASS NOTES
-- 📅 DATE: 19 AUGUST 2026 (WEDNESDAY) | BATCH: ONLINE BATCH 15 (DAY 16)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: ANSI SQL RELATIONAL JOINS SYNTAX & IMPLEMENTATION (INNER, LEFT, RIGHT, FULL OUTER),
--          COLUMN AMBIGUITY RESOLUTION, TABLE PREFIXING & ALIASING, DATA TYPE INDEPENDENCE,
--          ANTI-JOIN FILTERING & COMBINING JOINS WITH AGGREGATE FUNCTIONS (GROUP BY)
-- ====================================================================================================

-- ====================================================================================================
-- 📖 1. EXECUTIVE OVERVIEW & FACULTY ROADMAP
-- ====================================================================================================
/*
    FACULTY CONTEXT & ARCHITECTURAL SUMMARY:
    -----------------------------------------
    1. Yesterday's Milestone Recap (Day 15 - August 18):
       - Explored the foundational theory of Joins: Cartesian Cross-Product (N x M combinations).
       - Studied Three-Valued Logic (3VL) and why NULL = NULL evaluates to UNKNOWN.
       - Mastered mathematical row-count formulas for INNER, LEFT, RIGHT, and FULL OUTER joins.

    2. Today's Core Engineering Focus (Day 16 - August 19):
       - Hands-on implementation of standard ANSI SQL join syntax.
       - Understanding the mechanical difference between INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN.
       - Column Ambiguity Trap: What happens when both tables have the same column name (e.g., 'id')?
         Understanding the error: "Ambiguous column name 'id'" and solving it via table name prefixing & aliasing.
       - The System Stored Procedure `sp_rename` for modifying live table column definitions.
       - Real-World Entity Relationships: Doctor-Patient records (`p_info`, `d_info`), finding unassigned entities.
       - Data Type Compatibility on Join Predicates (ON condition matches values, not strict data types).
       - Combining JOINS with AGGREGATE FUNCTIONS: Computing Department-wise Average Salary (`AVG(salary)`)
         and why `LEFT JOIN` is mandatory to avoid dropping non-earning or empty departments.
       - Faculty Homework Challenges: Customer Orders analytics, month-wise sales, and Anti-Join identification.
*/

-- ====================================================================================================
-- 🧠 2. VOCABULARY & INTUITIVE REAL-LIFE ANALOGIES
-- ====================================================================================================
/*
    VOCABULARY & TECHNICAL DEFINITIONS:
    -----------------------------------
    1. AMBIGUOUS COLUMN NAME:
       - Meaning: A situation where SQL Server encounters a column referenced in SELECT, WHERE, or ON 
         that exists in multiple joined tables, causing the engine to fail because it cannot guess which table to read from.
       - Simple Definition: Like having two students named "Rahul" in the same classroom; when the teacher shouts "Rahul!", 
         neither knows who is being called until the teacher specifies the surname (Table.Column).

    2. TABLE PREFIXING / ALIASING:
       - Meaning: Qualifying a column with its parent table name (e.g., `A.id`) or assigning a temporary shorthand alias 
         (e.g., `FROM Employees AS E JOIN Departments AS D ON E.DeptID = D.DeptID`).
       - Simple Definition: Giving nicknames or using full names so everyone knows exactly who you mean.

    3. ANTI-JOIN PATTERN:
       - Meaning: An outer join followed by a `WHERE <right_table_key> IS NULL` filter to identify rows in one table 
         that have ZERO matching entries in another table.
       - Simple Definition: Finding customers who never bought anything, or doctors who currently have zero patients.

    4. DATA TYPE COMPATIBILITY (COERCION):
       - Meaning: SQL Server's ability to implicitly convert and compare differing data types (e.g., INT to BIGINT, 
         or VARCHAR number to INT) on the `ON` join predicate as long as the underlying values match.

    REAL-LIFE ANALOGIES:
    --------------------
    - THE SPEED DATING EVENT (INNER JOIN vs OUTER JOINS):
      * Room A (Employees / Table A), Room B (Salaries / Table B).
      * INNER JOIN: Only couples who both agreed to match walk out together.
      * LEFT JOIN: Every single person in Room A walks out. If they found a partner in Room B, they hold hands. 
        If no partner was found in Room B, they walk out holding a blank sign (NULL).
      * RIGHT JOIN: Every single person in Room B walks out. If they found a match in Room A, they walk out together. 
        If unmatched, Room A's spot is filled with a blank sign (NULL).
      * FULL OUTER JOIN: Everyone from both Room A and Room B gets to leave. Paired couples walk together, 
        and unmatched singles walk alone with NULL placeholders.
*/

-- ====================================================================================================
-- 🛠️ 3. CORE ANSI SQL JOIN SYNTAX & ARCHITECTURE
-- ====================================================================================================
/*
    STANDARD ANSI-92 JOIN SYNTAX:
    -----------------------------
    SELECT 
        <table1_alias>.<column1>,
        <table2_alias>.<column2>
    FROM <table1> AS <table1_alias>
    [INNER | LEFT | RIGHT | FULL] JOIN <table2> AS <table2_alias>
        ON <table1_alias>.<join_key> = <table2_alias>.<join_key>
    [WHERE <filter_conditions>]
    [GROUP BY <group_columns>]
    [HAVING <aggregate_conditions>]
    [ORDER BY <sort_columns>];
*/


-- ====================================================================================================
-- 🧪 4. HANDS-ON EXPERIMENT 1: SET1 & SET2 (EMPLOYEES & SALARIES)
-- ====================================================================================================

-- Step 4.1: Clean up existing tables if they exist
IF OBJECT_ID('set1', 'U') IS NOT NULL DROP TABLE set1;
IF OBJECT_ID('set2', 'U') IS NOT NULL DROP TABLE set2;

-- Step 4.2: Create Table SET1 (Employee Master)
CREATE TABLE set1
(
    id INT,
    name VARCHAR(50),
    dept VARCHAR(50)
);

-- Insert sample records into set1
INSERT INTO set1 (id, name, dept)
VALUES
(1, 'Arjun', 'IT'),
(2, 'Priya', 'HR'),
(3, 'Rahul', 'Finance'),
(4, 'Sneha', 'Marketing'),
(5, 'Vikas', 'IT'),
(6, 'Neha', 'Sales'),
(7, 'Amit', 'Finance'),
(8, 'Pooja', 'HR');

-- Step 4.3: Create Table SET2 (Payroll & Demographics)
CREATE TABLE set2
(
    id INT,
    salary DECIMAL(10,2),
    age INT
);

-- Insert sample records into set2
INSERT INTO set2 (id, salary, age)
VALUES
(1, 45000.00, 24),
(2, 52000.00, 27),
(3, 60000.00, 29),
(4, 48000.00, 25),
(5, 55000.00, 28),
(6, 42000.00, 23),
(9, 70000.00, 31),
(10, 65000.00, 30);

-- Step 4.4: Inspect both baseline tables
SELECT * FROM set1;
SELECT * FROM set2;

/*
    DATA OBSERVATION:
    - Table set1 contains IDs: 1, 2, 3, 4, 5, 6, 7, 8 (8 rows)
    - Table set2 contains IDs: 1, 2, 3, 4, 5, 6, 9, 10 (8 rows)
    - Common IDs (Intersection): 1, 2, 3, 4, 5, 6 (6 matching rows)
    - Unmatched in set1 (Left-only): 7, 8 (2 rows)
    - Unmatched in set2 (Right-only): 9, 10 (2 rows)
*/

-- 4.5.1: INNER JOIN (Common Matching Records Only)
-- Output: 6 Rows (IDs 1 through 6)
SELECT * 
FROM set1 
JOIN set2 
    ON set1.id = set2.id;

-- 4.5.2: LEFT OUTER JOIN (All set1 Records + Matched set2 Records)
-- Output: 8 Rows (IDs 1 to 6 matched; IDs 7 & 8 padded with NULL for set2 columns)
SELECT * 
FROM set1 
LEFT JOIN set2 
    ON set1.id = set2.id;

-- 4.5.3: RIGHT OUTER JOIN (All set2 Records + Matched set1 Records)
-- Output: 8 Rows (IDs 1 to 6 matched; IDs 9 & 10 padded with NULL for set1 columns)
SELECT * 
FROM set1 
RIGHT JOIN set2 
    ON set1.id = set2.id;

-- 4.5.4: FULL OUTER JOIN (All Records from Both Tables)
-- Output: 10 Rows (6 Common + 2 Left Only + 2 Right Only)
SELECT * 
FROM set1 
FULL JOIN set2 
    ON set1.id = set2.id;


-- ====================================================================================================
-- 🧪 5. HANDS-ON EXPERIMENT 2: TABLE A & B, SP_RENAME & COLUMN AMBIGUITY
-- ====================================================================================================

-- Step 5.1: Clean up tables A and B
IF OBJECT_ID('A', 'U') IS NOT NULL DROP TABLE A;
IF OBJECT_ID('B', 'U') IS NOT NULL DROP TABLE B;

-- Step 5.2: Create Table A (id, name) and Table B (custid, dept)
CREATE TABLE A 
( 
    id INT,
    name VARCHAR(10)
);

CREATE TABLE B 
( 
    custid INT,
    dept VARCHAR(10)
);

-- Insert records into A
INSERT INTO A (id, name) 
VALUES
(1, 'Amit'),
(2, 'Rahul'),
(3, 'Priya'),
(4, 'Sneha'),
(5, 'Vikas'),
(6, 'Neha'),
(7, 'Arjun'),
(8, 'Pooja');

-- Insert records into B
INSERT INTO B (custid, dept) 
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Finance'),
(5, 'IT'),
(6, 'HR'),
(9, 'Admin'),
(10, 'IT');

-- Data Hygiene & Sanity Check (cleaning dummy test records if any)
DELETE FROM A
WHERE name IN ('a', 'b');

SELECT * FROM A;
SELECT * FROM B;

-- Step 5.3: Demonstrating Join when Key Names Differ (id vs custid)
-- 1. INNER JOIN
SELECT * 
FROM A 
JOIN B 
    ON A.id = B.custid;

-- 2. LEFT JOIN (Preserves all rows of A, unmatched B fields set to NULL)
SELECT * 
FROM A 
LEFT JOIN B 
    ON A.id = B.custid;

-- 3. RIGHT JOIN (Preserves all rows of B, unmatched A fields set to NULL)
SELECT * 
FROM A 
RIGHT JOIN B 
    ON A.id = B.custid;

-- 4. FULL OUTER JOIN (Preserves all rows of both A and B)
SELECT * 
FROM A 
FULL JOIN B 
    ON A.id = B.custid;

-- Step 5.4: Renaming Column custid to id in Table B using sp_rename
-- Syntax: EXEC sp_rename '<table_name>.<old_column_name>', '<new_column_name>', 'COLUMN'
EXEC sp_rename 'B.custid', 'id', 'COLUMN';

-- Step 5.5: The Column Ambiguity Trap & Resolution
/*
    -- ❌ FAILING QUERY:
    SELECT id, name, dept 
    FROM A 
    JOIN B 
        ON A.id = B.id;

    -- ERROR RETURNED:
    -- Msg 209, Level 16, State 1, Line 135
    -- Ambiguous column name 'id'.
    
    -- WHY THIS ERROR OCCURS:
    -- Both Table A and Table B contain a column named 'id'. 
    -- When the SELECT clause requests 'id', SQL Server has no way of knowing whether 
    -- you want A.id or B.id.
*/

-- ✅ CORRECT WORKING QUERY (Prefixing column with table name):
SELECT 
    A.id AS employee_id,
    A.name,
    B.dept 
FROM A 
JOIN B 
    ON A.id = B.id;

-- ✅ ADVANCED BEST PRACTICE: Using Table Aliases for clean readability
SELECT 
    t1.id AS emp_id,
    t1.name AS emp_name,
    t2.dept AS department_name
FROM A AS t1
JOIN B AS t2
    ON t1.id = t2.id;


-- ====================================================================================================
-- 🧪 6. HANDS-ON EXPERIMENT 3: DOCTOR-PATIENT RELATIONSHIP & ANTI-JOINS
-- ====================================================================================================

-- Step 6.1: Clean up medical tables
IF OBJECT_ID('D_info', 'U') IS NOT NULL DROP TABLE D_info;
IF OBJECT_ID('p_info', 'U') IS NOT NULL DROP TABLE p_info;

-- Step 6.2: Create Patient Master Table (p_info)
CREATE TABLE p_info
(
    p_id INT,
    pname VARCHAR(50)
);

-- Step 6.3: Create Doctor Appointment Table (D_info)
CREATE TABLE D_info
(
    p_id INT,
    d_id INT,
    Dname VARCHAR(50)
);

-- Seed Data:
INSERT INTO p_info (p_id, pname)
VALUES
(101, 'Ramesh Kumar'),
(102, 'Sita Sharma'),
(103, 'Gopal Das'),
(104, 'Anita Desai');

INSERT INTO D_info (p_id, d_id, Dname)
VALUES
(101, 1, 'Dr. Batra'),
(102, 2, 'Dr. Trehan'),
(105, 3, 'Dr. Mukherjee');

SELECT * FROM p_info;
SELECT * FROM D_info;

-- Question 1: Display Patient Name (pname) with their assigned Doctor Name (Dname)
-- (Only patients who currently have an assigned doctor)
SELECT 
    p.pname,
    d.Dname 
FROM p_info AS p
JOIN D_info AS d 
    ON p.p_id = d.p_id;

-- Question 2: Display all Patient Names who have NOT been assigned any Doctor till date
-- (Anti-Join Pattern: LEFT JOIN + WHERE right_table_key IS NULL)
SELECT 
    p.p_id,
    p.pname,
    d.Dname 
FROM p_info AS p
LEFT JOIN D_info AS d 
    ON p.p_id = d.p_id
WHERE d.Dname IS NULL;

-- Question 3: Display all Doctors who currently have NO Patient assigned to them
-- (Right Anti-Join Pattern: RIGHT JOIN + WHERE left_table_key IS NULL)
SELECT 
    d.d_id,
    d.Dname,
    p.pname
FROM p_info AS p
RIGHT JOIN D_info AS d 
    ON p.p_id = d.p_id
WHERE p.pname IS NULL;


-- ====================================================================================================
-- 🧪 7. HANDS-ON EXPERIMENT 4: COMBINING JOINS WITH AGGREGATIONS (GROUP BY)
-- ====================================================================================================
/*
    CORE ARCHITECTURAL RULE:
    - When calculating aggregated metrics across related tables (e.g. Department-wise Average Salary),
      we must join the entity table with the numeric metrics table.
    - If some departments have zero salary records, `INNER JOIN` will silently DROP those departments!
    - `LEFT JOIN` ensures all departments are preserved in the aggregation summary.
*/

-- Step 7.1: Department-wise Average Salary using set1 (Employees & Depts) and set2 (Salaries)
-- Using INNER JOIN (Only departments with matched salary records):
SELECT 
    s1.dept,
    AVG(s2.salary) AS avg_salary
FROM set1 AS s1
JOIN set2 AS s2
    ON s1.id = s2.id
GROUP BY s1.dept;

-- Step 7.2: Department-wise Average Salary using LEFT JOIN (Preserves all departments):
SELECT 
    s1.dept,
    AVG(s2.salary) AS avg_salary,
    COUNT(s1.id) AS total_employees,
    COUNT(s2.salary) AS employees_with_salary
FROM set1 AS s1
LEFT JOIN set2 AS s2
    ON s1.id = s2.id
GROUP BY s1.dept;


-- ====================================================================================================
-- 📝 8. FACULTY HOMEWORK & IN-CLASS TASK REQUIREMENTS
-- ====================================================================================================
/*
    FACULTY HOMEWORK SPECIFICATION:
    -------------------------------
    Given two relational tables:
      - Table 1 (Customers): custid, custname, t_date, city
      - Table 2 (Orders): custid, p_id, o_id, amount

    SOLVE THE FOLLOWING 3 HIGH-IMPACT QUESTIONS:
    1. Calculate Month-wise Average Sales across all customer orders.
    2. Display customers who did NOT order anything till date (Anti-Join).
    3. Display Customer Name (custname), Month Name, Product ID (p_id), and Order Amount.

    (Note: Full production solutions with DDL schemas and verification queries are implemented 
     inside: 04_CLASS_TASKS/2026-08-19_CLASS_TASK.SQL).
*/
