/* ====================================================================================================
   🎓 SQL CLASS NOTES - 02 SEPTEMBER 2026 (DAY 25)
   🏢 MODULE 01: SQL Relational Architecture & Query Engine
   🎯 TOPIC: T-SQL Server Functions — LEFT, RIGHT, TRIM, CONVERT/CAST, BIGINT & Dynamic String Parsing
   ==================================================================================================== */

-- ====================================================================================================
-- ⚙️ SECTION 1: SETUP DEMO TABLES & SEED DATA
-- ====================================================================================================

IF OBJECT_ID('EmployeeDirectory', 'U') IS NOT NULL DROP TABLE EmployeeDirectory;
IF OBJECT_ID('TransactionStaging', 'U') IS NOT NULL DROP TABLE TransactionStaging;

CREATE TABLE EmployeeDirectory
(
    EmpID       INT IDENTITY(101,1) PRIMARY KEY,
    FullName    VARCHAR(100) NOT NULL,
    RawDeptCode VARCHAR(20)  NOT NULL,
    PaddedCity  VARCHAR(50)  NOT NULL,
    HireDate    DATETIME     NOT NULL DEFAULT GETDATE()
);

INSERT INTO EmployeeDirectory (FullName, RawDeptCode, PaddedCity, HireDate) VALUES
('Arpit Bangre',     'DE_TECH_2026', '	Pune		',       '2026-01-15 09:30:00'),
('Rohit Sharma',     'DS_ANLT_2025', '  Mumbai   ',     '2025-06-20 14:15:00'),
('Pooja Kulkarni',   'QA_AUTO_2024', '	Bangalore	',   '2024-11-10 11:45:00'),
('Amitabh Bachchan', 'LD_EXEC_2023', '   Hyderabad   ', '2023-03-01 10:00:00');

CREATE TABLE TransactionStaging
(
    TxnID       INT IDENTITY(1,1) PRIMARY KEY,
    TxnCode     VARCHAR(30) NOT NULL,
    AmountText  VARCHAR(20) NOT NULL
);

INSERT INTO TransactionStaging (TxnCode, AmountText) VALUES
('TXN-9081-IND', '1500'),
('TXN-4321-USA', '3200'),
('TXN-8821-EUR', '4800'),
('TXN-1092-GBP', '2100000000');


-- ====================================================================================================
-- ⚙️ SECTION 2: POSITIONAL STRING SLICING (LEFT & RIGHT)
-- ====================================================================================================

/* Theory: LEFT(str, n) extracts n characters from the left boundary.
   RIGHT(str, n) extracts n characters from the right boundary. */

-- 1. Fixed-Width Extraction from Raw Strings
SELECT 
    LEFT('ANHFHjfew', 4)  AS ExtractedPrefix,  -- Output: ANHF
    RIGHT('ANHFHjfew', 4) AS ExtractedSuffix;  -- Output: jfew

-- 2. Practical Table Column Slicing
SELECT 
    EmpID,
    RawDeptCode,
    LEFT(RawDeptCode, 2)  AS DeptPrefix,       -- Example: DE, DS, QA, LD
    RIGHT(RawDeptCode, 4) AS IntakeYear        -- Example: 2026, 2025, 2024
FROM EmployeeDirectory;


-- ====================================================================================================
-- ⚙️ SECTION 3: WHITESPACE SANITIZATION (TRIM, LTRIM, RTRIM)
-- ====================================================================================================

/* Theory: TRIM() removes leading and trailing spaces/tabs.
   LTRIM() strips leading spaces only; RTRIM() strips trailing spaces only. */

-- 3. Raw Padded String Inspection vs TRIM
SELECT 
    '	ABC		'         AS RawPaddedString,
    TRIM('	ABC		')    AS CleansedTrim,
    LTRIM('   ABC   ')    AS LeftStripped,
    RTRIM('   ABC   ')    AS RightStripped;

