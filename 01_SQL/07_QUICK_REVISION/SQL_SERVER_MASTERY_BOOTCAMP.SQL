/* ====================================================================
   🚀 SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 28)
   THE DEFINITIVE 28-DAY T-SQL REVISION & 60-QUESTION SPRINT ENGINE
   Database: `DataEngineeringMasterDB` | Target: SSMS Direct Execution
   Author  : Pippo 🐥 | Candidate: Captain Arpit Manoj Bangre (Cap)
==================================================================== */

/*
====================================================================
           📑 MASTER TABLE OF CONTENTS & TOPIC INDEX
====================================================================
📦 SECTION 1: MASTER DATABASE & TABLE SETUP (`DataEngineeringMasterDB`)
   ├─ 1.1 Fresh Database Creation & Cleanup
   ├─ 1.2 Table Creation (10 Core Enterprise Tables)
   │     • Departments (Primary Key)
   │     • Employees (Primary Key, Foreign Key, Manager Hierarchy)
   │     • Customers (Primary Key)
   │     • Products (Primary Key)
   │     • Orders (Primary Key, Foreign Key)
   │     • OrderItems (Auto-Increment ID, Dual Foreign Keys)
   │     • BankTransactions (Fraud Detection Practice Table)
   │     • StockMovements (Stock In/Out Practice Table)
   │     • SalaryAuditLog (Automated Triggers Audit Table)
   │     • StagingInvoices (Raw Type-Casting & String Sanitization Table)
   └─ 1.3 Sample Data Insertion (Real-life Multi-City Records)

🏛️ SECTION 2: 28-DAY COMPLETE REVISION WITH 60-QUESTION CHECKPOINTS
   ├─ 📚 MODULE A: SQL FOUNDATIONS & ROW FILTERING (DAYS 01 TO 05)
   │     ├─ 🗓️ DAY 01: SQL Basics, 4 Command Types & Table Creation
   │     ├─ 🗓️ DAY 02: WHERE Filtering, Basic Operators & Wildcard Search
   │     ├─ 🗓️ DAY 03: Smart Pattern Matching with LIKE & NULL Safety
   │     ├─ 🗓️ DAY 04: Math Calculations, UPDATE, DELETE & Safe Changes
   │     ├─ 🗓️ DAY 05: DELETE vs TRUNCATE vs DROP & Table Structure Changes
   │     └─ 🎯 CHECKPOINT 1: 10 FOUNDATION PRACTICE QUESTIONS (Q01 – Q10)
   │
   ├─ 📚 MODULE B: AGGREGATIONS, GROUPING & EXECUTION FLOW (DAYS 06 TO 08)
   │     ├─ 🗓️ DAY 06: Aggregate Functions (MIN, MAX, AVG, SUM, COUNT) & TOP N
   │     ├─ 🗓️ DAY 07: The 6 Execution Steps, GROUP BY, HAVING & ORDER BY
   │     ├─ 🗓️ DAY 08: Common SQL Mistakes (WHERE on Rows vs HAVING on Groups)
   │     └─ 🎯 CHECKPOINT 2: 10 AGGREGATION & FILTERING QUESTIONS (Q11 – Q20)
   │
   ├─ 📚 MODULE C: CONSTRAINTS, PARENT/CHILD & SET OPERATORS (DAYS 09 TO 13)
   │     ├─ 🗓️ DAY 09: 4 Core Rules (PRIMARY KEY, UNIQUE, NOT NULL, CHECK)
   │     ├─ 🗓️ DAY 10: DEFAULT Values, Auto-ID (IDENTITY) & FOREIGN KEY Links
   │     ├─ 🗓️ DAY 11: Parent vs Child Table Rules when Deleting or Dropping
   │     ├─ 🗓️ DAY 12: Adding Rules to Old Data (3 Steps) & TRUNCATE Rollback
   │     ├─ 🗓️ DAY 13: Combining Results Vertically (UNION, UNION ALL, INTERSECT, EXCEPT)
   │     └─ 🎯 CHECKPOINT 3: 10 CONSTRAINTS & SET OPERATOR QUESTIONS (Q21 – Q30)
   │
   ├─ 📚 MODULE D: TEMPORAL FUNCTIONS, MULTI-JOINS & HIERARCHIES (DAYS 14 TO 18)
   │     ├─ 🗓️ DAY 14: Date Functions (DATEDIFF, DATEADD, EOMONTH) & Fast Index Filters
   │     ├─ 🗓️ DAY 15: Joining Tables Basics, Row Multiplication & NULL Rules
   │     ├─ 🗓️ DAY 16: Standard Joins (INNER, LEFT, RIGHT, FULL) & Finding Missing Data
   │     ├─ 🗓️ DAY 17: Joining 3 or More Tables & Table Pairing (CROSS JOIN)
   │     ├─ 🗓️ DAY 18: Self-Joins (Employee-Boss Tree) & 5-Min Multi-City Fraud Check
   │     └─ 🎯 CHECKPOINT 4: 10 DATES & RELATIONAL JOINS QUESTIONS (Q31 – Q40)
   │
   ├─ 📚 MODULE E: ADVANCED ANALYTICS, WINDOW FUNCTIONS & LOGIC (DAYS 19 TO 22)
   │     ├─ 🗓️ DAY 19: Ranking Functions (ROW_NUMBER, RANK, DENSE_RANK) & Filter Traps
   │     ├─ 🗓️ DAY 20: Common Table Expressions (CTEs) & Safe Duplicate Deletion
   │     ├─ 🗓️ DAY 21: Looking at Previous/Next Rows (LEAD/LAG) & Running Balances
   │     ├─ 🗓️ DAY 22: IF-ELSE in SQL (CASE Statement) & Custom Priority Sorting
   │     └─ 🎯 CHECKPOINT 5: 10 WINDOW FUNCTIONS & CTE QUESTIONS (Q41 – Q50)
   │
   └─ 📚 MODULE F: TCL, SPs, VIEWS, INDEXES & TRIGGERS (DAYS 23 TO 28)
         ├─ 🗓️ DAY 23: Advanced Scenario Analytics & Surprise Test Lab
         ├─ 🗓️ DAY 24: T-SQL Server String Functions & PII Masking Engine
         ├─ 🗓️ DAY 25: String Slicing (LEFT/RIGHT), Casting & Full Name Parsers
         ├─ 🗓️ DAY 26: Transaction Control (TCL: ROLLBACK/COMMIT), NULLs & Subqueries vs CTEs
         ├─ 🗓️ DAY 27: Stored Procedures (Deduplication), Views & Clustered/Non-Clustered Indexes
         ├─ 🗓️ DAY 28: DML Triggers, Event-Driven Auditing & Magic Tables (INSERTED/DELETED)
         └─ 🎯 CHECKPOINT 6: 10 ADVANCED ARCHITECTURE & OPTIMIZATION QUESTIONS (Q51 – Q60)

🧠 SECTION 3: QUICK SYNTAX MEMORY CHEAT SHEET (RULES 1 TO 10)
🏆 SECTION 4: FINAL BOSS PROJECT (360° Customer & Financial Intelligence View)
🧠 SECTION 5: TOP 20 INTERVIEW TRAPS & HOW TO FIX THEM
⚡ SECTION 6: 20 SHORT INTERVIEW QUESTIONS & QUICK ANSWERS (RAPID RECALL)
🏁 SECTION 7: THE 13-STEP METHOD TO SOLVE ANY SQL PROBLEM
====================================================================
*/

-- ====================================================================
-- 📦 SECTION 1: MASTER DATABASE & TABLE SETUP (`DataEngineeringMasterDB`)
-- ====================================================================

USE master;
GO

-- Recreate a clean database so tests are always 100% fresh
IF DB_ID('DataEngineeringMasterDB') IS NOT NULL
BEGIN
    ALTER DATABASE DataEngineeringMasterDB 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataEngineeringMasterDB;
END;
GO

CREATE DATABASE DataEngineeringMasterDB;
GO

USE DataEngineeringMasterDB;
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

-- 9. SalaryAuditLog Table (For Event-Driven Trigger Auditing)
CREATE TABLE SalaryAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmpID INT NOT NULL,
    OldSalary DECIMAL(10,2) NOT NULL,
    NewSalary DECIMAL(10,2) NOT NULL,
    ChangedAt DATETIME DEFAULT GETDATE(),
    ChangedBy VARCHAR(50) DEFAULT SYSTEM_USER
);

