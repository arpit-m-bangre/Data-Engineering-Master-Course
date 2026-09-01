-- ====================================================================================================
-- 🎯 TOPIC PRACTICE QUESTIONS - 01 SEPTEMBER 2026 (DAY 24)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: T-SQL Server Functions — String Transformations, Slicing, Masking & Cleansing (14 DRILLS)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('AppUsers', 'U') IS NOT NULL DROP TABLE AppUsers;
IF OBJECT_ID('ProductSKUs', 'U') IS NOT NULL DROP TABLE ProductSKUs;
IF OBJECT_ID('PaymentCards', 'U') IS NOT NULL DROP TABLE PaymentCards;
IF OBJECT_ID('LogMessages', 'U') IS NOT NULL DROP TABLE LogMessages;

CREATE TABLE AppUsers
(
    UserID      INT IDENTITY(1,1) PRIMARY KEY,
    FirstName   VARCHAR(50) NOT NULL,
    LastName    VARCHAR(50) NOT NULL,
    Email       VARCHAR(100) NOT NULL,
    City        VARCHAR(50) NOT NULL
);

INSERT INTO AppUsers (FirstName, LastName, Email, City) VALUES
('arpit',    'bangre', 'arpit.bangre@enterprise.io', 'nagpur'),
('rohan',    'sharma', 'rohan.sharma@cloudtech.com', 'pune'),
('kavita',   'iyer',   'kavita.iyer@analytics.org',  'bengaluru'),
('deepak',   'verma',  'deepak.verma@fintech.net',   'mumbai'),
('pooja',    'nair',   'pooja.nair@datasystems.in',  'hyderabad');

CREATE TABLE ProductSKUs
(
    SKUID       INT IDENTITY(101,1) PRIMARY KEY,
    RawCode     VARCHAR(50) NOT NULL,
    Category    VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NOT NULL
);

INSERT INTO ProductSKUs (RawCode, Category, Description) VALUES
('LAP-DELL-XPS15-2026', 'Hardware', 'High performance engineering workstation laptop'),
('MOU-LOGI-MX3S-2025',  'Peripheral','Ergonomic wireless precision mouse'),
('KEY-KEYCH-K2V2-2026', 'Peripheral','Mechanical tactile keyboard with RGB backlight'),
('MON-LG-34WN80C-2025', 'Hardware', 'UltraWide curved IPS monitor for multitasking'),
('SRV-DELL-R750-2026',  'DataCenter','Enterprise rack server for database clustering');

CREATE TABLE PaymentCards
(
    CardID      INT IDENTITY(1,1) PRIMARY KEY,
    HolderName  VARCHAR(50) NOT NULL,
    CardNumber  VARCHAR(20) NOT NULL,
    ExpiryMMYY  VARCHAR(10) NOT NULL
);

INSERT INTO PaymentCards (HolderName, CardNumber, ExpiryMMYY) VALUES
('Arpit M Bangre',  '4532789012345678', '08/29'),
('Rohan Sharma',    '5412751234567890', '11/28'),
('Kavita Iyer',     '378282246310005',  '03/27'),
('Deepak Verma',    '6011000990139424', '12/30'),
('Pooja Nair',      '3528001234567890', '07/26');

CREATE TABLE LogMessages
(
    LogID        INT IDENTITY(1,1) PRIMARY KEY,
    RawPayload   VARCHAR(200) NOT NULL,
    SeverityCode VARCHAR(20) NOT NULL
);

INSERT INTO LogMessages (RawPayload, SeverityCode) VALUES
('ERROR:DB_CONNECTION_TIMEOUT:Host=db-primary-01:Port=1433', 'CRITICAL'),
('WARN:HIGH_MEMORY_USAGE:Process=sqlservr:Threshold=85%',    'WARNING'),
('INFO:JOB_COMPLETED_SUCCESSFULLY:JobName=ETL_Nightly_Sync', 'INFO'),
('ERROR:DEADLOCK_DETECTED:Victim=Txn_9821:Resource=Orders',  'CRITICAL'),
('DEBUG:CACHE_HIT_RATIO:Buffer=99.2%:Engine=InMemOLTP',      'DEBUG');


