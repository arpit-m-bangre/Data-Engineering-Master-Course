/* ====================================================================
   🚀 10-HOUR SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 22)
   T-SQL BENCHMARKS, ARCHITECTURE & SUPER 50 INTERVIEW ENGINE
   Dialect: Microsoft SQL Server (T-SQL) | Target: SSMS Execution
   Author : Pippo 🐥 | Candidate: Captain Arpit Manoj Bangre (Cap)
==================================================================== */

-- ====================================================================
-- 📦 SECTION 1: MASTER TESTBED DATABASE & SCHEMA SETUP (CompanyDB)
-- ====================================================================

USE master;
GO

IF DB_ID('CompanyDB') IS NOT NULL
BEGIN
    ALTER DATABASE CompanyDB 
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CompanyDB;
END;
GO

CREATE DATABASE CompanyDB;
GO

USE CompanyDB;
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
-- 🧱 MODULE 1: DDL/DML, STORAGE & DELETION MECHANICS (HOURS 1 & 2)
-- ====================================================================

/*
   THE BIG DELETION BATTLE:
   - DELETE   : DML | Row-by-row lock | Keeps IDENTITY | Slower
   - TRUNCATE : DDL | Page deallocation | Resets IDENTITY | Fast
   - DROP     : DDL | Destroys table structure & metadata
   
   TRUNCATE ROLLBACK PROOF IN SQL SERVER:
   TRUNCATE can be rolled back 100% inside explicit transactions!
*/

BEGIN TRANSACTION;
    TRUNCATE TABLE BankTransactions;
    -- Returns 0 rows
    SELECT COUNT(*) AS CountAfterTruncate FROM BankTransactions;
ROLLBACK TRANSACTION;

-- Original 4 rows restored!
SELECT COUNT(*) AS CountAfterRollback FROM BankTransactions;

/*
   PATTERN MATCHING & 3VL (Three-Valued Logic):
   - '%'  : 0 or more chars
   - '_'  : Exactly 1 char
   - NULL : Represents UNKNOWN. col NOT IN (1, NULL) returns 0 rows!
*/

-- Exactly 6 letters: starts with A, ends with n
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE 'A____n';

-- Safe NULL handling with pattern exclusion
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;

-- ====================================================================
-- 📊 MODULE 2: AGGREGATIONS & 6-STAGE EXECUTION ENGINE (HOUR 3)
-- ====================================================================

/*
   THE 6-STAGE LOGICAL EXECUTION FLOW:
   Stage 1: FROM + JOIN  (Identify sources & Cartesian product)
   Stage 2: WHERE        (Filter raw rows before grouping)
   Stage 3: GROUP BY     (Bucket rows into aggregate groups)
   Stage 4: HAVING       (Filter aggregate group stats)
   Stage 5: SELECT       (Compute expressions & column aliases)
   Stage 6: ORDER BY     (Sort output - Can see SELECT aliases!)
*/

SELECT 
    DeptID,
    COUNT(*)    AS Headcount,
    AVG(Salary) AS AvgSalary
FROM Employees
WHERE JoiningDate >= '2023-01-01'  -- Stage 2: Filter rows
GROUP BY DeptID                    -- Stage 3: Bucket
HAVING AVG(Salary) >= 100000.00    -- Stage 4: Filter stats
ORDER BY AvgSalary DESC;           -- Stage 6: Sort by alias

-- ====================================================================
-- 🛡️ MODULE 3: CONSTRAINTS & DIRTY TABLE RETROFITTING (HOUR 4)
-- ====================================================================

/*
   3-STEP RETROFITTING FRAMEWORK:
   Step 1: Detect duplicate violations
   Step 2: Cleanse duplicates using CTE + ROW_NUMBER()
   Step 3: Apply ALTER TABLE ADD CONSTRAINT safely
*/

-- Step 1: Detect duplicates
SELECT Email, COUNT(*) AS DupCount 
FROM Customers 
WHERE Email IS NOT NULL 
GROUP BY Email 
HAVING COUNT(*) > 1;

-- Step 2: Cleanse duplicates (keep earliest)
WITH DuplicateCleanser AS (
    SELECT CustomerID, Email,
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY RegistrationDate ASC
           ) AS rn
    FROM Customers
    WHERE Email IS NOT NULL
)
DELETE FROM DuplicateCleanser WHERE rn > 1;

-- Step 3: Retrofit constraint
-- ALTER TABLE Customers ADD CONSTRAINT UQ_Customers_Email UNIQUE (Email);

-- ====================================================================
-- 📅 MODULE 4: SET OPERATORS & TEMPORAL ENGINE (HOUR 5)
-- ====================================================================

