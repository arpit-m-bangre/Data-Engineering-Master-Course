/* ====================================================================
   🚀 10-HOUR SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 22)
   THE DEFINITIVE 22-DAY COMPREHENSIVE T-SQL REVISION & PRACTICE ENGINE
   Database: `BootcampMasteryDB` | Target: SSMS Direct Execution
   Author  : Pippo 🐥 | Candidate: Captain Arpit Manoj Bangre (Cap)
==================================================================== */

/*
====================================================================
           📑 MASTER TABLE OF CONTENTS & TOPIC INDEX
====================================================================
📦 SECTION 1: MASTER TESTBED DATABASE SETUP (`BootcampMasteryDB`)
   ├─ 1.1 Database Initialization & Safe Cleanup Protocol
   ├─ 1.2 Master Schema Creation (8 Core Relational Tables)
   │     • Departments (PK)
   │     • Employees (PK, FK, Self-Referencing Hierarchy)
   │     • Customers (PK)
   │     • Products (PK)
   │     • Orders (PK, FK)
   │     • OrderItems (IDENTITY PK, Dual FKs)
   │     • BankTransactions (Fraud & Velocity Sandbox)
   │     • StockMovements (Inventory & Running Totals)
   └─ 1.3 Master Production Seed Datasets (Multi-City Enterprise Data)

🏛️ SECTION 2: 22-DAY COMPLETE CURRICULUM DEEP-DIVE MODULES
   ├─ 🗓️ DAY 01: SQL Architecture, Commands Taxonomy & Table Creation
   ├─ 🗓️ DAY 02: Filtering Clauses, Operators, Wildcards & Information Schema
   ├─ 🗓️ DAY 03: Precision Pattern Matching, Ranges & Vowel/Digit Filters
   ├─ 🗓️ DAY 04: Numeric Types, Arithmetic, UPDATE, DELETE & Security
   ├─ 🗓️ DAY 05: The Deletion Battle (DELETE vs TRUNCATE vs DROP) & ALTER TABLE
   ├─ 🗓️ DAY 06: Aggregates (MIN/MAX/SUM/AVG/COUNT), DISTINCT & TOP N
   ├─ 🗓️ DAY 07: 6-Stage Execution Pipeline, GROUP BY, HAVING & ORDER BY
   ├─ 🗓️ DAY 08: Query Mistakes Analysis & Scoping Rules (Rows vs Groups)
   ├─ 🗓️ DAY 09: Core Constraints (PRIMARY KEY, UNIQUE, NOT NULL, CHECK)
   ├─ 🗓️ DAY 10: DEFAULT, IDENTITY & FOREIGN KEY Referential Architecture
   ├─ 🗓️ DAY 11: Parent Protection vs Child Table Destruction Rules
   ├─ 🗓️ DAY 12: 3-Step Live Constraint Retrofitting & TRUNCATE Rollback Proof
   ├─ 🗓️ DAY 13: Set Operators (UNION, UNION ALL, INTERSECT, EXCEPT)
   ├─ 🗓️ DAY 14: Temporal Engine, DATEDIFF, DATEADD, DATEPART & EOMONTH
   ├─ 🗓️ DAY 15: Joins Foundations, Cartesian Math (N x M) & 3VL Traps
   ├─ 🗓️ DAY 16: ANSI Relational Joins (INNER, LEFT, RIGHT, FULL) & Anti-Joins
   ├─ 🗓️ DAY 17: Multi-Table Ingestion Chains (3+ Tables) & CROSS JOIN Matrices
   ├─ 🗓️ DAY 18: Self-Joins, Manager Trees, CEO Shield & 5-Min Geo-Fraud
   ├─ 🗓️ DAY 19: Window Functions (ROW_NUMBER, RANK, DENSE_RANK) & Msg 4108
   ├─ 🗓️ DAY 20: Common Table Expressions (CTEs) & In-Place Deduplication
   ├─ 🗓️ DAY 21: Value Functions (LEAD/LAG), Stock Deltas & Running Totals
   └─ 🗓️ DAY 22: Conditional CASE Logic, Multi-Tiering & Dynamic Pinned Sort

🧠 SECTION 3: SYNTAX RECALL & MUSCLE MEMORY DRILLS
   ├─ Drill 1: 6-Stage Logical Query Execution Order
   ├─ Drill 2: 3-Step Constraint Retrofitting Template
   ├─ Drill 3: SARGable Temporal Date Range Template
   ├─ Drill 4: 3-Way Ranking Behavior Matrix
   ├─ Drill 5: Value Functions & Running Cumulative Syntax
   └─ Drill 6: Dynamic Pinned Sorting via Searched CASE

🧪 SECTION 4: 50 HIGH-LEVEL INTERVIEW CHALLENGES (SUPER 50)
   ├─ 🟢 Block 1: Foundation & Filtering (Q01 – Q10)
   ├─ 🟡 Block 2: GROUP BY, HAVING & Aggregations (Q11 – Q20)
   ├─ 🟠 Block 3: Relational Joins & Self-Joins (Q21 – Q30)
   ├─ 🔴 Block 4: Window Functions & Deduplication (Q31 – Q40)
   └─ 💀 Block 5: Analytical Boss & War Room (Q41 – Q50)

🏆 SECTION 5: FINAL BOSS CUSTOMER INTELLIGENCE VIEW (vw_EnterpriseCustomer360)
🧠 SECTION 6: TOP 20 WHITEBOARD INTERVIEW TRAPS CHEAT SHEET
🏁 SECTION 7: THE 13-STEP SQL PROBLEM-SOLVING ALGORITHM
====================================================================
*/

-- ====================================================================
-- 📦 SECTION 1: MASTER TESTBED DATABASE SETUP (`BootcampMasteryDB`)
-- ====================================================================

USE master;
GO

IF DB_ID('BootcampMasteryDB') IS NOT NULL
BEGIN
    ALTER DATABASE BootcampMasteryDB 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BootcampMasteryDB;
END;
GO

CREATE DATABASE BootcampMasteryDB;
GO

USE BootcampMasteryDB;
GO

-- 1. Departments Table
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

-- 2. Employees Table (Self-referencing hierarchy)
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    DeptID INT NOT NULL 
        FOREIGN KEY REFERENCES Departments(DeptID),
    ManagerID INT NULL,
    JoiningDate DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Email VARCHAR(100) NULL
);

-- 3. Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    RegistrationDate DATE NOT NULL,
    Email VARCHAR(100) NULL
);

-- 4. Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

-- 5. Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL 
        FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    DeliveryDate DATE NULL
);

-- 6. OrderItems Table
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL 
        FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT NOT NULL 
        FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- 7. BankTransactions Table (Fraud & Velocity Testing)
CREATE TABLE BankTransactions (
    TxnID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    TxnTimestamp DATETIME NOT NULL,
    TxnAmount DECIMAL(10,2) NOT NULL,
    TxnCity VARCHAR(50) NOT NULL,
    Channel VARCHAR(20) NOT NULL
);

-- 8. StockMovements Table (Inventory Windowing)
CREATE TABLE StockMovements (
    MovementID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    MovementDate DATE NOT NULL,
    QtyChange INT NOT NULL
);
GO

-- ====================================================================
-- 🌱 SEED MASTER DATASETS
-- ====================================================================