-- ====================================================================================================
-- 📝 PHASE 1: TARGETED DRILLS (EXACTLY 14 QUESTIONS)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- QUESTION 1: BASIC CASE NORMALIZATION
-- Scenario: Return all AppUsers with their FirstName converted to UPPERCASE and LastName to LOWERCASE.
-- Expected Output: UserID, UpperFirstName, LowerLastName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 2: MEASURING FULL NAME STRING LENGTH
-- Scenario: Calculate the total character length of the combined full name (FirstName + space + LastName).
-- Expected Output: UserID, FullName, TotalLength
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 3: STRING REVERSAL FOR AUDITING
-- Scenario: Return each user's Email address along with its mirror reversed representation.
-- Expected Output: UserID, Email, ReversedEmail
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 4: DOMAIN NAME EXTRACTION VIA SUBSTRING & CHARINDEX
-- Scenario: Extract only the domain part (everything after '@') from each user's email address.
-- Expected Output: UserID, Email, DomainName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 5: SUBSTRING EXTRACTION FOR PRODUCT CATEGORY PREFIX
-- Scenario: Extract the first 3 characters from RawCode in ProductSKUs (e.g. 'LAP', 'MOU').
-- Expected Output: SKUID, RawCode, SKU_Prefix
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 6: EXTRACTING YEAR FROM END OF SKU CODE
-- Scenario: Extract the 4-digit release year located at the end of each RawCode string.
-- Expected Output: SKUID, RawCode, ReleaseYear
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 7: STRING REPLACEMENT FOR URL SLUG CREATION
-- Scenario: In ProductSKUs, replace all hyphens '-' in RawCode with underscores '_'.
-- Expected Output: SKUID, RawCode, CleanedSlug
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 8: REPLICATE & PADDING FOR SYSTEM FORMATTING
-- Scenario: Format UserID as a fixed 6-character string padded with leading zeros (e.g. UserID 1 -> '000001').
-- Expected Output: UserID, FormattedPaddedID
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 9: PAYMENT CARD PII MASKING (KEEP FIRST 4 & LAST 4)
-- Scenario: In PaymentCards, mask CardNumber showing only the first 4 and last 4 digits (e.g. '4532********5678').
-- Expected Output: CardID, HolderName, MaskedCardNumber
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 10: DYNAMIC CORPORATE EMAIL GENERATION VIA CONCAT
-- Scenario: Generate a standardized corporate email for AppUsers in format: 'firstletterOfFirstName.lastname@company.com'.
-- Expected Output: UserID, FirstName, LastName, CorporateEmail
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 11: EXTRACTING SEVERITY TAG FROM LOG MESSAGES
-- Scenario: Extract the text before the first colon ':' in RawPayload from LogMessages (e.g. 'ERROR', 'WARN', 'INFO').
-- Expected Output: LogID, RawPayload, ExtractedSeverity
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 12: COUNTING DELIMITERS IN LOG PAYLOAD
-- Scenario: Calculate how many colon ':' delimiters exist in each record of RawPayload in LogMessages.
-- Expected Output: LogID, RawPayload, ColonCount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 13: TITLE CASING ON CITIES (FIRST LETTER UPPER, REST LOWER)
-- Scenario: Format the City column in AppUsers to proper Title Case (e.g. 'nagpur' -> 'Nagpur').
-- Expected Output: UserID, RawCity, FormattedCity
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- QUESTION 14: MULTI-FUNCTION PASSWORD GENERATOR
-- Scenario: Generate a temporary secure password for AppUsers:
--           First 2 chars of FirstName (UPPER) + Last 2 chars of LastName (LOWER) + '@' + LEN(Email).
-- Expected Output: UserID, FirstName, LastName, Email, TemporaryPassword
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




