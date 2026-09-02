-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS TASKS & HOMEWORK
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 02 SEPTEMBER 2026 (Day 25)
-- 🎯 TOPIC: T-SQL Server Functions Part 2 — Full Name Parser, Whitespace Cleansing & Type Casting
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('CustomerRoster', 'U') IS NOT NULL DROP TABLE CustomerRoster;
IF OBJECT_ID('DirtyAddressBook', 'U') IS NOT NULL DROP TABLE DirtyAddressBook;
IF OBJECT_ID('StagingInvoices', 'U') IS NOT NULL DROP TABLE StagingInvoices;
IF OBJECT_ID('SystemTelemetry', 'U') IS NOT NULL DROP TABLE SystemTelemetry;

-- 1. Table: CustomerRoster (For Full Name Separation Homework)
CREATE TABLE CustomerRoster
(
    CustomerID   INT IDENTITY(101,1) PRIMARY KEY,
    FullName     VARCHAR(100) NOT NULL
);

INSERT INTO CustomerRoster (FullName) VALUES
('Arpit Bangre'),
('Rohit Sharma'),
('Pooja Kulkarni'),
('Amitabh Bachchan'),
('Sachin Tendulkar');

-- 2. Table: DirtyAddressBook (For Whitespace & Tab Cleansing)
CREATE TABLE DirtyAddressBook
(
    AddressID    INT IDENTITY(1,1) PRIMARY KEY,
    ContactName  VARCHAR(50)  NOT NULL,
    RawCity      VARCHAR(50)  NOT NULL
);

INSERT INTO DirtyAddressBook (ContactName, RawCity) VALUES
('Arpit Bangre',     '	Pune		'),
('Rohit Sharma',     '   Mumbai   '),
('Pooja Kulkarni',   '	Bangalore	'),
('Deepak Verma',     '   Hyderabad   '),
('Neha Singh',       '	Delhi		');

-- 3. Table: StagingInvoices (For Runtime Casting & Summation)
CREATE TABLE StagingInvoices
(
    InvoiceID    INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceCode  VARCHAR(30)  NOT NULL,
    AmountString VARCHAR(20)  NOT NULL,
    PaymentDate  DATETIME     NOT NULL
);

INSERT INTO StagingInvoices (InvoiceCode, AmountString, PaymentDate) VALUES
('INV-9081', '2500', '2026-01-15 08:30:00'),
('INV-4321', '4200', '2026-03-20 14:15:00'),
('INV-8821', '6800', '2026-06-10 11:45:00'),
('INV-1092', '1900', '2026-08-05 16:00:00'),
('INV-7734', '5100', '2026-09-02 10:00:00');

-- 4. Table: SystemTelemetry (For Fixed-Width Boundary Slicing)
CREATE TABLE SystemTelemetry
(
    LogID        INT IDENTITY(1,1) PRIMARY KEY,
    SensorCode   VARCHAR(50)  NOT NULL
);

INSERT INTO SystemTelemetry (SensorCode) VALUES
('ANHFHjfew'),
('PROD_IOT_2026_US'),
('TEMP_SN10928_EU'),
('EDGE_GATEWAY_APAC');


-- ====================================================================================================
-- 📝 PHASE 1: IN-CLASS TASKS & HOMEWORK ASSIGNMENTS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: FACULTY HOMEWORK — FULL NAME SEPARATION (FIRST NAME & LAST NAME VIA SUBSTRING)
-- Scenario: From CustomerRoster, dynamically split FullName into FirstName and SecondName (LastName).
--           Locate the space delimiter using CHARINDEX. Extract FirstName using LEFT, and SecondName
--           using SUBSTRING.
-- Expected Output: CustomerID, FullName, FirstName, SecondName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 2: FULL NAME SEPARATION VIA RIGHT() AND LENGTH COMPUTATION
-- Scenario: Achieve the exact same separation of FullName into FirstName and SecondName, but extract
--           SecondName using RIGHT() combined with LEN() and CHARINDEX().
-- Expected Output: CustomerID, FullName, FirstName, SecondName
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 3: TAB & WHITESPACE SANITIZATION ENGINE (TRIM, LTRIM, RTRIM)
-- Scenario: In DirtyAddressBook, display ContactName, RawCity, the character length of RawCity,
--           the cleansed city using TRIM(), and the new cleansed character length. Also display
--           columns demonstrating LTRIM() and RTRIM() behavior.
-- Expected Output: AddressID, ContactName, RawCity, RawLen, CleanCity, CleanLen, LeftStripped, RightStripped
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 4: WAREHOUSE DATE STANDARDIZATION ENGINE (CONVERT STYLES)
-- Scenario: For each record in StagingInvoices, project PaymentDate in five standardized formats:
--           1. Default System Format
--           2. US Standard (mm/dd/yy - Style 1 and mm/dd/yyyy - Style 101)
--           3. British/Indian Standard (dd/mm/yyyy - Style 103)
--           4. ISO Warehouse Integer Key format (yyyymmdd - Style 112)
--           5. ODBC Canonical Timestamp (yyyy-mm-dd hh:mi:ss - Style 120)
-- Expected Output: InvoiceID, InvoiceCode, US_Short, US_Full, British_Full, ISO_Key, ODBC_Standard
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 5: STAGING DATA TYPE CONVERSION & AGGREGATION
-- Scenario: The finance department requires total revenue from StagingInvoices.
--           Compute the total sum of AmountString using both CAST() and CONVERT() to INT.
--           Also calculate the average invoice amount converted to DECIMAL(10,2).
-- Expected Output: TotalRevenue_Cast, TotalRevenue_Convert, AvgInvoiceAmount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




