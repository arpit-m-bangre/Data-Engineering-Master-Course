/*============================================================
        DAY 9 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: CONSTRAINTS, PRIMARY KEY, UNIQUE, CHECK, NOT NULL
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day9', 'U') IS NOT NULL DROP TABLE practice_day9;
CREATE TABLE practice_day9 (
    id INT,
    name VARCHAR(20)
);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Create table 'Vendor' with:
--     VendorID (INT PRIMARY KEY),
--     VendorName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q2. Create table 'ProductCatalog' with:
--     ProductID (INT UNIQUE),
--     Price (INT CHECK (Price > 0)).
-- Write your SQL Query below:




-- Q3. Create table 'AccountLog' with:
--     LogID (INT PRIMARY KEY),
--     Username (VARCHAR(20) NOT NULL).
-- Write your SQL Query below:




-- Q4. Insert a row into 'Vendor'
--     with a duplicate VendorID.
-- Write your SQL Query and explanation:




-- Q5. Create 'TestCheck' table with
--     status VARCHAR(10) NOT NULL.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Insert a negative Price into
--     'ProductCatalog'. Show error.
-- Write your SQL Query and explanation:




-- Q7. Add CHECK constraint to 'Vendor'
--     ensuring name doesn't start with 'X'.
-- Write your SQL Query below:




-- Q8. Try inserting a second NULL
--     into a UNIQUE column. Show error.
-- Write your SQL Query and explanation:




-- Q9. Add UNIQUE constraint to
--     username column in 'AccountLog'.
-- Write your SQL Query below:




-- Q10. Explain NOT NULL + UNIQUE
--      vs PRIMARY KEY constraints.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Staff Schema Design:
--      Q11.1. Create table 'StaffRegister' with
--             RollID (INT PRIMARY KEY).
--      Q11.2. Add Email (VARCHAR(40) NOT NULL UNIQUE)
--             and Age (INT CHECK (Age >= 18)).
-- Write your SQL Queries below:




-- Q12. Email Input Audits:
--      Q12.1. Insert staff record with
--             email set to empty string ('').
--      Q12.2. Try inserting staff record with
--             email set to NULL (Show error).
-- Write your SQL Query and explanation:




-- Q13. Department Domain Constraints:
--      Q13.1. Add CHECK constraint on Department
--             ensuring it is in ('IT', 'HR', 'Admin').
--      Q13.2. Try inserting Department = 'Sales'.
-- Write your SQL Query and explanation:




-- Q14. Accounts Creation Verification:
--      Q14.1. Create 'Accounts' table with
--             acc_no INT CHECK (acc_no > 1000).
--      Q14.2. Insert account number 1001.
-- Write your SQL Queries below:




-- Q15. Metadata Verification Checks:
--      Q15.1. Find all active CHECK constraints
--             applied to the 'StaffRegister' table.
--      Q15.2. Find all UNIQUE constraints.
-- Write your SQL Queries below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the query check:
--      ALTER TABLE Student ADD CHECK
--      (Grade IN ('A', 'B') AND Grade IS NOT NULL);
--      Make it allow NULL values.
-- Write your corrected Query below:




-- Q17. Explain whether a CHECK
--      constraint blocks NULL values.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      CREATE TABLE Q4_Test (
--      id INT PRIMARY KEY NULL
--      );
-- Write your corrected Query below:




-- Q19. Why does SQL Server restrict
--      a table to one PRIMARY KEY?
-- Write your explanation below:




-- Q20. Correct the query check:
--      ALTER TABLE Vendor ADD CHECK
--      (VendorName = NULL);
-- Write your corrected Query below:\n