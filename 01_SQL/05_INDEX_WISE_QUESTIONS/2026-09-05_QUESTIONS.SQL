-- ====================================================================================
-- DAY 28: 14 TARGETED PRACTICE QUESTIONS — DATABASE & DML TRIGGERS
-- Date: 05 September 2026 | Module: 01_SQL
-- ====================================================================================

USE DataEngineeringMasterDB;
GO

-- ------------------------------------------------------------------------------------
-- PHASE 0: ENVIRONMENT SETUP & SCHEMA TABLES
-- ------------------------------------------------------------------------------------
IF OBJECT_ID('dbo.TriggerPractice_Employees', 'U') IS NOT NULL DROP TABLE dbo.TriggerPractice_Employees;
IF OBJECT_ID('dbo.TriggerPractice_Audit', 'U') IS NOT NULL DROP TABLE dbo.TriggerPractice_Audit;
IF OBJECT_ID('dbo.TriggerPractice_Salaries', 'U') IS NOT NULL DROP TABLE dbo.TriggerPractice_Salaries;
GO

CREATE TABLE dbo.TriggerPractice_Employees (
    EmpID INT PRIMARY KEY IDENTITY(1,1),
    EmpName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(12,2) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.TriggerPractice_Audit (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName VARCHAR(50),
    OperationType VARCHAR(20),
    RecordID INT,
    OldSalary DECIMAL(12,2),
    NewSalary DECIMAL(12,2),
    ExecutedBy VARCHAR(50) DEFAULT SYSTEM_USER,
    LogTimestamp DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE dbo.TriggerPractice_Salaries (
    SalaryID INT PRIMARY KEY IDENTITY(1,1),
    EmpID INT NOT NULL,
    MonthlyAmount DECIMAL(12,2) NOT NULL
);
GO

INSERT INTO dbo.TriggerPractice_Employees (EmpName, Department, Salary)
VALUES ('Arpit Bangre', 'Data Platform', 125000.00),
       ('Siddharth Rao', 'Cloud Engineering', 95000.00),
       ('Ananya Sen', 'Data Science', 110000.00),
       ('Rahul Verma', 'DevOps', 85000.00);
GO


-- ------------------------------------------------------------------------------------
-- QUESTION 01: DDL Database-Scoped Trigger for Table Creation
-- Task: Create a DDL trigger `trg_DDL_LockTableCreation` on DATABASE that prints
-- 'Table creation is restricted in this database' and rolls back any CREATE_TABLE event.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 02: DDL Trigger for Schema Modifications
-- Task: Create a DDL trigger `trg_DDL_LockAlter` on DATABASE that blocks ALTER_TABLE
-- events on all tables and prints an explicit security warning.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 03: Querying DDL Trigger Metadata
-- Task: Write a query against `sys.triggers` to list all database-scoped DDL triggers,
-- showing trigger name, create date, and whether it is enabled (`is_disabled`).
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 04: Disabling & Enabling DDL Triggers
-- Task: Write statements to disable `trg_DDL_LockTableCreation`, verify via metadata,
-- and then re-enable it.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 05: Dropping Database-Scoped DDL Trigger
-- Task: Write the correct command to drop `trg_DDL_LockTableCreation` from the database.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 06: Basic DML AFTER INSERT Trigger
-- Task: Create an AFTER INSERT trigger `trg_Emp_InsertLog` on `dbo.TriggerPractice_Employees`
-- that inserts an audit record into `dbo.TriggerPractice_Audit` whenever new rows are inserted.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 07: DML AFTER UPDATE Trigger with Magic Tables
-- Task: Create an AFTER UPDATE trigger `trg_Emp_SalaryChangeAudit` on `dbo.TriggerPractice_Employees`
-- that records old and new salary values into `dbo.TriggerPractice_Audit` only when `Salary` changes.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 08: Multi-Row Safe Trigger Design
-- Task: Explain and demonstrate why an AFTER UPDATE trigger must join `INSERTED` and `DELETED`
-- on `EmpID` rather than using scalar subqueries `(SELECT Salary FROM INSERTED)`.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 09: DML AFTER DELETE Trigger for Tombstone Logging
-- Task: Create an AFTER DELETE trigger `trg_Emp_DeleteLog` that captures deleted employee
-- details from the `DELETED` virtual table and writes an audit row with OperationType = 'DELETE'.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 10: INSTEAD OF DELETE Trigger (Soft-Delete Pattern)
-- Task: Create an INSTEAD OF DELETE trigger on `dbo.TriggerPractice_Employees` that sets
-- `IsActive = 0` instead of physically deleting rows from the table.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 11: Business Logic Validation inside DML Trigger
-- Task: Create an AFTER UPDATE trigger that checks if any employee's updated salary exceeds
-- 200000. If so, raise an error using `RAISERROR` or `THROW` and rollback the transaction.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 12: Column Update Detection with IF UPDATE()
-- Task: Write a trigger on `dbo.TriggerPractice_Employees` that prints a notice only when
-- the `Department` column is modified.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 13: Disabling All Triggers on a Table for High-Speed Bulk Ingestion
-- Task: Write T-SQL commands to disable all triggers on `dbo.TriggerPractice_Employees`,
-- and write the command to re-enable them after ETL completion.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ------------------------------------------------------------------------------------
-- QUESTION 14: Inspecting Table Triggers via System Catalog
-- Task: Write a query joining `sys.triggers` and `sys.tables` to list all DML triggers
-- attached to tables in the `dbo` schema.
-- ------------------------------------------------------------------------------------
-- Write your SQL Query below:



