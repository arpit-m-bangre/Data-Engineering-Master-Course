/*============================================================
        DAY 1 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: CREATE, INSERT, SELECT
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day1', 'U') IS NOT NULL DROP TABLE practice_day1;
CREATE TABLE practice_day1 (
    id INT,
    name VARCHAR(30),
    dept VARCHAR(20),
    salary INT
);

INSERT INTO practice_day1 (id, name, dept, salary) VALUES 
(101, 'Amit', 'HR', 2000),
(102, 'Puja', 'Entc', 3000),
(103, 'Arpit', 'Stat', 4000);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Create table 'ITStaff' with:
--     StaffID (INT),
--     StaffName (VARCHAR(30)),
--     MonthlySalary (INT).
-- Write your SQL Query below:




-- Q2. Select 'StaffName' and
--     'MonthlySalary' from
--     the 'ITStaff' table.
-- Write your SQL Query below:




-- Q3. Insert a single staff row
--     using explicit columns.
-- Write your SQL Query below:




-- Q4. Insert a row with NULL
--     MonthlySalary using the
--     full column pattern.
-- Write your SQL Query below:




-- Q5. Write a query to display
--     all rows from 'ITStaff'.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Create table 'StudentLog'
--     with RollNo (INT),
--     FirstName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q7. Insert 3 rows into
--     'StudentLog' in one query.
-- Write your SQL Query below:




-- Q8. Select all rows from
--     the 'StudentLog' table.
-- Write your SQL Query below:




-- Q9. Create table 'Dummy'
--     with ID (INT).
-- Write your SQL Query below:




-- Q10. Insert 2 rows into
--      'Dummy' and select them.
-- Write your SQL Queries below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. HR needs 'CandidateProfile'
--      with ID, Name, Email, Age.
--      Emails must support 50 chars.
-- Write your SQL Query below:




-- Q12. Insert a candidate without
--      providing an email ID.
-- Write your SQL Query below:




-- Q13. Project name and age of
--      all candidate profiles.
-- Write your SQL Query below:




-- Q14. Insert candidate 'Amit'
--      with age 25 and NULL email.
-- Write your SQL Query below:




-- Q15. Create 'Dept' table with
--      DeptID and DeptName.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Correct the syntax error:
--      INSERT INTO ITStaff
--      (StaffID, StaffName)
--      VALUES ('Arpit', 101);
-- Write your corrected Query below:




-- Q17. Explain what happens if
--      you omit VARCHAR size.
-- Write your explanation below:




-- Q18. Explain why full column
--      insert throws error if
--      value list is too short.
-- Write your explanation below:




-- Q19. Why does 'SELECT * FROM'
--      fail if no table name
--      is provided in the query?
-- Write your explanation below:




-- Q20. Correct the syntax error:
--      CREATE TABLE (ID INT);
-- Write your corrected Query below:\n