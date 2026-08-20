/* ====================================================================================================
                  🏢 DATA ENGINEERING ENTERPRISE PROJECT 4 (PROJECT4.SQL)
                  TITLE: HR ENTERPRISE PAYROLL & DATA INTEGRITY ENGINE
                  TOPICS: PRIMARY KEY, UNIQUE, NOT NULL, CHECK, DEFAULT, IDENTITY, INGESTION & AUDIT
   ==================================================================================================== */

/* ====================================================================================================
📖 1. THE BUSINESS STORY & WHY WE ARE BUILDING THIS
=======================================================================================================
You are the Lead Database Architect at a fast-growing Global Tech Corporation ("Apex Global Technologies").
The company is hiring hundreds of engineers and HR staff across Pune, Bangalore, and Nagpur.

🚨 THE PROBLEM:
Previously, the HR team was using Excel sheets without validation. Because of this:
- Duplicate employee records got inserted (paying same salary twice!).
- Employees with invalid ages (like 14 years old or 150 years old) were entered by mistake.
- Unapproved department names (like "Sales & Party", "Random") caused payroll reports to fail.
- Missing city names created tax calculation nightmares.

🛡️ YOUR MISSION:
Build a bulletproof SQL Server database schema with automated constraints that acts like an unbreakable
security system. If bad data tries to enter, SQL Server will instantly REJECT it!
======================================================================================================= */


/* ====================================================================================================
💡 REAL-LIFE ANALOGIES: THE 5 DEFENSE SHIELDS OF DATA INTEGRITY
=======================================================================================================
1. 🪪 PRIMARY KEY + IDENTITY(10001, 1):
   -> Analogy: The "Automated Smart ID Badge".
   -> You never write your own EmpID. The machine assigns 10001, 10002, 10003 automatically. Unique & never null.

2. 👆 UNIQUE (NationalID / Aadhaar):
   -> Analogy: The "Biometric Fingerprint Scanner".
   -> Two different employees can have the same name ("Rahul Sharma"), but NO two people can share the same National ID.

3. ✍️ NOT NULL:
   -> Analogy: The "Mandatory Red Asterisk (*)" on an online form.
   -> You cannot submit the form with this box left blank.

4. 🥋 CHECK Constraint:
   -> Analogy: The "Club Security Bouncer".
   -> "Are you between 18 and 65 years old?" -> If NO, you cannot enter.
   -> "Is your department in the approved company list?" -> If NO, access denied.

5. 🦺 DEFAULT Constraint:
   -> Analogy: The "Safety Net / Auto-Pilot".
   -> If the HR person forgets to type a city, the database automatically assigns 'Pune'.
   -> If starting salary is omitted, the database automatically assigns ₹45,000.
======================================================================================================= */


-- ====================================================================================================
-- 🧹 STEP 0: CLEAN SLATE ENVIRONMENT RESET
-- (Run this block anytime you want to start fresh without 'Table already exists' errors)
-- ====================================================================================================
IF OBJECT_ID('EmployeesMaster', 'U') IS NOT NULL DROP TABLE EmployeesMaster;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
GO


-- ====================================================================================================
-- 🏗️ STEP 1: CONSTRAINT-VALIDATED SCHEMA CREATION (DDL)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- Task 1: Create 'Departments' Reference Table
-- ----------------------------------------------------------------------------------------------------
CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,              -- 🪪 Unique Dept identifier (1, 2, 3...)
    DeptName VARCHAR(30) NOT NULL UNIQUE   -- 👆 Dept name cannot be blank and cannot be duplicated
);
GO

-- Insert Approved Department Master Data
INSERT INTO Departments (DeptID, DeptName)
VALUES 
    (101, 'Data Engineering'),
    (102, 'Software Development'),
    (103, 'HR'),
    (104, 'Finance'),
    (105, 'General IT');
GO