-- 10. StagingInvoices Table (For Runtime Casting, BIGINT & String Cleansing)
CREATE TABLE StagingInvoices (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceCode VARCHAR(30) NOT NULL,
    RawAmount VARCHAR(30) NOT NULL,
    RawPaddedCity VARCHAR(50) NOT NULL,
    PaymentDate DATETIME NOT NULL
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
(1, 'Enterprise Cloud Server', 'Hardware', 85000.00),
(2, 'Mechanical Tactile Keyboard', 'Accessories', 8500.00),
(3, 'Wireless Precision Mouse', 'Accessories', 3200.00),
(4, '34-Inch Curved UltraWide Monitor', 'Monitors', 45000.00),
(5, 'Noise-Cancelling Pro Headset', 'Audio', 12500.00),
(6, 'Smart Office Standing Desk', 'Furniture', 28000.00);

INSERT INTO Orders VALUES
(1001, 1, '2026-01-10', 93500.00, '2026-01-14'),
(1002, 2, '2026-01-15', 3200.00,  '2026-01-18'),
(1003, 3, '2026-02-01', 45000.00, '2026-02-05'),
(1004, 1, '2026-02-20', 12500.00, '2026-02-25'),
(1005, 4, '2026-03-05', 133500.00, '2026-03-12'),
(1006, 5, '2026-03-18', 8500.00,  NULL), -- In transit
(1007, 2, '2026-04-02', 28000.00, '2026-04-08');

INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1001, 1, 1, 85000.00),
(1001, 2, 1, 8500.00),
(1002, 3, 1, 3200.00),
(1003, 4, 1, 45000.00),
(1004, 5, 1, 12500.00),
(1005, 1, 1, 85000.00),
(1005, 4, 1, 45000.00),
(1005, 3, 1, 3200.00),
(1006, 2, 1, 8500.00),
(1007, 6, 1, 28000.00);

INSERT INTO BankTransactions VALUES
(1, 1001, '2026-02-01 10:00:00', 5000.00,  'Pune',      'ATM'),
(2, 1001, '2026-02-01 10:03:00', 15000.00, 'Mumbai',    'POS'), -- Fraud Alert (3 mins gap)
(3, 1002, '2026-02-01 11:30:00', 2000.00,  'Bengaluru', 'UPI'),
(4, 1002, '2026-02-01 18:45:00', 12000.00, 'Bengaluru', 'NetBanking'),
(5, 1003, '2026-02-02 09:15:00', 8000.00,  'Delhi',     'ATM');

INSERT INTO StockMovements (ProductID, MovementDate, QtyChange) VALUES
(1, '2026-01-01', 50),
(1, '2026-01-10', -2),
(1, '2026-01-15', -1),
(2, '2026-01-01', 100),
(2, '2026-01-12', -5);

INSERT INTO StagingInvoices (InvoiceCode, RawAmount, RawPaddedCity, PaymentDate) VALUES
('INV-9081-IND', '1500000000', '	Pune		',       '2026-01-15 09:30:00'),
('INV-4321-USA', '3200000000', '  Mumbai   ',     '2026-03-20 14:15:00'),
('INV-8821-EUR', '4800000000', '	Bangalore	',   '2026-06-10 11:45:00'),
('INV-1092-GBP', '2100000000', '   Hyderabad   ', '2026-08-05 16:00:00');
GO


-- ====================================================================
-- 🏛️ SECTION 2: 28-DAY COMPLETE REVISION WITH 60-QUESTION CHECKPOINTS
-- ====================================================================

-- ####################################################################
-- 📚 MODULE A: SQL FOUNDATIONS & ROW FILTERING (DAYS 01 TO 05)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 01: SQL BASICS, 4 COMMAND TYPES & TABLE CREATION
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is SQL? A tool to ask questions and store information in tables.
   - The 4 Main Types of Commands:
     1. DDL (Define table structure)  : CREATE, ALTER, DROP, TRUNCATE
     2. DML (Change rows inside)      : INSERT, UPDATE, DELETE
     3. DQL (Ask questions/read data) : SELECT
     4. TCL (Save or cancel changes)  : COMMIT, ROLLBACK
   - Real-life Analogy:
     Creating an empty Excel sheet is DDL. Typing rows inside it is DML.
*/

-- 1. Create a simple table
CREATE TABLE SampleDemo (
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- 2. Add rows and view them
INSERT INTO SampleDemo VALUES (1, 'Arpit'), (2, 'Pippo');
SELECT * FROM SampleDemo;

-- 3. Cleanup demo table
DROP TABLE SampleDemo;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 02: WHERE FILTERING, BASIC OPERATORS & WILDCARD SEARCH
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is WHERE? A filter to view only the rows you care about.
   - Comparison Operators:
     `=`, `<>` (not equal), `<`, `>`, `<=`, `>=`
   - List Checking (IN):
     Instead of writing `City = 'Pune' OR City = 'Mumbai'`, just write `City IN ('Pune', 'Mumbai')`.
   - Wildcard Search (LIKE):
     • `%` means any letters of any length.
     • `_` means exactly one single letter.
*/

-- 1. Find employees earning more than 120,000
SELECT EmpName, Salary 
FROM Employees 
WHERE Salary > 120000.00;

-- 2. Find employees in specific departments
SELECT EmpName, DeptID 
FROM Employees 
WHERE DeptID IN (1, 2);

-- 3. Find names starting with 'P'
SELECT EmpName 
FROM Employees 
WHERE EmpName LIKE 'P%';
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 03: SMART PATTERN MATCHING WITH LIKE & NULL SAFETY
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Precise Letter Counting:
     `A____n` means starts with A, has 4 letters in the middle, and ends with n (Total 6 letters).
   - Character Sets:
     `[A-M]%` means first letter must be between A and M.
   - The NULL Trap:
     `NULL` means missing unknown data. Writing `WHERE Email = NULL` returns 0 rows!
     Always write `WHERE Email IS NULL` or `WHERE Email IS NOT NULL`.
*/

-- 1. Find names starting with A or P
SELECT EmpName 
FROM Employees 
WHERE EmpName LIKE '[AP]%';

-- 2. Find employees who do not have an email address
SELECT EmpName, Email 
FROM Employees 
WHERE Email IS NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 04: MATH CALCULATIONS, UPDATE, DELETE & SAFE CHANGES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Math on Columns:
     You can calculate columns on the fly: `Salary * 1.10 AS NewSalary`.
   - UPDATE Statement: Modifies existing values.
   - DELETE Statement: Removes specific rows.
   - Golden Safety Rule:
     ALWAYS use a WHERE clause with UPDATE and DELETE! If you forget WHERE,
     you will update or erase every single row in the entire company table!
*/

-- 1. Calculate a 10% bonus for everyone
SELECT EmpName, Salary, (Salary * 0.10) AS DiwaliBonus 
FROM Employees;

-- 2. Update salary safely for one person
UPDATE Employees 
SET Salary = Salary + 5000.00 
WHERE EmpID = 110;

-- Revert back to original
UPDATE Employees 
SET Salary = Salary - 5000.00 
WHERE EmpID = 110;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 05: DELETE vs TRUNCATE vs DROP & TABLE STRUCTURE CHANGES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - The Big 3 Data Removal Methods:
     1. DELETE   : Removes specific rows one by one. Slow. Can use WHERE.
     2. TRUNCATE : Empties the entire table in 1 millisecond. Resets auto-IDs.
     3. DROP     : Completely destroys the table and deletes it from disk.
   - Changing Table Structure (ALTER):
     • Add a new column   : `ALTER TABLE Employees ADD Mobile VARCHAR(15);`
     • Drop an old column : `ALTER TABLE Employees DROP COLUMN Mobile;`
*/

-- 1. Add and remove a test column
ALTER TABLE Employees ADD TestNote VARCHAR(20);
ALTER TABLE Employees DROP COLUMN TestNote;
GO


-- ====================================================================
-- 🎯 CHECKPOINT 1: 10 FOUNDATION PRACTICE QUESTIONS (Q01 – Q10)
-- --------------------------------------------------------------------
-- Test your mastery of Days 01 to 05. Write your query in the blank space!
-- ====================================================================

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


-- [Q07] Find the top 3 highest-priced products in the catalog.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q07] ---
SELECT TOP 3 ProductID, ProductName, Price 
FROM Products 
ORDER BY Price DESC;
-------------------------------- */


-- [Q08] Project each product name with a 15% promotional discount price labeled as [DiscountPrice].
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q08] ---
SELECT ProductID, ProductName, Price, (Price * 0.85) AS DiscountPrice 
FROM Products;
-------------------------------- */


-- [Q09] Find all customers living in either 'Pune' or 'Bengaluru' who registered after '2024-02-01'.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q09] ---
SELECT CustomerID, CustomerName, City, RegistrationDate 
FROM Customers 
WHERE City IN ('Pune', 'Bengaluru') 
  AND RegistrationDate > '2024-02-01';
-------------------------------- */


-- [Q10] Find employees whose name starts with letters between 'A' and 'N' inclusive.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q10] ---
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE '[A-N]%';
-------------------------------- */
GO


-- ####################################################################
-- 📚 MODULE B: AGGREGATIONS, GROUPING & EXECUTION FLOW (DAYS 06 TO 08)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 06: AGGREGATE FUNCTIONS (MIN, MAX, AVG, SUM, COUNT) & TOP N
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What are Aggregates? Functions that summarize many rows into 1 single answer:
     • MIN() : Smallest value
     • MAX() : Largest value
     • SUM() : Total addition of numbers
     • AVG() : Average of numbers (Ignores NULLs automatically!)
     • COUNT(): Counts occurrences of items
   - COUNT(*) vs COUNT(col):
     • COUNT(*) counts every single row including NULLs.
     • COUNT(col) counts only rows where that specific column has data.
*/

