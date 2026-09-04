-- ====================================================================================================
-- 🎯 INDEX-WISE PRACTICE DRILLS (14 TARGETED QUESTIONS)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 TOPIC DATE: 03 SEPTEMBER 2026 (Day 26)
-- 🎯 TOPIC: Transaction Control (TCL), NULL Functions (ISNULL, COALESCE) & Subqueries vs CTEs
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP TEST ENVIRONMENT & DATASETS
-- ====================================================================================================

IF OBJECT_ID('CorporateEmployees', 'U') IS NOT NULL DROP TABLE CorporateEmployees;
IF OBJECT_ID('ClientAccounts', 'U') IS NOT NULL DROP TABLE ClientAccounts;
IF OBJECT_ID('LegacyProjects', 'U') IS NOT NULL DROP TABLE LegacyProjects;
IF OBJECT_ID('ActiveProjects', 'U') IS NOT NULL DROP TABLE ActiveProjects;

CREATE TABLE CorporateEmployees
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50)    NOT NULL,
    DeptName   VARCHAR(50)    NULL,
    Salary     DECIMAL(10,2)  NOT NULL,
    Bonus      DECIMAL(10,2)  NULL,
    ManagerID  INT            NULL
);

INSERT INTO CorporateEmployees (EmpID, EmpName, DeptName, Salary, Bonus, ManagerID) VALUES
(101, 'Arpit Bangre',     'Data Platform',  120000.00, 15000.00, NULL),
(102, 'Rohit Sharma',     'Data Platform',  95000.00,  NULL,     101),
(103, 'Pooja Kulkarni',   'Analytics',      120000.00, 12000.00, 101),
(104, 'Amit Verma',       'Analytics',      85000.00,  5000.00,  103),
(105, 'Neha Singh',       NULL,             72000.00,  NULL,     101),
(106, 'Vikram Malhotra',  'Infrastructure', 95000.00,  8000.00,  101);

CREATE TABLE ClientAccounts
(
    AccountID       INT PRIMARY KEY,
    ClientName      VARCHAR(50)  NOT NULL,
    PrimaryEmail    VARCHAR(100) NULL,
    SecondaryEmail  VARCHAR(100) NULL,
    OfficePhone     VARCHAR(20)  NULL,
    EmergencyPhone  VARCHAR(20)  NULL
);

INSERT INTO ClientAccounts (AccountID, ClientName, PrimaryEmail, SecondaryEmail, OfficePhone, EmergencyPhone) VALUES
(1, 'Apex Global',     'contact@apex.com', 'support@apex.com', '020-112233', '9876543210'),
(2, 'Nexus Corp',      NULL,               'admin@nexus.io',   '022-998877', NULL),
(3, 'Zenith Retail',   NULL,               NULL,               '080-445566', '9123456780'),
(4, 'Quantum Labs',    NULL,               NULL,               NULL,         '9988776655'),
(5, 'Starlight Media', NULL,               NULL,               NULL,         NULL);

CREATE TABLE LegacyProjects
(
    ProjectID   INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL
);

INSERT INTO LegacyProjects (ProjectID, ProjectName) VALUES
(1, 'Project Alpha'),
(2, 'Project Beta'),
(3, 'Project Gamma');

CREATE TABLE ActiveProjects
(
    ProjectID   INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL
);

INSERT INTO ActiveProjects (ProjectID, ProjectName) VALUES
(2, 'Project Beta'),
(3, 'Project Gamma'),
(4, 'Project Delta');


