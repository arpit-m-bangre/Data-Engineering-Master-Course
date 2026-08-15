/*============================================================
        DAY 5 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: TRUNCATE, ALTER TABLE, SP_RENAME
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Write a query to
--      TRUNCATE table 'employee'.
-- Write your SQL Query below:




-- Q1.2. Add column 'country'
--      (VARCHAR(20)) to 'employee'.
-- Write your SQL Query below:




-- Q1.3. Drop column 'country'
--      from 'employee' table.
-- Write your SQL Query below:




-- Q1.4. Rename 'employee' table
--      to 'emp_backup' using sp.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Add column 'status'
--      (VARCHAR(10)) to 'employee'.
-- Write your SQL Query below:




-- Q2.2. Change data type of 'salary'
--      in 'employee' to VARCHAR(15).
-- Write your SQL Query below:




-- Q2.3. Change data type of
--      'salary' back to INT.
-- Write your SQL Query below:




-- Q2.4. Update all rows in table
--      to set country = 'India'.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Drop column 'status'
--      from the table.
-- Write your SQL Query below:




-- Q3.2. Rename column 'dept' to
--      'department' using sp.
-- Write your SQL Query below:




-- Q3.3. Alter column 'empname'
--      to increase size to 60.
-- Write your SQL Query below:




-- Q3.4. Select table metadata from
--      INFORMATION_SCHEMA.COLUMNS.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. Add columns 'doj' (DATE)
--      and 'status' to profiles.
-- Write your SQL Query below:




-- Q4.2. Rename column 'status' to
--      'candidate_status' in table.
-- Write your SQL Query below:




-- Q4.3. Try changing size of 'name'
--      to VARCHAR(5) when long
--      values exist. What happens?
-- Write your explanation below:




-- Q4.4. Drop columns 'age' and
--      'marks' from student backup.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Add column 'rating' (INT)
--      with default value NULL.
-- Write your SQL Query below:




-- Q5.2. Change column 'rating' to
--      VARCHAR(5) nullable.
-- Write your SQL Query below:




-- Q5.3. Rename the table 'emp_backup'
--      back to 'employee'.
-- Write your SQL Query below:




-- Q5.4. Select all active columns
--      from the 'employee' table.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Correct the syntax error:
--      ALTER TABLE employee
--      RENAME COLUMN dept TO department;
-- Write your corrected Query below:




-- Q6.2. Explain why TRUNCATE
--      does not accept WHERE.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      ALTER TABLE employee
--      DROP city, marks;
-- Write your corrected Query below:




-- Q6.4. Why does reducing VARCHAR
--      size fail if active data
--      is longer than target?
-- Write your explanation below:\n