-- Summary stats for the whole company
SELECT 
    MIN(Salary) AS LowestSalary,
    MAX(Salary) AS HighestSalary,
    AVG(Salary) AS AverageSalary,
    SUM(Salary) AS TotalSalaryBudget,
    COUNT(*)    AS TotalEmployees
FROM Employees;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 07: THE 6 EXECUTION STEPS, GROUP BY, HAVING & ORDER BY
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is GROUP BY?
     Puts rows into category buckets (e.g. calculate average salary per department).
   - WHERE vs HAVING:
     • WHERE filters individual rows BEFORE grouping.
     • HAVING filters grouped summary buckets AFTER grouping.
   - The 6 Order-of-Execution Steps:
     1. FROM     (Get table)
     2. WHERE    (Filter raw rows)
     3. GROUP BY (Put in buckets)
     4. HAVING   (Filter buckets)
     5. SELECT   (Pick columns & do math)
     6. ORDER BY (Sort final answer)
*/

-- Department salary summary for high-paying departments
SELECT 
    DeptID,
    COUNT(*)    AS EmployeeCount,
    AVG(Salary) AS AvgDeptSalary
FROM Employees
WHERE Salary >= 90000.00 -- Step 2: Row filter
GROUP BY DeptID          -- Step 3: Grouping
HAVING AVG(Salary) > 120000.00 -- Step 4: Group filter
ORDER BY AvgDeptSalary DESC;   -- Step 6: Sorting
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 08: COMMON SQL MISTAKES (WHERE ON ROWS vs HAVING ON GROUPS)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Mistake 1: Trying to use a column alias in WHERE:
     `SELECT Salary * 1.1 AS NewSalary FROM Employees WHERE NewSalary > 100000;` ❌ Fails!
     Reason: WHERE runs at Step 2, but SELECT alias is born at Step 5!
   - Mistake 2: Using HAVING like WHERE:
     Filtering raw columns in HAVING slows down queries on big databases.
     Always pre-filter raw rows in WHERE first!
*/

-- Correct way: Filter in WHERE, group, then filter groups
SELECT 
    DeptID, 
    SUM(Salary) AS TotalPayroll
FROM Employees
WHERE Gender = 'F' -- Pre-filter
GROUP BY DeptID
HAVING SUM(Salary) > 100000.00; -- Group filter
GO


-- ====================================================================
-- 🎯 CHECKPOINT 2: 10 AGGREGATION & FILTERING QUESTIONS (Q11 – Q20)
-- --------------------------------------------------------------------
-- Test your mastery of Days 06 to 08. Write your query in the blank space!
-- ====================================================================

-- [Q11] Show total salary budget and employee count for each DepartmentID.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q11] ---
SELECT DeptID, 
       SUM(Salary) AS TotalBudget, 
       COUNT(*) AS EmployeeCount 
FROM Employees 
GROUP BY DeptID;
-------------------------------- */


-- [Q12] Find departments where the average salary is greater than 120,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q12] ---
SELECT DeptID, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY DeptID 
HAVING AVG(Salary) > 120000.00;
-------------------------------- */


-- [Q13] Count how many unique cities our customers come from.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q13] ---
SELECT COUNT(DISTINCT City) AS UniqueCityCount 
FROM Customers;
-------------------------------- */


-- [Q14] Find how many female employees work in each department.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q14] ---
SELECT DeptID, COUNT(*) AS FemaleStaffCount 
FROM Employees 
WHERE Gender = 'F' 
GROUP BY DeptID;
-------------------------------- */


-- [Q15] Find the highest order amount placed by each customer.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q15] ---
SELECT CustomerID, MAX(TotalAmount) AS HighestOrderValue 
FROM Orders 
GROUP BY CustomerID;
-------------------------------- */


-- [Q16] Show cities that have 2 or more registered customers.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q16] ---
SELECT City, COUNT(*) AS CustomerCount 
FROM Customers 
GROUP BY City 
HAVING COUNT(*) >= 2;
-------------------------------- */


-- [Q17] Show product categories having average product price above 20,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q17] ---
SELECT Category, AVG(Price) AS AvgCategoryPrice 
FROM Products 
GROUP BY Category 
HAVING AVG(Price) > 20000.00;
-------------------------------- */


-- [Q18] Find total sales revenue per customer for completed deliveries only (DeliveryDate is NOT NULL).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q18] ---
SELECT CustomerID, SUM(TotalAmount) AS TotalDeliveredRevenue 
FROM Orders 
WHERE DeliveryDate IS NOT NULL 
GROUP BY CustomerID;
-------------------------------- */


-- [Q19] List all departments sorted by employee count descending, and then by total salary descending.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q19] ---
SELECT DeptID, COUNT(*) AS HeadCount, SUM(Salary) AS TotalSalary 
FROM Employees 
GROUP BY DeptID 
ORDER BY HeadCount DESC, TotalSalary DESC;
-------------------------------- */


-- [Q20] Find the minimum and maximum order amount across the entire Orders table.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q20] ---
SELECT MIN(TotalAmount) AS SmallestOrder, MAX(TotalAmount) AS LargestOrder 
FROM Orders;
-------------------------------- */
GO


-- ####################################################################
-- 📚 MODULE C: CONSTRAINTS, PARENT/CHILD & SET OPERATORS (DAYS 09 TO 13)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 09: 4 CORE RULES (PRIMARY KEY, UNIQUE, NOT NULL, CHECK)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Table Rules (Constraints) keep bad data out:
     1. PRIMARY KEY : Unique identity number for each row. Never NULL. Only 1 per table.
     2. UNIQUE      : No duplicate values allowed (Allows at most one NULL).
     3. NOT NULL    : Field cannot be left blank.
     4. CHECK       : Validates rules (e.g. `Salary > 0` or `Gender IN ('M', 'F')`).
*/

-- --------------------------------------------------------------------
-- 🗓️ DAY 10: DEFAULT VALUES, AUTO-ID (IDENTITY) & FOREIGN KEY LINKS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - DEFAULT   : Automatically fills in a value (e.g. `GETDATE()`) if you don't provide one.
   - IDENTITY  : Auto-increments numbers (1, 2, 3...) automatically on insert.
   - FOREIGN KEY: The bridge between 2 tables.
     Links Child table (`Orders.CustomerID`) to Parent table (`Customers.CustomerID`).
*/

-- --------------------------------------------------------------------
-- 🗓️ DAY 11: PARENT vs CHILD TABLE RULES WHEN DELETING OR DROPPING
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - The Golden Parent-Child Rule:
     You CANNOT delete a Parent row if Child rows still depend on it!
     Example: If Customer #1 has orders in `Orders`, trying to delete Customer #1
     causes SQL Server to block the deletion (Foreign Key Error)!
   - Teardown Order:
     Always delete or drop Child tables FIRST, then Parent tables LAST.
*/

-- --------------------------------------------------------------------
-- 🗓️ DAY 12: ADDING RULES TO OLD DATA (3 STEPS) & TRUNCATE ROLLBACK
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 3 Steps to Add a Rule to an Existing Table:
     Step 1: Clean bad/dirty data that violates the rule first.
     Step 2: If setting NOT NULL, use `ALTER TABLE ... ALTER COLUMN ... NOT NULL`.
     Step 3: Add named constraint: `ALTER TABLE ... ADD CONSTRAINT ...`.
   - TRUNCATE Rollback Secret:
     In SQL Server, inside `BEGIN TRANSACTION ... ROLLBACK`, even TRUNCATE can be undone!
*/

-- --------------------------------------------------------------------
-- 🗓️ DAY 13: COMBINING RESULTS VERTICALLY (UNION, UNION ALL, INTERSECT, EXCEPT)
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Vertical Stacking:
     • UNION     : Combines two lists and REMOVES duplicate rows.
     • UNION ALL : Combines two lists FAST without removing duplicates.
     • INTERSECT : Returns only rows that appear in BOTH lists.
     • EXCEPT    : Returns rows in List 1 that do NOT exist in List 2.
   - Rule: Both queries must have the exact same number of columns with matching data types!
*/

-- Employees and Customers combined into a single master contact directory
SELECT EmpName AS ContactName, Email, 'Employee' AS SourceType FROM Employees
UNION ALL
SELECT CustomerName, Email, 'Customer' AS SourceType FROM Customers;
GO


-- ====================================================================
-- 🎯 CHECKPOINT 3: 10 CONSTRAINTS & SET OPERATOR QUESTIONS (Q21 – Q30)
-- --------------------------------------------------------------------
-- Test your mastery of Days 09 to 13. Write your query in the blank space!
-- ====================================================================

-- [Q21] Find all unique cities that appear in EITHER Departments OR Customers.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q21] ---
SELECT Location AS City FROM Departments
UNION
SELECT City FROM Customers;
-------------------------------- */


-- [Q22] Find cities where we have BOTH a company department AND at least one customer.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q22] ---
SELECT Location FROM Departments
INTERSECT
SELECT City FROM Customers;
-------------------------------- */


-- [Q23] Find department cities where we have NO registered customers yet.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q23] ---
SELECT Location FROM Departments
EXCEPT
SELECT City FROM Customers;
-------------------------------- */


