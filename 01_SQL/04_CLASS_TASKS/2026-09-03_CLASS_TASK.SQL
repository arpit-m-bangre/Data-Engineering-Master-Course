-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS TASKS & HOMEWORK
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 03 SEPTEMBER 2026 (Day 26)
-- 🎯 TOPIC: Transaction Control (TCL), NULL Functions (ISNULL, COALESCE) & Subqueries vs CTEs
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('StudentDummy', 'U') IS NOT NULL DROP TABLE StudentDummy;
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
IF OBJECT_ID('DepartmentRoster', 'U') IS NOT NULL DROP TABLE DepartmentRoster;
IF OBJECT_ID('TableA', 'U') IS NOT NULL DROP TABLE TableA;
IF OBJECT_ID('TableB', 'U') IS NOT NULL DROP TABLE TableB;

CREATE TABLE StudentDummy
(
    StudentID   INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(50) NULL,
    City        VARCHAR(50) NULL
);

INSERT INTO StudentDummy (StudentName, City) VALUES
('Arpit', 'Pune'),
(NULL,    'Mumbai'),
('Rohit', NULL),
(NULL,    NULL);

CREATE TABLE StudentInfo
(
    StudentID INT PRIMARY KEY,
    FullName  VARCHAR(50) NOT NULL,
    Marks     INT         NOT NULL
);

INSERT INTO StudentInfo (StudentID, FullName, Marks) VALUES
(1, 'Arpit', 95),
(2, 'Rohit', 88),
(3, 'Pooja', 95),
(4, 'Amit',  75),
(5, 'Neha',  82);

CREATE TABLE DepartmentRoster
(
    EmpID         INT PRIMARY KEY,
    EmpName       VARCHAR(50) NOT NULL,
    WorkEmail     VARCHAR(100) NULL,
    PersonalEmail VARCHAR(100) NULL,
    EmergencyPhone VARCHAR(20) NULL
);

INSERT INTO DepartmentRoster (EmpID, EmpName, WorkEmail, PersonalEmail, EmergencyPhone) VALUES
(101, 'Arpit Bangre',  'arpit@company.com', NULL, '9876543210'),
(102, 'Rohit Sharma',  NULL, 'rohit@personal.com', '9123456780'),
(103, 'Pooja Kulkarni', NULL, NULL, '9988776655'),
(104, 'Amit Verma',    'amit@company.com', 'amit@gmail.com', NULL),
(105, 'Neha Singh',    NULL, NULL, NULL);

CREATE TABLE TableA (ID INT);
CREATE TABLE TableB (ID INT);

INSERT INTO TableA (ID) VALUES (1), (2), (3), (4);
INSERT INTO TableB (ID) VALUES (2), (4), (6);


-- ====================================================================================================
-- 📝 PHASE 1: IN-CLASS TASKS & HOMEWORK ASSIGNMENTS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: EXPLICIT TRANSACTION ROLLBACK VERIFICATION (DML UNDO)
-- Scenario: Open an explicit transaction block. Delete all records from StudentDummy where StudentName IS NULL.
--           Select all rows from StudentDummy within the transaction to verify the deletion.
--           Execute a ROLLBACK and select all rows again to prove the data was 100% restored.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 2: COMMIT FINALITY & ERROR 3903 REPRODUCTION
-- Scenario: Open an explicit transaction block. Delete all records from StudentDummy where City IS NULL.
--           Execute a COMMIT statement.
--           Attempt to execute a ROLLBACK statement immediately after and analyze the engine response.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 3: SQL SERVER DDL ROLLBACK VERIFICATION (DROP TABLE RECOVERY)
-- Scenario: Open an explicit transaction block. Drop TableA.
--           Verify that TableA is dropped within the active transaction scope.
--           Execute a ROLLBACK and select all records from TableA to prove DDL rollback in SQL Server.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 4: NULL REPLACEMENT DRILL (ISNULL VS COALESCE)
-- Scenario: For StudentDummy, project StudentID, and replace NULL StudentName with 'Unassigned Name'
--           using ISNULL(). Also project City, replacing NULL City with 'Unassigned City' using ISNULL().
--           Add a third column using COALESCE to return the first non-null value between StudentName,
--           City, and 'Complete Record Missing'.
-- Expected Output: StudentID, CleanName, CleanCity, PrimaryContactInfo
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 5: MULTI-TIER COMMUNICATION FALLBACK VIA COALESCE
-- Scenario: In DepartmentRoster, HR needs a single BestContact column.
--           Return EmpID, EmpName, and evaluate contact details in priority order:
--           1st Priority: WorkEmail
--           2nd Priority: PersonalEmail
--           3rd Priority: EmergencyPhone
--           Fallback: 'No Contact Channel Available'
-- Expected Output: EmpID, EmpName, BestContact
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 6: REFACTORING SCALAR SUBQUERY TO PRODUCTION CTE (2ND HIGHEST MARKS)
-- Scenario: Part A: Write a scalar subquery using WHERE Marks < (SELECT MAX(Marks)...) to find the 2nd highest marks.
--           Part B: Refactor Part A into an industry-standard CTE using DENSE_RANK() OVER (ORDER BY Marks DESC).
-- Expected Output: StudentID, FullName, Marks (for Rank 2)
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 7: REFACTORING IN-SUBQUERY TO SET-BASED INNER JOIN
-- Scenario: Part A: Write a query selecting ID from TableA where ID IN (SELECT ID FROM TableB).
--           Part B: Refactor Part A into a high-performance set-based INNER JOIN.
-- Expected Output: Matched ID values
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




