/* ====================================================================
   🚀 10-HOUR SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 22)
   THE DEFINITIVE 22-DAY T-SQL REVISION & PRACTICE GUIDE
   Database: `BootcampMasteryDB` | Target: SSMS Direct Execution
   Author  : Pippo 🐥 | Candidate: Captain Arpit Manoj Bangre (Cap)
==================================================================== */

/*
====================================================================
           📑 MASTER TABLE OF CONTENTS & TOPIC INDEX
====================================================================
📦 SECTION 1: MASTER DATABASE & TABLE SETUP (`BootcampMasteryDB`)
   ├─ 1.1 Fresh Database Creation & Cleanup
   ├─ 1.2 Table Creation (8 Core Tables with Simple Keys)
   │     • Departments (Primary Key)
   │     • Employees (Primary Key, Foreign Key, Manager Hierarchy)
   │     • Customers (Primary Key)
   │     • Products (Primary Key)
   │     • Orders (Primary Key, Foreign Key)
   │     • OrderItems (Auto-Increment ID, Dual Foreign Keys)
   │     • BankTransactions (Fraud Detection Practice Table)
   │     • StockMovements (Stock In/Out Practice Table)
   └─ 1.3 Sample Data Insertion (Real-life Multi-City Records)

🏛️ SECTION 2: 22-DAY COMPLETE COURSE REVISION (SIMPLE ENGLISH)
   ├─ 🗓️ DAY 01: SQL Basics, 4 Command Types & Table Creation
   ├─ 🗓️ DAY 02: WHERE Filtering, Basic Operators & Wildcard Search
   ├─ 🗓️ DAY 03: Smart Pattern Matching with LIKE & NULL Safety
   ├─ 🗓️ DAY 04: Math Calculations, UPDATE, DELETE & Safe Changes
   ├─ 🗓️ DAY 05: DELETE vs TRUNCATE vs DROP & Table Structure Changes
   ├─ 🗓️ DAY 06: Aggregate Functions (MIN, MAX, AVG, SUM, COUNT) & TOP N
   ├─ 🗓️ DAY 07: The 6 Execution Steps, GROUP BY, HAVING & ORDER BY
   ├─ 🗓️ DAY 08: Common SQL Mistakes (WHERE on Rows vs HAVING on Groups)
   ├─ 🗓️ DAY 09: 4 Core Rules (PRIMARY KEY, UNIQUE, NOT NULL, CHECK)
   ├─ 🗓️ DAY 10: DEFAULT Values, Auto-ID (IDENTITY) & FOREIGN KEY Links
   ├─ 🗓️ DAY 11: Parent vs Child Table Rules when Deleting or Dropping
   ├─ 🗓️ DAY 12: Adding Rules to Old Data (3 Steps) & TRUNCATE Rollback
   ├─ 🗓️ DAY 13: Combining Results Vertically (UNION, UNION ALL, INTERSECT, EXCEPT)
   ├─ 🗓️ DAY 14: Date Functions (DATEDIFF, DATEADD, EOMONTH) & Fast Index Filters
   ├─ 🗓️ DAY 15: Joining Tables Basics, Row Multiplication & NULL Rules
   ├─ 🗓️ DAY 16: Standard Joins (INNER, LEFT, RIGHT, FULL) & Finding Missing Data
   ├─ 🗓️ DAY 17: Joining 3 or More Tables & Table Pairing (CROSS JOIN)
   ├─ 🗓️ DAY 18: Self-Joins (Employee-Boss Tree) & 5-Min Multi-City Fraud Check
   ├─ 🗓️ DAY 19: Ranking Functions (ROW_NUMBER, RANK, DENSE_RANK) & Filter Traps
   ├─ 🗓️ DAY 20: Common Table Expressions (CTEs) & Safe Duplicate Deletion
   ├─ 🗓️ DAY 21: Looking at Previous/Next Rows (LEAD/LAG) & Running Balances
   └─ 🗓️ DAY 22: IF-ELSE in SQL (CASE Statement) & Custom Priority Sorting

🧠 SECTION 3: QUICK SYNTAX MEMORY CHEAT SHEET
   ├─ Rule 1: The 6 SQL Execution Steps in Order
   ├─ Rule 2: 3-Step Recipe for Adding Constraints to Old Tables
   ├─ Rule 3: Fast Index Date Filter Template
   ├─ Rule 4: Difference between ROW_NUMBER, RANK, and DENSE_RANK
   ├─ Rule 5: LEAD, LAG & Running Balance Formula
   └─ Rule 6: Custom Priority Sorting with CASE

🧪 SECTION 4: 50 INTERVIEW PRACTICE QUESTIONS (SUPER 50)
   ├─ 🟢 Block 1: Basic Filters & Projections (Q01 – Q10)
   ├─ 🟡 Block 2: GROUP BY & Group Calculations (Q11 – Q20)
   ├─ 🟠 Block 3: Joining Tables & Self-Joins (Q21 – Q30)
   ├─ 🔴 Block 4: Window Ranking & Duplicate Removal (Q31 – Q40)
   └─ 💀 Block 5: Advanced Analytics & Tricky Scenarios (Q41 – Q50)

🏆 SECTION 5: FINAL BOSS PROJECT (360° Customer Intelligence View)
🧠 SECTION 6: TOP 20 INTERVIEW TRAPS & HOW TO FIX THEM
🏁 SECTION 7: THE 13-STEP METHOD TO SOLVE ANY SQL PROBLEM
====================================================================
*/

-- ====================================================================
-- 📦 SECTION 1: MASTER DATABASE & TABLE SETUP (`BootcampMasteryDB`)
-- ====================================================================

USE master;
GO

-- Recreate a clean database so tests are always 100% fresh
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

-- 2. Employees Table (Has ManagerID to show Boss-Employee link)
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

-- 6. OrderItems Table (Uses IDENTITY for auto 1, 2, 3 ID)
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL 
        FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT NOT NULL 
        FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- 7. BankTransactions Table (For Fraud & Speed Tests)
CREATE TABLE BankTransactions (
    TxnID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    TxnTimestamp DATETIME NOT NULL,
    TxnAmount DECIMAL(10,2) NOT NULL,
    TxnCity VARCHAR(50) NOT NULL,
    Channel VARCHAR(20) NOT NULL
);

-- 8. StockMovements Table (For Tracking Items In & Out)
CREATE TABLE StockMovements (
    MovementID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    MovementDate DATE NOT NULL,
    QtyChange INT NOT NULL
);
GO

-- ====================================================================
-- 🌱 INSERT SAMPLE REAL-LIFE DATA
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
-- 🏛️ SECTION 2: 22-DAY COMPLETE COURSE REVISION (SIMPLE ENGLISH)
-- ====================================================================

-- --------------------------------------------------------------------
-- 🗓️ DAY 01: SQL BASICS, 4 COMMAND TYPES & TABLE CREATION
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Data: Raw facts (like numbers or names).
   - Database: A digital organized locker to store data.
   - RDBMS: Software (like SQL Server) that stores data in connected tables.
   
   4 Types of SQL Commands:
   1. DDL (Create & Change Structure) : CREATE, ALTER, DROP, TRUNCATE.
   2. DML (Change Data Inside)        : INSERT, UPDATE, DELETE.
   3. DQL (Read & View Data)          : SELECT.
   4. TCL (Save & Undo Changes)       : COMMIT (save), ROLLBACK (undo).

   Keys:
   - Primary Key: Gives each row a unique identity number. No duplicates, no NULL.
   - Foreign Key: Connects a child table to a parent table.
*/

-- 1. View all columns in Employees table
SELECT EmpID, EmpName, DeptID, Salary, JoiningDate 
FROM Employees;

-- 2. View specific columns with clean English labels
SELECT 
    EmpName AS [Employee Full Name],
    Salary  AS [Monthly Base Salary]
FROM Employees;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 02: WHERE FILTERING, BASIC OPERATORS & WILDCARD SEARCH
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - WHERE: Filters rows one by one to pick only matching records.
   - Comparison: =, <> (not equal), <, <=, >, >=.
   - List & Range:
     • IN (1, 2)            : Matches if value is in list.
     • BETWEEN 100 AND 200  : Matches if value is between 100 and 200.
     • IS NULL / IS NOT NULL: Checks if value is empty/missing.
   - LIKE Wildcards:
     • '%'  : Means any number of characters (e.g. 'P%' means starts with P).
     • '_'  : Means exactly 1 single character.
*/

-- 1. List all active tables in our database
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

-- 2. Filter employees in Departments 1 or 2 earning 100k to 160k
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE DeptID IN (1, 2) 
  AND Salary BETWEEN 100000.00 AND 160000.00;

-- 3. Find customers from cities starting with 'P' or ending with 'luru'
SELECT CustomerID, CustomerName, City 
FROM Customers 
WHERE City LIKE 'P%' OR City LIKE '%luru';
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 03: SMART PATTERN MATCHING WITH LIKE & NULL SAFETY
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Fixed Length Pattern: 'A____n' matches 6-letter words (A + 4 letters + n).
   - Letter Ranges: '[A-M]%' matches names starting with any letter from A to M.
   - The Big NULL Rule:
     In SQL, NULL means "Unknown". If a person has no email (NULL),
     `WHERE Email NOT LIKE '%@gmail.com'` will drop them by mistake!
     -> Fix: Always write `WHERE Email NOT LIKE '%@gmail.com' OR Email IS NULL`.
*/

-- 1. Exact 6-letter name search
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE 'A____n';

-- 2. Search names starting with letters A to P
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE '[A-P]%';

-- 3. Safe query that keeps employees with NULL email
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 04: MATH CALCULATIONS, UPDATE, DELETE & SAFE CHANGES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - You can do direct math in SELECT (+, -, *, /).
   - UPDATE: Changes data in existing rows. Always use WHERE, or it updates everything!
   - DELETE: Removes rows one by one.
   - Safety: Wrap changes inside `BEGIN TRANSACTION` and check output with
     SELECT before running `COMMIT` or `ROLLBACK`.
*/

-- 1. Calculate 10% bonus and monthly split
SELECT 
    EmpID, EmpName, Salary,
    (Salary * 1.10)     AS [Salary With 10% Hike],
    (Salary / 12.0)     AS [Monthly Split],
    (Salary - 25000.00) AS [Net After Tax]
FROM Employees;

-- till here done 
-- 2. Test an update safely inside a transaction and rollback
BEGIN TRANSACTION;
    UPDATE Employees 
    SET Salary = Salary + 5000.00 
    WHERE DeptID = 4;
    
    -- Check updated salary
    SELECT EmpID, EmpName, DeptID, Salary 
    FROM Employees 
    WHERE DeptID = 4;
ROLLBACK TRANSACTION; -- Undo the change completely!
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 05: DELETE vs TRUNCATE vs DROP & TABLE STRUCTURE CHANGES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - DELETE   : Slowest | Deletes row by row | Can use WHERE | Keeps ID seed.
   - TRUNCATE : Super fast | Wipes all rows by freeing disk pages | Resets ID seed to 1.
   - DROP     : Completely destroys table and all its data.
   - ALTER TABLE: Adds new columns or changes data types.
   - sp_rename  : Built-in tool to rename tables or columns.
*/

-- 1. Create a quick test table
CREATE TABLE TempAuditTest (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    Notes VARCHAR(100) NULL
);

-- 2. Add a new column and change column size
ALTER TABLE TempAuditTest ADD StatusFlag CHAR(1) DEFAULT 'A';
ALTER TABLE TempAuditTest ALTER COLUMN Notes VARCHAR(250) NOT NULL;

-- 3. Delete the test table
DROP TABLE TempAuditTest;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 06: AGGREGATE FUNCTIONS (MIN, MAX, AVG, SUM, COUNT) & TOP N
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 5 Main Summary Functions:
     • MIN(col)   : Smallest value.
     • MAX(col)   : Highest value.
     • SUM(col)   : Total addition.
     • AVG(col)   : Average value (Note: Silently skips NULL rows!).
     • COUNT(col) : Counts non-empty rows.
     • COUNT(*)   : Counts all rows (including empty/NULL rows).
   - TOP N: Picks first N rows based on sorting.
*/

-- 1. Complete company salary summary
SELECT 
    COUNT(*)                 AS [Total Headcount],
    COUNT(Email)             AS [Employees With Email],
    COUNT(DISTINCT DeptID)   AS [Total Departments],
    MIN(Salary)              AS [Lowest Salary],
    MAX(Salary)              AS [Highest Salary],
    AVG(Salary)              AS [Average Salary],
    AVG(ISNULL(Salary, 0.0)) AS [Average Including 0],
    SUM(Salary)              AS [Total Company Payroll]
FROM Employees;

-- 2. Find Top 3 highest earning employees
SELECT TOP 3 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 07: THE 6 EXECUTION STEPS, GROUP BY, HAVING & ORDER BY
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   SQL does NOT read top to bottom. It runs in this exact 6-step order:
   
   Step 1: FROM + JOIN  ──► Pick tables and match rows.
   Step 2: WHERE        ──► Filter individual raw rows.
   Step 3: GROUP BY     ──► Group rows into buckets (e.g. by Department).
   Step 4: HAVING       ──► Filter group totals (e.g. Total Salary > 100k).
   Step 5: SELECT       ──► Pick columns and give them nicknames (Aliases).
   Step 6: ORDER BY     ──► Sort the final output (Can see SELECT nicknames!).

   * Why WHERE fails on nicknames: WHERE runs at Step 2, before nicknames 
     are created at Step 5.
   * Why ORDER BY works on nicknames: ORDER BY runs at Step 6, after SELECT.
*/

-- Running all 6 steps in one query:
SELECT 
    DeptID,
    COUNT(*)    AS Headcount,
    AVG(Salary) AS AvgDeptSalary
FROM Employees
WHERE JoiningDate >= '2023-01-01'  -- Step 2: Filter rows
GROUP BY DeptID                    -- Step 3: Bucket by department
HAVING AVG(Salary) >= 100000.00    -- Step 4: Filter bucket average
ORDER BY AvgDeptSalary DESC;       -- Step 6: Sort by Step 5 nickname!
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 08: COMMON SQL MISTAKES (WHERE on Rows vs HAVING on Groups)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Simple Golden Rule:
     • WHERE  -> Filters raw individual ROWS (runs before grouping).
     • HAVING -> Filters summarized GROUPS (runs after grouping).
   - Error Msg 8120:
     If you use GROUP BY, any column you put in SELECT must either be 
     in the GROUP BY list OR inside a function like SUM() / AVG()!
*/

-- ❌ Wrong: SELECT DeptID, COUNT(*) FROM Employees WHERE COUNT(*) > 2 GROUP BY DeptID;
-- ✅ Correct:
SELECT 
    DeptID,
    COUNT(*)    AS StaffCount,
    MIN(Salary) AS MinSalary,
    MAX(Salary) AS MaxSalary
FROM Employees 
GROUP BY DeptID 
HAVING COUNT(*) >= 2;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 09: 4 CORE RULES (PRIMARY KEY, UNIQUE, NOT NULL, CHECK)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   1. PRIMARY KEY : Unique ID for every row. Cannot be NULL (Max 1 per table).
   2. UNIQUE      : No duplicates allowed. (Allows 1 single NULL in SQL Server).
   3. NOT NULL    : Field cannot be left empty.
   4. CHECK       : Sets a business rule (e.g. Age must be 18 or older).
*/

CREATE TABLE TestRules_Day09 (
    RecordID INT PRIMARY KEY,
    UserEmail VARCHAR(100) UNIQUE NOT NULL,
    Age INT CHECK (Age >= 18 AND Age <= 65),
    Salary DECIMAL(10,2) CHECK (Salary > 0)
);

-- Insert 1 valid row
INSERT INTO TestRules_Day09 VALUES 
(1, 'demo.user@company.com', 25, 80000.00);

-- Delete test table
DROP TABLE TestRules_Day09;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 10: DEFAULT VALUES, AUTO-ID (IDENTITY) & FOREIGN KEY LINKS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - DEFAULT: Auto-fills value (like 'Active') if user doesn't provide one.
   - IDENTITY(1,1): Auto-generates numbers (1, 2, 3...) automatically.
   - FOREIGN KEY: Connects child table to parent table.
     • Prevents adding an order for a customer that does not exist.
*/
-- till here 
SELECT 
    e.EmpID, e.EmpName, e.Salary,
    d.DeptName, d.Location
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 11: PARENT VS CHILD TABLE RULES (DELETING & DROPPING)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Parent Table = Main master table (e.g. Departments).
   - Child Table  = Connected table (e.g. Employees).

   Rules:
   1. You cannot delete a Parent row if Child rows are using it.
   2. You CANNOT TRUNCATE a Parent table if a Child Foreign Key points to it,
      even if the child table is 100% empty!
   3. You cannot DROP a Parent table before dropping the Child link.
*/
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 12: ADDING RULES TO OLD DATA (3 STEPS) & TRUNCATE ROLLBACK
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 3-Step Recipe to add UNIQUE rule to a table with existing dirty data:
     • Step 1: Find duplicates using `GROUP BY col HAVING COUNT(*) > 1`.
     • Step 2: Delete extra copies using CTE and `ROW_NUMBER() > 1`.
     • Step 3: Add the rule using `ALTER TABLE ADD CONSTRAINT`.

   - Can TRUNCATE be undone?
     YES! In SQL Server, TRUNCATE runs inside transactions and can be 
     undone 100% with `ROLLBACK TRANSACTION`.
*/

-- Undo TRUNCATE proof test:
BEGIN TRANSACTION;
    TRUNCATE TABLE BankTransactions;
    -- Shows 0 rows inside transaction
    SELECT COUNT(*) AS [Rows Inside Transaction] FROM BankTransactions;
ROLLBACK TRANSACTION;

-- All 4 original rows are completely back!
SELECT COUNT(*) AS [Rows After Rollback] FROM BankTransactions;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 13: COMBINING RESULTS VERTICALLY (UNION, ALL, INTERSECT, EXCEPT)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Stacking query results on top of each other:
     • UNION     : Combines results and removes duplicate rows (slower).
     • UNION ALL : Combines results directly without removing duplicates (10x faster!).
     • INTERSECT : Shows only rows that exist in BOTH queries.
     • EXCEPT    : Shows rows from Query 1 that do not exist in Query 2.
   - Rule: Both queries must have the same number of columns and compatible types.
*/

-- 1. UNION (Combines and removes duplicates)
SELECT City FROM Customers
UNION
SELECT Location FROM Departments;

-- 2. UNION ALL (Combines and keeps all duplicates)
SELECT City FROM Customers
UNION ALL
SELECT Location FROM Departments;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 14: DATE FUNCTIONS & FAST INDEX SEARCHES (SARGABLE)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Useful Date Functions:
     • GETDATE()                  : Today's current date and time.
     • DATEDIFF(unit, start, end) : Counts how many days/months between two dates.
     • DATEADD(unit, n, date)     : Adds or subtracts days/months.
     • EOMONTH(date)              : Gives the last day of the month (e.g. 28 Feb).
   - Fast Index Search Rule (SARGable):
     • Slow (Table Scan): WHERE YEAR(OrderDate) = 2026
     • Fast (Index Seek): WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01'
*/

SELECT 
    OrderID, OrderDate,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS [Days Since Order],
    DATEADD(DAY, 7, OrderDate)          AS [Expected Delivery Date],
    DATEPART(QUARTER, OrderDate)        AS [Quarter Number],
    EOMONTH(OrderDate)                  AS [Month End Date]
FROM Orders;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 15: JOINING TABLES BASICS, ROW MULTIPLICATION & NULL RULES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - How Joins Work Behind the Scenes:
     Join = (Multiply Table A rows by Table B rows) + (Filter with ON rule).
   - Row Multiplication Rule:
     If Table A has 4 rows with ID '1', and Table B has 3 rows with ID '1':
     INNER JOIN creates 4 x 3 = 12 rows!
   - NULL Rule:
     In SQL, NULL = NULL is Unknown (False). Rows with NULL keys will not match!
*/

-- CROSS JOIN multiplies all customers by all orders:
SELECT 
    c.CustomerID, c.CustomerName, o.OrderID, o.TotalAmount
FROM Customers c
CROSS JOIN Orders o;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 16: STANDARD JOINS (INNER, LEFT, RIGHT, FULL) & ANTI-JOINS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 4 Main Join Types:
     • INNER JOIN : Shows only rows that match in BOTH tables.
     • LEFT JOIN  : Keeps ALL rows from left table; puts NULL if right has no match.
     • RIGHT JOIN : Keeps ALL rows from right table.
     • FULL JOIN  : Keeps ALL rows from both tables.
   - Anti-Join (Finding Missing Links):
     • Find customers who never ordered:
       `LEFT JOIN Orders ON ... WHERE Orders.OrderID IS NULL`
*/

-- 1. Standard Inner Join
SELECT e.EmpID, e.EmpName, d.DeptName, e.Salary 
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;

-- 2. Anti-Join: Find customers who NEVER placed an order
SELECT c.CustomerID, c.CustomerName, c.City 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 17: JOINING 3 OR MORE TABLES & TABLE PAIRING (CROSS JOIN)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Chaining Multiple Tables:
     Table 1 -> JOIN Table 2 ON ... -> JOIN Table 3 ON ...
   - Always use clean table short names (like `c` for Customers, `o` for Orders).
*/

SELECT 
    c.CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    p.Category,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice) AS [Line Total Price]
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 18: SELF-JOINS (EMPLOYEE-BOSS TREE) & 5-MIN FRAUD CHECK
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Self-Join: Joining a table to itself using two nicknames (`e` and `m`).
   - Boss Tree with CEO Protection:
     • Use LEFT JOIN so the CEO (who has NULL manager) is not dropped!
   - Removing Duplicate Pairs:
     • Writing `t1.ID < t2.ID` prevents pairing an item with itself and 
       removes reverse duplicates (like A-B and B-A).
*/

-- 1. Employee-Boss List (Includes CEO)
SELECT 
    e.EmpName AS [Employee Name],
    e.Salary  AS [Employee Salary],
    ISNULL(m.EmpName, '👑 Top CEO (No Boss)') AS [Manager Name],
    m.Salary  AS [Manager Salary]
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- 2. Fraud Check: Same account transacting in different cities in <= 5 mins
SELECT 
    t1.AccountID,
    t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
    t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
    DATEDIFF(SECOND, t1.TxnTimestamp, t2.TxnTimestamp) AS [Seconds Apart]
FROM BankTransactions t1
INNER JOIN BankTransactions t2 
    ON t1.AccountID = t2.AccountID
   AND t1.TxnID < t2.TxnID                          -- Stops self-pairing & reverse duplicates
   AND t1.TxnCity <> t2.TxnCity                     -- Different cities
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 19: RANKING FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 3 Ways to Rank Rows:
     • ROW_NUMBER() : Simple 1, 2, 3, 4 (Every row gets a unique number).
     • DENSE_RANK() : Tied items get same number, NO gaps: 1, 2, 2, 3 (Best for 2nd highest).
     • RANK()       : Tied items get same number, LEAVES gaps: 1, 2, 2, 4.
   - The WHERE Trap (Error 4108):
     • You CANNOT put `WHERE ROW_NUMBER() = 1`.
     • Fix: Put the query inside a CTE or subquery first, then filter!
*/

-- 1. Compare the 3 ranking functions side-by-side
SELECT 
    DeptID, EmpName, Salary,
    ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS [Row Number],
    DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS [Dense Rank (No Gaps)],
    RANK()       OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS [Rank (With Gaps)]
FROM Employees;

-- 2. Find Top 1 highest earner per department
SELECT DeptID, EmpName, Salary 
FROM (
    SELECT DeptID, EmpName, Salary,
           DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rnk
    FROM Employees
) RankedSalaries
WHERE rnk = 1;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 20: COMMON TABLE EXPRESSIONS (CTEs) & DEDUPLICATION
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is a CTE?
     A clean temporary named query block created with `WITH CTE_Name AS (...)`.
   - Safe Duplicate Deletion:
     In SQL Server, you can run `DELETE` directly on a CTE, and it deletes
     duplicate rows straight from the real table!
*/

-- Safe Duplicate Deletion Template:
WITH DuplicateCleaner AS (
    SELECT CustomerID, Email,
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY RegistrationDate ASC
           ) AS OccurrenceNumber
    FROM Customers
    WHERE Email IS NOT NULL
)
-- Preview first: SELECT * FROM DuplicateCleaner WHERE OccurrenceNumber > 1;
DELETE FROM DuplicateCleaner 
WHERE OccurrenceNumber > 1;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 21: LOOKING AT PREVIOUS/NEXT ROWS (LEAD/LAG) & RUNNING TOTALS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Looking across rows:
     • LAG(col, 1, 0)  : Looks at the PREVIOUS row value.
     • LEAD(col, 1, 0) : Looks at the NEXT upcoming row value.
   - Cumulative Running Total:
     • `SUM(col) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`
     • Adds up amounts continuously from top row down to current row.
*/

-- 1. Look at previous transaction amount and running account balance
SELECT 
    AccountID, TxnTimestamp, TxnAmount,
    LAG(TxnAmount, 1, 0.00) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp
    ) AS [Previous Transaction Amount],
    SUM(TxnAmount) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS [Running Account Balance]