-- [Q24] Stack all employee emails and customer emails with duplicates included (fastest speed).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q24] ---
SELECT Email FROM Employees WHERE Email IS NOT NULL
UNION ALL
SELECT Email FROM Customers WHERE Email IS NOT NULL;
-------------------------------- */


-- [Q25] Find all products that have NEVER been ordered (using EXCEPT on ProductID).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q25] ---
SELECT ProductID FROM Products
EXCEPT
SELECT DISTINCT ProductID FROM OrderItems;
-------------------------------- */


-- [Q26] Show how to safely test TRUNCATE rollback behavior inside a transaction block.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q26] ---
BEGIN TRANSACTION;
    TRUNCATE TABLE StockMovements;
    -- Verify rows are gone in session
    -- SELECT COUNT(*) FROM StockMovements;
ROLLBACK TRANSACTION;
-- Verify rows are restored
-- SELECT COUNT(*) FROM StockMovements;
-------------------------------- */


-- [Q27] Demonstrate inserting an employee with Gender 'X' to prove CHECK constraint enforcement.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q27] ---
-- Expected to fail with Check Constraint Violation:
-- INSERT INTO Employees VALUES (999, 'Invalid Staff', 1, 101, '2026-01-01', 50000, 'X', 'test@company.com');
SELECT 'CHECK constraint Gender IN (''M'', ''F'') prevents invalid gender values' AS EnforcementProof;
-------------------------------- */


-- [Q28] Find customers who have ordered products in Category 'Hardware' using INTERSECT.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q28] ---
SELECT CustomerID FROM Orders
INTERSECT
SELECT o.CustomerID 
FROM Orders o 
JOIN OrderItems oi ON o.OrderID = oi.OrderID 
JOIN Products p ON oi.ProductID = p.ProductID 
WHERE p.Category = 'Hardware';
-------------------------------- */


-- [Q29] List all order IDs from 2026-01 that did NOT recur in 2026-02 for the same customer.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q29] ---
SELECT CustomerID FROM Orders WHERE OrderDate BETWEEN '2026-01-01' AND '2026-01-31'
EXCEPT
SELECT CustomerID FROM Orders WHERE OrderDate BETWEEN '2026-02-01' AND '2026-02-28';
-------------------------------- */


-- [Q30] Combine employee names and customer names into a single sorted directory.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q30] ---
SELECT EmpName AS PersonName FROM Employees
UNION
SELECT CustomerName AS PersonName FROM Customers
ORDER BY PersonName ASC;
-------------------------------- */
GO


-- ####################################################################
-- 📚 MODULE D: TEMPORAL FUNCTIONS, MULTI-JOINS & HIERARCHIES (DAYS 14 TO 18)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 14: DATE FUNCTIONS (DATEDIFF, DATEADD, EOMONTH) & FAST INDEX FILTERS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Date Calculation Tools:
     • DATEDIFF(unit, start, end) : Difference between two dates (DAY, MONTH, YEAR).
     • DATEADD(unit, count, date) : Adds or subtracts time.
     • EOMONTH(date)              : Returns the last day of the month.
   - Fast Index Rule (Sargability):
     NEVER wrap indexed columns in functions in WHERE:
     `WHERE YEAR(OrderDate) = 2026;` ❌ Bad! Slow table scan.
     `WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01';` ✅ Fast B-Tree Seek!
*/

-- Delivery turnaround days calculation
SELECT 
    OrderID, OrderDate, DeliveryDate,
    DATEDIFF(DAY, OrderDate, DeliveryDate) AS ShippingDays
FROM Orders
WHERE DeliveryDate IS NOT NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 15: JOINING TABLES BASICS, ROW MULTIPLICATION & NULL RULES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is a Relational Join?
     Matching rows from Table A with Table B side-by-side using a common key.
   - The Cartesian Trap (N x M):
     If you join tables without an `ON` condition, SQL Server multiplies every row:
     10 rows in A x 10 rows in B = 100 rows in result! Always provide `ON A.Key = B.Key`.
*/

-- --------------------------------------------------------------------
-- 🗓️ DAY 16: STANDARD JOINS (INNER, LEFT, RIGHT, FULL) & FINDING MISSING DATA
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - 4 Standard Join Types:
     1. INNER JOIN : Only keeps rows that match in BOTH tables.
     2. LEFT JOIN  : Keeps ALL rows from left table, fills NULLs if no match on right.
     3. RIGHT JOIN : Keeps ALL rows from right table, fills NULLs if no match on left.
     4. FULL JOIN  : Keeps ALL rows from both tables.
   - Finding Missing Data (Anti-Join):
     Use `LEFT JOIN ... WHERE RightTable.Key IS NULL`.
*/

-- Find customers who have never placed any order
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
   - Chaining Joins:
     Table A joins Table B, and Table B joins Table C.
   - CROSS JOIN:
     Pairs every row of Table A with every row of Table B (e.g. all teams playing each other).
*/

-- 3-Table Pipeline: Customer -> Order -> Product Details
SELECT 
    c.CustomerName,
    o.OrderID,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice,
    (oi.Quantity * oi.UnitPrice) AS LineTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 18: SELF-JOINS (EMPLOYEE-BOSS TREE) & 5-MIN MULTI-CITY FRAUD CHECK
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Self-Join: Joining a table to itself using two different aliases (`e` for Employee, `m` for Manager).
   - Real-World Use Cases:
     1. Hierarchy: Find each employee's manager name.
     2. Fraud Detection: Spot same account transacting in 2 different cities within 5 minutes!
*/

-- 1. Employee-Manager Hierarchy
SELECT 
    e.EmpName AS EmployeeName,
    m.EmpName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- 2. Bank Fraud Anomaly Detection (Different cities, < 10 mins apart)
SELECT 
    t1.AccountID,
    t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
    t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
    DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) AS TimeGapMinutes
FROM BankTransactions t1
JOIN BankTransactions t2 ON t1.AccountID = t2.AccountID 
                        AND t1.TxnID < t2.TxnID
WHERE t1.TxnCity <> t2.TxnCity
  AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) <= 10;
GO


-- ====================================================================
-- 🎯 CHECKPOINT 4: 10 DATES & RELATIONAL JOINS QUESTIONS (Q31 – Q40)
-- --------------------------------------------------------------------
-- Test your mastery of Days 14 to 18. Write your query in the blank space!
-- ====================================================================

-- [Q31] List every employee with their department name and office location.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q31] ---
SELECT e.EmpID, e.EmpName, d.DeptName, d.Location 
FROM Employees e 
JOIN Departments d ON e.DeptID = d.DeptID;
-------------------------------- */


-- [Q32] Find employees who earn strictly MORE than their direct manager.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q32] ---
SELECT e.EmpName AS StaffName, e.Salary AS StaffSalary,
       m.EmpName AS BossName, m.Salary AS BossSalary 
FROM Employees e 
JOIN Employees m ON e.ManagerID = m.EmpID 
WHERE e.Salary > m.Salary;
-------------------------------- */


-- [Q33] Find all products that have never been sold (LEFT JOIN check).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q33] ---
SELECT p.ProductID, p.ProductName, p.Price 
FROM Products p 
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID 
WHERE oi.OrderItemID IS NULL;
-------------------------------- */


-- [Q34] Find total revenue generated by each product category.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q34] ---
SELECT p.Category, SUM(oi.Quantity * oi.UnitPrice) AS CategoryRevenue 
FROM Products p 
JOIN OrderItems oi ON p.ProductID = oi.ProductID 
GROUP BY p.Category;
-------------------------------- */


-- [Q35] Generate all possible matchup pairs between departments without self-pairing (CROSS JOIN or inequality).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q35] ---
SELECT d1.DeptName AS DeptA, d2.DeptName AS DeptB 
FROM Departments d1 
JOIN Departments d2 ON d1.DeptID < d2.DeptID;
-------------------------------- */


-- [Q36] Find orders that took more than 4 days to deliver.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q36] ---
SELECT OrderID, CustomerID, OrderDate, DeliveryDate,
       DATEDIFF(DAY, OrderDate, DeliveryDate) AS DeliveryDays 
FROM Orders 
WHERE DeliveryDate IS NOT NULL 
  AND DATEDIFF(DAY, OrderDate, DeliveryDate) > 4;
-------------------------------- */


-- [Q37] Find all employees who joined the company in the year 2023 using sargable range boundaries.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q37] ---
SELECT EmpID, EmpName, JoiningDate 
FROM Employees 
WHERE JoiningDate >= '2023-01-01' AND JoiningDate < '2024-01-01';
-------------------------------- */


-- [Q38] Show customer name, order ID, and order total for orders placed in the first quarter of 2026.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q38] ---
SELECT c.CustomerName, o.OrderID, o.OrderDate, o.TotalAmount 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderDate >= '2026-01-01' AND o.OrderDate <= '2026-03-31';
-------------------------------- */


-- [Q39] Show the manager name and the count of direct reportees under each manager.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q39] ---
SELECT m.EmpName AS ManagerName, COUNT(e.EmpID) AS DirectReportsCount 
FROM Employees e 
JOIN Employees m ON e.ManagerID = m.EmpID 
GROUP BY m.EmpName;
-------------------------------- */


