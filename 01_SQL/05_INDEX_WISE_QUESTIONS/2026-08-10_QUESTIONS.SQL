/*============================================================
       DAY 9 PRACTICE QUESTIONS - 10 AUGUST 2026
       TOPICS: SQL CONSTRAINTS, PRIMARY KEY, UNIQUE, NOT NULL, CHECK CONSTRAINTS
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Create a table 'Vendor' with: VendorID (INT PRIMARY KEY) and VendorName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q2. Create a table 'ProductCatalog' with: ProductID (INT UNIQUE) and Price (INT CHECK (Price > 0)).
-- Write your SQL Query below:




-- Q3. Write a query to create a table 'AccountLog' with: LogID (INT PRIMARY KEY) and Username (VARCHAR(20) NOT NULL).
-- Write your SQL Query below:




-- Q4. Insert a row into 'Vendor' with a duplicate VendorID. What error is produced?
-- Write your SQL Query and explanation below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Insert a row into 'ProductCatalog' with a negative Price. What error is produced?
-- Write your SQL Query and explanation below:




-- Q6. Write a query to add a CHECK constraint to the 'Vendor' table to ensure VendorName does not start with 'X'.
-- Write your SQL Query below:




-- Q7. Try inserting a second NULL value into a column defined with a UNIQUE constraint in SQL Server.
-- Write your SQL Query and explanation below:




-- Q8. Explain how the combination of NOT NULL and UNIQUE constraints differs from a PRIMARY KEY constraint.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR Database: Create a table 'StaffRegister' with: RollID (INT PRIMARY KEY), Email (VARCHAR(40) NOT NULL UNIQUE),
--     Age (INT CHECK (Age >= 18)), and Department (VARCHAR(15) DEFAULT 'Bench').
-- Write your SQL Query below:




-- Q10. Insert a staff record into 'StaffRegister' where the email is blank ('') vs NULL.
-- Write your SQL Queries below:




-- Q11. Audit checks: Write a query to alter 'StaffRegister' to add a CHECK constraint on Department
--      ensuring it must be in ('IT', 'HR', 'Admin', 'Bench').
-- Write your SQL Query below:




-- Q12. Try inserting a row into 'StaffRegister' with Department = 'Sales'. What constraint is violated?
-- Write your SQL Query and explanation below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the logic error: The developer wants to block grades other than 'A', 'B', 'C',
--      but wants to allow NULL values. They ran:
--      ALTER TABLE Student ADD CHECK (Grade IN ('A', 'B', 'C') AND Grade IS NOT NULL);
--      Why does this fail to allow NULLs, and how do you fix it?
-- Write your corrected SQL Query below:




-- Q14. Explain whether a CHECK constraint will fail, succeed, or ignore a value when that value evaluates to NULL.
-- Write your explanation below:\n