/*============================================================
       DAY 12 PRACTICE QUESTIONS - 13 AUGUST 2026
       TOPICS: RETROFITTING CONSTRAINTS, COLUMN PROPERTIES VS TABLE CONSTRAINTS
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write an ALTER TABLE query to add a UNIQUE constraint named 'u_emp_email' to an existing column 'email'.
-- Write your SQL Query below:




-- Q2. Write an ALTER TABLE query to change the data type of an existing column 'age' to INT NOT NULL.
-- Write your SQL Query below:




-- Q3. Write an ALTER TABLE query to add a CHECK constraint named 'ck_emp_salary' to ensure salary <= 50000.
-- Write your SQL Query below:




-- Q4. Write a query to drop the UNIQUE constraint 'u_emp_email' from your table.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Add a new column 'serial_no' (INT IDENTITY(1,1)) to an existing populated table.
-- Write your SQL Query below:




-- Q6. Query system metadata to view all active constraints in the current database.
-- Write your SQL Query below:




-- Q7. Try adding a CHECK constraint 'ck_age' (age > 18) when the table contains rows with age = 15.
-- Write your SQL Query and explanation below:




-- Q8. Explain the difference between column properties (NOT NULL, IDENTITY) and table constraints (PRIMARY KEY, CHECK).
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR Cleanup: You have duplicate emails in 'emp'. Write a query to delete duplicate rows,
--     and then retrofit a UNIQUE constraint on the email column.
-- Write your SQL Queries below:




-- Q10. HR Onboarding: Convert the column 'status' in table 'emp' to NOT NULL. Explain what data pre-cleaning
--      is required before you can execute the ALTER COLUMN statement.
-- Write your SQL Query and explanation below:




-- Q11. Add a DEFAULT constraint named 'df_emp_status' to set status = 'Active' on the 'status' column.
-- Write your SQL Query below:




-- Q12. Perform metadata audit: Find the status of all UNIQUE constraints applied to the 'emp' table.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the syntax error: The developer wants to retrofit a PRIMARY KEY on a column, so they wrote:
--      ALTER TABLE q10 ADD CONSTRAINT pk_id PRIMARY KEY (id);
--      Why does this fail if the column was created as NULLABLE, and how do you fix it?
-- Write your corrected SQL Queries below:




-- Q14. Explain why you cannot apply the IDENTITY property to an existing column using ALTER COLUMN.
-- Write your explanation below:\n