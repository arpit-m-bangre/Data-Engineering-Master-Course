/*============================================================
       DAY 5 PRACTICE QUESTIONS
       TOPICS: TRUNCATE, ALTER TABLE, SP_RENAME
============================================================*/

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

-- Q11. Add columns 'doj' (DATE)
--      and 'status' to profiles.
-- Write your SQL Query below:




-- Q12. Rename column 'status' to
--      'candidate_status' in table.
-- Write your SQL Query below:




-- Q13. Try changing size of 'name'
--      to VARCHAR(5) when long
--      values exist. What happens?
-- Write your explanation below:




-- Q14. Drop columns 'age' and
--      'marks' from student backup.
-- Write your SQL Query below:




-- Q15. Add column 'rating' (INT)
--      with default value NULL.
-- Write your SQL Query below:





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