/*
   SET OPERATORS:
   - UNION     : Appends & deduplicates (in-memory sort)
   - UNION ALL : Appends directly (10x faster for big data!)
   - INTERSECT : Common rows
   - EXCEPT    : Query 1 minus Query 2

   SARGABLE TEMPORAL FILTERING:
   - Avoid: WHERE YEAR(OrderDate) = 2026 (Forces Table Scan)
   - Use  : WHERE OrderDate >= '2026-01-01' AND OrderDate < '2027-01-01' (Index Seek)
*/

SELECT OrderID, CustomerID, OrderDate, TotalAmount
FROM Orders
WHERE OrderDate >= '2026-01-01' 
  AND OrderDate < '2026-04-01';

-- ====================================================================
-- 🔗 MODULE 5: RELATIONAL JOINS & SELF-JOINS (HOURS 6 & 7)
-- ====================================================================

/*
   THE JOIN EQUATION:
   JOIN = (Cartesian Cross Product N x M) + (ON Filter)
*/

-- 1. Anti-Join: Customers who NEVER placed an order
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 2. Self-Join: Employee-to-Manager Tree (Preserve CEO with LEFT JOIN)
SELECT 
    e.EmpName AS EmployeeName,
    e.Salary  AS EmployeeSalary,
    ISNULL(m.EmpName, '👑 CEO / TOP EXECUTIVE') AS ManagerName,
    m.Salary  AS ManagerSalary
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- 3. Geo-Temporal Fraud Anomaly Engine (Diff city in <= 5 mins)
SELECT 
    t1.AccountID,
    t1.TxnID AS Txn1, t1.TxnCity AS City1, t1.TxnTimestamp AS Time1,
    t2.TxnID AS Txn2, t2.TxnCity AS City2, t2.TxnTimestamp AS Time2,
    DATEDIFF(SECOND, t1.TxnTimestamp, t2.TxnTimestamp) AS TimeDiffSec
FROM BankTransactions t1
INNER JOIN BankTransactions t2 
    ON t1.AccountID = t2.AccountID
   AND t1.TxnID < t2.TxnID      -- Eliminates mirror duplicates!
   AND t1.TxnCity <> t2.TxnCity -- Distinct cities
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;

-- ====================================================================
-- 👑 MODULE 6: WINDOW FUNCTIONS, CTES & ANALYTICS (HOURS 8 & 9)
-- ====================================================================

/*
   RANKING COMPARISON:
   - ROW_NUMBER() : 1, 2, 3, 4 (Zero gaps, unique sequential ID)
   - DENSE_RANK() : 1, 2, 2, 3 (Zero gaps, ties share rank)
   - RANK()       : 1, 2, 2, 4 (Leaves gaps after ties)
*/

-- 1. Ranking Engine Demonstration
SELECT 
    DeptID, EmpName, Salary,
    ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SeqRow,
    DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS DenseRnk,
    RANK()       OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS PosRnk
FROM Employees;

