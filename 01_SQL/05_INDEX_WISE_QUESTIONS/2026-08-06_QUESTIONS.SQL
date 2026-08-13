/* ============================================================
               DAY 6 PRACTICE QUESTIONS & SOLUTIONS (6 AUGUST 2026)
               TOPICS: AGGREGATE FUNCTIONS (MIN, MAX, SUM, AVG, COUNT),
                       NULL HANDLING, DISTINCT, TOP N, GROUP BY INTRO
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - Aggregations, DISTINCT & TOP N]:
/*
Task: Write queries on table 'Employees(EmpID INT, Name VARCHAR 20, Dept VARCHAR 15, Salary INT)':
1. Show MIN(Salary) and MAX(Salary).
2. Show SUM(Salary) and AVG(Salary).
3. Show COUNT(*) and COUNT(Dept).
4. Show DISTINCT Dept.
5. Show TOP 3 records.
6. Show Dept and AVG(Salary) grouped by Dept.
*/

-- Solution:
SELECT MIN(Salary) AS MinSal, MAX(Salary) AS MaxSal FROM Employees;
SELECT SUM(Salary) AS TotalSal, AVG(Salary) AS AvgSal FROM Employees;
SELECT COUNT(*) AS TotalRows, COUNT(Dept) AS NonNullDepts FROM Employees;
SELECT DISTINCT Dept FROM Employees;
SELECT TOP 3 * FROM Employees;
SELECT Dept, AVG(Salary) AS AvgSalary FROM Employees GROUP BY Dept;


-- QUESTION 2 [Basic Syntax - COUNT(DISTINCT) & Data Type Constraints]:
/*
Task:
1. Write a query to count unique non-NULL departments (COUNT(DISTINCT Dept)).
2. Explain why SUM(Name) or AVG(Name) fails with an error in SQL Server.
*/

-- Solution:
SELECT COUNT(DISTINCT Dept) AS UniqueDepts FROM Employees;
/*
2. EXPLANATION: SUM and AVG require numeric operand types (INT, FLOAT, DECIMAL). Strings cannot be summed or averaged.
*/


-- ============================================================
-- SECTION 2: DAYS 1 - 5 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-5 Revision - Payroll Table & DDL]:
/*
Task:
1. Create table 'StaffPayroll' with: StaffID (INT), StaffName (VARCHAR 30), DeptCode (VARCHAR 20), BaseSalary (INT), PerformanceScore (INT).
2. Alter 'StaffPayroll' to ADD column 'City' (VARCHAR 20).
3. Insert 8 sample records including rows with NULL BaseSalary, NULL PerformanceScore, and NULL City.
*/

-- Solution:
CREATE TABLE StaffPayroll
(
    StaffID          INT,
    StaffName        VARCHAR(30),
    DeptCode         VARCHAR(20),
    BaseSalary       INT,
    PerformanceScore INT
);

ALTER TABLE StaffPayroll ADD City VARCHAR(20);

INSERT INTO StaffPayroll VALUES (1, 'Manoj Bangre', 'IT', 75000, 5, 'Nagpur');
INSERT INTO StaffPayroll VALUES (2, 'Rahul Patil', 'IT', 60000, 4, 'Pune');
INSERT INTO StaffPayroll VALUES (3, 'Sneha Joshi', 'HR', 55000, 3, 'Mumbai');
INSERT INTO StaffPayroll VALUES (4, 'Priya Sharma', 'HR', NULL, 4, 'Nagpur');
INSERT INTO StaffPayroll VALUES (5, 'Amit Verma', 'Finance', 80000, 5, 'Delhi');
INSERT INTO StaffPayroll VALUES (6, 'Rohit Singh', 'Finance', 45000, NULL, NULL);
INSERT INTO StaffPayroll VALUES (7, 'Neha Kale', NULL, 35000, 2, 'Indore');
INSERT INTO StaffPayroll VALUES (8, 'Vikas Meena', 'IT', NULL, NULL, 'Jaipur');


