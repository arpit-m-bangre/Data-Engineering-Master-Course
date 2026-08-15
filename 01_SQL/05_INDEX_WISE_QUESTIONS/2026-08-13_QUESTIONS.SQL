/*============================================================
        DAY 12 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: RETROFITTING CONSTRAINTS, PROPERTY VS CONSTRAINT
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day12', 'U') IS NOT NULL DROP TABLE practice_day12;
CREATE TABLE practice_day12 (
    empid INT,
    email VARCHAR(50),
    age INT,
    salary INT,
    status VARCHAR(10)
);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Add UNIQUE constraint 'u_email'
--     to existing column 'email'.
-- Write your SQL Query below:




-- Q2. Change column 'age' data type
--     to INT NOT NULL.
-- Write your SQL Query below:




-- Q3. Add CHECK constraint 'ck_salary'
--     to ensure salary <= 50000.
-- Write your SQL Query below:




-- Q4. Drop UNIQUE constraint 'u_email'.
-- Write your SQL Query below:




-- Q5. Add DEFAULT 'Active' for status.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Add column 'sr_no'
--     (INT IDENTITY(1,1)) to table.
-- Write your SQL Query below:




-- Q7. Query system metadata for all
--     active constraints.
-- Write your SQL Query below:




-- Q8. Try adding CHECK 'ck_age' (>18)
--     when rows contain age = 15.
-- Write your SQL Query and explanation:




-- Q9. Change column property of 'name'
--     to VARCHAR(30) NOT NULL.
-- Write your SQL Query below:




-- Q10. Explain column properties vs
--      table constraints.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. HR Cleanup: Delete duplicate
--      emails and add UNIQUE.
-- Write your SQL Queries below:




-- Q12. Convert 'status' to NOT NULL.
--      What pre-cleaning is needed?
-- Write your SQL Query and explanation:




-- Q13. Add DEFAULT constraint named
--      'df_status' for status column.
-- Write your SQL Query below:




-- Q14. Show all check constraints
--      applied to the 'emp' table.
-- Write your SQL Query below:




-- Q15. Create table 'q11' with a
--      nullable integer column.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the primary key retrofit:
--      ALTER TABLE q10 ADD CONSTRAINT
--      pk_id PRIMARY KEY (id);
--      Why does it fail on NULL column?
-- Write your corrected Query below:




-- Q17. Explain why IDENTITY property
--      cannot be added via ALTER COLUMN.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      ALTER TABLE emp ALTER COLUMN
--      ADD CONSTRAINT NOT NULL;
-- Write your corrected Query below:




-- Q19. Why does constraint retrofit
--      fail if dirty data exists?
-- Write your explanation below:




-- Q20. Correct the query check:
--      ALTER TABLE emp ADD CONSTRAINT
--      df_val DEFAULT FOR salary;
-- Write your corrected Query below:\n