-- 2. LEAD / LAG & Cumulative Running Balance
SELECT 
    AccountID, TxnTimestamp, TxnAmount,
    LAG(TxnAmount, 1, 0.00) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp
    ) AS PrevTxnAmount,
    SUM(TxnAmount) OVER (
        PARTITION BY AccountID 
        ORDER BY TxnTimestamp 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningAccountBalance
FROM BankTransactions;

-- 3. Dynamic Pinned Sorting via Searched CASE
SELECT CustomerID, CustomerName, City
FROM Customers
ORDER BY 
    CASE 
        WHEN City = 'Pune'      THEN 1
        WHEN City = 'Bengaluru' THEN 2
        ELSE 3
    END ASC,
    City DESC;

-- ====================================================================
-- 🧪 50 HIGH-LEVEL SQL SERVER INTERVIEW CHALLENGES (SUPER 50)
-- ====================================================================

-- --------------------------------------------------------------------
-- 🟢 SECTION A: FOUNDATION & FILTERING (Q01 – Q10)
-- --------------------------------------------------------------------

-- Q01: Employees with Salary > 120,000 ordered descending
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE Salary > 120000.00 
ORDER BY Salary DESC;

-- Q02: Department Membership Filtering via IN
SELECT EmpID, EmpName, DeptID 
FROM Employees 
WHERE DeptID IN (1, 2, 4);

-- Q03: Pattern Matching: Starts with 'A', ends with 'n', exactly 6 chars
SELECT EmpID, EmpName 
FROM Employees 
WHERE EmpName LIKE 'A____n';

-- Q04: Non-Gmail Domain Users (Preserving NULLs)
SELECT EmpID, EmpName, Email 
FROM Employees 
WHERE Email NOT LIKE '%@gmail.com' 
   OR Email IS NULL;

-- Q05: Safe Range Filtering with BETWEEN
SELECT OrderID, CustomerID, OrderDate, TotalAmount 
FROM Orders 
WHERE OrderDate BETWEEN '2026-01-01' AND '2026-03-31';

-- Q06: Root Node Executives (No Manager Assigned)
SELECT EmpID, EmpName, Salary 
FROM Employees 
WHERE ManagerID IS NULL;

-- Q07: Top 5 Highest Compensated Employees
SELECT TOP 5 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;

-- Q08: Global 2nd Highest Salary via DENSE_RANK
WITH SalaryRanks AS (
    SELECT Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT DISTINCT Salary 
FROM SalaryRanks 
WHERE rnk = 2;

-- Q09: Departmental Salary Summary Aggregates
SELECT 
    COUNT(*)    AS Headcount,
    MIN(Salary) AS MinSal,
    MAX(Salary) AS MaxSal,
    AVG(Salary) AS AvgSal,
    SUM(Salary) AS TotalPayroll
FROM Employees;

-- Q10: Employee Headcount per Department
SELECT DeptID, COUNT(*) AS DeptHeadcount 
FROM Employees 
GROUP BY DeptID;

-- --------------------------------------------------------------------
-- 🟡 SECTION B: GROUP BY, HAVING & AGGREGATE DRILLS (Q11 – Q20)
-- --------------------------------------------------------------------

-- Q11: Departments with More Than 3 Employees
SELECT DeptID, COUNT(*) AS StaffCount 
FROM Employees 
GROUP BY DeptID 
HAVING COUNT(*) > 3;

-- Q12: High Average Salary Departments (> 120,000)
SELECT DeptID, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY DeptID 
HAVING AVG(Salary) > 120000.00;

-- Q13: Department with Absolute Highest Average Salary
SELECT TOP 1 DeptID, AVG(Salary) AS HighestAvgSalary 
FROM Employees 
GROUP BY DeptID 
ORDER BY AVG(Salary) DESC;

-- Q14: Department with Highest Cumulative Payroll Spend
SELECT TOP 1 DeptID, SUM(Salary) AS TotalSpend 
FROM Employees 
GROUP BY DeptID 
ORDER BY SUM(Salary) DESC;

-- Q15: Employees Earning More than Their Department's Average
WITH DeptAvg AS (
    SELECT DeptID, AVG(Salary) AS AvgSal 
    FROM Employees 
    GROUP BY DeptID
)
SELECT e.EmpID, e.EmpName, e.Salary, d.AvgSal AS DeptAverage
FROM Employees e
INNER JOIN DeptAvg d ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSal;

-- Q16: Second-Highest Salary without Window Functions
SELECT MAX(Salary) AS SecondHighestSalary 
FROM Employees 
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- Q17: Third-Highest Salary without TOP Keyword
WITH RankedSalaries AS (
    SELECT Salary, 
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk 
    FROM Employees
)
SELECT DISTINCT Salary 
FROM RankedSalaries 
WHERE rnk = 3;

-- Q18: Duplicate Email Detection
SELECT Email, COUNT(*) AS DuplicateCount 
FROM Customers 
WHERE Email IS NOT NULL 
GROUP BY Email 
HAVING COUNT(*) > 1;

-- Q19: Departments Where Minimum Salary is Above 90,000
SELECT DeptID, MIN(Salary) AS LowestSalary 
FROM Employees 
GROUP BY DeptID 
HAVING MIN(Salary) > 90000.00;

-- Q20: Multi-Metric Departmental Salary Scorecard
SELECT 
    d.DeptName,
    COUNT(e.EmpID)           AS TotalEmployees,
    ISNULL(AVG(e.Salary), 0) AS AvgSalary,
    ISNULL(SUM(e.Salary), 0) AS TotalPayroll
FROM Departments d
LEFT JOIN Employees e ON d.DeptID = e.DeptID
GROUP BY d.DeptID, d.DeptName;

-- --------------------------------------------------------------------
-- 🟠 SECTION C: RELATIONAL JOINS & SELF-JOINS (Q21 – Q30)
-- --------------------------------------------------------------------

-- Q21: Standard Employee + Department Inner Join
SELECT e.EmpID, e.EmpName, d.DeptName, e.Salary 
FROM Employees e 
INNER JOIN Departments d ON e.DeptID = d.DeptID;

-- Q22: Employees Without Assigned Departments (Orphan Check)
SELECT e.EmpID, e.EmpName 
FROM Employees e 
LEFT JOIN Departments d ON e.DeptID = d.DeptID 
WHERE d.DeptID IS NULL;

-- Q23: Departments with Zero Hired Staff
SELECT d.DeptID, d.DeptName 
FROM Departments d 
LEFT JOIN Employees e ON d.DeptID = e.DeptID 
WHERE e.EmpID IS NULL;

-- Q24: Customer and Orders Join
SELECT c.CustomerName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Q25: Relational Anti-Join: Customers with Zero Orders
SELECT c.CustomerID, c.CustomerName, c.City 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE o.OrderID IS NULL;

-- Q26: Products That Have Never Been Ordered
SELECT p.ProductID, p.ProductName, p.Price 
FROM Products p 
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID 
WHERE oi.OrderItemID IS NULL;

-- Q27: Customer Lifetime Spend Including Zero Spend
SELECT 
    c.CustomerID, c.CustomerName,
    COUNT(o.OrderID) AS OrderCount,
    ISNULL(SUM(o.TotalAmount), 0.00) AS TotalLifetimeSpend
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

-- Q28: Employees Earning Higher Salaries Than Their Direct Boss
SELECT 
    e.EmpID, e.EmpName AS EmployeeName, e.Salary AS EmployeeSalary,
    m.EmpName AS ManagerName, m.Salary AS ManagerSalary,
    (e.Salary - m.Salary) AS SalaryExcess
FROM Employees e
INNER JOIN Employees m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Q29: Complete Employee-Manager Hierarchy with CEO Preservation
SELECT 
    e.EmpName AS EmployeeName,
    ISNULL(m.EmpName, '👑 CEO / NO MANAGER') AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmpID;

-- Q30: Same-Department Employee Pairs (No Symmetric Duplicates)
SELECT 
    e1.EmpName AS Employee1,
    e2.EmpName AS Employee2,
    e1.DeptID
FROM Employees e1
INNER JOIN Employees e2 
    ON e1.DeptID = e2.DeptID 
   AND e1.EmpID < e2.EmpID;

-- --------------------------------------------------------------------
-- 🔴 SECTION D: WINDOW FUNCTIONS & DEDUPLICATION (Q31 – Q40)
-- --------------------------------------------------------------------

-- Q31: Highest Paid Employee per Department
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

-- Q32: Top 3 Highest Earners per Department
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

-- Q33: Exact 2nd Highest Earner per Department
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

-- Q34: Sequential Row Numbering by Salary Across Company
SELECT 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SeqID,
    EmpName, DeptID, Salary
FROM Employees;

-- Q35: Structural Comparison of RANK vs DENSE_RANK
SELECT 
    EmpName, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankNoGaps,
    RANK()       OVER (ORDER BY Salary DESC) AS PositionalRankWithGaps
FROM Employees;

-- Q36: Employees Sharing the Exact Same Salary Rank
WITH SalaryCounts AS (
    SELECT Salary, COUNT(*) AS TieCount 
    FROM Employees 
    GROUP BY Salary 
    HAVING COUNT(*) > 1
)
SELECT e.EmpID, e.EmpName, e.Salary 
FROM Employees e 
INNER JOIN SalaryCounts s ON e.Salary = s.Salary;

-- Q37: Highest Spending Customer per City
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

-- Q38: Latest Order Record per Customer via CTE
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

-- Q39: First Lifetime Order per Customer
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

-- Q40: Employees Earning More Than Chronologically Preceding Hire
WITH SalaryProgression AS (
    SELECT EmpID, EmpName, JoiningDate, Salary,
           LAG(Salary) OVER (ORDER BY JoiningDate ASC) AS PrevHireSalary
    FROM Employees
)
SELECT EmpID, EmpName, JoiningDate, Salary, PrevHireSalary
FROM SalaryProgression
WHERE Salary > PrevHireSalary;

-- --------------------------------------------------------------------
-- 💀 SECTION E: ANALYTICAL BOSS & WAR ROOM (Q41 – Q50)
-- --------------------------------------------------------------------

-- Q41: Safe In-Place Full-Row Deduplication Engine
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

-- Q42: Customers with Orders on Consecutive Calendar Days
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

-- Q43: Customer 30-Day Inactivity Gap Analysis
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

-- Q44: Cumulative Running Revenue Total per Customer
SELECT 
    CustomerID, OrderID, OrderDate, TotalAmount,
    SUM(TotalAmount) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeCustomerSpend
FROM Orders;

-- Q45: Variance from Immediately Preceding Order
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

-- Q46: Forward Sequence Peeking (Next Scheduled Order Date)
SELECT 
    CustomerID, OrderID, OrderDate,
    LEAD(OrderDate, 1, NULL) OVER (
        PARTITION BY CustomerID 
        ORDER BY OrderDate ASC
    ) AS NextOrderDate
FROM Orders;

-- Q47: Dynamic Salary Tiering & Department Headcount Summary
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

-- Q48: Top 2 Highest Paid Employees per Department (Including Ties)
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

-- Q49: High-Velocity Geo-Temporal Fraud Anomaly Engine
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

-- Q50: Master 360° Customer Analytics Intelligence Pipeline
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

-- ====================================================================
-- 🏆 SECTION 7: FINAL BOSS CUSTOMER INTELLIGENCE VIEW
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