-- [Q40] Find accounts that had multiple bank transactions on the same calendar day.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q40] ---
SELECT AccountID, CAST(TxnTimestamp AS DATE) AS TxnDate, COUNT(*) AS DailyTxnCount 
FROM BankTransactions 
GROUP BY AccountID, CAST(TxnTimestamp AS DATE) 
HAVING COUNT(*) > 1;
-------------------------------- */
GO


-- ####################################################################
-- 📚 MODULE E: ADVANCED ANALYTICS, WINDOW FUNCTIONS & LOGIC (DAYS 19 TO 22)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 19: RANKING FUNCTIONS (ROW_NUMBER, RANK, DENSE_RANK) & FILTER TRAPS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Ranking Big 3:
     • ROW_NUMBER(): Assigns 1, 2, 3, 4 with no ties.
     • RANK()      : Gives same rank on tie, but skips numbers (1, 2, 2, 4).
     • DENSE_RANK(): Gives same rank on tie without skipping (1, 2, 2, 3).
   - The WHERE Clause Window Trap (Msg 4108):
     You CANNOT use window functions directly in WHERE!
     Always wrap them inside a CTE or Derived Table first!
*/

-- Top paid employee in each department
WITH RankedStaff AS (
    SELECT EmpID, EmpName, DeptID, Salary,
           DENSE_RANK() OVER (
               PARTITION BY DeptID 
               ORDER BY Salary DESC
           ) AS rnk
    FROM Employees
)
SELECT EmpID, EmpName, DeptID, Salary
FROM RankedStaff
WHERE rnk = 1;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 20: COMMON TABLE EXPRESSIONS (CTEs) & SAFE DUPLICATE DELETION
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
-- Preview: SELECT * FROM DuplicateCleaner WHERE OccurrenceNumber > 1;
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

-- Running account balance calculation
SELECT 
    AccountID, TxnTimestamp, TxnAmount,
    LAG(TxnAmount, 1, 0.00) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp
    ) AS [Previous Amount],
    SUM(TxnAmount) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS [Running Balance]
FROM BankTransactions;
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

-- 2. Custom Priority Sorting (Pune 1st, Bengaluru 2nd, others alphabetical)
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
-- 🎯 CHECKPOINT 5: 10 WINDOW FUNCTIONS & CTE QUESTIONS (Q41 – Q50)
-- --------------------------------------------------------------------
-- Test your mastery of Days 19 to 22. Write your query in the blank space!
-- ====================================================================

-- [Q41] Find the 2nd highest salary in the company using DENSE_RANK and a CTE.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q41] ---
WITH SalaryRanks AS (
    SELECT Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT DISTINCT Salary 
FROM SalaryRanks 
WHERE rnk = 2;
-------------------------------- */


-- [Q42] Find the top 2 highest-paid employees inside EACH department.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q42] ---
WITH DeptRanks AS (
    SELECT EmpID, EmpName, DeptID, Salary,
           DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT EmpID, EmpName, DeptID, Salary 
FROM DeptRanks 
WHERE rnk <= 2;
-------------------------------- */


-- [Q43] For each customer order, calculate the difference in amount compared to their previous order using LAG.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q43] ---
SELECT OrderID, CustomerID, OrderDate, TotalAmount,
       LAG(TotalAmount, 1, TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PrevOrderAmount,
       TotalAmount - LAG(TotalAmount, 1, TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderVariance 
FROM Orders;
-------------------------------- */


-- [Q44] Calculate the cumulative running revenue of orders sorted chronologically by OrderDate.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q44] ---
SELECT OrderID, CustomerID, OrderDate, TotalAmount,
       SUM(TotalAmount) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeRevenue 
FROM Orders;
-------------------------------- */


-- [Q45] Use CASE to classify orders as 'Small' (< 10,000), 'Medium' (10,000 to 50,000), or 'Large' (> 50,000).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q45] ---
SELECT OrderID, CustomerID, TotalAmount,
       CASE 
           WHEN TotalAmount > 50000.00 THEN 'Large'
           WHEN TotalAmount >= 10000.00 THEN 'Medium'
           ELSE 'Small'
       END AS OrderTier 
FROM Orders;
-------------------------------- */


-- [Q46] Using a CTE, delete duplicate customer entries keeping the one with earliest RegistrationDate.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q46] ---
WITH CustomerDedupe AS (
    SELECT CustomerID, Email,
           ROW_NUMBER() OVER (PARTITION BY Email ORDER BY RegistrationDate ASC) AS RowNum 
    FROM Customers 
    WHERE Email IS NOT NULL
)
DELETE FROM CustomerDedupe WHERE RowNum > 1;
-------------------------------- */


-- [Q47] Find the next upcoming order date for each customer using LEAD.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q47] ---
SELECT OrderID, CustomerID, OrderDate,
       LEAD(OrderDate, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS NextOrderDate 
FROM Orders;
-------------------------------- */


-- [Q48] Custom sort products so 'Hardware' is 1st, 'Monitors' 2nd, and remaining categories alphabetical.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q48] ---
SELECT ProductID, ProductName, Category, Price 
FROM Products 
ORDER BY 
    CASE 
        WHEN Category = 'Hardware' THEN 1
        WHEN Category = 'Monitors' THEN 2
        ELSE 3
    END ASC,
    ProductName ASC;
-------------------------------- */


-- [Q49] Number every employee chronologically by JoiningDate within their department using ROW_NUMBER.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q49] ---
SELECT DeptID, EmpName, JoiningDate,
       ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY JoiningDate ASC) AS SeniorityRank 
FROM Employees;
-------------------------------- */


-- [Q50] Calculate moving average order amount over a 3-order window (previous order, current, next).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q50] ---
SELECT OrderID, OrderDate, TotalAmount,
       AVG(TotalAmount) OVER (
           ORDER BY OrderDate 
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS MovingAvgAmount 
FROM Orders;
-------------------------------- */
GO


-- ####################################################################
-- 📚 MODULE F: STRING PIPELINES, SPs, TRIGGERS & INDEXES (DAYS 23 TO 28)
-- ####################################################################

-- --------------------------------------------------------------------
-- 🗓️ DAY 23: ADVANCED SCENARIO ANALYTICS & SURPRISE TEST LAB
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - High-Value Enterprise Scenarios:
     1. Big Salary Jumps: Spot employees whose salary jumped > 30% compared to previous grade via LAG().
     2. Multi-City Collision: Same bank card transacting in 2 cities within minutes (Self-Join fraud engine).
     3. 100% Calendar Active Customers: Customers who ordered across consecutive months.
*/

-- Track salary gap compared to preceding colleague in department
SELECT 
    EmpID, EmpName, DeptID, Salary,
    LAG(Salary) OVER (PARTITION BY DeptID ORDER BY Salary) AS LowerSalary,
    Salary - LAG(Salary) OVER (PARTITION BY DeptID ORDER BY Salary) AS SalaryStepGap
FROM Employees;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 24: T-SQL SERVER STRING FUNCTIONS & PII MASKING ENGINE
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Built-in Text Tools:
     • UPPER(str) / LOWER(str) : Capitalize or lowercase text.
     • LEN(str)                : Counts letters (Ignores trailing spaces!).
     • DATALENGTH(str)         : Measures actual physical byte storage on disk.
     • REVERSE(str)            : Inverts letters from back to front.
     • REPLACE(str, old, new)  : Substitutes characters.
     • REPLICATE(char, N)      : Repeats a character N times.
     • CONCAT(a, b, c)         : Safely joins text without NULL crash (unlike '+').
     • SUBSTRING(str, pos, len): Slices text starting at 1-based position.
*/

-- 1. PII Masking: Mask email handle keeping domain visible
SELECT 
    CustomerName, Email,
    CONCAT('*****', SUBSTRING(Email, CHARINDEX('@', Email), LEN(Email))) AS MaskedEmail
FROM Customers
WHERE Email IS NOT NULL;
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 25: STRING SLICING (LEFT/RIGHT), CASTING & FULL NAME PARSERS
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - Precision Boundary Slicers:
     • LEFT(str, N)  : Cuts N characters from front.
     • RIGHT(str, N) : Cuts N characters from back.
     • TRIM(str)     : Cleans dirty spaces and tabs '\t' from both ends.
   - Dynamic Full Name Parser:
     To split "Arpit Bangre":
     • First Name = `LEFT(Name, CHARINDEX(' ', Name) - 1)`
     • Last Name  = `SUBSTRING(Name, CHARINDEX(' ', Name) + 1, LEN(Name))`
   - CAST vs CONVERT:
     • `CAST(val AS INT)` : Universal ANSI SQL standard.
     • `CONVERT(VARCHAR, Date, 103)` : T-SQL with style codes (101 US, 103 British/Indian, 112 ISO).
*/

-- 1. Dynamic Full Name Splitting
SELECT 
    CustomerName,
    LEFT(CustomerName, CHARINDEX(' ', CustomerName) - 1) AS FirstName,
    SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName) + 1, LEN(CustomerName)) AS LastName
