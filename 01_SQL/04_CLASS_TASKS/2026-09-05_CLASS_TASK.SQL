-- ====================================================================================
-- DAY 28: FACULTY CLASS TASKS - DATABASE & DML TRIGGERS
-- Date: 05 September 2026 | Module: 01_SQL
-- ====================================================================================

USE DataEngineeringMasterDB;
GO

-- ------------------------------------------------------------------------------------
-- PHASE 0: ENVIRONMENT SETUP & BASE TABLES
-- ------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.FacultyStudentDB', 'U') IS NOT NULL DROP TABLE dbo.FacultyStudentDB;
IF OBJECT_ID('dbo.StudentAuditTrail', 'U') IS NOT NULL DROP TABLE dbo.StudentAuditTrail;
GO

CREATE TABLE dbo.FacultyStudentDB (
    StudentID INT PRIMARY KEY IDENTITY(101, 1),
    StudentName VARCHAR(100) NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    FeesPaid DECIMAL(10,2) NOT NULL,
    UpdatedBy VARCHAR(50) DEFAULT SYSTEM_USER,
    UpdatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.StudentAuditTrail (
    AuditID INT PRIMARY KEY IDENTITY(1, 1),
    StudentID INT,
    OldName VARCHAR(100),
    NewName VARCHAR(100),
    OldFees DECIMAL(10,2),
    NewFees DECIMAL(10,2),
    ActionType VARCHAR(20),
    ModifiedAt DATETIME DEFAULT GETDATE(),
    ModifiedBy VARCHAR(50) DEFAULT SYSTEM_USER
);
GO

INSERT INTO dbo.FacultyStudentDB (StudentName, CourseName, FeesPaid)
VALUES ('Arpit Manoj Bangre', 'Data Engineering', 45000.00),
       ('Vikram Malhotra', 'Cloud Architecture', 52000.00),
       ('Priya Patel', 'Data Science', 48000.00);
GO


-- ------------------------------------------------------------------------------------
-- TASK 1: DDL TRIGGER TO PREVENT TABLE DROPS & TRUNCATES
-- Requirement: Create a Database-scoped DDL trigger named `trg_BlockTableDestruction`
-- that intercepts DROP_TABLE and prevents unauthorized deletion, printing an alert
-- and rolling back the transaction.
-- ------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- TASK 2: DML AFTER UPDATE AUDIT TRIGGER
-- Requirement: Create a DML AFTER UPDATE trigger named `trg_AuditStudentModifications`
-- on `dbo.FacultyStudentDB`. Whenever an update occurs on `FeesPaid` or `StudentName`,
-- capture the old values from DELETED and new values from INSERTED and write a record
-- into `dbo.StudentAuditTrail`.
-- ------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- TASK 3: DML INSTEAD OF DELETE TRIGGER (SOFT DELETE LOGIC)
-- Requirement: Create an INSTEAD OF DELETE trigger on `dbo.FacultyStudentDB`. When a
-- DELETE statement is executed, do NOT remove the row; instead, update the `CourseName`
-- to 'DEACTIVATED' and print a notification message.
-- ------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- TASK 4: TRIGGER STATUS MANAGEMENT & VERIFICATION
-- Requirement:
-- 1. Write commands to disable `trg_BlockTableDestruction`.
-- 2. Query `sys.triggers` to verify its `is_disabled` status.
-- 3. Re-enable the trigger.
-- ------------------------------------------------------------------------------------

-- Write your SQL Query below:



