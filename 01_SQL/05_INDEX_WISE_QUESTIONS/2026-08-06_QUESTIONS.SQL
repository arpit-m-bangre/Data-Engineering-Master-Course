/*============================================================
        DAY 6 PRACTICE QUESTIONS (6 AUGUST 2026)
        TOPICS: AGGREGATE FUNCTIONS, DISTINCT, TOP, GROUP BY
============================================================

Topics Covered:
✔ MIN()
✔ MAX()
✔ SUM()
✔ AVG()
✔ COUNT()
✔ DISTINCT
✔ TOP
✔ GROUP BY

============================================================
LEVEL 1 - BASIC AGGREGATE FUNCTIONS
============================================================*/

-- Q1. Display the minimum salary.
-- Write your SQL Query below:




-- Q2. Display the maximum salary.
-- Write your SQL Query below:




-- Q3. Display the total salary of all employees.
-- Write your SQL Query below:




-- Q4. Display the average salary.
-- Write your SQL Query below:




-- Q5. Count the total number of employees.
-- Write your SQL Query below:




-- Q6. Count employees whose Org_ID is not NULL.
-- Write your SQL Query below:




-- Q7. Display the minimum employee name.
-- Write your SQL Query below:




-- Q8. Display the maximum employee name.
-- Write your SQL Query below:




-- Q9. Display minimum and maximum salary together.
-- Write your SQL Query below:




-- Q10. Display MIN, MAX, SUM and AVG together.
-- Write your SQL Query below:





/*============================================================
LEVEL 2 - COUNT()
============================================================*/

-- Q11. Count all rows using COUNT(*).
-- Write your SQL Query below:




-- Q12. Count only employee names.
-- Write your SQL Query below:




-- Q13. Count only salaries.
-- Write your SQL Query below:




-- Q14. Count only Org_ID values.
-- Write your SQL Query below:




-- Q15. Create a Dummy table with 10 NULL values
--      and compare COUNT(*) with COUNT(id).
-- Write your SQL Query below:





/*============================================================
LEVEL 3 - DISTINCT
============================================================*/

-- Q16. Display unique departments (Org_ID).
-- Write your SQL Query below:




-- Q17. Display unique employee names.
-- Write your SQL Query below:




-- Q18. Count unique departments.
-- Write your SQL Query below:




-- Q19. Count unique employee names.
-- Write your SQL Query below:




-- Q20. Explain why
--      SELECT DISTINCT(empname), DISTINCT(org_id)
--      is invalid.
-- Write your explanation below:





/*============================================================
LEVEL 4 - TOP
============================================================*/

-- Q21. Display the first 2 employees.
-- Write your SQL Query below:




-- Q22. Display the first 5 employees.
-- Write your SQL Query below:




-- Q23. Display the first 3 salaries.
-- Write your SQL Query below:




-- Q24. Display TOP 1 employee.
-- Write your SQL Query below:




-- Q25. Display TOP 4 employee names only.
-- Write your SQL Query below:





/*============================================================
LEVEL 5 - GROUP BY
============================================================*/

-- Q26. Display average salary department-wise.
-- Write your SQL Query below:




-- Q27. Display total salary department-wise.
-- Write your SQL Query below:




-- Q28. Display minimum salary department-wise.
-- Write your SQL Query below:




-- Q29. Display maximum salary department-wise.
-- Write your SQL Query below:




-- Q30. Count employees department-wise.
-- Write your SQL Query below:





/*============================================================
LEVEL 6 - GROUP BY PRACTICE
============================================================*/

-- Q31. Display department and average salary.
-- Write your SQL Query below:




-- Q32. Display department and total salary.
-- Write your SQL Query below:




-- Q33. Display department and employee count.
-- Write your SQL Query below:




-- Q34. Display department and maximum salary.
-- Write your SQL Query below:




-- Q35. Display department and minimum salary.
-- Write your SQL Query below:





/*============================================================
LEVEL 7 - MULTIPLE AGGREGATE FUNCTIONS
============================================================*/

-- Q36. Display department-wise:
--      Average Salary
--      Maximum Salary
--      Minimum Salary
-- Write your SQL Query below:




-- Q37. Display department-wise:
--      SUM and COUNT.
-- Write your SQL Query below:




-- Q38. Display all five aggregate functions
--      department-wise.
-- Write your SQL Query below:




-- Q39. Display average salary
--      and total salary together.
-- Write your SQL Query below:




-- Q40. Display minimum salary,
--      maximum salary,
--      average salary,
--      and employee count.
-- Write your SQL Query below:





/*============================================================
LEVEL 8 - MIXED PRACTICE
============================================================*/

-- Q41. Display the first 3 employees.
-- Write your SQL Query below:




-- Q42. Display distinct departments.
-- Write your SQL Query below:




-- Q43. Display total employees.
-- Write your SQL Query below:




-- Q44. Display unique departments count.
-- Write your SQL Query below:




-- Q45. Display average salary.
-- Write your SQL Query below:




-- Q46. Display department-wise average salary.
-- Write your SQL Query below:




-- Q47. Display department-wise employee count.
-- Write your SQL Query below:




-- Q48. Display minimum salary.
-- Write your SQL Query below:




-- Q49. Display maximum salary.
-- Write your SQL Query below:




-- Q50. Display total salary of all employees.
-- Write your SQL Query below:





/*============================================================
LEVEL 9 - ENTERPRISE SCENARIO DRILLS (Zero Data Loss)
============================================================*/