FROM Customers
WHERE CHARINDEX(' ', CustomerName) > 0;

-- 2. Date Style Formatting
SELECT 
    GETDATE() AS [System Date],
    CONVERT(VARCHAR, GETDATE(), 101) AS [US mm/dd/yyyy],
    CONVERT(VARCHAR, GETDATE(), 103) AS [Indian dd/mm/yyyy],
    CONVERT(VARCHAR, GETDATE(), 112) AS [Warehouse YYYYMMDD Key];
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 26: TRANSACTION CONTROL (TCL), NULL FUNCTIONS & SUBQUERIES VS CTES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is TCL (Transaction Control Language)?
     A safety net. By default, SQL runs in autocommit. Wrapping code inside
     `BEGIN TRANSACTION` lets you test changes and `ROLLBACK` (undo) if something goes wrong,
     or `COMMIT` (save permanently) to disk. In SQL Server, even DROP TABLE and TRUNCATE can be rolled back!
   - NULL Management (ISNULL vs COALESCE):
     • `ISNULL(check_col, replacement)` : T-SQL 2-parameter fast replacement.
     • `COALESCE(v1, v2, ... fallback)` : ANSI standard multi-column cascading fallback.
   - Subqueries vs Modern CTEs:
     Subqueries run nested loops and can cause table scan bottlenecks. Modern production
     replaces scalar subqueries with CTEs + `DENSE_RANK()`.
*/

-- 1. Explicit Transaction with ROLLBACK Demonstration
BEGIN TRANSACTION;
    DELETE FROM Customers WHERE CustomerID = 5;
    -- Verify in-flight deletion (row temporarily gone in this session)
    SELECT * FROM Customers WHERE CustomerID = 5;
ROLLBACK TRANSACTION; -- Undo deletion, restoring customer row 5!
GO

-- 2. NULL Replacement via ISNULL and COALESCE
SELECT 
    CustomerID, CustomerName,
    ISNULL(Email, 'no-email@domain.com') AS FastEmail,
    COALESCE(Email, 'contact@company.com') AS CascadingContact
FROM Customers;
GO

-- 3. Modern Production Alternative: CTE + DENSE_RANK() instead of Subquery
WITH CTE_SalaryRanks AS
(
    SELECT EmpID, EmpName, DeptID, Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT EmpID, EmpName, DeptID, Salary
FROM CTE_SalaryRanks
WHERE SalaryRank = 2; -- 2nd Highest Salary cleanly extracted in a single pass!
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 27: STORED PROCEDURES (DEDUPLICATION), VIEWS & INDEXING ARCHITECTURE
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is a Stored Procedure?
     A pre-compiled, reusable recipe of SQL code stored inside the engine.
     Accepts parameters, supports transaction control, and encapsulates deduplication pipelines.
   - What is a View?
     A saved virtual table (saved SELECT query). It stores NO physical rows on disk;
     it acts as a secure, simplified lens over complex multi-table data.
   - Clustered vs Non-Clustered Indexes:
     • Clustered Index: Physically sorts leaf data pages on disk (Dictionary order). Max 1 per table.
       Automatically created on PRIMARY KEY!
     • Non-Clustered Index: Auxiliary B-Tree lookup pointers (Index at back of book). Up to 999 per table.
     • Audit via `EXEC sp_helpindex 'TableName'`.
*/

-- 1. Create a Stored Procedure to Find Duplicate Orders via CTE
IF OBJECT_ID('usp_GetDuplicateOrders', 'P') IS NOT NULL 
    DROP PROCEDURE usp_GetDuplicateOrders;
GO

CREATE PROCEDURE usp_GetDuplicateOrders
AS
BEGIN
    SET NOCOUNT ON;
    WITH CTE_OrderDeduplication AS
    (
        SELECT OrderID, CustomerID, OrderDate, TotalAmount,
               ROW_NUMBER() OVER
               (
                   PARTITION BY CustomerID, OrderDate, TotalAmount
                   ORDER BY OrderID
               ) AS row_occurrence
        FROM Orders
    )
    SELECT OrderID, CustomerID, OrderDate, TotalAmount, row_occurrence
    FROM CTE_OrderDeduplication
    WHERE row_occurrence > 1;
END;
GO

-- Execute the Stored Procedure
EXEC usp_GetDuplicateOrders;
GO

-- 2. Create a Virtual View for Customer Spend Analytics with Searched CASE
IF OBJECT_ID('vw_CustomerSpendProfile', 'V') IS NOT NULL 
    DROP VIEW vw_CustomerSpendProfile;
GO

CREATE VIEW vw_CustomerSpendProfile AS
SELECT 
    c.CustomerID, c.CustomerName, c.City,
    COUNT(o.OrderID) AS TotalOrders,
    ISNULL(SUM(o.TotalAmount), 0.00) AS LifetimeSpend,
    CASE 
        WHEN SUM(o.TotalAmount) >= 30000.00 THEN 'VIP Tier'
        WHEN SUM(o.TotalAmount) >= 10000.00 THEN 'Gold Tier'
        ELSE 'Regular Tier'
    END AS CustomerTier
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.City;
GO

SELECT * FROM vw_CustomerSpendProfile;
GO

-- 3. Non-Clustered Index Creation & sp_helpindex Audit
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Customers_City' AND object_id = OBJECT_ID('Customers'))
    DROP INDEX IX_Customers_City ON Customers;
GO

CREATE NONCLUSTERED INDEX IX_Customers_City
ON Customers (City)
INCLUDE (CustomerName, Email);
GO

EXEC sp_helpindex 'Customers';
GO

-- --------------------------------------------------------------------
-- 🗓️ DAY 28: DML TRIGGERS, EVENT-DRIVEN AUDITING & MAGIC TABLES
-- --------------------------------------------------------------------
/*
   📖 SIMPLE EXPLANATION:
   - What is a Trigger?
     An automated watchdog that fires automatically when an INSERT, UPDATE, or DELETE occurs.
   - The Magic Tables:
     • `INSERTED` : Holds incoming new rows in RAM.
     • `DELETED`  : Holds old deleted or overwritten rows in RAM.
   - Scalable Math & BIGINT:
     Standard INT maxes out at 2.14 Billion. For large multi-million row revenue aggregations,
     cast numeric sums to `BIGINT` to prevent Arithmetic Overflow (Msg 8115).
*/

-- 1. Automated Audit Trigger on Salary Changes
IF OBJECT_ID('trg_AuditSalaryChanges', 'TR') IS NOT NULL 
    DROP TRIGGER trg_AuditSalaryChanges;
GO

CREATE TRIGGER trg_AuditSalaryChanges
ON Employees
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(Salary)
    BEGIN
        INSERT INTO SalaryAuditLog (EmpID, OldSalary, NewSalary, ChangedAt, ChangedBy)
        SELECT d.EmpID, d.Salary, i.Salary, GETDATE(), SYSTEM_USER
        FROM deleted d
        JOIN inserted i ON d.EmpID = i.EmpID;
    END;
END;
GO

-- 2. BIGINT Summation to Prevent Overflow
SELECT 
    InvoiceCode,
    COALESCE(RawAmount, '0') AS ValidatedAmount,
    CAST(RawAmount AS BIGINT) AS ScaledAmountBigInt
FROM StagingInvoices;
GO


-- ====================================================================
-- 🎯 CHECKPOINT 6: 10 ADVANCED ARCHITECTURE & OPTIMIZATION QUESTIONS (Q51 – Q60)
-- --------------------------------------------------------------------
-- Test your mastery of Days 23 to 28. Write your query in the blank space!
-- ====================================================================

-- [Q51] Dynamically split CustomerName into FirstName and LastName for all customers.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q51] ---
SELECT CustomerID, CustomerName,
       LEFT(CustomerName, CHARINDEX(' ', CustomerName) - 1) AS FirstName,
       SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName) + 1, LEN(CustomerName)) AS LastName 
FROM Customers 
WHERE CHARINDEX(' ', CustomerName) > 0;
-------------------------------- */


-- [Q52] Format OrderDate in both British format (dd/mm/yyyy - Style 103) and ISO Key format (yyyymmdd - Style 112).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q52] ---
SELECT OrderID, OrderDate,
       CONVERT(VARCHAR, OrderDate, 103) AS BritishDate,
       CONVERT(VARCHAR, OrderDate, 112) AS IsoDateKey 
FROM Orders;
-------------------------------- */


-- [Q53] In StagingInvoices, clean RawPaddedCity using TRIM() and compare lengths before and after cleansing.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q53] ---
SELECT InvoiceCode, RawPaddedCity,
       LEN(RawPaddedCity) AS DirtyLength,
       TRIM(RawPaddedCity) AS CleanCity,
       LEN(TRIM(RawPaddedCity)) AS CleanLength 
FROM StagingInvoices;
-------------------------------- */


-- [Q54] Demonstrate TCL safety: Begin an explicit transaction, delete customer 5, verify deletion, and ROLLBACK.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q54] ---
BEGIN TRANSACTION;
DELETE FROM Customers WHERE CustomerID = 5;
SELECT * FROM Customers WHERE CustomerID = 5;
ROLLBACK TRANSACTION;
-------------------------------- */


