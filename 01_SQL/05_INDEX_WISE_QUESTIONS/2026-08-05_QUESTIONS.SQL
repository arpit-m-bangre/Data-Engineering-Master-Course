/*============================================================
        DAY 5 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: TRUNCATE, ALTER TABLE, SP_RENAME
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day5', 'U') IS NOT NULL DROP TABLE practice_day5;
CREATE TABLE practice_day5 (
    empid INT,
    emp_name VARCHAR(30),
    age INT,
    salary INT,
    city VARCHAR(30)
);

INSERT INTO practice_day5 (empid, emp_name, age, salary, city) VALUES 
(101, 'Arpit', 28, 35000, 'Nagpur'),
(102, 'Rohan', 30, 38000, NULL),
(103, 'Priya', 25, 39000, 'Mumbai');


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Write a query to
--     TRUNCATE table 'employee'.
-- Write your SQL Query below:




-- Q2. Add column 'country'
--     (VARCHAR(20)) to 'employee'.
-- Write your SQL Query below:




-- Q3. Drop column 'country'
--     from 'employee' table.
-- Write your SQL Query below:




-- Q4. Rename 'employee' table
--     to 'emp_backup' using sp.
-- Write your SQL Query below:




-- Q5. Add column 'status'
--     (VARCHAR(10)) to 'employee'.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Change data type of 'salary'
--     in 'employee' to VARCHAR(15).
-- Write your SQL Query below:




-- Q7. Change data type of
--     'salary' back to INT.
-- Write your SQL Query below:




-- Q8. Update all rows in table
--     to set country = 'India'.
-- Write your SQL Query below:




-- Q9. Drop column 'status'
--     from the table.
-- Write your SQL Query below:




-- Q10. Explain why TRUNCATE
--      is DDL and not DML.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Candidate Profile Setup:
--      Q11.1. Add columns 'doj' (DATE)
--             and 'status' to profiles.
--      Q11.2. Add column 'salary_exp'
--             (INT) to profiles.
-- Write your SQL Queries below:




-- Q12. Structural Column Renames:
--      Q12.1. Rename column 'status' to
--             'candidate_status' in table.
--      Q12.2. Rename column 'doj' to
--             'joining_date' in table.
-- Write your SQL Queries below:




-- Q13. Column Value Truncation Checks:
--      Q13.1. Try changing size of 'name'
--             to VARCHAR(5) when long
--             values exist. What happens?
--      Q13.2. Change size of 'name' to
--             VARCHAR(60) (Succeeds).
-- Write your SQL Query and explanation:




-- Q14. Backup Cleanup Operations:
--      Q14.1. Drop columns 'age' and
--             'marks' from student backup.
--      Q14.2. Drop column 'city' from
--             the backup table.
-- Write your SQL Queries below:




-- Q15. Initial Value Configuration:
--      Q15.1. Add column 'rating' (INT)
--             with default value NULL.
--      Q15.2. Update rating to 5 for
--             active employees.
-- Write your SQL Queries below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Correct the syntax error:
--      ALTER TABLE employee
--      RENAME COLUMN dept TO department;
-- Write your corrected Query below:




-- Q17. Explain why TRUNCATE
--      does not accept WHERE.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      ALTER TABLE employee
--      DROP city, marks;
-- Write your corrected Query below:




-- Q19. Why does reducing VARCHAR
--      size fail if active data
--      is longer than target?
-- Write your explanation below:




-- Q20. Correct the syntax error:
--      sp_rename 'employee', 'emp';
-- Write your corrected Query below:\n