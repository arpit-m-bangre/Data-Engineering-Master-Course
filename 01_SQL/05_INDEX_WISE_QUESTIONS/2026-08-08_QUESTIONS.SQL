/* ============================================================
               DAY 8 PRACTICE QUESTIONS (8 AUGUST 2026)
               TOPICS: COMPLEX SCENARIO-BASED SQL CHALLENGES,
                       QUERY MISTAKE ANALYSIS & LOGIC DEBUGGING
               REVISION: DAYS 1 - 7 (CLAUSE EXECUTION ORDER, GROUP BY, HAVING)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Multi-Clause Query Construction]:
/*
Task: Write queries on table 'Emp(EmpID INT, Dept VARCHAR 15, Salary INT, Exp INT)':
1. Group by Dept and show COUNT(EmpID) AS EmpCount, AVG(Salary) AS AvgSalary.
2. Group by Dept and show COUNT(EmpID) WHERE Salary > 20000 HAVING AVG(Salary) > 50000.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - Multi-Column Sorting Options]:
/*
Task: Write a query selecting Dept, AVG(Salary) AS AvgSalary from 'Emp' grouped by Dept, sorted by AvgSalary DESCENDING, and then Dept ASCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 3 [Syntax Drill - Multiple Conditions in HAVING]:
/*
Task: Write a query selecting Dept, AVG(Salary) AS AvgSal, COUNT(EmpID) AS EmpCnt from 'Emp' grouped by Dept, HAVING AVG(Salary) > 60000 AND COUNT(EmpID) >= 5 AND MAX(Exp) > 8.
*/

-- Write your SQL Query below:




-- QUESTION 4 [Syntax Drill - Multiple Conditions in WHERE]:
/*
Task: Write a query selecting Dept, SUM(Salary) AS TotalSal from 'Emp' WHERE Salary >= 30000 AND Exp >= 2 AND Dept IN ('HR', 'IT', 'Finance') GROUP BY Dept.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 2: DAYS 1 - 7 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-7 Revision - Full 6-Clause Integration]:
/*
Task: Write a query selecting Dept, COUNT(EmpID) AS EmpCount, AVG(Salary) AS AvgSalary from 'Emp' for employees with Salary > 30000, grouped by Dept, returning only departments with AVG(Salary) > 50000 AND COUNT(EmpID) >= 3, sorted by AvgSalary DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 6 [Days 1-7 Revision - Execution Order Check]:
/*
Task:
1. State the memory rule: What does WHERE filter vs what does HAVING filter?
2. At what step during execution are aggregate functions evaluated?
*/

-- Write your answers in comments below:




-- ============================================================
-- SECTION 3: COMPLEX SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario Challenge 1 - Finance Bonus Eligibility]:
/*
Scenario: Finance bonus qualification audit.
Task: Write a query on 'Emp' returning Dept, COUNT(EmpID) AS EmployeeCount, AVG(Salary) AS AvgSalary, MAX(Exp) AS MaxExperience for employees with Salary > 40000, grouped by Dept, returning departments where EmployeeCount >= 6 AND AvgSalary > 75000 AND MaxExperience > 10, sorted by AvgSalary DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 8 [Scenario Challenge 2 - City Performance Screening]:
/*
Scenario: City branch audit ignoring junior staff.
Task: Write a query on 'Emp' returning City, COUNT(EmpID) AS EmployeeCount, MIN(Salary) AS MinSalary, AVG(Exp) AS AvgExperience for employees aged 25 and above (Age >= 25), grouped by City, returning cities where EmployeeCount >= 8 AND MinSalary > 30000 AND AvgExperience > 5, sorted by EmployeeCount DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 9 [Scenario Challenge 3 - Department Gender Screening]:
/*
Scenario: Diversity audit screening female staff compensation.
Task: Write a query on 'Emp' returning Dept, COUNT(EmpID) AS EmployeeCount, SUM(Salary) AS TotalSalary, MAX(Salary) AS MaxSalary for female employees (Gender = 'female'), grouped by Dept, returning departments where EmployeeCount >= 4 AND TotalSalary > 500000 AND MaxSalary > 120000, sorted by TotalSalary DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 10 [Scenario Challenge 4 - Tricky Multi-Column Department Query]:
/*
Scenario: Comprehensive executive department analysis.
Task: Write a query on 'Emp' returning Dept, COUNT(EmpID) AS EmployeeCount, AVG(Salary) AS AvgSalary, MAX(Salary) AS MaxSalary, MIN(Exp) AS MinExperience for employees with Salary >= 45000, grouped by Dept, returning departments where EmployeeCount BETWEEN 5 AND 10 AND AvgSalary > 70000 AND MaxSalary > 120000 AND MinExperience >= 2, sorted by AvgSalary DESCENDING, Dept ASCENDING.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Word Problem Translation Rules]:
/*
Task: Translate the following business requirements into SQL clause fragments:
1. "Ignore staff aged below 25" -> ?
2. "Minimum experience is at least 2 years" -> ?
3. "Total department salary exceeds 5,00,000" -> ?
*/

-- Write your answers in comments below:




-- QUESTION 12 [Logic Builder - Common Threshold Pitfalls]:
/*
Task: Explain why writing 'WHERE Age < 25' when the business rule requires 'Ignore employees aged below 25' is a critical logic bug.
*/

-- Write your explanation in comments below:




-- QUESTION 13 [Debugging - Identify Multi-Error Buggy Queries]:
/*
Task: Identify all 3 errors in the following query and write the corrected version:
SELECT Dept, AVG(Salary)
FROM Emp
WHERE AVG(Salary) > 70000
ORDER BY Average Salary DESC;
*/

-- Write your explanation & corrected SQL Query below:




-- QUESTION 14 [Debugging - Multi-Column Sorting Syntax Errors]:
/*
Task: Identify why 'ORDER BY AvgSalary DESC Dept ASC' fails and write the corrected comma-separated syntax.
*/

-- Write your explanation & corrected query below:




/* ============================================================
                   END OF DAY 8 PRACTICE
   ============================================================ */