-- [Q55] Find the 2nd highest salary across Employees using CTE + DENSE_RANK() (modern anti-subquery standard).
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q55] ---
WITH CTE_RankedSalary AS
(
    SELECT EmpID, EmpName, DeptID, Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS Rnk
    FROM Employees
)
SELECT EmpID, EmpName, DeptID, Salary
FROM CTE_RankedSalary
WHERE Rnk = 2;
-------------------------------- */


-- [Q56] Create a stored procedure named `sp_GetCustomerOrders` that accepts `@CustID INT` and returns their orders.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q56] ---
-- CREATE PROCEDURE sp_GetCustomerOrders @CustID INT AS
-- BEGIN SET NOCOUNT ON; SELECT * FROM Orders WHERE CustomerID = @CustID; END;
SELECT * FROM Orders WHERE CustomerID = 1;
-------------------------------- */


-- [Q57] Create a view named `vw_HighValueOrders` displaying orders with TotalAmount > 20,000.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q57] ---
-- CREATE VIEW vw_HighValueOrders AS SELECT * FROM Orders WHERE TotalAmount > 20000.00;
SELECT OrderID, CustomerID, TotalAmount 
FROM Orders 
WHERE TotalAmount > 20000.00;
-------------------------------- */


-- [Q58] Create a non-clustered covering index `IX_Customers_City` on `Customers(City)` including CustomerName and Email.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q58] ---
-- CREATE NONCLUSTERED INDEX IX_Customers_City ON Customers (City) INCLUDE (CustomerName, Email);
SELECT CustomerName, Email FROM Customers WHERE City = 'Pune';
-------------------------------- */


-- [Q59] Create an automated AFTER UPDATE trigger `trg_AuditSalaryChanges` to log salary changes into SalaryAuditLog.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q59] ---
-- CREATE TRIGGER trg_AuditSalaryChanges ON Employees AFTER UPDATE AS
-- BEGIN
--     IF UPDATE(Salary)
--         INSERT INTO SalaryAuditLog (EmpID, OldSalary, NewSalary, ChangedAt, ChangedBy)
--         SELECT d.EmpID, d.Salary, i.Salary, GETDATE(), SYSTEM_USER
--         FROM deleted d JOIN inserted i ON d.EmpID = i.EmpID;
-- END;
SELECT * FROM SalaryAuditLog;
-------------------------------- */


-- [Q60] Detect potential fraud: Find any account in BankTransactions transacting in 2 different cities within 15 minutes.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q60] ---
SELECT t1.AccountID, 
       t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
       t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
       DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) AS GapMinutes 
FROM BankTransactions t1 
JOIN BankTransactions t2 ON t1.AccountID = t2.AccountID AND t1.TxnID < t2.TxnID 
WHERE t1.TxnCity <> t2.TxnCity 
  AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) <= 15;
-------------------------------- */
GO


-- ====================================================================
-- 🧠 SECTION 3: QUICK SYNTAX MEMORY CHEAT SHEET (RULES 1 TO 10)
-- ====================================================================
/*
   📌 RULE 1: The 6 SQL Execution Steps (FW-G-H-SO)
      1. FROM & JOIN
      2. WHERE
      3. GROUP BY
      4. HAVING
      5. SELECT
      6. ORDER BY

   📌 RULE 2: 3-Step Recipe for Adding Constraints
      Step 1: DELETE/UPDATE bad data first.
      Step 2: ALTER TABLE ... ALTER COLUMN ... NOT NULL;
      Step 3: ALTER TABLE ... ADD CONSTRAINT PK/FK/CHECK/DEFAULT;

   📌 RULE 3: Fast Index Date Filter Pattern
      WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01';

   📌 RULE 4: ROW_NUMBER vs RANK vs DENSE_RANK
      • Values: 100, 100, 90
      • ROW_NUMBER: 1, 2, 3
      • RANK      : 1, 1, 3  (Leaves gap!)
      • DENSE_RANK: 1, 1, 2  (No gap! Ideal for 2nd highest salary).

   📌 RULE 5: Dynamic Full Name Splitting
      • First Name = LEFT(FullName, CHARINDEX(' ', FullName) - 1)
      • Last Name  = SUBSTRING(FullName, CHARINDEX(' ', FullName) + 1, LEN(FullName))

   📌 RULE 6: Runtime Casting in Aggregations
      SUM(CAST(Amount AS BIGINT)) -- Prevents arithmetic overflow Msg 8115!

   📌 RULE 7: COALESCE vs ISNULL
      COALESCE(col1, col2, fallback) evaluates multi-expression list left to right.

   📌 RULE 8: Magic Tables in Triggers
      • INSERTED = New incoming values in RAM
      • DELETED  = Old deleted/overwritten values in RAM

   📌 RULE 9: Clustered vs Non-Clustered Index
      • Clustered     : Physical sorting on disk (1 per table).
      • Non-Clustered : Pointer B-Tree (Up to 999 per table).
      • Covering Index: Use INCLUDE (col) to eliminate Key Lookups.

   📌 RULE 10: Anti-Subquery Law
      Never use correlated subqueries when Window Functions or Joins solve the task!
*/


-- ====================================================================
-- 🏆 SECTION 4: FINAL BOSS PROJECT (360° CUSTOMER & FINANCIAL VIEW)
-- ====================================================================

IF OBJECT_ID('vw_Customer360Intelligence', 'V') IS NOT NULL 
    DROP VIEW vw_Customer360Intelligence;
GO

CREATE VIEW vw_Customer360Intelligence AS
WITH CustomerOrderStats AS (
    SELECT 
        c.CustomerID,
        c.CustomerName,
        c.City,
        COUNT(o.OrderID) AS TotalOrdersPlaced,
        COALESCE(SUM(o.TotalAmount), 0.00) AS LifetimeRevenue,
        MAX(o.OrderDate) AS LatestOrderDate
    FROM Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName, c.City
),
CustomerRankings AS (
    SELECT 
        CustomerID,
        CustomerName,
        City,
        TotalOrdersPlaced,
        LifetimeRevenue,
        LatestOrderDate,
        DENSE_RANK() OVER (ORDER BY LifetimeRevenue DESC) AS SpendingRank,
        CASE 
            WHEN LifetimeRevenue >= 100000.00 THEN '💎 Platinum VIP'
            WHEN LifetimeRevenue >= 30000.00  THEN '🥇 Gold Preferred'
            WHEN LifetimeRevenue > 0.00       THEN '🥈 Silver Active'
            ELSE '⚪ Inactive Lead'
        END AS LoyaltyTier
    FROM CustomerOrderStats
)
SELECT 
    CustomerID,
    CustomerName,
    City,
    TotalOrdersPlaced,
    LifetimeRevenue,
    LatestOrderDate,
    SpendingRank,
    LoyaltyTier
FROM CustomerRankings;
GO

-- Verify 360° Intelligence View
SELECT * FROM vw_Customer360Intelligence ORDER BY SpendingRank ASC;
GO


-- ====================================================================
-- 🧠 SECTION 5: TOP 20 INTERVIEW TRAPS & HOW TO FIX THEM
-- ====================================================================
/*
   1. The WHERE Alias Trap:
      Attempting to filter by SELECT alias in WHERE fails (WHERE runs at Step 2).
      Fix: Wrap inside a CTE or repeat expression in WHERE.

   2. The NULL Equality Trap:
      `WHERE col = NULL` returns nothing.
      Fix: Use `WHERE col IS NULL`.

   3. The NOT IN NULL Trap:
      `WHERE id NOT IN (SELECT id FROM t)` fails if subquery has even ONE NULL.
      Fix: Use `LEFT JOIN ... WHERE right.id IS NULL` or `WHERE id IS NOT NULL`.

   4. The AVG NULL Trap:
      AVG() ignores NULLs, calculating average over active rows only.
      Fix: Use `AVG(COALESCE(col, 0))` if NULLs should count as zero.

   5. The Non-Sargable Date Trap:
      `WHERE YEAR(date) = 2026` kills B-Tree indexes.
      Fix: `WHERE date >= '2026-01-01' AND date < '2027-01-01'`.

   6. The Cartesian Join Trap:
      Forgetting the ON clause creates an N x M row explosion.
      Fix: Always verify join predicate keys.

   7. The Window Function in WHERE Trap:
      `WHERE ROW_NUMBER() OVER (...) = 1` triggers Msg 4108.
      Fix: Wrap in a CTE and filter `rnk = 1` outside.

   8. The Single Name String Trap:
      `LEFT(Name, CHARINDEX(' ', Name) - 1)` crashes if no space exists (0 - 1 = -1).
      Fix: Use `CASE WHEN CHARINDEX(' ', Name) > 0 THEN ... ELSE Name END`.

   9. The Arithmetic Overflow Trap:
      `SUM(INT_col)` crashes on billions (Msg 8115).
      Fix: `SUM(CAST(col AS BIGINT))`.

   10. The Trailing Space Length Trap:
       LEN() ignores trailing spaces, but RIGHT() preserves them.
       Fix: Apply `TRIM()` or `RTRIM()` before slicing.

   11. The Parent-Child Delete Trap:
       Deleting parent record blocked by foreign key constraint.
       Fix: Delete child rows first or configure ON DELETE CASCADE.

   12. Correlated Subquery Trap:
       Running subquery per row chokes database engine.
       Fix: Convert to Window Functions or set-based ANSI Joins.

   13. Truncate Foreign Key Trap:
       TRUNCATE fails on parent table even if child table has 0 rows.
       Fix: Drop foreign key constraint first or use DELETE.

   14. The Missing Semicolon CTE Trap:
       Prior statement must end with semicolon `;` before `WITH CTE AS (...)`.
       Fix: Prepend `;WITH CTE AS (...)`.

   15. Missing ELSE in CASE Trap:
       If no conditions match and no ELSE exists, CASE returns NULL.
       Fix: Always provide explicit `ELSE 'Default'`.

   16. View Modification Single Table Rule:
       UPDATE on a view spanning multiple tables can only touch 1 table at a time.
       Fix: Target single base table or use INSTEAD OF Trigger.

   17. Dynamic SP SQL Injection Trap:
       Concatenating user text into `EXEC('...')`.
       Fix: Use parameterized SPs or `sp_executesql`.

   18. Missing Include Index Trap:
       Non-clustered index forces expensive Key Lookups for extra columns.
       Fix: Add `INCLUDE (col1, col2)`.

   19. Division by Zero Trap:
       `A / B` crashes if B is 0.
       Fix: Use `NULLIF(B, 0)`.

   20. Collation Case Sensitivity Trap:
       `CHECK (Code = UPPER(Code))` evaluates true in case-insensitive collation.
       Fix: Enforce binary collation: `COLLATE Latin1_General_BIN`.
*/


