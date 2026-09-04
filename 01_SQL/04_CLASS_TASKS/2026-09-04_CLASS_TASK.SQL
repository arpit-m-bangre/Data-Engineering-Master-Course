-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS TASKS & HOMEWORK
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 04 SEPTEMBER 2026 (Day 27)
-- 🎯 TOPIC: Stored Procedures (Deduplication), Views (Virtual vs Materialized) & Indexing Mechanics
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('dbo.StudentInfo', 'U') IS NOT NULL DROP TABLE dbo.StudentInfo;
IF OBJECT_ID('dbo.p11', 'U') IS NOT NULL DROP TABLE dbo.p11;
IF OBJECT_ID('dbo.p12', 'U') IS NOT NULL DROP TABLE dbo.p12;

CREATE TABLE dbo.StudentInfo
(
    roll_no   INT,
    name      VARCHAR(50),
    subject   VARCHAR(50),
    marks     INT,
    city      VARCHAR(50),
    mobile_no VARCHAR(15)
);

INSERT INTO dbo.StudentInfo (roll_no, name, subject, marks, city, mobile_no)
VALUES
(101, 'Arpit', 'SQL', 85, 'Nagpur', '9876543210'),
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'),
(103, 'Priya', 'SQL', 78, 'Pune', '9876543212'),
(101, 'Arpit', 'SQL', 85, 'Nagpur', '9876543210'), -- Duplicate 1
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'), -- Duplicate 1
(102, 'Rahul', 'Python', 90, 'Mumbai', '9876543211'), -- Duplicate 2
(104, 'Sneha', 'Java', 88, 'Delhi', '9876543213');

-- ====================================================================================================
-- 📝 IN-CLASS TASKS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: CREATE STORED PROCEDURE TO RETRIEVE DUPLICATE STUDENT RECORDS
-- Description: Write a stored procedure named `usp_FindDuplicateStudents` that uses a CTE and
-- ROW_NUMBER() partitioned by all student attributes to return all duplicate rows (row_occurrence > 1).
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- TASK 2: EXECUTE AND ALTER STORED PROCEDURE FOR MULTI-DUPLICATES
-- Description: Execute `usp_FindDuplicateStudents`. Then, modify (ALTER) the procedure so that it only
-- returns records that appear 3 or more times (row_occurrence > 2), and execute it again.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- TASK 3: CREATE VIRTUAL VIEW WITH CONDITIONAL STATUS
-- Description: Create a view named `vw_StudentStatus` that selects all student columns and adds a computed
-- column `status`: 'high' when marks > 250, otherwise 'low'. Query the view to verify output.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- TASK 4: ALTER VIEW TO HANDLE NULL MARKS
-- Description: Alter `vw_StudentStatus` so that it returns 'high' when marks > 250, 'a' when marks IS NULL,
-- and 'low' otherwise. Query the altered view.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- TASK 5: CREATE NON-CLUSTERED INDEX & AUDIT VIA SP_HELPINDEX
-- Description: Create a non-clustered index named `idx_StudentInfo_Marks` on `StudentInfo(marks)`.
-- Then, execute the system procedure `sp_helpindex` on `dbo.StudentInfo` to inspect the created index.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- TASK 6: CLUSTERED INDEX PHYSICAL SORTING ON HEAP VS PRIMARY KEY TABLE
-- Description: 
-- 1. Create table `p11` with column `id INT PRIMARY KEY` and insert (2), (4), (3), (1).
-- 2. Create table `p12` with column `id INT` (heap) and insert (2), (4), (3), (1).
-- 3. Query both tables and compare row order.
-- 4. Apply a clustered index named `cdx_p12_id` on `p12(id)` and query `p12` again to observe physical reorganization.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ====================================================================================================
