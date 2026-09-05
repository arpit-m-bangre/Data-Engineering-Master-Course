-- ====================================================================================
-- DAY 28: SQL SERVER DATABASE-LEVEL & DML TRIGGERS
-- Date: 05 September 2026 | Module: 01_SQL
-- Faculty Homework: see 04_CLASS_TASKS/2026-09-05_CLASS_TASK.SQL
-- ====================================================================================

USE DataEngineeringMasterDB;
GO

-- ------------------------------------------------------------------------------------
-- SECTION 1: DDL TRIGGERS (DATABASE-SCOPED EVENT MONITORING)
-- Theory: DDL Triggers fire in response to Data Definition events (CREATE, ALTER, DROP)
-- to enforce schema change controls, security compliance, and audit logging.
-- ------------------------------------------------------------------------------------

-- 1.1 Create DDL Trigger to Block Table Creation and Alteration
IF EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'trg_BlockSchemaModifications' AND parent_class_desc = 'DATABASE')
    DROP TRIGGER trg_BlockSchemaModifications ON DATABASE;
GO

CREATE TRIGGER trg_BlockSchemaModifications
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    PRINT '>> ACCESS DENIED: Table creation or modification is strictly prohibited by Database Security Policy.';
    ROLLBACK TRANSACTION;
END;
GO

-- 1.2 Test DDL Trigger (Expect Rollback & Print Message)
-- The following statement will fail and trigger a rollback:
-- CREATE TABLE tbl_TestDDL (ID INT);
GO

-- 1.3 Disable and Drop DDL Trigger
DISABLE TRIGGER trg_BlockSchemaModifications ON DATABASE;
GO
ENABLE TRIGGER trg_BlockSchemaModifications ON DATABASE;
GO
DROP TRIGGER trg_BlockSchemaModifications ON DATABASE;
GO


-- ------------------------------------------------------------------------------------
-- SECTION 2: DML TRIGGERS (ROW-LEVEL & STATEMENT-LEVEL DATA GUARDS)
-- Theory: DML Triggers fire automatically after (or instead of) INSERT, UPDATE, DELETE
-- statements on specific tables using virtual magic tables (INSERTED & DELETED).
-- ------------------------------------------------------------------------------------

-- 2.1 Setup Sample Target Table
IF OBJECT_ID('dbo.StudentInfo', 'U') IS NOT NULL DROP TABLE dbo.StudentInfo;
GO
CREATE TABLE dbo.StudentInfo (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    StudentName VARCHAR(100) NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    Status VARCHAR(20) DEFAULT 'ACTIVE'
);
GO

INSERT INTO dbo.StudentInfo (StudentName, CourseName)
VALUES ('Arpit Manoj Bangre', 'Data Engineering'),
       ('Rohan Sharma', 'Cloud Computing');
GO

-- 2.2 Create DML AFTER UPDATE Trigger
IF OBJECT_ID('dbo.trg_StudentInfo_UpdateGuard', 'TR') IS NOT NULL DROP TRIGGER dbo.trg_StudentInfo_UpdateGuard;
GO

CREATE TRIGGER trg_StudentInfo_UpdateGuard
ON dbo.StudentInfo
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if StudentName was modified
    IF UPDATE(StudentName)
    BEGIN
        PRINT '>> WARNING: StudentName updated. Audit entry generated for verification.';
    END;
END;
GO

-- 2.3 Create DML INSTEAD OF Trigger (Prevent Unrestricted Updates)
IF OBJECT_ID('dbo.trg_StudentInfo_PreventDirectUpdate', 'TR') IS NOT NULL DROP TRIGGER dbo.trg_StudentInfo_PreventDirectUpdate;
GO

CREATE TRIGGER trg_StudentInfo_PreventDirectUpdate
ON dbo.StudentInfo
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Restrict direct updates unless specific business condition is met
    PRINT '>> ACCESS RESTRICTED: Direct UPDATE bypassed. Routing through secure business logic layer.';
    
    -- Safe partial update simulation
    UPDATE s
    SET s.CourseName = i.CourseName,
        s.Status = i.Status
    FROM dbo.StudentInfo s
    INNER JOIN INSERTED i ON s.StudentID = i.StudentID;
END;
GO

-- 2.4 Test DML Execution
UPDATE dbo.StudentInfo 
SET StudentName = 'Arpit Bangre', CourseName = 'Advanced DE & Cloud'
WHERE StudentID = 1;
GO

SELECT * FROM dbo.StudentInfo;
GO