INSERT INTO Departments VALUES
(1, 'Engineering', 'Bengaluru'),
(2, 'Data Platform', 'Pune'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Delhi');

INSERT INTO Employees VALUES
(101, 'Aarav Sharma', 1, NULL, '2022-03-15', 180000.00, 'M', 'aarav@company.com'),
(102, 'Priya Patel', 1, 101, '2023-01-10', 145000.00, 'F', 'priya@company.com'),
(103, 'Rohan Verma', 1, 101, '2023-08-20', 110000.00, 'M', 'rohan@gmail.com'),
(104, 'Sneha Rao', 1, 102, '2024-05-12', 110000.00, 'F', 'sneha@company.com'),
(105, 'Vikram Malhotra', 2, 101, '2023-06-01', 150000.00, 'M', 'vikram@company.com'),
(106, 'Ananya Sen', 2, 105, '2024-02-15', 130000.00, 'F', 'ananya@yahoo.com'),
(107, 'Karan Joshi', 2, 105, '2024-11-20', 95000.00, 'M', 'karan@company.com'),
(108, 'Neha Gupta', 3, 101, '2022-10-05', 135000.00, 'F', 'neha@company.com'),
(109, 'Amit Singh', 3, 108, '2024-12-01', 115000.00, 'M', 'amit@company.com'),
(110, 'Pooja Nair', 4, 101, '2023-04-18', 85000.00, 'F', 'pooja@company.com');

INSERT INTO Customers VALUES
(1, 'Rajesh Kumar', 'Bengaluru', '2024-01-15', 'rajesh@gmail.com'),
(2, 'Meera Iyer', 'Pune', '2024-02-10', 'meera@yahoo.com'),
(3, 'Sunil Chawla', 'Mumbai', '2024-03-05', 'sunil@gmail.com'),
(4, 'Kavita Deshmukh', 'Delhi', '2024-04-20', 'kavita@company.com'),
(5, 'Arjun Reddy', 'Pune', '2024-05-12', 'arjun@gmail.com'),
(6, 'Divya Joshi', 'Ahmedabad', '2024-06-18', 'divya@hotmail.com'),
(7, 'Sanjay Roy', 'Kolkata', '2024-07-22', 'sanjay@gmail.com');

INSERT INTO Products VALUES
(501, 'Cloud Data Lakehouse', 'Enterprise Software', 25000.00),
(502, 'PySpark Compute Node', 'Compute', 12000.00),
(503, 'Airflow Orchestrator', 'Enterprise Software', 8000.00),
(504, 'Snowflake DWH Cluster', 'Data Warehouse', 45000.00),
(505, 'Kafka Event Streamer', 'Compute', 15000.00);

INSERT INTO Orders VALUES
(1001, 1, '2026-01-15', 50000.00, '2026-01-18'),
(1002, 2, '2026-02-10', 12000.00, '2026-02-14'),
(1003, 3, '2026-03-05', 45000.00, NULL),
(1004, 4, '2026-04-12', 25000.00, '2026-04-15'),
(1005, 1, '2026-05-18', 65000.00, '2026-05-20'),
(1006, 2, '2026-06-22', 8000.00, '2026-06-28'),
(1007, 5, '2026-07-30', 90000.00, NULL);

INSERT INTO BankTransactions VALUES
(1, 9001, '2026-08-27 10:00:00', 5000.00, 'Mumbai', 'ATM'),
(2, 9001, '2026-08-27 10:03:00', 15000.00, 'Delhi', 'POS_SWIPE'),
(3, 9002, '2026-08-27 11:15:00', 2500.00, 'Pune', 'ONLINE'),
(4, 9003, '2026-08-27 12:00:00', 10000.00, 'Bengaluru', 'ATM');

INSERT INTO StockMovements (ProductID, MovementDate, QtyChange) VALUES
(501, '2026-08-01', 100),
(501, '2026-08-05', -20),
(501, '2026-08-10', -60),
(501, '2026-08-15', -10),
(502, '2026-08-01', 50),
(502, '2026-08-12', -40);
GO

-- ====================================================================
-- 🏛️ SECTION 2: 22-DAY COMPLETE CURRICULUM DEEP-DIVE MODULES
-- ====================================================================

-- --------------------------------------------------------------------
-- 🗓️ DAY 01: SQL ARCHITECTURE, COMMANDS TAXONOMY & TABLE CREATION
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Data vs Database vs DBMS vs RDBMS:
     • Data: Raw unorganized facts.
     • DBMS: Software to store/manage data (flat files / hierarchical).
     • RDBMS: Relational engine enforcing tables, columns, rows & keys.
   - SQL Commands Taxonomy:
     • DDL (Data Definition Language) : CREATE, ALTER, DROP, TRUNCATE
       -> Modifies metadata catalog, system tables, storage allocations.
     • DML (Data Manipulation Language): INSERT, UPDATE, DELETE
       -> Modifies data rows inside existing tables; locks rows.
     • DQL (Data Query Language)       : SELECT
       -> Projects, transforms, aggregates in-memory result sets.
     • TCL (Transaction Control)       : COMMIT, ROLLBACK, SAVEPOINT
       -> Manages ACID transaction state and lock release.
   - Primary Key & Foreign Key Principles:
     • Primary Key enforces entity uniqueness and creates Clustered Index.
     • Foreign Key establishes parent-child referential integrity.
*/

-- 1. Exploring table definitions & column metadata
SELECT EmpID, EmpName, DeptID, Salary, JoiningDate 
FROM Employees;

-- 2. Basic Column Projection & Explicit Aliasing
SELECT 
    EmpName AS EmployeeFullName,
    Salary  AS BaseCompensationMonthly
FROM Employees;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 02: FILTERING CLAUSES, OPERATORS & INFORMATION SCHEMA
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - WHERE Clause: Evaluates Boolean conditions row by row at Stage 2.
   - Relational Comparison Operators: =, <>, !=, <, <=, >, >=.
   - Special Set & Range Operators:
     • IN (val1, val2) / NOT IN (val1, val2)
     • BETWEEN lower AND upper (inclusive range)
     • IS NULL / IS NOT NULL (handles Three-Valued Logic NULL state)
   - Pattern Matching with LIKE:
     • '%'  : Zero or more characters (e.g. '%tech%').
     • '_'  : Exactly ONE single character position (e.g. 'R__').
     • '[]' : Character set list/range (e.g. '[A-Z]%').
     • '[^]': Negated character set (e.g. '[^0-9]%').
   - INFORMATION_SCHEMA: ANSI standard system metadata exploration view.
*/

-- 1. Exploring database catalog via INFORMATION_SCHEMA
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

-- 2. Range & Set Filtering with Combined Predicates
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE DeptID IN (1, 2) 
  AND Salary BETWEEN 100000.00 AND 160000.00;

-- 3. Basic Pattern Matching with LIKE
SELECT CustomerID, CustomerName, City 
FROM Customers 
WHERE City LIKE 'P%' OR City LIKE '%luru';
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 03: PRECISION PATTERN MATCHING & VOWEL/DIGIT FILTERS
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Character Length & Boundary Matching:
     • 'A____n' matches names starting with 'A', ending with 'n', length 6.
   - Character Set Matching:
     • LIKE '[AEIOU]%' : Starts with a vowel (case-insensitive in SQL Server).
     • LIKE '[0-9]%'   : Starts with any numeric digit.
     • LIKE '[^0-9]%'  : Starts with any non-digit character.
   - 3VL (Three-Valued Logic) Pattern Exclusion Trap:
     • WHERE Email NOT LIKE '%@gmail.com' drops NULL emails!
     • Fix: Always append `OR Email IS NULL`.
*/

-- 1. Exact 6-Character length pattern with fixed boundary
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE 'A____n';

-- 2. Vowel and Range pattern filtering
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE '[A-P]%';

-- 3. Resilient NULL exclusion query
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 04: NUMERIC TYPES, ARITHMETIC, UPDATE, DELETE & SECURITY
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Numeric Data Types: INT, BIGINT, DECIMAL(p,s), FLOAT.
     • DECIMAL(10,2): Exact financial precision (10 total digits, 2 decimals).
     • FLOAT: Approximate floating-point representation.
   - Arithmetic Operators: (+, -, *, /).
   - DML UPDATE Mechanics:
     • Modifies existing column values in place.
     • Always specify WHERE clause to prevent accidental whole-table overwrites!
   - DML DELETE Mechanics:
     • Removes selected rows one by one.
     • Logs each individual row deletion in the transaction log.
   - Database Security Architecture:
     • Principle of Least Privilege: Analysts get DQL (SELECT); 
       DBAs/Admins get DDL (CREATE/ALTER) and DML (INSERT/UPDATE/DELETE).
*/

-- 1. Computed arithmetic expressions in SELECT
SELECT 
    EmpID, EmpName, Salary,
    (Salary * 1.10)       AS SalaryWith10PercentHike,
    (Salary / 12.0)       AS MonthlyCompensation,
    (Salary - 25000.00)   AS NetAfterDeductions
FROM Employees;

-- 2. Safe transaction-wrapped UPDATE demonstration
BEGIN TRANSACTION;
    UPDATE Employees 
    SET Salary = Salary + 5000.00 
    WHERE DeptID = 4;
    
    SELECT EmpID, EmpName, DeptID, Salary 
    FROM Employees 
    WHERE DeptID = 4;
ROLLBACK TRANSACTION;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 05: THE DELETION BATTLE & DDL ALTER TABLE
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The Great Deletion Comparison:
     ------------------------------------------------------------------
     Dimension             DELETE            TRUNCATE          DROP
     ------------------------------------------------------------------
     Command Type          DML               DDL               DDL
     Execution Level       Row-by-row        Page deallocation Schema wipe
     WHERE Clause          Supported         Forbidden         Forbidden
     IDENTITY Property     Keeps current     Resets to seed    Destroyed
     FK Target Table       Allowed           Blocked by FK     Blocked by FK
     Transaction Rollback  Supported         Supported (MSSQL) Supported
     ------------------------------------------------------------------
   - DDL ALTER TABLE Operations:
     • ADD Column: Appends column metadata to table catalog.
     • DROP Column: Removes column definition and unlinks storage.
     • ALTER COLUMN: Changes data type and nullability rules.
   - Object Renaming via `sp_rename`:
     • EXEC sp_rename 'OldTable', 'NewTable';
     • EXEC sp_rename 'Table.OldCol', 'NewCol', 'COLUMN';
*/

-- 1. Creating scratch table to demonstrate DDL ALTER operations
CREATE TABLE TempAudit_Day05 (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    Notes VARCHAR(100) NULL
);

-- 2. ALTER TABLE ADD & ALTER COLUMN
ALTER TABLE TempAudit_Day05 ADD StatusFlag CHAR(1) DEFAULT 'A';
ALTER TABLE TempAudit_Day05 ALTER COLUMN Notes VARCHAR(250) NOT NULL;

-- 3. Cleanup scratch object
DROP TABLE TempAudit_Day05;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 06: AGGREGATES, DISTINCT & TOP N
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The 5 Standard Aggregate Functions:
     • MIN(col)   : Minimum value (ignores NULL).
     • MAX(col)   : Maximum value (ignores NULL).
     • SUM(col)   : Sum of numeric expressions (ignores NULL).
     • AVG(col)   : Average = SUM(col) / COUNT(col) (IGNORES NULLs!).
     • COUNT(col) : Count of non-NULL column entries.
     • COUNT(*)   : Count of all physical rows (INCLUDING NULLs!).
   - The Average Null Trap:
     • If 4 rows exist with salaries: 100k, 100k, 100k, NULL:
       -> AVG(Salary) = 300k / 3 = 100k.
       -> If NULL represents 0 salary: AVG(ISNULL(Salary, 0)) = 300k / 4 = 75k!
   - DISTINCT vs COUNT(DISTINCT):
     • DISTINCT collapses duplicate result rows.
     • COUNT(DISTINCT col) counts unique non-NULL values.
   - TOP N Clause: Returns the first N rows based on sorting criteria.
*/

-- 1. Complete aggregate summary scorecard
SELECT 
    COUNT(*)                 AS TotalRowsCount,
    COUNT(Email)             AS ValidEmailsCount,
    COUNT(DISTINCT DeptID)   AS DistinctDepartments,
    MIN(Salary)              AS MinSalary,
    MAX(Salary)              AS MaxSalary,
    AVG(Salary)              AS StandardAvgSalary,
    AVG(ISNULL(Salary, 0.0)) AS ResilientAvgSalary,
    SUM(Salary)              AS TotalCompanyPayroll
FROM Employees;

-- 2. TOP N with deterministic ordering
SELECT TOP 3 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 07: 6-STAGE EXECUTION PIPELINE, GROUP BY & HAVING
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The 6-Stage Logical Query Processing Order:
     [STAGE 1] FROM + JOIN  ──► Load source tables, evaluate join matrix
     [STAGE 2] WHERE        ──► Filter individual rows before grouping
     [STAGE 3] GROUP BY     ──► Group rows into distinct summary buckets
     [STAGE 4] HAVING       ──► Filter aggregate group statistics
     [STAGE 5] SELECT       ──► Compute projections & assign column aliases
     [STAGE 6] ORDER BY     ──► Sort final output (Can see SELECT aliases!)
   - Why WHERE Fails on Aliases:
     • WHERE executes at Stage 2. The alias created at Stage 5 (SELECT)
       does not exist in memory yet!
   - Why ORDER BY Succeeds on Aliases:
     • ORDER BY executes at Stage 6, after SELECT has assigned the alias.
*/

-- Benchmark query exercising all 6 execution stages:
SELECT 
    DeptID,
    COUNT(*)    AS Headcount,
    AVG(Salary) AS AvgDeptSalary
FROM Employees
WHERE JoiningDate >= '2023-01-01'  -- Stage 2: Filter raw rows
GROUP BY DeptID                    -- Stage 3: Bucket into department groups
HAVING AVG(Salary) >= 100000.00    -- Stage 4: Filter aggregated group stats
ORDER BY AvgDeptSalary DESC;       -- Stage 6: Sort by Stage 5 SELECT alias!
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 08: COMMON MISTAKES ANALYSIS (WHERE vs HAVING)
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Rule of Thumb:
     • WHERE  -> Filters individual ROWS (runs before GROUP BY).
     • HAVING -> Filters aggregated GROUPS (runs after GROUP BY).
   - SQL Server Error Msg 8120:
     • "Column is invalid in the select list because it is not contained
        in either an aggregate function or the GROUP BY clause."
     • Every column in SELECT must either be in GROUP BY or inside an aggregate!
*/

-- ❌ Wrong: SELECT DeptID, EmpName, AVG(Salary) FROM Employees GROUP BY DeptID; (Msg 8120)
-- ✅ Correct: Grouping key and aggregates only:
SELECT 
    DeptID,
    COUNT(*)    AS StaffCount,
    MIN(Salary) AS MinDeptSal,
    MAX(Salary) AS MaxDeptSal
FROM Employees 
GROUP BY DeptID 
HAVING COUNT(*) >= 2;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 09: SQL CONSTRAINTS & DATA VALIDATION
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The Core Constraints:
     1. PRIMARY KEY : Unique identifier + NOT NULL. Creates Clustered Index.
     2. UNIQUE      : Enforces uniqueness. Allows 1 single NULL in SQL Server.
     3. NOT NULL    : Blocks NULL value insertion into the column.
     4. CHECK       : Validates Boolean expressions on row insertion/update.
*/

CREATE TABLE ConstraintValidation_Day09 (
    RecordID INT PRIMARY KEY,
    UserEmail VARCHAR(100) UNIQUE NOT NULL,
    Age INT CHECK (Age >= 18 AND Age <= 65),
    Salary DECIMAL(10,2) CHECK (Salary > 0)
);

-- Inserting valid row
INSERT INTO ConstraintValidation_Day09 VALUES 
(1, 'valid.user@company.com', 28, 95000.00);

-- Cleanup
DROP TABLE ConstraintValidation_Day09;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 10: DEFAULT, IDENTITY & FOREIGN KEY ARCHITECTURE
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - DEFAULT Constraint: Fallback value when column is omitted in INSERT.
   - IDENTITY(seed, increment): System-managed surrogate key.
   - FOREIGN KEY Constraint:
     • Enforces referential integrity between child table and parent PK/UNIQUE.
     • Prevents orphan records in child tables.
     • Controls CASCADE actions: ON DELETE CASCADE / ON DELETE SET NULL.
*/

SELECT 
    e.EmpID, e.EmpName, e.Salary,
    d.DeptName, d.Location
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 11: PARENT VS CHILD DESTRUCTION RULES
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The Parent Protection Protocol:
     1. DELETE Parent Row: Blocked if child rows reference it (Msg 547).
     2. TRUNCATE Parent Table: FORBIDDEN by SQL Server engine if any child
        table has a Foreign Key pointing to it, EVEN IF CHILD IS EMPTY!
     3. DROP Parent Table: Blocked until child foreign key is dropped.
     4. Child Table Operations: Child rows can always be DELETED, TRUNCATED,
        or DROPPED freely without affecting the parent table.
*/
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 12: 3-STEP CONSTRAINT RETROFITTING & TRUNCATE ROLLBACK
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The 3-Step Retrofitting Framework on Live Dirty Tables:
     • Step 1: Detect duplicate violations using GROUP BY + HAVING COUNT(*) > 1.
     • Step 2: Cleanse duplicates using CTE + ROW_NUMBER() in-place delete.
     • Step 3: Apply ALTER TABLE ADD CONSTRAINT safely.
   - Proof of TRUNCATE Rollback:
     • TRUNCATE deallocates data pages. The page deallocations are logged
       in the transaction log, allowing full 100% rollback in MSSQL!
*/

-- TRUNCATE Transaction Rollback Verification:
BEGIN TRANSACTION;
    TRUNCATE TABLE BankTransactions;
    SELECT COUNT(*) AS CountDuringTransaction FROM BankTransactions; -- 0 rows
ROLLBACK TRANSACTION;
SELECT COUNT(*) AS CountAfterRollback FROM BankTransactions; -- 4 rows restored!
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 13: SET OPERATORS (UNION, ALL, INTERSECT, EXCEPT)
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Vertical Result Set Appending:
     • UNION     : Combines query results + runs in-memory DISTINCT sort (slower).
     • UNION ALL : Combines query results directly without sorting (10x faster!).
     • INTERSECT : Returns rows present in BOTH result sets.
     • EXCEPT    : Returns rows in Query 1 that do not exist in Query 2.
   - Structural Rules:
     • Both queries must have the exact same number of columns.
     • Corresponding column data types must be compatible.
*/

-- 1. UNION (Deduplicated locations)
SELECT City FROM Customers
UNION
SELECT Location FROM Departments;

-- 2. UNION ALL (All locations preserved)
SELECT City FROM Customers
UNION ALL
SELECT Location FROM Departments;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 14: TEMPORAL DATA TYPES, DATEDIFF & SARGABILITY
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Temporal Built-in Functions:
     • GETDATE()                  : Current system clock timestamp.
     • DATEDIFF(unit, start, end) : Counts boundary crossings between two dates.
     • DATEADD(unit, n, date)     : Adds/subtracts time intervals.
     • DATEPART(unit, date)       : Extracts calendar components (year, month, qq).
     • EOMONTH(date)              : Returns last day of month (handles leap years).
   - SARGability (Search Argument Able):
     • Non-SARGable: WHERE YEAR(OrderDate) = 2026 (Forces Full Index Scan).
     • SARGable    : WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01'
                     (Enables B-Tree Index Seek!).
*/

SELECT 
    OrderID, OrderDate,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrderPlaced,
    DATEADD(DAY, 7, OrderDate)          AS EstimatedDeliveryDate,
    DATEPART(QUARTER, OrderDate)        AS OrderQuarter,
    EOMONTH(OrderDate)                  AS MonthEndDate
FROM Orders;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 15: RELATIONAL JOINS, CARTESIAN MATH (N x M) & 3VL
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - The Fundamental Join Equation:
     JOIN = (Cartesian Cross Product N x M) + (ON Filter Predicate)
   - Cartesian Row Multiplication:
     • If Table A has 4 rows with key '1', and Table B has 3 rows with key '1':
       -> INNER JOIN generates 4 x 3 = 12 matching rows!
   - Three-Valued Logic (3VL) in Joins:
     • In SQL, NULL = NULL evaluates to UNKNOWN.
     • Rows with NULL join keys will NOT match in standard INNER JOIN!
*/

-- ANSI CROSS JOIN Demonstration (Total rows = Customers x Orders)
SELECT 
    c.CustomerID, c.CustomerName, o.OrderID, o.TotalAmount
FROM Customers c
CROSS JOIN Orders o;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 16: ANSI RELATIONAL JOINS & ANTI-JOIN PATTERNS
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - ANSI Relational Join Taxonomy:
     • INNER JOIN : Returns rows that satisfy the ON condition in both tables.
     • LEFT JOIN  : Preserves ALL left table rows; fills NULL for unmatched right.
     • RIGHT JOIN : Preserves ALL right table rows; fills NULL for unmatched left.
     • FULL JOIN  : Preserves ALL rows from both tables.
   - The Relational Anti-Join Pattern:
     • Used to find parent records with ZERO corresponding child records.
     • Syntax: `LEFT JOIN Child c ON p.ID = c.ID WHERE c.ID IS NULL`
*/

-- 1. Standard Inner Join
SELECT e.EmpID, e.EmpName, d.DeptName, e.Salary 
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;

-- 2. Anti-Join: Customers who have never placed an order
SELECT c.CustomerID, c.CustomerName, c.City 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 17: MULTI-TABLE INGESTION CHAINS & CROSS JOIN MATRICES
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Multi-Table Chaining:
     • Connects 3 or more entities across normalized schemas.
     • Customer Master -> Orders Header -> Order Items -> Product Master.
   - ANSI SQL-92 vs Legacy Non-ANSI Comma Joins:
     • Always use explicit ANSI `INNER JOIN ... ON` syntax.
     • Avoid legacy comma joins (`FROM T1, T2 WHERE T1.ID = T2.ID`) due to
       accidental accidental Cartesian explosion risks.
*/

SELECT 
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    p.Category,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice) AS TotalLineAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 18: SELF-JOINS, MANAGER TREES & 5-MIN GEO-FRAUD ENGINE
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Self-Join Mechanics:
     • Joins a table to itself in memory using aliases (e.g. `e` and `m`).
   - Hierarchical Mapping & Root Node Handling:
     • Using INNER JOIN drops the CEO (whose ManagerID is NULL).
     • Using LEFT JOIN preserves the CEO at the root of the hierarchy!
   - Symmetric Deduplication:
     • In same-table comparisons, `t1.ID < t2.ID` eliminates self-matches
       and symmetric mirror duplicate pairs (A-B vs B-A).