-- 4. Cleansing Table Records
SELECT 
    FullName,
    PaddedCity,
    LEN(PaddedCity)       AS RawLengthWithSpaces,
    TRIM(PaddedCity)      AS CleansedCity,
    LEN(TRIM(PaddedCity)) AS CleanLength
FROM EmployeeDirectory;


-- ====================================================================================================
-- ⚙️ SECTION 4: TYPE CONVERSION & DATE FORMATTING (CAST & CONVERT)
-- ====================================================================================================

/* Theory: CAST() is ANSI-SQL standard: CAST(expression AS data_type).
   CONVERT() is T-SQL specific with Style codes: CONVERT(data_type, expression [, style]).
   Both perform temporary runtime transformations without mutating physical storage on disk.
   To permanently modify column types on disk, DDL ALTER TABLE ... ALTER COLUMN is required. */

-- 5. Dynamic Date Formatting Styles
SELECT 
    GETDATE()                                AS CurrentSystemDate,
    CONVERT(VARCHAR, GETDATE())              AS DefaultStyleDate,  -- mon dd yyyy hh:miAM/PM
    CONVERT(VARCHAR, GETDATE(), 1)           AS US_Style_1,        -- mm/dd/yy
    CONVERT(VARCHAR, GETDATE(), 101)         AS US_Style_101,      -- mm/dd/yyyy
    CONVERT(VARCHAR, GETDATE(), 103)         AS British_Style_103, -- dd/mm/yyyy
    CONVERT(VARCHAR, GETDATE(), 112)         AS ISO_Style_112,     -- yyyymmdd
    CONVERT(VARCHAR, GETDATE(), 120)         AS ODBC_Style_120;    -- yyyy-mm-dd hh:mi:ss

-- 6. Runtime Casting in Aggregations & BIGINT Overflow Protection
/* Theory: When aggregating large sums, converting to BIGINT prevents arithmetic overflow (Msg 8115). */
SELECT 
    SUM(CAST(AmountText AS BIGINT))        AS TotalAmountViaCast,
    SUM(CONVERT(BIGINT, AmountText))       AS TotalAmountViaConvert
FROM TransactionStaging;


-- ====================================================================================================
-- ⚙️ SECTION 5: PATTERN LOCATION & DYNAMIC STRING PARSING (CHARINDEX)
-- ====================================================================================================

/* Theory: CHARINDEX(find_text, target_str [, start_pos]) returns 1-based index of substring.
   Returns 0 if the pattern is not found. */

-- 7. Locating Space Delimiters
SELECT 
    FullName,
    CHARINDEX(' ', FullName) AS SpacePosition
FROM EmployeeDirectory;

-- 8. Dynamic Full Name Separation into First Name and Second Name (Homework Drill)
SELECT 
    FullName,
    -- Extract First Name from index 1 up to (space - 1)
    LEFT(FullName, CHARINDEX(' ', FullName) - 1) AS FirstName,
    
    -- Extract Second Name from (space + 1) to the end using SUBSTRING
    SUBSTRING(FullName, CHARINDEX(' ', FullName) + 1, LEN(FullName)) AS SecondName_Method1,
    
    -- Extract Second Name using RIGHT and total length subtraction
    RIGHT(FullName, LEN(FullName) - CHARINDEX(' ', FullName)) AS SecondName_Method2
FROM EmployeeDirectory;


-- ====================================================================================================
-- ⚙️ SECTION 6: ENTERPRISE ARCHITECTURE PERSPECTIVE (INTERVIEW PLAYBOOK)
-- ====================================================================================================

/* Theory: In Tier-1 technical interviews:
   1. Prefer Window Functions / Joins over Correlated Subqueries for performance and optimizer pushdown.
   2. Core evaluation stack: Clauses, Date Functions, Joins, Window Functions, CASE, Server Functions, ISNULL.
   3. Upcoming Core Objects Roadmap: Stored Procedures, Views, Triggers, Indexes. */

/* Faculty Homework: see 04_CLASS_TASKS/2026-09-02_CLASS_TASK.SQL */