-- ----------------------------------------------------------------------------------------------------
-- Task 2: Create 'EmployeesMaster' Table with Full 5-Constraint Stack
-- ----------------------------------------------------------------------------------------------------
CREATE TABLE EmployeesMaster
(
    -- 1. Automated Primary Key: Starts at 10001, increments by 1 for each new hire
    EmpID         INT IDENTITY(10001, 1) PRIMARY KEY,
    
    -- 2. Mandatory Text: Employee name cannot be NULL
    EmpName       VARCHAR(40) NOT NULL,
    
    -- 3. Unique Candidate Key: National ID (Aadhaar/SSN) must be 100% unique per person
    NationalID    INT NOT NULL UNIQUE,
    
    -- 4. Bouncer Shield 1: Age must be legal working age (18 to 65)
    Age           INT CHECK (Age >= 18 AND Age <= 65),
    
    -- 5. Bouncer Shield 2: Department must belong to official list; defaults to 'General IT'
    Department    VARCHAR(30) DEFAULT 'General IT' 
                  CHECK (Department IN ('General IT', 'Software Development', 'HR', 'Finance', 'Data Engineering')),
    
    -- 6. Bouncer Shield 3: Base salary must be positive (> 0) and realistic (below 1,000,000/mo)
    BaseSalary    INT DEFAULT 45000 
                  CHECK (BaseSalary > 0 AND BaseSalary <= 1000000),
    
    -- 7. Safety Net: Default company headquarters location
    WorkLocation  VARCHAR(20) DEFAULT 'Pune'
);
GO


-- ====================================================================================================
-- 📥 STEP 2: DEMONSTRATING ENTERPRISE INGESTION PATTERNS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- Ingestion Pattern A: Explicit Column List (Best Practice for Production Pipelines)
-- We supply all columns explicitly (Notice: We NEVER insert EmpID because IDENTITY handles it!).
-- ----------------------------------------------------------------------------------------------------
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary, WorkLocation)
VALUES ('Arpit Bangre', 998801, 24, 'Data Engineering', 85000, 'Nagpur');
GO

-- ----------------------------------------------------------------------------------------------------
-- Ingestion Pattern B: Partial Columns (Relying on DEFAULT constraints)
-- HR omitted Department, BaseSalary, and WorkLocation. Watch SQL Server auto-fill them!
-- ----------------------------------------------------------------------------------------------------
INSERT INTO EmployeesMaster (EmpName, NationalID, Age)
VALUES 
    ('Rahul Patil', 998802, 32),
    ('Sneha Joshi', 998803, 26);
GO

-- ----------------------------------------------------------------------------------------------------
-- Ingestion Pattern C: Explicit 'DEFAULT' Keyword
-- Explicitly telling SQL Server to use the configured default rule.
-- ----------------------------------------------------------------------------------------------------
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary, WorkLocation)
VALUES ('Priya Sharma', 998804, 29, 'Data Engineering', 92000, DEFAULT);
GO

-- ----------------------------------------------------------------------------------------------------
-- Ingestion Pattern D: Multi-Row Enterprise Bulk Ingestion
-- ----------------------------------------------------------------------------------------------------
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary, WorkLocation)
VALUES 
    ('Amit Verma',    998805, 35, 'Finance',              65000, 'Mumbai'),
    ('Kavita Rao',    998806, 28, 'HR',                   52000, 'Pune'),
    ('Rohan Kulkarni',998807, 41, 'Data Engineering',     110000,'Bangalore'),
    ('Pooja Nair',    998808, 23, 'General IT',           45000, 'Pune'),
    ('Vikram Singh',  998809, 38, 'Finance',              72000, 'Pune');
GO


-- ====================================================================================================
-- 🔍 STEP 3: SYSTEM AUDIT & IDENTITY VERIFICATION
-- ====================================================================================================

-- Task 3: Inspect the live table.
-- Notice how EmpID automatically generated 10001, 10002, 10003... 10009 without a single error!
-- Notice how Rahul and Sneha got Department='General IT', BaseSalary=45000, and WorkLocation='Pune'!
SELECT 
    EmpID, 
    EmpName, 
    NationalID, 
    Age, 
    Department, 
    BaseSalary, 
    WorkLocation 
