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

-- Q11. Create 'StaffRegister':
--      RollID (INT PRIMARY KEY),
--      Email (VARCHAR(40) NOT NULL UNIQUE),
--      Age (INT CHECK (Age >= 18)),
--      Department (VARCHAR(15) DEFAULT 'Bench').
-- Write your SQL Query below:




-- Q12. Insert staff register with
--      email blank ('') vs NULL.
-- Write your SQL Queries below:




-- Q13. Add CHECK constraint on
--      Department ensuring it is
--      in ('IT', 'HR', 'Admin').
-- Write your SQL Query below:




-- Q14. Try inserting Department = 'Sales'.
--      Explain constraint validation.
-- Write your SQL Query and explanation:




-- Q15. Create 'Accounts' table with
--      acc_no INT CHECK (acc_no > 1000).
-- Write your SQL Query below:





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