*/

-- 1. Employee-Manager Hierarchy with CEO Shield
SELECT 
    e.EmpName AS EmployeeName,
    e.Salary  AS EmployeeSalary,
    ISNULL(m.EmpName, '👑 CEO / TOP EXECUTIVE') AS ManagerName,
    m.Salary  AS ManagerSalary
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- 2. Geo-Temporal Fraud Anomaly Engine (Different cities in <= 5 mins)
SELECT 
    t1.AccountID,
    t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
    t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
    DATEDIFF(SECOND, t1.TxnTimestamp, t2.TxnTimestamp) AS TimeDiffSeconds
FROM BankTransactions t1
INNER JOIN BankTransactions t2 
    ON t1.AccountID = t2.AccountID
   AND t1.TxnID < t2.TxnID                          -- Suppresses self-match & mirror duplicates
   AND t1.TxnCity <> t2.TxnCity                     -- Distinct locations
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 19: WINDOW FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK)
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Window Functions vs GROUP BY:
     • GROUP BY collapses individual rows into a single summary row.
     • Window Functions preserve individual row identity while calculating
       aggregates and rankings across a defined subset (PARTITION BY).
   - The 3 Core Ranking Functions:
     • ROW_NUMBER() : 1, 2, 3, 4 (Strict sequential ID; no ties, no gaps).
     • DENSE_RANK() : 1, 2, 2, 3 (Tied rows share rank; NO gaps).
     • RANK()       : 1, 2, 2, 4 (Tied rows share rank; LEAVES gaps).
   - SQL Server Error Msg 4108:
     • "Windowed functions can only appear in the SELECT or ORDER BY clauses."
     • Window functions are forbidden in WHERE clauses.
     • Solution: Wrap the window function in a CTE or Derived Table!
