-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS TASKS & HOMEWORK
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 01 SEPTEMBER 2026 (Day 24)
-- 🎯 TOPIC: T-SQL Server Functions — String Masking, Slicing, Title Casing & Character Analytics
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('UserProfiles', 'U') IS NOT NULL DROP TABLE UserProfiles;
IF OBJECT_ID('CustomerContacts', 'U') IS NOT NULL DROP TABLE CustomerContacts;
IF OBJECT_ID('RawTextStrings', 'U') IS NOT NULL DROP TABLE RawTextStrings;
IF OBJECT_ID('PayloadLogs', 'U') IS NOT NULL DROP TABLE PayloadLogs;

-- 1. Table: UserProfiles (For Title Casing / Name Capitalization)
CREATE TABLE UserProfiles
(
    UserID   INT IDENTITY(1,1) PRIMARY KEY,
    RawName  VARCHAR(50) NOT NULL
);

INSERT INTO UserProfiles (RawName) VALUES
('arpit'),
('AMIT'),
('rOHAN'),
('kAVITA'),
('dEEPAK');

-- 2. Table: CustomerContacts (For Mobile PII Masking)
CREATE TABLE CustomerContacts
(
    CustomerID   INT IDENTITY(101,1) PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    MobileNo     VARCHAR(20) NOT NULL
);

INSERT INTO CustomerContacts (CustomerName, MobileNo) VALUES
('Arpit Bangre',  '73504545645'),
('Rohan Sharma',  '9823012345'),
('Kavita Iyer',   '8888776655'),
('Deepak Verma',  '9123456789'),
('Pooja Nair',    '9900112233');

-- 3. Table: RawTextStrings (For Middle Character Slicing)
CREATE TABLE RawTextStrings
(
    StringID   INT IDENTITY(1,1) PRIMARY KEY,
    Word       VARCHAR(50) NOT NULL
);

INSERT INTO RawTextStrings (Word) VALUES
('arpit'),       -- Length 5 -> Middle index 3 -> 'p'
('rohan'),       -- Length 5 -> Middle index 3 -> 'h'
('analytics'),   -- Length 9 -> Middle index 5 -> 'y'
('sqlserver'),   -- Length 9 -> Middle index 5 -> 'e'
('data');        -- Length 4 -> Middle index 2 -> 'a'

-- 4. Table: PayloadLogs (For Character Occurrence Analytics)
CREATE TABLE PayloadLogs
(
    LogID       INT IDENTITY(1,1) PRIMARY KEY,
    PayloadCode VARCHAR(50) NOT NULL
);

INSERT INTO PayloadLogs (PayloadCode) VALUES
('AETEYERE'),       -- Occurrences of 'E' = 3
('BANANA_SPLIT'),   -- Occurrences of 'A' = 3
('MISSISSIPPI'),    -- Occurrences of 'S' = 4, 'I' = 4
('ENTERPRISE_ETL'), -- Occurrences of 'E' = 4
('DATA_WAREHOUSE'); -- Occurrences of 'A' = 3


-- ====================================================================================================
-- 📝 PHASE 1: IN-CLASS TASKS & HOMEWORK ASSIGNMENTS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: TITLE CASING FORMATTER (FIRST CHARACTER CAPITAL, REMAINING SMALL)
-- Scenario: Transform the erratic names in UserProfiles such that the first letter is strictly UPPERCASE
--           and all subsequent characters are strictly LOWERCASE (e.g. 'arpit' -> 'Arpit', 'AMIT' -> 'Amit').
-- Expected Output: UserID, RawName, FormattedName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 2: MOBILE NUMBER PII MASKING (DYNAMIC MASKING WITH VISIBLE TAIL)
-- Scenario: For each contact in CustomerContacts, mask the mobile number by replacing all characters
--           except the last 3 digits with asterisks '*' (e.g. '73504545645' -> '********645').
-- Expected Output: CustomerID, CustomerName, MobileNo, MaskedMobileNo
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 3: DYNAMIC MIDDLE CHARACTER EXTRACTION
-- Scenario: Extract the exact middle character from each word in RawTextStrings using dynamic length formulas.
-- Expected Output: StringID, Word, WordLength, MiddleCharIndex, MiddleCharacter
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 4: CHARACTER OCCURRENCE FREQUENCY ANALYZER
-- Scenario: For each record in PayloadLogs, calculate the exact count of occurrences of the target letter 'E'
--           using the string length mathematical substitution formula without loops or cursors.
-- Expected Output: LogID, PayloadCode, TargetCharacter, OccurrenceCount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




