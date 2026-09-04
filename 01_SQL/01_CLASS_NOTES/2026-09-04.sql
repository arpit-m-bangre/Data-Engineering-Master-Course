-- ==============================================================================
-- 📅 CLASS DATE: 04 SEP 2026 (DAY 27)
-- 🎯 TOPIC: STORED PROCEDURES (DEDUPLICATION), VIEWS & INDEXING ARCHITECTURE
-- 🏢 MODULE: 01_SQL (ENTERPRISE DATABASE ARCHITECTURE & QUERY ENGINE)
-- 🧑‍🏫 FACULTY HOMEWORK: see 04_CLASS_TASKS/2026-09-04_CLASS_TASK.SQL
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. SETUP ENVIRONMENT & SAMPLE DATASET WITH DUPLICATES
-- ------------------------------------------------------------------------------
IF OBJECT_ID('dbo.StudentInfo', 'U') IS NOT NULL
    DROP TABLE dbo.StudentInfo;
GO

CREATE TABLE dbo.StudentInfo
(
    roll_no   INT,
    name      VARCHAR(50),
    subject   VARCHAR(50),
    marks     INT,
    city      VARCHAR(50),
    mobile_no VARCHAR(15)
);
GO

INSERT INTO dbo.StudentInfo (roll_no, name, subject, marks, city, mobile_no)
VALUES
(101, 'Arpit', 'SQL', 85, 'Nagpur', '9876543210'),
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'),
(103, 'Priya', 'SQL', 78, 'Pune', '9876543212'),
-- Duplicate 1 of Roll No 101
(101, 'Arpit', 'SQL', 85, 'Nagpur', '9876543210'),
-- Duplicate 1 and 2 of Roll No 102
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'),
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'),
(104, 'Sneha', 'Java', 88, 'Delhi', '9876543213');
GO

-- ------------------------------------------------------------------------------
-- 2. STORED PROCEDURE: FIND DUPLICATE RECORDS USING CTE & ROW_NUMBER()
-- ------------------------------------------------------------------------------
-- Theory: Stored Procedures encapsulate pre-compiled execution plans on server.
IF OBJECT_ID('dbo.usp_FindDuplicates', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_FindDuplicates;
GO

CREATE PROCEDURE dbo.usp_FindDuplicates
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH CTE_Duplicates AS
    (
        SELECT roll_no, name, subject, marks, city, mobile_no,
               ROW_NUMBER() OVER
               (
                   PARTITION BY roll_no, name, subject, marks, city, mobile_no
                   ORDER BY roll_no
               ) AS row_occurrence
        FROM dbo.StudentInfo
    )
    SELECT roll_no, name, subject, marks, city, mobile_no, row_occurrence
    FROM CTE_Duplicates
    WHERE row_occurrence > 1;
END;
GO

-- Execute Procedure
EXECUTE dbo.usp_FindDuplicates;
GO

-- ------------------------------------------------------------------------------
-- 3. MODIFY STORED PROCEDURE (ALTER PROCEDURE)
-- ------------------------------------------------------------------------------
-- Theory: ALTER PROCEDURE updates object definition while preserving server permissions.
ALTER PROCEDURE dbo.usp_FindDuplicates
AS
BEGIN
    SET NOCOUNT ON;
    
    WITH CTE_Duplicates AS
    (
        SELECT roll_no, name, subject, marks, city, mobile_no,
               ROW_NUMBER() OVER
               (
                   PARTITION BY roll_no, name, subject, marks, city, mobile_no
                   ORDER BY roll_no
               ) AS row_occurrence
        FROM dbo.StudentInfo
    )
    SELECT roll_no, name, subject, marks, city, mobile_no, row_occurrence
    FROM CTE_Duplicates
    WHERE row_occurrence > 2; -- Filter records appearing 3+ times
END;
GO

-- Execute Altered Procedure
EXECUTE dbo.usp_FindDuplicates;
GO

-- ------------------------------------------------------------------------------
-- 4. VIEWS: VIRTUAL TABLES & LOGICAL ABSTRACTIONS
-- ------------------------------------------------------------------------------
-- Theory: Views store saved SQL queries (virtual table schema), not physical rows.
IF OBJECT_ID('dbo.vw_StudentPerformance', 'V') IS NOT NULL
    DROP VIEW dbo.vw_StudentPerformance;
GO

CREATE VIEW dbo.vw_StudentPerformance
AS
SELECT roll_no, name, subject, marks, city, mobile_no,
       CASE 
           WHEN marks > 250 THEN 'high'
           ELSE 'low'
       END AS status
FROM dbo.StudentInfo;
GO

-- Query the Virtual View
SELECT * FROM dbo.vw_StudentPerformance;
GO

-- Modify View Definition using ALTER VIEW
ALTER VIEW dbo.vw_StudentPerformance
AS
SELECT roll_no, name, subject, marks, city, mobile_no,
       CASE 
           WHEN marks > 250 THEN 'high'
           WHEN marks IS NULL THEN 'a'
           ELSE 'low'
       END AS status
FROM dbo.StudentInfo;
GO

SELECT * FROM dbo.vw_StudentPerformance;
GO

-- ------------------------------------------------------------------------------
-- 5. INDEXING ARCHITECTURE: NON-CLUSTERED & CLUSTERED INDEXES
-- ------------------------------------------------------------------------------
-- Create Non-Clustered Index on StudentInfo (marks)
CREATE NONCLUSTERED INDEX idx_StudentInfo_Marks
ON dbo.StudentInfo (marks);
GO

-- Inspect Indexes using System Stored Procedure
EXECUTE sp_helpindex 'dbo.StudentInfo';
GO

-- ------------------------------------------------------------------------------
-- 6. CLUSTERED INDEX PHYSICAL SORTING MECHANICS (PK VS HEAP TABLE)
-- ------------------------------------------------------------------------------
-- Table 1: Primary Key automatically applies a Clustered Index (B-Tree Data Pages Sorted)
IF OBJECT_ID('dbo.p11', 'U') IS NOT NULL DROP TABLE dbo.p11;
CREATE TABLE dbo.p11 (id INT PRIMARY KEY);
INSERT INTO dbo.p11 VALUES (2), (4), (3), (1);

-- Table 2: Heap Table (No Primary Key, Unsorted Physical Allocation)
IF OBJECT_ID('dbo.p12', 'U') IS NOT NULL DROP TABLE dbo.p12;
CREATE TABLE dbo.p12 (id INT);
INSERT INTO dbo.p12 VALUES (2), (4), (3), (1);

-- Verification: p11 returns sorted physically (1,2,3,4), p12 returns insertion order (2,4,3,1)
SELECT * FROM dbo.p11;
SELECT * FROM dbo.p12;
GO

-- Apply Explicit Clustered Index on Heap Table p12
CREATE CLUSTERED INDEX cdx_p12_id
ON dbo.p12 (id);
GO

-- Verification: p12 is now physically re-ordered on leaf data pages (1,2,3,4)
SELECT * FROM dbo.p12;
GO