*/

-- 1. Direct comparison of the 3 ranking functions
SELECT 
    DeptID, EmpName, Salary,
    ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SeqRow,
    DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS DenseRnk,
    RANK()       OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS PosRnk
FROM Employees;

-- 2. Resolving Msg 4108 via Derived Table (Top 1 Earner per Department)
SELECT DeptID, EmpName, Salary 
FROM (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rnk
    FROM Employees
) RankedData
WHERE rnk = 1;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 20: COMMON TABLE EXPRESSIONS (CTEs) & DEDUPLICATION
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Common Table Expressions (CTEs):
     • A temporary named in-memory result set defined using `WITH CTE AS (...)`.
     • Exists only for the execution scope of the immediately following statement.
   - Safe In-Place Full-Row Deduplication:
     • SQL Server allows executing DELETE directly against a CTE!
     • The deletions propagate immediately to the underlying physical table.
*/

-- Safe In-Place Full-Row Deduplication Engine Template:
WITH DuplicateCleanser AS (
    SELECT CustomerID, Email,
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY RegistrationDate ASC
           ) AS RowOccurrence
    FROM Customers
    WHERE Email IS NOT NULL
)
-- Preview first: SELECT * FROM DuplicateCleanser WHERE RowOccurrence > 1;
DELETE FROM DuplicateCleanser 
WHERE RowOccurrence > 1;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 21: VALUE FUNCTIONS (LEAD/LAG) & RUNNING TOTALS
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Value Window Functions:
     • LAG(col, offset, default)  : Peeks backwards into previous rows.
     • LEAD(col, offset, default) : Peeks forwards into upcoming rows.
   - Cumulative Running Totals Formula:
     • SUM(col) OVER (PARTITION BY id ORDER BY date 
                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
     • Computes running balance across chronological rows without subqueries.
*/

-- 1. Inter-row peeking and cumulative running balance
SELECT 
    AccountID, TxnTimestamp, TxnAmount,
    LAG(TxnAmount, 1, 0.00) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp
    ) AS PriorTxnAmount,
    SUM(TxnAmount) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeAccountBalance
FROM BankTransactions;

-- 2. Stock Inventory Delta & Running Stock Balance
SELECT 
    ProductID, MovementDate, QtyChange,
    SUM(QtyChange) OVER (
        PARTITION BY ProductID 
        ORDER BY MovementDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingStockOnHand
FROM StockMovements;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 22: CONDITIONAL CASE LOGIC & DYNAMIC PINNED SORTING
-- --------------------------------------------------------------------
/*
   🧠 CONCEPT SUMMARY:
   - Searched CASE vs Simple CASE:
     • Simple CASE: `CASE col WHEN 'val' THEN ...` (equality checks only).
     • Searched CASE: `CASE WHEN condition1 THEN ...` (arbitrary Boolean logic).
   - Dynamic Pinned Sorting via ORDER BY CASE:
     • Custom priority sorting without modifying table data or creating temp tables.
*/

-- 1. Multi-Tier Categorization via Searched CASE
SELECT 
    EmpID, EmpName, Salary,
    CASE 
        WHEN Salary >= 140000.00 THEN '💎 Executive Tier'
        WHEN Salary >= 110000.00 THEN '🥇 Senior Tier'
        ELSE '🥈 Associate Tier'
    END AS CompensationBand
FROM Employees;

-- 2. Dynamic Pinned Sorting (Pune 1st, Bengaluru 2nd, others alphabetical)
SELECT CustomerID, CustomerName, City
FROM Customers
ORDER BY 
    CASE 
        WHEN City = 'Pune'      THEN 1
        WHEN City = 'Bengaluru' THEN 2
        ELSE 3
    END ASC,
    City DESC;
GO

-- ====================================================================
-- 🧠 SECTION 3: SYNTAX RECALL & MUSCLE MEMORY DRILLS
-- ====================================================================

/*
   DRILL 1: 6-STAGE EXECUTION ORDER
   Write the 6 stages in order from memory:
   1. FROM + JOIN
   2. WHERE
   3. GROUP BY
   4. HAVING
   5. SELECT
   6. ORDER BY
*/

/*
   DRILL 2: THE 3-STEP CONSTRAINT RETROFITTING
   Step 1: SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 1;
   Step 2: WITH C AS (SELECT id, ROW_NUMBER() OVER(PARTITION BY col ORDER BY id) rn FROM table)
           DELETE FROM C WHERE rn > 1;
   Step 3: ALTER TABLE table ADD CONSTRAINT UQ_name UNIQUE (col);
*/

/*
   DRILL 3: SARGABLE DATE FILTERING
   -- Non-SARGable: WHERE YEAR(OrderDate) = 2026 AND MONTH(OrderDate) = 5
   -- SARGable    : WHERE OrderDate >= '2026-05-01' AND OrderDate < '2026-06-01'
*/

/*
   DRILL 4: 3-WAY RANKING BEHAVIOR
   - ROW_NUMBER() : Unique sequential (1, 2, 3, 4) - Deduplication & Pagination
   - DENSE_RANK() : Tied shared rank without gaps (1, 2, 2, 3) - Nth highest salary
   - RANK()       : Tied shared rank with gaps (1, 2, 2, 4) - Official standings
*/

/*
   DRILL 5: VALUE WINDOW FUNCTIONS & RUNNING TOTALS
   - LAG(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - LEAD(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - SUM(col) OVER (PARTITION BY id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
*/

/*
   DRILL 6: DYNAMIC PINNED SORTING (CASE)
   ORDER BY 
       CASE 
           WHEN City = 'Pune' THEN 1
           WHEN City = 'Bengaluru' THEN 2
           ELSE 3
       END ASC,
       City DESC;
*/

-- ====================================================================
-- 🧪 SECTION 4: 50 HIGH-LEVEL INTERVIEW CHALLENGES (SUPER 50)
-- --------------------------------------------------------------------
-- All official solution keys are enclosed in comments below each task.
-- Try solving on your own in the blank query space first!
-- ====================================================================

-- --------------------------------------------------------------------
-- 🟢 BLOCK 1: FOUNDATION & FILTERING (Q01 – Q10)
-- --------------------------------------------------------------------

-- [Q01] Retrieve all employees earning more than 120,000 ordered by salary descending.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q01] ---
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE Salary > 120000.00 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q02] Find employees in Departments 1, 2, or 4 without using multiple OR conditions.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q02] ---
SELECT EmpID, EmpName, DeptID 
FROM Employees 
WHERE DeptID IN (1, 2, 4);
-------------------------------- */


-- [Q03] Find employees whose name starts with 'A', ends with 'n', and has exactly 6 letters.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q03] ---
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE 'A____n';
-------------------------------- */


-- [Q04] Retrieve all employees whose email does NOT end with '@gmail.com' (preserve NULLs).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q04] ---
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;
-------------------------------- */


-- [Q05] Select orders placed between '2026-01-01' and '2026-03-31' using BETWEEN.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q05] ---
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM Orders 
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31';
-------------------------------- */


-- [Q06] Find top-level leaders who have no direct manager assigned (ManagerID is NULL).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q06] ---
SELECT EmpID, EmpName, Salary 
FROM Employees 
WHERE ManagerID IS NULL;
-------------------------------- */