FROM EmployeesMaster;
GO


-- ====================================================================================================
-- 💥 STEP 4: CONSTRAINT STRESS LAB (DELIBERATELY BREAKING THE RULES TO SEE SHIELDS WORK!)
-- NOTE: In SSMS, highlight and run each test query individually to inspect the exact error message.
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- Test 1 [CHECK Constraint Failure - Underage Rule]:
-- What we are doing: Trying to insert an employee aged 16 (Child labor / Illegal age).
-- Expected Result: ❌ FAILS with CHECK constraint violation on 'Age'.
-- ----------------------------------------------------------------------------------------------------
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary)
VALUES ('Underage Intern', 998890, 16, 'General IT', 20000);
-- 🚨 Error message: The INSERT statement conflicted with the CHECK constraint "CK__EmployeesM__Age...".
*/

-- ----------------------------------------------------------------------------------------------------
-- Test 2 [CHECK Constraint Failure - Unapproved Department]:
-- What we are doing: Trying to insert Department = 'Marketing' (not in our company approved list).
-- Expected Result: ❌ FAILS with CHECK constraint violation on 'Department'.
-- ----------------------------------------------------------------------------------------------------
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary)
VALUES ('Rajesh Gupta', 998891, 30, 'Marketing', 60000);
-- 🚨 Error message: The INSERT statement conflicted with the CHECK constraint "CK__EmployeesM__Depar...".
*/

-- ----------------------------------------------------------------------------------------------------
-- Test 3 [UNIQUE Key Constraint Failure - Duplicate National ID]:
-- What we are doing: Trying to insert NationalID = 998801 (which already belongs to Arpit Bangre).
-- Expected Result: ❌ FAILS with Violation of UNIQUE KEY constraint.
-- ----------------------------------------------------------------------------------------------------
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary)
VALUES ('Fake Arpit Clone', 998801, 27, 'Data Engineering', 85000);
-- 🚨 Error message: Violation of UNIQUE KEY constraint 'UQ__Employees...'. Cannot insert duplicate key value (998801).
*/

-- ----------------------------------------------------------------------------------------------------
-- Test 4 [CHECK Constraint Failure - Negative Salary]:
-- What we are doing: Trying to insert BaseSalary = -5000.
-- Expected Result: ❌ FAILS because salary must be > 0.
-- ----------------------------------------------------------------------------------------------------
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary)
VALUES ('Negative Pay Guy', 998892, 31, 'General IT', -5000);
-- 🚨 Error message: The INSERT statement conflicted with the CHECK constraint on BaseSalary.
*/


-- ====================================================================================================
-- 📊 STEP 5: EXECUTIVE PAYROLL ANALYTICS & BUSINESS REPORTING (YOUR TASK!)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- Task 8: Executive Department Payroll Summary
-- 🎯 Business Requirement:
-- Retrieve each Department, the Total Number of Employees in that department, 
-- and their Average Base Salary (rounded/formatted).
-- Filter the result to ONLY show departments where the Average Base Salary is greater than or equal to 50,000.
-- Sort the result by Average Base Salary in DESCENDING order (highest paying dept first).
--
-- 💡 Pippo Hint: Use GROUP BY Department, HAVING AVG(BaseSalary) >= 50000, and ORDER BY AVG(BaseSalary) DESC.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- Task 9: Location-Wise Headcount & Salary Outflow
-- 🎯 Business Requirement:
-- The CFO wants to see total company salary outflow grouped by WorkLocation.
-- Display: WorkLocation, COUNT(EmpID) AS TotalEmployees, SUM(BaseSalary) AS TotalSalaryOutflow, MAX(BaseSalary) AS TopEarnerSalary.
-- Sort by TotalSalaryOutflow DESC.
--
-- 💡 Pippo Hint: Use GROUP BY WorkLocation and standard aggregate functions (COUNT, SUM, MAX).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




/* ====================================================================================================
🏁 END OF PROJECT 4 — ENTERPRISE HR PAYROLL & DATA INTEGRITY ENGINE
======================================================================================================= */