FROM BankTransactions;

-- 2. Track warehouse stock changes over time
SELECT 
    ProductID, MovementDate, QtyChange,
    SUM(QtyChange) OVER (
        PARTITION BY ProductID 
        ORDER BY MovementDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS [Stock Remaining On Hand]
FROM StockMovements;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 22: IF-ELSE IN SQL (CASE STATEMENT) & CUSTOM SORTING
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - CASE Expression:
     Works like IF-THEN-ELSE to label data dynamically.
   - Custom Priority Sorting:
     You can sort your favourite city (e.g. Pune) to the top of the list
     without changing any database data!
*/

-- 1. Label employees into salary tiers
SELECT 
    EmpID, EmpName, Salary,
    CASE 
        WHEN Salary >= 140000.00 THEN '💎 Executive Tier'
        WHEN Salary >= 110000.00 THEN '🥇 Senior Tier'
        ELSE '🥈 Associate Tier'
    END AS [Salary Level]
FROM Employees;

-- 2. Custom Priority Sorting (Pune 1st, Bengaluru 2nd, other cities alphabetical)
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
-- 🧠 SECTION 3: QUICK SYNTAX MEMORY CHEAT SHEET
-- ====================================================================

/*
   RULE 1: 6-STAGE EXECUTION ORDER
   Write the 6 stages in order from memory:
   1. FROM + JOIN
   2. WHERE
   3. GROUP BY
   4. HAVING
   5. SELECT
   6. ORDER BY
*/

/*
   RULE 2: 3-STEP CONSTRAINT RETROFITTING
   Step 1: SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 1;
   Step 2: WITH C AS (SELECT id, ROW_NUMBER() OVER(PARTITION BY col ORDER BY id) rn FROM table)
           DELETE FROM C WHERE rn > 1;
   Step 3: ALTER TABLE table ADD CONSTRAINT UQ_name UNIQUE (col);
*/

/*
   RULE 3: SARGABLE DATE FILTERING
   -- Slow (Scan): WHERE YEAR(OrderDate) = 2026 AND MONTH(OrderDate) = 5
   -- Fast (Seek): WHERE OrderDate >= '2026-05-01' AND OrderDate < '2026-06-01'
*/

/*
   RULE 4: 3-WAY RANKING BEHAVIOR
   - ROW_NUMBER() : Unique sequential (1, 2, 3, 4) - Deduplication & Pagination
   - DENSE_RANK() : Tied shared rank without gaps (1, 2, 2, 3) - Nth highest salary
   - RANK()       : Tied shared rank with gaps (1, 2, 2, 4) - Official standings
*/

/*
   RULE 5: VALUE WINDOW FUNCTIONS & RUNNING TOTALS
   - LAG(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - LEAD(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - SUM(col) OVER (PARTITION BY id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
*/

/*
   RULE 6: DYNAMIC PINNED SORTING (CASE)
   ORDER BY 
       CASE 
           WHEN City = 'Pune' THEN 1
           WHEN City = 'Bengaluru' THEN 2
           ELSE 3
       END ASC,
       City DESC;
*/

-- ====================================================================
-- 🧪 SECTION 4: 50 INTERVIEW PRACTICE QUESTIONS (SUPER 50)
-- --------------------------------------------------------------------
-- All official solutions are enclosed in comments below each question.
-- Try writing your own query in the blank space first!
-- ====================================================================

-- --------------------------------------------------------------------
-- 🟢 BLOCK 1: BASIC FILTERS & PROJECTIONS (Q01 – Q10)
-- --------------------------------------------------------------------

-- [Q01] Find all employees earning more than 120,000 ordered by salary highest first.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q01] ---
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE Salary > 120000.00 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q02] Find employees in Departments 1, 2, or 4 without typing multiple OR conditions.
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


-- [Q04] Find all employees whose email does NOT end with '@gmail.com' (keep employees with no email).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q04] ---
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;
-------------------------------- */


-- [Q05] Find orders placed between '2026-01-01' and '2026-03-31' using BETWEEN.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q05] ---
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM Orders 
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31';
-------------------------------- */


-- [Q06] Find top leaders who have no boss assigned (ManagerID is NULL).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q06] ---
SELECT EmpID, EmpName, Salary 
FROM Employees 
WHERE ManagerID IS NULL;
-------------------------------- */


-- [Q07] Find the top 5 highest-paid employees in the company.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q07] ---
SELECT TOP 5 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q08] Find the exact 2nd highest salary in the company using DENSE_RANK.
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


-- [Q09] In a single query, show Lowest, Highest, Average, Total salary and Total employee count.
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


-- [Q10] Show DeptID and total number of employees working in each department.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q10] ---
SELECT DeptID, COUNT(*) AS DeptHeadcount 
FROM Employees 
GROUP BY DeptID;
-------------------------------- */


-- --------------------------------------------------------------------
-- 🟡 BLOCK 2: GROUP BY & GROUP CALCULATIONS (Q11 – Q20)
-- --------------------------------------------------------------------

-- [Q11] Find departments that have more than 3 employees.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q11] ---
SELECT DeptID, COUNT(*) AS StaffCount 
FROM Employees 
GROUP BY DeptID 
HAVING COUNT(*) > 3;
-------------------------------- */