-- [Q07] Retrieve the top 5 highest-paid employees in the company using TOP.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q07] ---
SELECT TOP 5 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q08] Find the exact 2nd highest distinct salary across company using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q08] ---
WITH SalaryRanks AS (
    SELECT Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT DISTINCT Salary 
FROM SalaryRanks 
WHERE rnk = 2;
-------------------------------- */


-- [Q09] Compute MIN, MAX, AVG, SUM salary and total headcount in a single query.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q09] ---
SELECT 
    COUNT(*)    AS Headcount,
    MIN(Salary) AS MinSal,
    MAX(Salary) AS MaxSal,
    AVG(Salary) AS AvgSal,
    SUM(Salary) AS TotalPayroll
FROM Employees;
-------------------------------- */


-- [Q10] Return DeptID and total employee headcount per department.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q10] ---
SELECT DeptID, COUNT(*) AS DeptHeadcount 
FROM Employees 
GROUP BY DeptID;
-------------------------------- */


-- --------------------------------------------------------------------
-- 🟡 BLOCK 2: GROUP BY, HAVING & AGGREGATIONS (Q11 – Q20)
-- --------------------------------------------------------------------

-- [Q11] Departments with strictly more than 3 employees.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q11] ---
SELECT DeptID, COUNT(*) AS StaffCount 
FROM Employees 
GROUP BY DeptID 
HAVING COUNT(*) > 3;
-------------------------------- */


-- [Q12] Departments where average salary is strictly greater than 120,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q12] ---
SELECT DeptID, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY DeptID 
HAVING AVG(Salary) > 120000.00;
-------------------------------- */


-- [Q13] Department with the absolute highest average salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q13] ---
SELECT TOP 1 DeptID, AVG(Salary) AS HighestAvgSalary 
FROM Employees 
GROUP BY DeptID 
ORDER BY AVG(Salary) DESC;
-------------------------------- */


-- [Q14] Department with highest cumulative payroll spend.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q14] ---
SELECT TOP 1 DeptID, SUM(Salary) AS TotalSpend 
FROM Employees 
GROUP BY DeptID 
ORDER BY SUM(Salary) DESC;
-------------------------------- */


-- [Q15] Employees earning more than their own department's average salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q15] ---
WITH DeptAvg AS (
    SELECT DeptID, AVG(Salary) AS AvgSal 
    FROM Employees 
    GROUP BY DeptID
)
SELECT e.EmpID, e.EmpName, e.Salary, d.AvgSal AS DeptAverage
FROM Employees e
INNER JOIN DeptAvg d ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSal;
-------------------------------- */


-- [Q16] Second-highest distinct salary across entire company without window functions.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q16] ---
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees);
-------------------------------- */


-- [Q17] Third-highest salary using DENSE_RANK without TOP keyword.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q17] ---
WITH RankedSalaries AS (
    SELECT Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT DISTINCT Salary 
FROM RankedSalaries 
WHERE rnk = 3;
-------------------------------- */


-- [Q18] Duplicate Email detection query on Customers table.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q18] ---
SELECT Email, COUNT(*) AS DuplicateCount 
FROM Customers 
WHERE Email IS NOT NULL 
GROUP BY Email 
HAVING COUNT(*) > 1;
-------------------------------- */


-- [Q19] Departments where the minimum salary is above 90,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q19] ---
SELECT DeptID, MIN(Salary) AS LowestSalary 
FROM Employees 
GROUP BY DeptID 
HAVING MIN(Salary) > 90000.00;
-------------------------------- */


-- [Q20] Multi-metric department scorecard: DeptName, TotalEmployees, AvgSalary, TotalPayroll.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q20] ---
SELECT 
    d.DeptName,
    COUNT(e.EmpID)           AS TotalEmployees,
    ISNULL(AVG(e.Salary), 0) AS AvgSalary,
    ISNULL(SUM(e.Salary), 0) AS TotalPayroll
FROM Departments d
LEFT JOIN Employees e ON d.DeptID = e.DeptID
GROUP BY d.DeptID, d.DeptName;
-------------------------------- */


-- --------------------------------------------------------------------
-- 🟠 BLOCK 3: RELATIONAL JOINS & SELF-JOINS (Q21 – Q30)
-- --------------------------------------------------------------------

-- [Q21] Standard Employee + Department Inner Join returning EmpID, EmpName, DeptName, Salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q21] ---
SELECT e.EmpID, e.EmpName, d.DeptName, e.Salary 
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;
-------------------------------- */


-- [Q22] Find employees without assigned departments (Orphan Check).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q22] ---
SELECT e.EmpID, e.EmpName 
FROM Employees e 
LEFT JOIN Departments d ON e.DeptID = d.DeptID 
WHERE d.DeptID IS NULL;
-------------------------------- */


-- [Q23] Find departments with zero hired staff.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q23] ---
SELECT d.DeptID, d.DeptName 
FROM Departments d 
LEFT JOIN Employees e ON d.DeptID = e.DeptID 
WHERE e.EmpID IS NULL;
-------------------------------- */


-- [Q24] Customer and Orders Join: CustomerName, OrderID, OrderDate, TotalAmount.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q24] ---
SELECT c.CustomerName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
-------------------------------- */


-- [Q25] Relational Anti-Join: Customers who have NEVER placed any order.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q25] ---
SELECT c.CustomerID, c.CustomerName, c.City 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;
-------------------------------- */


-- [Q26] Products that have never been ordered (Anti-Join with OrderItems).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q26] ---
SELECT p.ProductID, p.ProductName, p.Price 
FROM Products p 
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID 
WHERE oi.OrderItemID IS NULL;
-------------------------------- */


-- [Q27] Customer Lifetime Spend scorecard including customers with zero orders.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q27] ---
SELECT 
    c.CustomerID, c.CustomerName,
    COUNT(o.OrderID) AS OrderCount,
    ISNULL(SUM(o.TotalAmount), 0.00) AS TotalLifetimeSpend
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;
-------------------------------- */


-- [Q28] Self-Join: Employees earning higher salary than their direct manager.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q28] ---
SELECT 
    e.EmpID, e.EmpName AS EmployeeName, e.Salary AS EmployeeSalary,
    m.EmpName AS ManagerName, m.Salary AS ManagerSalary,
    (e.Salary - m.Salary) AS SalaryExcess
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;
-------------------------------- */


-- [Q29] Employee-to-Manager hierarchy with CEO preservation ('👑 CEO / NO MANAGER').
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q29] ---
SELECT 
    e.EmpName AS EmployeeName,
    ISNULL(m.EmpName, '👑 CEO / NO MANAGER') AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;
-------------------------------- */


-- [Q30] Same-department employee pairs without symmetric duplicates (Emp1 < Emp2).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q30] ---
SELECT 
    e1.EmpName AS Employee1,
    e2.EmpName AS Employee2,
    e1.DeptID
FROM Employees e1
INNER JOIN Employees e2 
    ON e1.DeptID = e2.DeptID 
   AND e1.EmpID < e2.EmpID;
-------------------------------- */


-- --------------------------------------------------------------------
-- 🔴 BLOCK 4: WINDOW FUNCTIONS & DEDUPLICATION (Q31 – Q40)
-- --------------------------------------------------------------------

-- [Q31] Highest paid employee in each department using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q31] ---
WITH RankedSalaries AS (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (
               PARTITION BY DeptID 
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)
SELECT DeptID, EmpName, Salary 
FROM RankedSalaries 
WHERE rnk = 1;
-------------------------------- */


-- [Q32] Top 3 highest earners in each department using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q32] ---
WITH RankedSalaries AS (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (
               PARTITION BY DeptID 
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)
SELECT DeptID, EmpName, Salary, rnk 
FROM RankedSalaries 
WHERE rnk <= 3;
-------------------------------- */


-- [Q33] Exact 2nd highest earner in each department using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q33] ---
WITH RankedSalaries AS (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (
               PARTITION BY DeptID 
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)
SELECT DeptID, EmpName, Salary 
FROM RankedSalaries 
WHERE rnk = 2;
-------------------------------- */


-- [Q34] Sequential row numbering by salary across the entire company using ROW_NUMBER.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q34] ---
SELECT 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SeqID,
    EmpName, DeptID, Salary