-- ====================================================================================================
-- 📝 PHASE 1: 14 TARGETED PRACTICE DRILLS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- QUESTION 1: BASIC EXPLICIT TRANSACTION WITH ROLLBACK
-- Scenario: Write an explicit transaction that deletes all employees with Salary < 80000 from CorporateEmployees.
--           Select the remaining employees inside the transaction. Then issue a ROLLBACK and select all
--           employees again to confirm zero data was permanently lost.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 2: EXPLICIT TRANSACTION WITH COMMIT
-- Scenario: Write an explicit transaction that updates the DeptName of employee 105 to 'Cloud Engineering'.
--           Commit the transaction, and verify that the change persisted permanently to disk.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 3: ATOMIC MULTI-STATEMENT TRANSACTION ROLLBACK
-- Scenario: Open a transaction. Increase the Salary of all employees in 'Data Platform' by 10%, and delete
--           all employees with NULL DeptName. View the table, then rollback all changes in one atomic step.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 4: SQL SERVER DDL ROLLBACK (TRUNCATE TABLE RESTORATION)
-- Scenario: Open an explicit transaction. TRUNCATE the LegacyProjects table. Verify the table is empty
--           inside the transaction, then execute a ROLLBACK and prove that all rows return intact.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 5: SQL SERVER DDL ROLLBACK (CREATE TABLE UNDO)
-- Scenario: Open an explicit transaction. Create a temporary staging table named StagingAudit (AuditID INT).
--           Verify the table exists in the current session. Execute a ROLLBACK and check OBJECT_ID to
--           prove the table was dropped cleanly by the rollback.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 6: NULL REPLACEMENT WITH DEFAULT VALUE USING ISNULL()
-- Scenario: Display EmpID, EmpName, and replace NULL DeptName with 'General Allocation' using ISNULL().
--           Also calculate TotalCompensation as Salary + ISNULL(Bonus, 0).
-- Expected Output: EmpID, EmpName, DeptName, TotalCompensation
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 7: CONDITIONAL UPDATE ON NULL RECORDS
-- Scenario: Update all records in CorporateEmployees where Bonus IS NULL, setting Bonus = 2500.00.
--           Display the updated table.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 8: MULTI-COLUMN HIERARCHICAL FALLBACK VIA COALESCE()
-- Scenario: In ClientAccounts, generate a master contact directory displaying AccountID, ClientName,
--           and PreferredEmail (1st choice: PrimaryEmail, 2nd choice: SecondaryEmail, Fallback: 'No Email on Record').
-- Expected Output: AccountID, ClientName, PreferredEmail
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 9: 4-TIER UNIVERSAL CONTACT RESOLUTION VIA COALESCE()
-- Scenario: In ClientAccounts, evaluate all 4 contact channels in sequence:
--           PrimaryEmail -> SecondaryEmail -> OfficePhone -> EmergencyPhone -> 'Unreachable Account'
--           Project AccountID, ClientName, and BestContactChannel.
-- Expected Output: AccountID, ClientName, BestContactChannel
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 10: SCALAR SUBQUERY FOR ABOVE-AVERAGE SALARY FILTERING
-- Scenario: Write a scalar subquery to find all employees in CorporateEmployees who earn strictly more
--           than the overall company average salary.
-- Expected Output: EmpID, EmpName, Salary, CompanyAvgSalary
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 11: SCALAR SUBQUERY FOR 2ND HIGHEST SALARY
-- Scenario: Write a query using a subquery (WHERE Salary < (SELECT MAX(Salary)...)) to find the 2nd highest
--           salary in CorporateEmployees.
-- Expected Output: SecondHighestSalary
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 12: CTE + DENSE_RANK() REFACTORING FOR N-TH HIGHEST SALARY
-- Scenario: Refactor Question 11 into a production-grade CTE using DENSE_RANK() OVER (ORDER BY Salary DESC)
--           to return all employees who earn the 2nd highest salary, including ties.
-- Expected Output: EmpID, EmpName, DeptName, Salary, RankPosition
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 13: REFACTORING IN-SUBQUERY TO INNER JOIN
-- Scenario: Part A: Write a subquery selecting ProjectID and ProjectName from LegacyProjects WHERE ProjectID IN (SELECT ProjectID FROM ActiveProjects).
--           Part B: Refactor Part A into an optimized set-based INNER JOIN.
-- Expected Output: Matched projects
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 14: REFACTORING NOT IN SUBQUERY TO ANTI-JOIN (NULL-SAFE LEFT JOIN)
-- Scenario: Find all projects in LegacyProjects that are NOT present in ActiveProjects.
--           Write this using a NULL-safe LEFT JOIN + WHERE IS NULL pattern rather than NOT IN.
-- Expected Output: ProjectID, ProjectName (for legacy-only projects)
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