-- [Q12] Find departments where average salary is greater than 120,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q12] ---
SELECT DeptID, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY DeptID 
HAVING AVG(Salary) > 120000.00;
-------------------------------- */


-- [Q13] Find the single department that has the highest average salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q13] ---
SELECT TOP 1 DeptID, AVG(Salary) AS HighestAvgSalary 
FROM Employees 
GROUP BY DeptID 
ORDER BY AVG(Salary) DESC;
-------------------------------- */


-- [Q14] Find the department where the company spends the most total money on salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q14] ---
SELECT TOP 1 DeptID, SUM(Salary) AS TotalSpend 
FROM Employees 
GROUP BY DeptID 
ORDER BY SUM(Salary) DESC;
-------------------------------- */


-- [Q15] Find employees who earn more than their own department's average salary.
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


-- [Q16] Find the second-highest salary in the company without using window functions.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q16] ---
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees);
-------------------------------- */


-- [Q17] Find the 3rd highest salary using DENSE_RANK without using the TOP keyword.
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


-- [Q18] Find duplicate customer emails (emails appearing more than once).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q18] ---
SELECT Email, COUNT(*) AS DuplicateCount 
FROM Customers 
WHERE Email IS NOT NULL 
GROUP BY Email 
HAVING COUNT(*) > 1;
-------------------------------- */


-- [Q19] Find departments where the lowest-earning employee makes more than 90,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q19] ---
SELECT DeptID, MIN(Salary) AS LowestSalary 
FROM Employees 
GROUP BY DeptID 
HAVING MIN(Salary) > 90000.00;
-------------------------------- */


-- [Q20] Create a department report showing DeptName, TotalStaff, AvgSalary, TotalPayroll.
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
-- 🟠 BLOCK 3: JOINING TABLES & SELF-JOINS (Q21 – Q30)
-- --------------------------------------------------------------------

-- [Q21] Join Employees and Departments to show EmpID, EmpName, DeptName, Salary.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q21] ---
SELECT e.EmpID, e.EmpName, d.DeptName, e.Salary 
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;
-------------------------------- */


-- [Q22] Find employees who are not assigned to any department.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q22] ---
SELECT e.EmpID, e.EmpName 
FROM Employees e 
LEFT JOIN Departments d ON e.DeptID = d.DeptID 
WHERE d.DeptID IS NULL;
-------------------------------- */


-- [Q23] Find departments that have zero employees hired.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q23] ---
SELECT d.DeptID, d.DeptName 
FROM Departments d 
LEFT JOIN Employees e ON d.DeptID = e.DeptID 
WHERE e.EmpID IS NULL;
-------------------------------- */


-- [Q24] Join Customers and Orders to show CustomerName, OrderID, OrderDate, TotalAmount.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q24] ---
SELECT c.CustomerName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;
-------------------------------- */


-- [Q25] Find customers who have NEVER placed any order.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q25] ---
SELECT c.CustomerID, c.CustomerName, c.City 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;
-------------------------------- */


-- [Q26] Find products that have never been ordered by anyone.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q26] ---
SELECT p.ProductID, p.ProductName, p.Price 
FROM Products p 
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID 
WHERE oi.OrderItemID IS NULL;
-------------------------------- */


-- [Q27] Show Total Orders and Lifetime Spend per customer (include customers with 0 orders).
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


-- [Q28] Find employees who earn a higher salary than their direct manager.
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


-- [Q29] List all employees and their managers (show '👑 CEO' for top leader).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q29] ---
SELECT 
    e.EmpName AS EmployeeName,
    ISNULL(m.EmpName, '👑 CEO / NO MANAGER') AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;
-------------------------------- */


-- [Q30] Pair employees in the same department without pairing anyone with themselves or repeating.
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
-- 🔴 BLOCK 4: WINDOW RANKING & DUPLICATE REMOVAL (Q31 – Q40)
-- --------------------------------------------------------------------

-- [Q31] Find the highest paid employee in each department using DENSE_RANK.
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


-- [Q32] Find top 3 highest earners in each department using DENSE_RANK.
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


-- [Q33] Find the exact 2nd highest earner in each department using DENSE_RANK.
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


-- [Q34] Give every employee a unique line number (1, 2, 3...) ordered by salary highest first.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q34] ---
SELECT 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SeqID,
    EmpName, DeptID, Salary
FROM Employees;
-------------------------------- */


-- [Q35] Show DENSE_RANK and RANK side-by-side on salaries to see the gap difference.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q35] ---
SELECT 
    EmpName, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankNoGaps,
    RANK()       OVER (ORDER BY Salary DESC) AS PositionalRankWithGaps
FROM Employees;
-------------------------------- */


-- [Q36] Find employees who earn the exact same salary as another colleague (salary ties).
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


-- [Q37] Find the highest spending customer in each city using DENSE_RANK.
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


-- [Q38] Show only the most recent (latest) order for each customer using ROW_NUMBER.
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


-- [Q39] Show only the very first lifetime order for each customer using ROW_NUMBER.
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


