-- ====================================================================================================
-- 🎯 TOPIC PRACTICE QUESTIONS - 02 SEPTEMBER 2026 (DAY 25)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: T-SQL Server Functions Part 2 — LEFT, RIGHT, TRIM, CAST/CONVERT & Dynamic Parsing (14 DRILLS)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('DimCustomerAccounts', 'U') IS NOT NULL DROP TABLE DimCustomerAccounts;
IF OBJECT_ID('StagingFeed', 'U') IS NOT NULL DROP TABLE StagingFeed;
IF OBJECT_ID('WarehouseSales', 'U') IS NOT NULL DROP TABLE WarehouseSales;
IF OBJECT_ID('ServerEventLogs', 'U') IS NOT NULL DROP TABLE ServerEventLogs;

CREATE TABLE DimCustomerAccounts
(
    AccountID    INT IDENTITY(101,1) PRIMARY KEY,
    AccountCode  VARCHAR(30)  NOT NULL,
    FullName     VARCHAR(100) NOT NULL,
    EmailAddress VARCHAR(120) NOT NULL,
    PaddedRegion VARCHAR(50)  NOT NULL
);

INSERT INTO DimCustomerAccounts (AccountCode, FullName, EmailAddress, PaddedRegion) VALUES
('ACC-DE-9081', 'Arpit Bangre',     'arpit.bangre@enterprise.io', '	West-Pune		'),
('ACC-DS-4321', 'Rohit Sharma',     'rohit.sharma@analytics.com', '  North-Delhi   '),
('ACC-QA-8821', 'Pooja Kulkarni',   'pooja.k@qualityeng.net',     '	South-Bangalore	'),
('ACC-LD-1092', 'Amitabh Bachchan', 'amitabh.b@cinema.org',       '   West-Mumbai   '),
('ACC-EX-7734', 'Cher',             'cher@musiclegends.com',      '  East-Kolkata   ');

CREATE TABLE StagingFeed
(
    FeedID       INT IDENTITY(1,1) PRIMARY KEY,
    BatchTag     VARCHAR(50)  NOT NULL,
    RawAmount    VARCHAR(30)  NOT NULL,
    IngestDate   DATETIME     NOT NULL
);

INSERT INTO StagingFeed (BatchTag, RawAmount, IngestDate) VALUES
('BATCH_2026_09_A', '12500.50', '2026-01-15 08:30:45'),
('BATCH_2026_09_B', '8400.00',  '2026-03-22 14:15:10'),
('BATCH_2026_09_C', '19200.75', '2026-06-18 19:45:00'),
('BATCH_2026_09_D', '4300.25',  '2026-08-30 11:20:30'),
('BATCH_2026_09_E', '7100.00',  '2026-09-02 21:10:00');

CREATE TABLE WarehouseSales
(
    SaleID       INT IDENTITY(1001,1) PRIMARY KEY,
    ProductSKU   VARCHAR(40)  NOT NULL,
    SaleDate     DATETIME     NOT NULL DEFAULT GETDATE(),
    UnitsSold    VARCHAR(10)  NOT NULL
);

INSERT INTO WarehouseSales (ProductSKU, SaleDate, UnitsSold) VALUES
('PROD-MON-2026-X1', '2026-02-10 10:00:00', '15'),
('PROD-LAP-2025-Z9', '2026-04-15 12:30:00', '25'),
('PROD-KEY-2026-M4', '2026-07-20 16:45:00', '40'),
('PROD-MOU-2025-W2', '2026-08-25 09:15:00', '50');

CREATE TABLE ServerEventLogs
(
    EventID      INT IDENTITY(1,1) PRIMARY KEY,
    RawPayload   VARCHAR(150) NOT NULL
);

INSERT INTO ServerEventLogs (RawPayload) VALUES
('ERR:1001:DATABASE_TIMEOUT:SERVER_01'),
('WRN:2004:HIGH_LATENCY:SERVER_02'),
('INF:3005:BACKUP_SUCCESS:SERVER_03'),
('ERR:1002:DEADLOCK_VICTIM:SERVER_01');


