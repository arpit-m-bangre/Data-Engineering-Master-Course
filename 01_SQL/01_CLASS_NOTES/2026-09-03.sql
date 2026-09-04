/* ====================================================================================================
   🎓 SQL CLASS NOTES - 03 SEPTEMBER 2026 (DAY 26)
   🏢 MODULE 01: SQL Relational Architecture & Query Engine
   🎯 TOPIC: Transaction Control (TCL), NULL Functions (ISNULL, COALESCE) & Subqueries vs CTEs
   ==================================================================================================== */

-- ====================================================================================================
-- ⚙️ SECTION 1: SETUP DEMO TABLES & SEED DATA
-- ====================================================================================================

IF OBJECT_ID('StudentDummy', 'U') IS NOT NULL DROP TABLE StudentDummy;
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
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

CREATE TABLE TableA (ID INT);
CREATE TABLE TableB (ID INT);

INSERT INTO TableA (ID) VALUES (1), (2), (3), (4);
INSERT INTO TableB (ID) VALUES (2), (4), (6);


-- ====================================================================================================
-- ⚙️ SECTION 2: TRANSACTION CONTROL LANGUAGE (TCL) & ROLLBACK MECHANICS
-- ====================================================================================================

/* Theory: By default, SQL Server runs in Autocommit mode (every statement commits automatically).
   To rollback DML or DDL, statements MUST be executed inside an explicit BEGIN TRANSACTION block. */

-- 1. Uncommitted DELETE without explicit transaction cannot be rolled back
-- DELETE FROM StudentDummy;
-- ROLLBACK; -- Error Msg 3903: The ROLLBACK TRANSACTION request has no corresponding BEGIN TRANSACTION.

-- 2. Explicit Transaction with ROLLBACK (Restores Data)
BEGIN TRANSACTION;
    DELETE FROM StudentDummy WHERE StudentName IS NULL;
    SELECT * FROM StudentDummy; -- Shows remaining records in transaction buffer
ROLLBACK;

SELECT * FROM StudentDummy; -- All 4 records intact after rollback

-- 3. Explicit Transaction with COMMIT (Permanently Saved)
BEGIN TRANSACTION;
    DELETE FROM StudentDummy WHERE StudentName IS NULL;
COMMIT;
-- ROLLBACK; -- Error Msg 3903: Cannot rollback after COMMIT has finalized the transaction.

-- 4. DDL Rollback in SQL Server (Unique Feature: DDL can be rolled back inside active transactions)
BEGIN TRANSACTION;
    DROP TABLE TableA;
    -- TableA is dropped in transaction state
ROLLBACK;

SELECT * FROM TableA; -- TableA still exists on disk because DROP was rolled back


-- ====================================================================================================
-- ⚙️ SECTION 3: NULL HANDLING & REPLACEMENT (ISNULL VS COALESCE)
-- ====================================================================================================

/* Theory: ISNULL(val, default) is a 2-parameter T-SQL specific function.
   COALESCE(v1, v2, ... vn) is an ANSI-SQL standard function returning the first non-null value. */

-- 5. Updating NULL values with Default Literal
UPDATE StudentDummy
SET StudentName = 'Unknown Student'
WHERE StudentName IS NULL;

-- 6. Dynamic NULL Substitution in SELECT queries via ISNULL
SELECT 
    StudentID,
    ISNULL(StudentName, 'No Info') AS StudentNameInfo,
    ISNULL(City, 'Unassigned City') AS CityInfo
FROM StudentDummy;

-- 7. Multi-Column Fallback via COALESCE
SELECT 
    StudentID,
    StudentName,
    City,
    COALESCE(StudentName, City, 'No Info Available') AS FirstAvailableInfo
FROM StudentDummy;


-- ====================================================================================================
-- ⚙️ SECTION 4: SUBQUERIES VS INDUSTRY-STANDARD CTEs & WINDOW FUNCTIONS
-- ====================================================================================================

/* Theory: Subqueries execute nested queries. In production, Correlated/Nested subqueries often cause 
   table scans and row-by-row re-evaluations. CTEs and Window Functions are preferred for speed and readability. */

-- 8. Subquery Approach: Finding 2nd Highest Marks (Scalar Subquery)
SELECT MAX(Marks) AS SecondHighestMarks_Subquery
FROM StudentInfo
WHERE Marks < (SELECT MAX(Marks) FROM StudentInfo);

-- 9. Production Best Practice: Finding 2nd Highest Marks via CTE & DENSE_RANK()
WITH RankedStudents AS
(
    SELECT 
        StudentID,
        FullName,
        Marks,
        DENSE_RANK() OVER (ORDER BY Marks DESC) AS RankOrder
    FROM StudentInfo
)
SELECT 
    StudentID,
    FullName,
    Marks AS SecondHighestMarks_CTE
FROM RankedStudents
WHERE RankOrder = 2;

-- 10. Subquery with IN Operator
SELECT ID 
FROM TableA 
WHERE ID IN (SELECT ID FROM TableB);

-- 11. Production Best Practice: Replacing IN Subquery with INNER JOIN
SELECT A.ID
FROM TableA A
INNER JOIN TableB B ON A.ID = B.ID;


-- ====================================================================================================
-- ⚙️ SECTION 5: ENTERPRISE ARCHITECTURE & INTERVIEW PLAYBOOK
-- ====================================================================================================

/* Theory: In Tier-1 Interviews:
   1. Subqueries are tested for knowledge, but candidates should explicitly provide CTE + Window Function solutions.
   2. Explicit Transactions protect data integrity in high-frequency ETL / Financial operations.
   3. ISNULL is faster for 2 arguments in SQL Server; COALESCE is standard across multi-cloud engines. */

/* Faculty Homework: see 04_CLASS_TASKS/2026-09-03_CLASS_TASK.SQL */