-- [Q40] Find employees who earn more than the person hired immediately before them using LAG.
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
-- 💀 BLOCK 5: ADVANCED ANALYTICS & TRICKY SCENARIOS (Q41 – Q50)
-- --------------------------------------------------------------------

-- [Q41] Delete duplicate customer emails permanently using a CTE and ROW_NUMBER.
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


-- [Q42] Find customers who placed orders on two back-to-back calendar days using LAG.
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


-- [Q43] Find customers who had a gap of 30 or more days between two consecutive orders.
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


-- [Q44] Calculate running total of money spent by each customer over time using SUM() OVER.
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


-- [Q45] Show order amount, previous order amount, and the dollar difference using LAG.
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


-- [Q46] For each order, display the date of the customer's NEXT order using LEAD.
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


-- [Q47] Group employees into Executive (>=140k), Senior (110k-140k), Associate (<110k) and count staff.
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


-- [Q48] Find Top 2 salaries in each department (if two employees tie for 2nd, show both).
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
   AND t1.TxnID < t2.TxnID                          -- Stops self-pairing
   AND t1.TxnCity <> t2.TxnCity                     -- Different cities
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;
-------------------------------- */


-- [Q50] Build a 360-degree customer summary (Name, First Order, Latest Order, Lifetime Spend, Status Tier).
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

-- Check View Output:
SELECT * 
FROM vw_EnterpriseCustomer360 
ORDER BY TotalLifetimeRevenue DESC;
GO

-- ====================================================================
-- 🧠 SECTION 6: TOP 20 INTERVIEW TRAPS & HOW TO FIX THEM
-- ====================================================================

/*
   1. WHERE DENSE_RANK() = 2 -> Fails (Msg 4108). Fix: Wrap inside CTE or subquery.
   2. DELETE duplicates without temp table -> Use CTE + ROW_NUMBER() > 1.
   3. WHERE id NOT IN (SELECT with NULL) -> Returns 0 rows! Fix: Use LEFT JOIN ... WHERE IS NULL.
   4. Can TRUNCATE be undone? -> YES! Inside BEGIN TRANSACTION, it rolls back 100%.
   5. AVG(Salary) with NULLs -> Skips NULL rows. Use AVG(ISNULL(Salary, 0)) if NULL means 0.
   6. Boss Tree missing CEO -> Use LEFT JOIN on ManagerID so CEO is not dropped.
   7. Alternating Male/Female list -> Use ROW_NUMBER() PARTITION BY Gender.
   8. Same account diff cities in <= 5 mins -> Self-join with ID < ID and DATEDIFF <= 5.
   9. UNION vs UNION ALL -> UNION ALL is 10x faster because it skips in-memory duplicate sorting.
   10. Table A (4 '1's) JOIN Table B (3 '1's) -> Produces 4 x 3 = 12 rows!
   11. 50% order drop -> Anchor with ROW_NUMBER() in CTE before comparing with LEAD().
   12. WHERE YEAR(date) = 2026 -> Slow. Fix: Use date range: date >= '2026-01-01' AND < '2027-01-01'.
   13. TRUNCATE parent with empty child table -> Blocked by Foreign Key link.
   14. NULL = NULL in Join ON condition -> Evaluates to False. Use IS NULL OR.
   15. WHERE TotalSalary > 1000 -> Cannot use SELECT nickname in WHERE (Step 2 vs Step 5).
   16. LEFT JOIN + WHERE RightTable.City = 'Pune' -> Accidentally turns LEFT JOIN into INNER JOIN!
   17. COUNT(*) vs COUNT(Col) -> COUNT(Col) skips NULLs; COUNT(*) counts all rows.
   18. PK vs UNIQUE -> UNIQUE allows 1 single NULL in SQL Server; PK allows zero NULLs.
   19. DATEDIFF boundary count -> DATEDIFF('2025-12-31', '2026-01-01', YEAR) = 1 (even though 1 day passed).
   20. sp_rename vs ALTER TABLE -> sp_rename changes object names; ALTER changes data types.
*/

-- ====================================================================
-- 🏁 SECTION 7: THE 13-STEP METHOD TO SOLVE ANY SQL PROBLEM
-- ====================================================================

/*
   1. Clarify Output Granularity  (What does 1 single row mean?)
   2. Identify Source Tables      (Which tables have the columns I need?)
   3. Choose Correct Joins        (INNER, LEFT to keep parents, or Anti-Join?)
   4. Check Row Multiplication    (Will duplicate IDs multiply my rows?)
   5. Filter Early at Step 2      (Use fast WHERE filters before grouping)
   6. Check Grouping Need         (Do I need summary totals or row details?)
   7. Pick Window Functions       (Do I need Top-N, Rankings, LEAD/LAG, or Running Sum?)
   8. Wrap into Clean CTEs        (Avoid messy deep subqueries)
   9. Add Conditional Logic       (Use CASE for dynamic status labels or custom sorting)
   10. Guard Against NULLs        (Protect math and averages with ISNULL)
   11. Remove Reverse Duplicates  (In self-joins, use Table1.ID < Table2.ID)
   12. Fast Index Search          (Never wrap date columns in functions inside WHERE)
   13. Final Sort                 (Apply explicit ORDER BY at Step 6)
*/