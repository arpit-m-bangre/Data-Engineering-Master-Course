/* ============================================================
               DAY 6 PRACTICE QUESTIONS (6 AUGUST 2026)
               TOPICS: AGGREGATE FUNCTIONS (MIN, MAX, SUM, AVG, COUNT),
                       NULL HANDLING, DISTINCT, TOP N, GROUP BY INTRO
               REVISION: DAYS 1 - 5 (WHERE, ALTER TABLE, UPDATE, DATA TYPES)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - 5 Aggregate Functions]:
/*
Task: Write queries on table 'Employees(EmpID INT, Name VARCHAR 20, Dept VARCHAR 15, Salary INT)':
1. Show MIN(Salary) and MAX(Salary).
2. Show SUM(Salary) and AVG(Salary).
3. Show COUNT(*) and COUNT(Dept).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - DISTINCT Keyword Usage]:
/*
Task: Write queries on 'Employees':
1. Show DISTINCT Dept values.
2. Show COUNT(DISTINCT Dept) to count unique non-NULL departments.
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - TOP N Result Limiting]:
/*
Task: Write queries on 'Employees':
1. Select TOP 3 records from 'Employees'.
2. Select TOP 5 employees sorted by Salary DESCENDING.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - Basic GROUP BY Projections]:
/*
Task: Write queries on 'Employees':
1. Show Dept and AVG(Salary) grouped by Dept.
2. Show Dept and COUNT(EmpID) grouped by Dept.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 5 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-5 Revision - Payroll Table & DDL]:
/*
Task:
1. Create table 'StaffPayroll' with: StaffID (INT), StaffName (VARCHAR 30), DeptCode (VARCHAR 20), BaseSalary (INT), PerformanceScore (INT).
2. Alter 'StaffPayroll' to ADD column 'City' (VARCHAR 20).
3. Insert 8 sample records including rows with NULL BaseSalary, NULL PerformanceScore, and NULL City.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-5 Revision - UPDATE & Target DELETE]:
/*
Task:
1. Update BaseSalary = BaseSalary * 1.10 for employees in DeptCode = 'IT'.
2. Delete records where PerformanceScore IS NULL AND BaseSalary IS NULL.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Enterprise Payroll Metrics Aggregation]:
/*
Scenario: Executive payroll audit summary.
Task: Write a query returning average salary (AVG), total salary payout (SUM), minimum salary (MIN), and maximum salary (MAX) across the entire 'StaffPayroll' table.
*/

-- Write your SQL Query below:




-- QUESTION 8 [Scenario - NULL Value Handling in AVG & COUNT]:
/*
Scenario: Auditing missing data handling in statistical functions.
Task:
1. Explain how AVG(BaseSalary) handles NULL values in a column with values (20000, 30000, NULL, 30000).
2. Explain the difference between COUNT(DeptCode) and COUNT(*).
*/

-- Write your explanations in comments below:




-- QUESTION 9 [Scenario - Unicity Verification & TOP Earner Rankings]:
/*
Scenario: HR analytics ranking top earners.
Task:
1. Select unique DeptCode values using DISTINCT.
2. Select COUNT(DISTINCT DeptCode) to show total unique departments.
3. Select TOP 3 highest earning employees from 'StaffPayroll' sorted by BaseSalary descending.
*/

-- Write your SQL Queries below:




-- QUESTION 10 [Scenario - Department Average Salary Grouping]:
/*
Scenario: Department budget analysis.
Task: Write a GROUP BY query returning DeptCode and AVG(BaseSalary) AS AvgSalary for each department.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Un-aggregated Columns in GROUP BY]:
/*
Task:
1. Why does 'SELECT StaffName, DeptCode, AVG(BaseSalary) FROM StaffPayroll GROUP BY DeptCode' fail with an error?
2. Explain the fundamental rule regarding un-aggregated columns in SELECT queries with GROUP BY.
*/

-- Write your answer in comments below:




-- QUESTION 12 [Logic Builder - Data Type Limitations on Aggregates]:
/*
Task: Explain why SUM(StaffName) or AVG(StaffName) fails with an error in SQL Server.
*/

-- Write your explanation in comments below:




-- QUESTION 13 [Debugging - Fix Invalid DISTINCT Syntax & SELECT * Errors]:
/*
Task: Identify and fix errors in the following 2 queries:
1. SELECT *, AVG(BaseSalary) FROM StaffPayroll;
2. SELECT DISTINCT(StaffName), DISTINCT(DeptCode) FROM StaffPayroll;
*/

-- Write your corrected SQL Queries below:




-- QUESTION 14 [Debugging - COUNT(col) on 100% NULL Column]:
/*
Task: If a table has 5 rows where column 'DeptCode' is NULL for all 5 rows, what will 'COUNT(DeptCode)' return vs 'COUNT(*)'?
*/

-- Write your explanation in comments below:




/* ============================================================
                   END OF DAY 6 PRACTICE
   ============================================================ */