-- Q51 [Scenario - Enterprise Payroll Metrics Aggregation]:
-- Scenario: Executive payroll audit summary.
-- Task: Write a query returning average salary (AVG), total salary payout (SUM),
--       minimum salary (MIN), and maximum salary (MAX) across the entire 'StaffPayroll' table.
-- Write your SQL Query below:




-- Q52 [Scenario - NULL Value Handling in AVG & COUNT]:
-- Scenario: Auditing missing data handling in statistical functions.
-- Task:
-- 1. Explain how AVG(BaseSalary) handles NULL values in a column with values (20000, 30000, NULL, 30000).
-- 2. Explain the difference between COUNT(DeptCode) and COUNT(*).
-- Write your explanations in comments below:




-- Q53 [Scenario - Unicity Verification & TOP Earner Rankings]:
-- Scenario: HR analytics ranking top earners.
-- Task:
-- 1. Select unique DeptCode values using DISTINCT.
-- 2. Select COUNT(DISTINCT DeptCode) to show total unique departments.
-- 3. Select TOP 3 highest earning employees from 'StaffPayroll' sorted by BaseSalary descending.
-- Write your SQL Queries below:




-- Q54 [Scenario - Department Average Salary Grouping]:
-- Scenario: Department budget analysis.
-- Task: Write a GROUP BY query returning DeptCode and AVG(BaseSalary) AS AvgSalary for each department.
-- Write your SQL Query below:




-- Q55 [Logic Builder - Un-aggregated Columns in GROUP BY]:
-- Task:
-- 1. Why does 'SELECT StaffName, DeptCode, AVG(BaseSalary) FROM StaffPayroll GROUP BY DeptCode' fail with an error?
-- 2. Explain the fundamental rule regarding un-aggregated columns in SELECT queries with GROUP BY.
-- Write your answer in comments below:




-- Q56 [Logic Builder - Data Type Limitations on Aggregates]:
-- Task: Explain why SUM(StaffName) or AVG(StaffName) fails with an error in SQL Server.
-- Write your explanation in comments below:




-- Q57 [Debugging - Fix Invalid DISTINCT Syntax & SELECT * Errors]:
-- Task: Identify and fix errors in the following 2 queries:
-- 1. SELECT *, AVG(BaseSalary) FROM StaffPayroll;
-- 2. SELECT DISTINCT(StaffName), DISTINCT(DeptCode) FROM StaffPayroll;
-- Write your corrected SQL Queries below:




-- Q58 [Debugging - COUNT(col) on 100% NULL Column]:
-- Task: If a table has 5 rows where column 'DeptCode' is NULL for all 5 rows,
--       what will 'COUNT(DeptCode)' return vs 'COUNT(*)'?
-- Write your explanation in comments below:





/*============================================================
CHALLENGE QUESTIONS
============================================================*/

-- Challenge 1
-- Display:
-- Department
-- Average Salary
-- Total Salary
-- Write your SQL Query below:




-- Challenge 2
-- Display:
-- Department
-- Minimum Salary
-- Maximum Salary
-- Employee Count
-- Write your SQL Query below:




-- Challenge 3
-- Display all five aggregate functions
-- for every department.
-- Write your SQL Query below:




-- Challenge 4
-- Display only unique employee names.
-- Write your SQL Query below:




-- Challenge 5
-- Display the first 5 employees
-- and explain why SQL Server
-- has TOP but not BOTTOM.
-- Write your SQL Query and explanation below:




-- Challenge 6
-- Create a Dummy table
-- containing only NULL values.
-- Verify:
-- COUNT(*)
-- COUNT(column_name)
-- Write your SQL Queries below:




-- Challenge 7
-- Explain why AVG()
-- ignores NULL values.
-- Write your explanation below:




-- Challenge 8
-- Explain why SUM(empname)
-- produces an error.
-- Write your explanation below:




-- Challenge 9
-- Explain why aggregate functions
-- return only one value.
-- Write your explanation below:




-- Challenge 10
-- Explain why GROUP BY
-- and Aggregate Functions
-- are used together.
-- Write your explanation below:





/*============================================================
BONUS THEORY (INTERVIEW)
============================================================*/

-- 1. What are Aggregate Functions?
-- Write your answer below:


-- 2. Which five Aggregate Functions
--    are most commonly used?
-- Write your answer below:


-- 3. Which Aggregate Functions
--    require numeric data types?
-- Write your answer below:


-- 4. Difference between COUNT(*)
--    and COUNT(column_name).
-- Write your answer below:


-- 5. Does COUNT() ignore NULL?
-- Write your answer below:


-- 6. Does AVG() ignore NULL?
-- Write your answer below:


-- 7. What is DISTINCT?
-- Write your answer below:


-- 8. Difference between DISTINCT
--    and COUNT(DISTINCT).
-- Write your answer below:


-- 9. What is GROUP BY?
-- Write your answer below:


-- 10. Why is GROUP BY used?
-- Write your answer below:


-- 11. Which functions are commonly
--     used with GROUP BY?
-- Write your answer below:


-- 12. What is TOP?
-- Write your answer below:


-- 13. Is there a BOTTOM keyword
--     in SQL Server?
-- Write your answer below:


-- 14. Why can't we write:
--     SELECT *, AVG(salary)
--     FROM emp;
-- Write your answer below:


-- 15. Difference between
--     WHERE and HAVING
--     (based on today's notes).
-- Write your answer below:


/********************* END OF PRACTICE ************************/