FROM Employees;
-------------------------------- */


-- [Q35] Structural comparison of RANK vs DENSE_RANK in a single query.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q35] ---
SELECT 
    EmpName, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankNoGaps,
    RANK()       OVER (ORDER BY Salary DESC) AS PositionalRankWithGaps
FROM Employees;
-------------------------------- */


-- [Q36] Find all employees who share the exact same salary rank with a colleague.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q36] ---
WITH SalaryCounts AS (
    SELECT Salary, COUNT(*) AS TieCount 
    FROM Employees 
    GROUP BY Salary 
    HAVING COUNT(*) > 1
)
SELECT e.EmpID, e.EmpName, e.Salary 
FROM Employees e 
INNER JOIN SalaryCounts s ON e.Salary = s.Salary;
-------------------------------- */


-- [Q37] Highest spending customer per city using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q37] ---
WITH CustomerTotals AS (
    SELECT c.City, c.CustomerName, SUM(o.TotalAmount) AS CitySpend,
           DENSE_RANK() OVER (
               PARTITION BY c.City 
               ORDER BY SUM(o.TotalAmount) DESC
           ) AS rnk
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.City, c.CustomerName
)
SELECT City, CustomerName, CitySpend 
FROM CustomerTotals 
WHERE rnk = 1;
-------------------------------- */


-- [Q38] Retrieve only the latest order record for each customer using ROW_NUMBER.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q38] ---
WITH LatestOrders AS (
    SELECT OrderID, CustomerID, OrderDate, TotalAmount,
           ROW_NUMBER() OVER (
               PARTITION BY CustomerID 
               ORDER BY OrderDate DESC
           ) AS rn
    FROM Orders
)
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM LatestOrders 
WHERE rn = 1;
-------------------------------- */


-- [Q39] Retrieve the first lifetime order for each customer using ROW_NUMBER.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q39] ---
WITH FirstOrders AS (
    SELECT OrderID, CustomerID, OrderDate, TotalAmount,
           ROW_NUMBER() OVER (
               PARTITION BY CustomerID 
               ORDER BY OrderDate ASC
           ) AS rn
    FROM Orders
)
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM FirstOrders 
WHERE rn = 1;
-------------------------------- */


-- [Q40] Find employees who earn more than the chronologically preceding hire using LAG.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q40] ---
WITH SalaryProgression AS (
    SELECT EmpID, EmpName, JoiningDate, Salary,
           LAG(Salary) OVER (ORDER BY JoiningDate ASC) AS PrevHireSalary
    FROM Employees
)
SELECT EmpID, EmpName, JoiningDate, Salary, PrevHireSalary
FROM SalaryProgression
WHERE Salary > PrevHireSalary;
-------------------------------- */


-- --------------------------------------------------------------------
-- 💀 BLOCK 5: ANALYTICAL BOSS & WAR ROOM (Q41 – Q50)
-- --------------------------------------------------------------------

-- [Q41] Safe In-Place Full-Row Deduplication Engine on Customers using CTE.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q41] ---
WITH DuplicateRecords AS (
    SELECT CustomerID, Email,
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY CustomerID ASC
           ) AS RowOccurrence
    FROM Customers
    WHERE Email IS NOT NULL
)
DELETE FROM DuplicateRecords 
WHERE RowOccurrence > 1;
-------------------------------- */


-- [Q42] Find customers with orders on two consecutive calendar days using LAG.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q42] ---
WITH OrderGaps AS (
    SELECT 
        CustomerID, OrderDate,
        LAG(OrderDate) OVER (
            PARTITION BY CustomerID 
            ORDER BY OrderDate ASC
        ) AS PrevOrderDate
    FROM Orders
)
SELECT DISTINCT CustomerID, PrevOrderDate, OrderDate
FROM OrderGaps
WHERE DATEDIFF(DAY, PrevOrderDate, OrderDate) = 1;
-------------------------------- */


-- [Q43] Identify customers with a gap of 30+ days between any two consecutive orders.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q43] ---
WITH InactivityIntervals AS (
    SELECT 
        CustomerID, OrderID, OrderDate,
        LAG(OrderDate) OVER (
            PARTITION BY CustomerID 
            ORDER BY OrderDate ASC
        ) AS PreviousOrderDate,
        DATEDIFF(DAY, 
            LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate ASC), 
            OrderDate
        ) AS DaysBetween
    FROM Orders
)
SELECT CustomerID, OrderID, PreviousOrderDate, OrderDate, DaysBetween
FROM InactivityIntervals
WHERE DaysBetween >= 30;
-------------------------------- */


-- [Q44] Cumulative running revenue total per customer using SUM() OVER (ROWS UNBOUNDED).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q44] ---
SELECT 
    CustomerID, OrderID, OrderDate, TotalAmount,
    SUM(TotalAmount) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeCustomerSpend
FROM Orders;
-------------------------------- */


-- [Q45] Variance and dollar delta from immediately preceding order using LAG.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q45] ---
SELECT 
    CustomerID, OrderID, OrderDate, TotalAmount,
    LAG(TotalAmount, 1, 0.00) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate
    ) AS PrevAmount,
    TotalAmount - LAG(TotalAmount, 1, TotalAmount) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate
    ) AS DeltaVariance
FROM Orders;
-------------------------------- */


-- [Q46] Forward sequence peeking (Next Scheduled Order Date) using LEAD.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q46] ---
SELECT 
    CustomerID, OrderID, OrderDate,
    LEAD(OrderDate, 1, NULL) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate ASC
    ) AS NextOrderDate
FROM Orders;
-------------------------------- */


-- [Q47] Categorize employees into Executive (>=140k), Senior (110k-140k), Associate (<110k) and summarize.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q47] ---
SELECT 
    CASE 
        WHEN Salary >= 140000.00 THEN 'Executive Tier'
        WHEN Salary >= 110000.00 THEN 'Senior Tier'
        ELSE 'Associate Tier'
    END AS SalaryBand,
    COUNT(*)    AS TotalStaff,
    SUM(Salary) AS BandPayroll
FROM Employees
GROUP BY 
    CASE 
        WHEN Salary >= 140000.00 THEN 'Executive Tier'
        WHEN Salary >= 110000.00 THEN 'Senior Tier'
        ELSE 'Associate Tier'
    END;
-------------------------------- */


-- [Q48] Top 2 highest paid employees per department returning all tied employees using DENSE_RANK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q48] ---
WITH DeptRanks AS (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (
               PARTITION BY DeptID 
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)
SELECT DeptID, EmpName, Salary, rnk
FROM DeptRanks
WHERE rnk <= 2;
-------------------------------- */


-- [Q49] Detect potential fraud: same account transacted in different cities within 5 minutes.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q49] ---
SELECT 
    t1.AccountID,
    t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
    t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
    DATEDIFF(SECOND, t1.TxnTimestamp, t2.TxnTimestamp) AS TimeDiffSeconds
FROM BankTransactions t1
INNER JOIN BankTransactions t2 
    ON t1.AccountID = t2.AccountID
   AND t1.TxnID < t2.TxnID                          -- Suppresses self-match
   AND t1.TxnCity <> t2.TxnCity                     -- Distinct cities
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;
-------------------------------- */


