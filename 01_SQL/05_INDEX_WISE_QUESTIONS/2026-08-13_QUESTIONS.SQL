/*============================================================
        DAY 12 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: RETROFITTING CONSTRAINTS, PROPERTY VS CONSTRAINT
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Add UNIQUE constraint 'u_email'
--      to existing column 'email'.
-- Write your SQL Query below:




-- Q1.2. Change column 'age' data type
--      to INT NOT NULL.
-- Write your SQL Query below:




-- Q1.3. Add CHECK constraint 'ck_salary'
--      to ensure salary <= 50000.
-- Write your SQL Query below:




-- Q1.4. Drop UNIQUE constraint 'u_email'.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Add DEFAULT 'Active' for status.
-- Write your SQL Query below:




-- Q2.2. Add column 'sr_no'
--      (INT IDENTITY(1,1)) to table.
-- Write your SQL Query below:




-- Q2.3. Query system metadata for all
--      active constraints.
-- Write your SQL Query below:




-- Q2.4. Try adding CHECK 'ck_age' (>18)
--      when rows contain age = 15.
-- Write your SQL Query and explanation:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Change column property of 'name'
--      to VARCHAR(30) NOT NULL.
-- Write your SQL Query below:




-- Q3.2. Explain column properties vs
--      table constraints.
-- Write your explanation below:




-- Q3.3. Verify if identity column can
--      be added to populated table.
-- Write your SQL Query below:




-- Q3.4. Show check constraints
--      applied to the 'emp' table.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. HR Cleanup: Delete duplicate
--      emails from table 'emp'.
-- Write your SQL Query below:




-- Q4.2. Retrofit UNIQUE constraint
--      on email column after cleanup.
-- Write your SQL Query below:




-- Q4.3. Convert 'status' to NOT NULL.
--      What pre-cleaning is needed?
-- Write your SQL Query and explanation:




-- Q4.4. Add DEFAULT constraint named
--      'df_status' for status column.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Create table 'q11' with a
--      nullable integer column.
-- Write your SQL Query below:




-- Q5.2. Insert NULL values into
--      the nullable column.
-- Write your SQL Query below:




-- Q5.3. Alter column property to
--      NOT NULL. What error occurs?
-- Write your SQL Query and explanation:




-- Q5.4. Clean NULL values and
--      convert column to NOT NULL.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug the primary key retrofit:
--      ALTER TABLE q10 ADD CONSTRAINT
--      pk_id PRIMARY KEY (id);
--      Why does it fail on NULL column?
-- Write your corrected Query below:




-- Q6.2. Explain why IDENTITY property
--      cannot be added via ALTER COLUMN.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      ALTER TABLE emp ALTER COLUMN
--      ADD CONSTRAINT NOT NULL;
-- Write your corrected Query below:




-- Q6.4. Why does constraint retrofit
--      fail if dirty data exists?
-- Write your explanation below:\n