-- QUESTION 4 [Days 1-5 Revision - UPDATE & Target DELETE]:
/*
Task:
1. Update BaseSalary = BaseSalary * 1.10 for employees in DeptCode = 'IT'.
2. Delete records where PerformanceScore IS NULL AND BaseSalary IS NULL.
*/

-- Solution:
UPDATE StaffPayroll SET BaseSalary = BaseSalary * 1.10 WHERE DeptCode = 'IT';
DELETE FROM StaffPayroll WHERE PerformanceScore IS NULL AND BaseSalary IS NULL;


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Enterprise Payroll Metrics Aggregation]:
/*
Scenario: Executive payroll audit summary.
Task: Write a query returning average salary (AVG), total salary payout (SUM), minimum salary (MIN), and maximum salary (MAX) across the entire 'StaffPayroll' table.
*/

-- Solution:
SELECT AVG(BaseSalary) AS AvgSal, SUM(BaseSalary) AS TotalSal, MIN(BaseSalary) AS MinSal, MAX(BaseSalary) AS MaxSal FROM StaffPayroll;


-- QUESTION 6 [Scenario - NULL Value Handling in AVG & COUNT]:
/*
Scenario: Auditing missing data handling in statistical functions.
Task:
1. Explain how AVG(BaseSalary) handles NULL values in a column with values (20000, 30000, NULL, 30000).
2. Explain the difference between COUNT(DeptCode) and COUNT(*).
*/

-- Solution:
/*
1. AVG NULL: AVG ignores NULLs in numerator and denominator. Sum = 80000, Count = 3 -> AVG = 26666.66.
2. COUNT: COUNT(DeptCode) ignores NULL values; COUNT(*) counts all rows.
*/


-- QUESTION 7 [Scenario - Unicity Verification & TOP Earner Rankings]:
/*
Scenario: HR analytics ranking top earners.
Task:
1. Select unique DeptCode values using DISTINCT.
2. Select COUNT(DISTINCT DeptCode) to show total unique departments.
3. Select TOP 3 highest earning employees from 'StaffPayroll' sorted by BaseSalary descending.
*/

-- Solution:
SELECT DISTINCT DeptCode FROM StaffPayroll;
SELECT COUNT(DISTINCT DeptCode) AS UniqueDepts FROM StaffPayroll;
SELECT TOP 3 * FROM StaffPayroll ORDER BY BaseSalary DESC;


-- QUESTION 8 [Scenario - Department Average Salary Grouping]:
/*
Scenario: Department budget analysis.
Task: Write a GROUP BY query returning DeptCode and AVG(BaseSalary) AS AvgSalary for each department.
*/

-- Solution:
SELECT DeptCode, AVG(BaseSalary) AS AvgSalary FROM StaffPayroll GROUP BY DeptCode;


-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Un-aggregated Columns in GROUP BY]:
/*
Task:
1. Why does 'SELECT StaffName, DeptCode, AVG(BaseSalary) FROM StaffPayroll GROUP BY DeptCode' fail with an error?
2. Explain the fundamental rule regarding un-aggregated columns in SELECT queries with GROUP BY.
*/

-- Solution:
/*
1. EXPLANATION: StaffName is un-aggregated and not listed in GROUP BY, causing ambiguity because multiple StaffNames exist per DeptCode.
2. RULE: Every non-aggregated column in SELECT must be included in the GROUP BY clause.
*/


-- QUESTION 10 [Debugging - Fix Invalid DISTINCT Syntax & SELECT * Errors]:
/*
Task: Identify and fix errors in the following 2 queries:
1. SELECT *, AVG(BaseSalary) FROM StaffPayroll;
2. SELECT DISTINCT(StaffName), DISTINCT(DeptCode) FROM StaffPayroll;
*/

-- Solution:
-- 1. Fix: Remove * or add GROUP BY.
SELECT AVG(BaseSalary) AS AvgSal FROM StaffPayroll;

-- 2. Fix: Apply DISTINCT once across selected column list.
SELECT DISTINCT StaffName, DeptCode FROM StaffPayroll;


/* ============================================================
                   END OF DAY 6 PRACTICE & SOLUTIONS
   ============================================================ */