-- [Q50] Master 360° Customer Analytics Intelligence Pipeline.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q50] ---
WITH CustomerOrderAnalytics AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount,
        MIN(o.OrderDate) OVER (PARTITION BY c.CustomerID) AS FirstOrderDate,
        MAX(o.OrderDate) OVER (PARTITION BY c.CustomerID) AS LatestOrderDate,
        COUNT(o.OrderID) OVER (PARTITION BY c.CustomerID) AS TotalOrdersCount,
        SUM(o.TotalAmount) OVER (PARTITION BY c.CustomerID) AS LifetimeSpend,
        AVG(o.TotalAmount) OVER (PARTITION BY c.CustomerID) AS AvgOrderValue,
        LAG(o.TotalAmount, 1, 0.00) OVER (
            PARTITION BY c.CustomerID 
            ORDER BY o.OrderDate
        ) AS PreviousOrderAmount,
        DATEDIFF(DAY, 
            LAG(o.OrderDate) OVER (PARTITION BY c.CustomerID ORDER BY o.OrderDate), 
            o.OrderDate
        ) AS DaysSincePrevOrder,
        ROW_NUMBER() OVER (
            PARTITION BY c.CustomerID 
            ORDER BY o.OrderDate DESC
        ) AS rn
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
)
SELECT 
    CustomerName,
    FirstOrderDate,
    LatestOrderDate,
    TotalOrdersCount,
    LifetimeSpend,
    AvgOrderValue,
    PreviousOrderAmount,
    ISNULL(DaysSincePrevOrder, 0) AS DaysSincePreviousOrder,
    CASE 
        WHEN LifetimeSpend >= 100000.00 THEN '💎 PLATINUM VIP'
        WHEN LifetimeSpend >= 50000.00  THEN '🥇 GOLD VIP'
        ELSE '🥈 REGULAR'
    END AS CustomerStatusTier
FROM CustomerOrderAnalytics
WHERE rn = 1;
-------------------------------- */

-- ====================================================================
-- 🏆 SECTION 5: FINAL BOSS CUSTOMER INTELLIGENCE VIEW
-- ====================================================================

CREATE OR ALTER VIEW vw_EnterpriseCustomer360 AS
WITH BaseOrderMetrics AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.City,
        o.OrderID,
        o.OrderDate,
        o.TotalAmount,
        LAG(o.TotalAmount, 1, 0.00) OVER (
            PARTITION BY c.CustomerID 
            ORDER BY o.OrderDate
        ) AS PriorOrderAmount,
        LAG(o.OrderDate) OVER (
            PARTITION BY c.CustomerID 
            ORDER BY o.OrderDate
        ) AS PriorOrderDate,
        ROW_NUMBER() OVER (
            PARTITION BY c.CustomerID 
            ORDER BY o.OrderDate DESC
        ) AS RecencyRank
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
),
AggregatedCustomerSummary AS (
    SELECT 
        CustomerID,
        CustomerName,
        City,
        COUNT(OrderID) AS LifetimeOrderCount,
        ISNULL(SUM(TotalAmount), 0.00) AS TotalLifetimeRevenue,
        ISNULL(AVG(TotalAmount), 0.00) AS AverageOrderValue,
        MIN(OrderDate) AS FirstAcquisitionDate,
        MAX(OrderDate) AS MostRecentOrderDate,
        MAX(CASE WHEN RecencyRank = 1 THEN PriorOrderAmount ELSE 0 END) 
            AS LastKnownPriorOrderAmount,
        MAX(CASE WHEN RecencyRank = 1 THEN DATEDIFF(DAY, PriorOrderDate, OrderDate) ELSE NULL END) 
            AS DaysBetweenLastTwoOrders
    FROM BaseOrderMetrics
    GROUP BY CustomerID, CustomerName, City
)
SELECT 
    CustomerID,
    CustomerName,
    City,
    LifetimeOrderCount,
    TotalLifetimeRevenue,
    AverageOrderValue,
    FirstAcquisitionDate,
    MostRecentOrderDate,
    LastKnownPriorOrderAmount,
    ISNULL(DaysBetweenLastTwoOrders, 0) AS DaysBetweenLastTwoOrders,
    CASE 
        WHEN TotalLifetimeRevenue >= 100000.00 THEN '💎 PLATINUM VIP'
        WHEN TotalLifetimeRevenue >= 50000.00  THEN '🥇 GOLD VIP'
        WHEN LifetimeOrderCount > 0            THEN '🥈 ACTIVE'
        ELSE '💤 DORMANT PROSPECT'
    END AS AccountTierClassification
FROM AggregatedCustomerSummary;
GO

-- Verify View Output:
SELECT * 
FROM vw_EnterpriseCustomer360 
ORDER BY TotalLifetimeRevenue DESC;
GO

-- ====================================================================
-- 🧠 SECTION 6: TOP 20 WHITEBOARD INTERVIEW TRAPS CHEAT SHEET
-- ====================================================================

/*
   1. WHERE DENSE_RANK() = 2 -> Fails (Msg 4108). Fix: Wrap in CTE.
   2. DELETE duplicates without temp table -> Use CTE + ROW_NUMBER() > 1.
   3. WHERE id NOT IN (SELECT with NULL) -> 3VL returns 0 rows! Use LEFT JOIN.
   4. Can TRUNCATE rollback? -> YES! Inside explicit transaction.
   5. AVG(Salary) with NULLs -> Excludes NULLs. Use AVG(ISNULL(Salary, 0)).
   6. Self-join missing CEO -> Use LEFT JOIN to preserve NULL manager.
   7. Alternating M/F sort -> Use ROW_NUMBER() PARTITION BY Gender.
   8. Same card diff cities <= 5m -> Self-join ON ID < ID AND DATEDIFF <= 5.
   9. UNION vs UNION ALL -> UNION ALL skips expensive in-memory sort.
   10. Table A (4 '1's) JOIN Table B (3 '1's) -> 4 x 3 = 12 rows!
   11. 50% order drop -> Anchor with ROW_NUMBER() in CTE before LEAD().
   12. WHERE YEAR(date) = 2026 -> Non-SARGable. Use range: date >= '2026-01-01'.
   13. TRUNCATE parent with empty child -> Blocked by FK metadata check.
   14. NULL = NULL in ON predicate -> Evaluates to UNKNOWN. Use IS NULL OR.
   15. WHERE alias > 1000 -> Alias not visible in WHERE (Stage 2 vs 5).
   16. LEFT JOIN + WHERE Right.Col = 'X' -> Converts to INNER JOIN!
   17. COUNT(*) vs COUNT(Col) -> COUNT(Col) ignores NULLs; COUNT(*) counts rows.
   18. PK vs UNIQUE -> UNIQUE allows 1 NULL in SQL Server; PK allows 0.
   19. DATEDIFF boundary count -> DATEDIFF('2025-12-31', '2026-01-01', YEAR) = 1.
   20. sp_rename vs ALTER TABLE -> sp_rename changes names; ALTER modifies types.
*/

-- ====================================================================
-- 🏁 SECTION 7: THE 13-STEP SQL PROBLEM-SOLVING ALGORITHM
-- ====================================================================

/*
   1. Clarify Output Granularity  (What does one row represent?)
   2. Identify Source Entities    (Which tables contain the attributes?)
   3. Determine Joins Needed      (INNER, LEFT to protect, or Anti-Join?)
   4. Check Cartesian Explosion   (Will duplicate keys multiply rows?)
   5. Filter Early at Stage 2     (Apply SARGable WHERE before grouping)
   6. Grouping vs Row Preservation(Do you need aggregate summary or details?)
   7. Window Functions Selection  (Top-N, rankings, running sums, LEAD/LAG?)
   8. Wrap into Sequential CTEs   (Never write deeply nested subqueries)
   9. Add Conditional Logic       (Use Searched CASE for dynamic tiers)
   10. Handle 3VL & NULL Traps    (Guard with ISNULL/COALESCE)
   11. Eliminate Mirror Duplicates(In self-joins, enforce A.ID < B.ID)
   12. Verify SARGability         (Keep indexed columns function-free)
   13. Final Deterministic Sort   (Apply explicit ORDER BY at Stage 6)
*/