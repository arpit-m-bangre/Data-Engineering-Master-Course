/*============================================================
        DAY 2 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: WHERE, OPERATORS, LIKE PATTERNS
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day2', 'U') IS NOT NULL DROP TABLE practice_day2;
CREATE TABLE practice_day2 (
    empid INT,
    empname VARCHAR(20),
    dept VARCHAR(20),
    salary INT
);

INSERT INTO practice_day2 (empid, empname, dept, salary) VALUES 
(101, 'Amit', 'HR', 2000),
(102, 'Puja', 'Entc', 3000),
(103, 'Arpit', 'Stat', 4000),
(104, 'Sidhant', 'HR', 5000),
(105, 'Mohit', NULL, 6000);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Select all employees
--     with department 'HR'.
-- Write your SQL Query below:




-- Q2. Select employees with
--     salary > 4000.
-- Write your SQL Query below:




-- Q3. Select employees in 'HR'
--     or 'Entc' using IN.
-- Write your SQL Query below:




-- Q4. Select employees with
--     salary between 3000
--     and 6000 inclusive.
-- Write your SQL Query below:




-- Q5. Select employees whose
--     department is NULL.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Create table 'Log' with
--     ID (INT) and LogText (VARCHAR(20)).
-- Write your SQL Query below:




-- Q7. Insert a row with a log
--     message into 'Log' table.
-- Write your SQL Query below:




-- Q8. Select all logs where
--     LogText is NOT NULL.
-- Write your SQL Query below:




-- Q9. Select all logs where
--     ID is strictly less than 5.
-- Write your SQL Query below:




-- Q10. Explain what the NOT IN
--      operator does with NULL.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Name Match Audits:
--      Q11.1. Find employees whose name
--             starts with 'A'.
--      Q11.2. Find employees whose name
--             ends with 't'.
-- Write your SQL Queries below:




-- Q12. Email Address Audits:
--      Q12.1. Find employees whose email
--             contains 'gmail.com'.
--      Q12.2. Find employees whose email
--             starts with 'arpit'.
-- Write your SQL Queries below:




-- Q13. Specific Character Matches:
--      Q13.1. Find employees whose second
--             character of name is 'a'.
--      Q13.2. Find employees whose third
--             character of name is 'p'.
-- Write your SQL Queries below:




-- Q14. High-Value Location Filter:
--      Q14.1. Find employees living in
--             'Nagpur' and aged >= 22.
--      Q14.2. Find employees in 'Pune'
--             earning > 3000.
-- Write your SQL Queries below:




-- Q15. Salary Range Screening:
--      Q15.1. Find employees whose salary
--             is NOT between 2000 and 4000.
--      Q15.2. Find employees whose salary
--             is exactly 2000 or 5000.
-- Write your SQL Queries below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the query:
--      SELECT * FROM emp
--      WHERE dept <> 'HR';
--      Why are NULL departments
--      excluded, and how to fix?
-- Write your corrected Query below:




-- Q17. Explain why email = NULL
--      returns zero rows.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT * FROM employee1
--      WHERE dept = 'HR' OR 'Sales';
-- Write your corrected Query below:




-- Q19. Explain what '[^A-Z]%'
--      wildcard matches.
-- Write your explanation below:




-- Q20. Correct the syntax error:
--      SELECT FROM employee1 WHERE ID = 1;
-- Write your corrected Query below:\n