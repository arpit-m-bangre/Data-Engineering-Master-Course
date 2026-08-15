/*============================================================
       DAY 5 PRACTICE QUESTIONS - 5 AUGUST 2026
       TOPICS: TRUNCATE VS DELETE VS DROP (DDL VS DML), ALTER TABLE (ADD, DROP, ALTER), SP_RENAME
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query to TRUNCATE the table 'employee'.
-- Write your SQL Query below:




-- Q2. Write an ALTER TABLE query to add a column 'country' (VARCHAR(20)) to the 'employee' table.
-- Write your SQL Query below:




-- Q3. Write an ALTER TABLE query to drop the column 'country' from 'employee'.
-- Write your SQL Query below:




-- Q4. Rename the table 'employee' to 'emp_backup' using the system stored procedure.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Change the data type of the column 'salary' in 'employee' from INT to VARCHAR(15).
-- Write your SQL Query below:




-- Q6. Change the data type of column 'salary' back to INT.
-- Write your SQL Query below:




-- Q7. Update all rows in 'employee' to set country = 'India' (if column exists).
-- Write your SQL Query below:




-- Q8. Explain why TRUNCATE TABLE is classified as DDL, while DELETE FROM is DML.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. Schema modification: Add columns 'doj' (DATE) and 'status' (VARCHAR(10)) to the candidate profiles table.
-- Write your SQL Query below:




-- Q10. You want to rename the column 'status' to 'candidate_status' in candidate profiles table.
-- Write your SQL Query below:




-- Q11. Decrease the size of column 'empname' in 'employee1' to VARCHAR(5). What warning/error does SQL Server raise
--      if existing records contain names longer than 5 characters?
-- Write your SQL Query and explanation below:




-- Q12. Perform database cleanup: Drop columns 'age' and 'marks' from 'student_dumy' table.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the syntax error in the following column rename operation:
--      ALTER TABLE employee RENAME COLUMN dept TO department;
-- Write your corrected SQL Query below:




-- Q14. Explain why 'TRUNCATE TABLE' fails if you try to add a WHERE clause filter to delete specific rows.
-- Write your explanation below:\n