-- ====================================================================
-- ⚡ SECTION 6: 20 SHORT INTERVIEW QUESTIONS & QUICK ANSWERS (RAPID RECALL)
-- ====================================================================
/*
   Q01: What is the core difference between DELETE, TRUNCATE, and DROP?
   A01: • DELETE   = DML, row-by-row, WHERE supported, slower, fully logged in WAL.
        • TRUNCATE = DDL, deallocates entire 8 KB data pages, fast, resets IDENTITY.
        • DROP     = DDL, destroys table schema, structure, and all data permanently.

   Q02: What is the difference between WHERE and HAVING?
   A02: • WHERE filters individual rows BEFORE GROUP BY (Row-level filter).
        • HAVING filters aggregated summary rows AFTER GROUP BY (Group-level filter).

   Q03: What is the difference between PRIMARY KEY and UNIQUE KEY?
   A03: • PRIMARY KEY : Mandatory NOT NULL, creates Clustered Index (Max 1 per table).
        • UNIQUE KEY  : Allows 1 NULL (in SQL Server), creates Non-Clustered Index (Multiple allowed).

   Q04: What is the difference between UNION and UNION ALL?
   A04: • UNION ALL stacks datasets directly (Fast O(1), preserves duplicates).
        • UNION performs an internal sorting/distinct operation to remove duplicates (Slower).

   Q05: How do ROW_NUMBER(), RANK(), and DENSE_RANK() handle tied values (e.g. 90, 90, 80)?
   A05: • ROW_NUMBER() : Sequential unique numbers (1, 2, 3).
        • RANK()       : Tied values share rank, leaves gaps (1, 1, 3).
        • DENSE_RANK() : Tied values share rank, NO gaps left (1, 1, 2).

   Q06: What is the difference between LEAD() and LAG()?
   A06: • LAG()  peeks at preceding (previous) rows to calculate period-over-period delta.
        • LEAD() peeks at succeeding (next) rows to calculate future trends.

   Q07: What is the difference between ISNULL() and COALESCE()?
   A07: • ISNULL(a, b) : 2 parameters, returns datatype of 1st parameter (T-SQL specific).
        • COALESCE()   : Multi-parameter, returns 1st non-null value with highest precedence (ANSI standard).

   Q08: Can TRUNCATE be rolled back inside SQL Server transactions?
   A08: YES! In SQL Server, TRUNCATE logs page deallocations in the transaction log and CAN be rolled back
        inside an explicit `BEGIN TRANSACTION ... ROLLBACK` block.

   Q09: What is the difference between a Clustered Index and a Non-Clustered Index?
   A09: • Clustered Index     : Dictates physical disk order of data pages (Max 1 per table, like a Dictionary).
        • Non-Clustered Index : Separate B-Tree storing key columns + row pointers (Up to 999 per table, like Book Index).

   Q10: What is the logical execution order of SQL query clauses?
   A10: FROM -> ON -> JOIN -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> TOP / OFFSET.

   Q11: What are the magic tables `inserted` and `deleted` in Triggers?
   A11: Temporary RAM-resident system tables:
        • `inserted` holds incoming new rows (INSERT / UPDATE).
        • `deleted` holds old overwritten or removed rows (DELETE / UPDATE).

   Q12: What is the difference between an AFTER Trigger and an INSTEAD OF Trigger?
   A12: • AFTER Trigger      : Fires automatically AFTER the base DML mutation successfully commits to table.
        • INSTEAD OF Trigger : Intercepts the statement and executes custom logic IN PLACE OF the base DML (great for Views).

   Q13: What is the difference between a Standard View and a Materialized (Indexed) View?
   A13: • Standard View     : Virtual query macro. Stores NO rows on disk; evaluated dynamically on every read.
        • Materialized View : Has a unique clustered index (`WITH SCHEMABINDING`), physically computing & storing rows on disk.

   Q14: What is the difference between a Stored Procedure and a User-Defined Function (UDF)?
   A14: • Stored Procedure : Can execute DDL/DML, transaction control (`BEGIN TRAN`), and returns multiple result sets.
        • Function (UDF)   : Pure computation (Read-only), cannot mutate data, must return a single scalar or table.

   Q15: How do you safely delete duplicate rows keeping only the lowest ID?
   A15: Using a CTE with ROW_NUMBER():
        `WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY keys ORDER BY id) AS r FROM Table) DELETE FROM CTE WHERE r > 1;`

   Q16: How do you find the Nth highest salary without using inefficient subqueries?
   A16: `WITH CTE AS (SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk FROM Employees) SELECT Salary FROM CTE WHERE rnk = N;`

   Q17: What is a Covering Index?
   A17: A Non-Clustered Index that includes all columns needed by a query (via Index Keys + `INCLUDE` clause),
        answering the query completely from index leaf pages with ZERO expensive base table Key Lookups.

   Q18: What is Sargability and why is it critical for query performance?
   A18: Sargability (Search Argument Able) means writing WHERE predicates so the engine can perform B-Tree Index Seeks.
        Wrapping indexed columns in functions (e.g. `WHERE YEAR(date) = 2026`) destroys sargability and forces full table scans.

   Q19: How do aggregate functions like AVG() and COUNT() handle NULL values?
   A19: • `COUNT(*)` counts all rows including NULLs.
        • `COUNT(col)` counts only non-null values.
        • `AVG(col)`, `SUM(col)`, `MIN(col)`, `MAX(col)` ignore NULL values completely.

   Q20: What error occurs if you execute ROLLBACK after COMMIT in SQL Server?
   A20: Error Msg 3903: "The ROLLBACK TRANSACTION request has no corresponding BEGIN TRANSACTION" because COMMIT
        permanently finalized the transaction and closed the active transaction scope.
*/


-- ====================================================================
-- 🏁 SECTION 7: THE 13-STEP METHOD TO SOLVE ANY SQL PROBLEM
-- ====================================================================
/*
   1. Read the business question twice and underline required output columns.
   2. Identify the Primary Granularity: Does the question want 1 row per customer,
      per department, per order, or overall summary?
   3. Identify source tables: Where do these columns live?
   4. Choose Join Strategy:
      • Match only? -> INNER JOIN
      • Keep all from primary table? -> LEFT JOIN
      • Compare hierarchy? -> Self-Join
   5. Apply Early Filtering (WHERE): Filter invalid rows before grouping.
   6. Determine Grouping: Does the question ask "for each", "per", or summary?
      If yes -> GROUP BY.
   7. Filter Summary Buckets: Does the question filter on total/average?
      If yes -> HAVING.
   8. Check for Ranking Needs: Top-N per group, 2nd highest?
      If yes -> DENSE_RANK() / ROW_NUMBER() in a CTE.
   9. Check for Row Comparisons: Yesterday vs Today, Lead vs Lag?
      If yes -> LEAD() or LAG() in a CTE.
   10. Check for Conditional Labels: If-Else classifications?
       If yes -> CASE Expression.
   11. Sanitize Strings & Nulls: Use TRIM(), CHARINDEX(), COALESCE() where needed.
   12. Sort the Output: ORDER BY specific requirements.
   13. Sanity Check Edge Cases: What if value is NULL? What if 2 rows tie?
*/

-- ====================================================================
-- 🚀 END OF SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 28)
-- 🎓 CONGRATULATIONS CAPTAIN ARPIT! READY FOR TIER-1 DE OFFERS! 🐥🔥
-- ====================================================================