/*============================================================
        DAY 6 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: AGGREGATE FUNCTIONS, DISTINCT, TOP
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day6', 'U') IS NOT NULL DROP TABLE practice_day6;
CREATE TABLE practice_day6 (
    empid INT,
    empname VARCHAR(20),
    org_id VARCHAR(10),
    salary INT
);

INSERT INTO practice_day6 (empid, empname, org_id, salary) VALUES 
(101, 'Amit', 'HR', 2000),
(102, 'Puja', 'Entc', 3000),
(103, 'Arpit', 'Stat', 4000),
(104, 'Sidhant', 'HR', 5000),
(105, 'Mohit', NULL, 6000);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Display minimum, maximum,
--     and average salary together.
-- Write your SQL Query below:




-- Q2. Find the total number of
--     rows using COUNT(*).
-- Write your SQL Query below:




-- Q3. Find unique departments
--     using DISTINCT.
-- Write your SQL Query below:




-- Q4. Select the TOP 3 highest
--     salaries from 'emp'.
-- Write your SQL Query below:




-- Q5. Find sum of all salaries.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Display RollNo and marks
--     for TOP 5 students.
-- Write your SQL Query below:




-- Q7. Find average marks of
--     students living in 'Nagpur'.
-- Write your SQL Query below:




-- Q8. Find count of students
--     without an email ID.
-- Write your SQL Query below:




-- Q9. Select unique city values.
-- Write your SQL Query below:




-- Q10. Explain COUNT(col) vs
--      COUNT(*) with NULLs.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. HR Payroll: Calculate total
--      budget and average salary
--      for 'IT' department.
-- Write your SQL Query below:




-- Q12. Find alphabetical minimum
--      and maximum employee names.
-- Write your SQL Query below:




-- Q13. Select unique statuses
--      using DISTINCT.
-- Write your SQL Query below:




-- Q14. Explain why SUM(empname)
--      returns a syntax error.
-- Write your explanation below:




-- Q15. Count unique departments
--      that are NOT NULL.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Correct the syntax error:
--      SELECT dept, AVG(salary)
--      FROM emp;
-- Write your corrected Query below:




-- Q17. Explain why SQL Server
--      lacks a BOTTOM keyword.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT DISTINCT(empname),
--      DISTINCT(org_id) FROM emp;
-- Write your corrected Query below:




-- Q19. Why does 'SELECT *, SUM(sal)'
--      fail in a query?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT COUNT(DISTINCT *) FROM emp;
-- Write your corrected Query below:\n