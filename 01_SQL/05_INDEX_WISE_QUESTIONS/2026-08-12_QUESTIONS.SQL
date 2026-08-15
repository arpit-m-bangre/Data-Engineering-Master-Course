/*============================================================
       DAY 11 PRACTICE QUESTIONS - 12 AUGUST 2026
       TOPICS: PARENT/CHILD DESTRUCTION RULES, PK/FK RECAP
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Drop the child table 'Staff_FK' from your database.
-- Write your SQL Query below:




-- Q2. Drop the parent table 'Departments_PK' after the child table has been dropped.
-- Write your SQL Query below:




-- Q3. Create a parent table 'CompanyBranch' with BranchID (INT PRIMARY KEY) and Location (VARCHAR(20)).
-- Write your SQL Query below:




-- Q4. Create a child table 'BranchStaff' with StaffID (INT PRIMARY KEY), Name (VARCHAR(20)),
--     and BranchID (INT FOREIGN KEY REFERENCES CompanyBranch(BranchID)).
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Insert 3 branches into 'CompanyBranch' and 3 staff members into 'BranchStaff'.
-- Write your SQL Queries below:




-- Q6. Delete a staff member from 'BranchStaff'. Does this operation fail or succeed?
-- Write your SQL Query and explanation below:




-- Q7. Try to TRUNCATE the parent table 'CompanyBranch'. Does it fail or succeed?
-- Write your SQL Query and explanation below:




-- Q8. Explain why dropping the child table 'BranchStaff' allows the parent table to be dropped afterwards.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR Cleanup Audit: You need to clean up data in 'CompanyBranch'. Write a query to delete all rows
--     from 'BranchStaff' child table first, and then delete a row from 'CompanyBranch' parent table.
-- Write your SQL Queries below:




-- Q10. Verify child deletion: Write a query to show all remaining rows in 'BranchStaff' and 'CompanyBranch'.
-- Write your SQL Queries below:




-- Q11. Test TRUNCATE: If the child table 'BranchStaff' has been completely cleared of rows (empty table),
--      can you TRUNCATE the parent table 'CompanyBranch'? Why or why not?
-- Write your SQL Query and explanation below:




-- Q12. Perform database audit: Show all tables in the current database schema.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the logic error: The developer wants to truncate the parent table 'CompanyBranch'
--      while a foreign key constraint is active. They ran:
--      DELETE FROM BranchStaff;
--      TRUNCATE TABLE CompanyBranch;
--      Why does the TRUNCATE fail, and what is the correct way to clear the parent table's data?
-- Write your corrected SQL Queries and explanation below:




-- Q14. Explain why the parent table can be DELETED FROM (if no child rows exist) but cannot be TRUNCATED
--      even if the child table is empty.
-- Write your explanation below:\n