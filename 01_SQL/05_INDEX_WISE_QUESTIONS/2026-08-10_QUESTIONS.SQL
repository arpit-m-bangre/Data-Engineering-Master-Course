/*============================================================
        DAY 9 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: CONSTRAINTS, PRIMARY KEY, UNIQUE, CHECK, NOT NULL
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Create table 'Vendor' with:
--      VendorID (INT PRIMARY KEY),
--      VendorName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q1.2. Create table 'ProductCatalog' with:
--      ProductID (INT UNIQUE),
--      Price (INT CHECK (Price > 0)).
-- Write your SQL Query below:




-- Q1.3. Create table 'AccountLog' with:
--      LogID (INT PRIMARY KEY),
--      Username (VARCHAR(20) NOT NULL).
-- Write your SQL Query below:




-- Q1.4. Create 'TestCheck' table with
--      status VARCHAR(10) NOT NULL.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Insert a duplicate VendorID
--      into 'Vendor'. Show error.
-- Write your SQL Query and explanation:




-- Q2.2. Insert a negative Price into
--      'ProductCatalog'. Show error.
-- Write your SQL Query and explanation:




-- Q2.3. Try inserting a second NULL
--      into a UNIQUE column. Show error.
-- Write your SQL Query and explanation:




-- Q2.4. Add UNIQUE constraint to
--      username column in 'AccountLog'.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Add CHECK constraint to 'Vendor'
--      ensuring name doesn't start with 'X'.
-- Write your SQL Query below:




-- Q3.2. Group by status and show count
--      from 'TestCheck'.
-- Write your SQL Query below:




-- Q3.3. Update status to 'Active' where
--      status is NULL.
-- Write your SQL Query below:




-- Q3.4. Explain NOT NULL + UNIQUE
--      vs PRIMARY KEY constraints.
-- Write your explanation below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. Create 'StaffRegister':
--      RollID (INT PRIMARY KEY),
--      Email (VARCHAR(40) NOT NULL UNIQUE),
--      Age (INT CHECK (Age >= 18)),
--      Department (VARCHAR(15) DEFAULT 'Bench').
-- Write your SQL Query below:




-- Q4.2. Insert staff register with
--      email blank ('') vs NULL.
-- Write your SQL Queries below:




-- Q4.3. Add CHECK constraint on
--      Department ensuring it is
--      in ('IT', 'HR', 'Admin').
-- Write your SQL Query below:




-- Q4.4. Try inserting Department = 'Sales'.
--      Explain constraint validation.
-- Write your SQL Query and explanation:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Create 'Accounts' table with
--      acc_no INT CHECK (acc_no > 1000).
-- Write your SQL Query below:




-- Q5.2. Insert valid acc_no and
--      verify CHECK constraint.
-- Write your SQL Query below:




-- Q5.3. Drop the CHECK constraint
--      applied to 'Accounts' table.
-- Write your SQL Query below:




-- Q5.4. Rename column 'acc_no' to
--      'account_number' in table.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug the query check:
--      ALTER TABLE Student ADD CHECK
--      (Grade IN ('A', 'B') AND Grade IS NOT NULL);
--      Make it allow NULL values.
-- Write your corrected Query below:




-- Q6.2. Explain whether a CHECK
--      constraint blocks NULL values.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      CREATE TABLE Q4_Test (
--      id INT PRIMARY KEY NULL
--      );
-- Write your corrected Query below:




-- Q6.4. Why does SQL Server restrict
--      a table to one PRIMARY KEY?
-- Write your explanation below:\n