-- ====================================================================================================
-- 📝 PHASE 1: TARGETED DRILLS (EXACTLY 14 QUESTIONS)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- QUESTION 1: PREFIX EXTRACTION WITH LEFT()
-- Scenario: From DimCustomerAccounts, extract the first 3 characters of AccountCode as PrefixCode.
-- Expected Output: AccountID, AccountCode, PrefixCode
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 2: SUFFIX EXTRACTION WITH RIGHT()
-- Scenario: From DimCustomerAccounts, extract the last 4 characters of AccountCode as AccountSequence.
-- Expected Output: AccountID, AccountCode, AccountSequence
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 3: WHITESPACE AUDIT AND CLEANSING WITH TRIM()
-- Scenario: For each customer in DimCustomerAccounts, display PaddedRegion, its raw length,
--           the cleansed region using TRIM(), and the length after cleansing.
-- Expected Output: AccountID, PaddedRegion, RawLength, CleansedRegion, CleanLength
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 4: ASYMMETRIC PADDING STRIPPING (LTRIM VS RTRIM)
-- Scenario: Using DimCustomerAccounts, demonstrate the difference between LTRIM() and RTRIM()
--           on PaddedRegion by projecting both side-by-side with their resulting string lengths.
-- Expected Output: AccountID, LeftCleaned, LeftCleanLen, RightCleaned, RightCleanLen
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 5: LOCATING PATTERN POSITIONS VIA CHARINDEX()
-- Scenario: In DimCustomerAccounts, find the 1-based character position of the '@' delimiter
--           inside EmailAddress.
-- Expected Output: AccountID, EmailAddress, AtSymbolPosition
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 6: EMAIL DOMAIN EXTRACTION VIA SUBSTRING & CHARINDEX
-- Scenario: Using DimCustomerAccounts, extract the email domain (everything after the '@' character)
--           using a combination of SUBSTRING, CHARINDEX, and LEN.
-- Expected Output: AccountID, EmailAddress, EmailDomain
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 7: USERNAME EXTRACTION VIA LEFT & CHARINDEX
-- Scenario: Using DimCustomerAccounts, extract the username portion of EmailAddress (everything before
--           the '@' character) using LEFT and CHARINDEX.
-- Expected Output: AccountID, EmailAddress, UserName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 8: FULL NAME SPLITTING — FIRST NAME EXTRACTION
-- Scenario: From DimCustomerAccounts, extract the First Name from FullName using LEFT() and CHARINDEX().
-- Expected Output: AccountID, FullName, FirstName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 9: FULL NAME SPLITTING — SECOND NAME VIA SUBSTRING()
-- Scenario: From DimCustomerAccounts, extract the Second Name (Last Name) from FullName using
--           SUBSTRING() and CHARINDEX().
-- Expected Output: AccountID, FullName, SecondName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 10: FULL NAME SPLITTING — SECOND NAME VIA RIGHT() & LEN()
-- Scenario: From DimCustomerAccounts, extract the Second Name (Last Name) from FullName using
--           RIGHT(), LEN(), and CHARINDEX().
-- Expected Output: AccountID, FullName, SecondName_Right
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 11: RESILIENT PARSING FOR SINGLE-WORD NAMES (BUG TRAP DEFENSE)
-- Scenario: In DimCustomerAccounts, row 105 has FullName = 'Cher' (no space delimiter).
--           Write a query using CASE and CHARINDEX that extracts FirstName and SecondName without
--           crashing or throwing Msg 537 (Invalid length parameter). If no space exists, FirstName
--           should be the full name and SecondName should be empty ''.
-- Expected Output: AccountID, FullName, SafeFirstName, SafeSecondName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 12: REGIONAL DATE FORMATTING VIA CONVERT()
-- Scenario: In StagingFeed, project IngestDate in both US format (mm/dd/yyyy - Style 101) and
--           British/Indian format (dd/mm/yyyy - Style 103).
-- Expected Output: FeedID, IngestDate, Date_US, Date_British
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 13: WAREHOUSE DIMENSION DATE KEY GENERATION
-- Scenario: Dimensional models require integer surrogate date keys in format YYYYMMDD (e.g. 20260115).
--           From StagingFeed, convert IngestDate into an INT date key using CONVERT Style 112 and CAST.
-- Expected Output: FeedID, IngestDate, DimDateKey
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 14: RUNTIME CASTING & FINANCIAL AGGREGATION
-- Scenario: In StagingFeed, RawAmount is stored as VARCHAR(30). Calculate the total sum of RawAmount
--           as DECIMAL(14,2) and the average amount as DECIMAL(14,2) using CAST() or CONVERT().
-- Expected Output: TotalStagingAmount, AverageStagingAmount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




