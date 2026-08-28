/* ====================================================================
   🚀 10-HOUR SQL SERVER MASTERY BOOTCAMP (DAYS 01 TO 22)
   T-SQL BENCHMARKS, SYNTAX RECALL & SUPER 50 PRACTICE ENGINE
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
-- 🧠 SECTION 2: SYNTAX RECALL & MUSCLE MEMORY DRILLS
-- ====================================================================

/*
   SYNTAX RECALL 1: 6-STAGE EXECUTION ORDER
   Write the 6 stages in order from memory:
   1. FROM + JOIN
   2. WHERE
   3. GROUP BY
   4. HAVING
   5. SELECT
   6. ORDER BY
*/

/*
   SYNTAX RECALL 2: THE 3-STEP CONSTRAINT RETROFITTING
   Step 1: SELECT col, COUNT(*) FROM table GROUP BY col HAVING COUNT(*) > 1;
   Step 2: WITH C AS (SELECT id, ROW_NUMBER() OVER(PARTITION BY col ORDER BY id) rn FROM table)
           DELETE FROM C WHERE rn > 1;
   Step 3: ALTER TABLE table ADD CONSTRAINT UQ_name UNIQUE (col);
*/

/*
   SYNTAX RECALL 3: SARGABLE DATE FILTERING
   -- Non-SARGable: WHERE YEAR(OrderDate) = 2026 AND MONTH(OrderDate) = 5
   -- SARGable    : WHERE OrderDate >= '2026-05-01' AND OrderDate < '2026-06-01'
*/

/*
   SYNTAX RECALL 4: 3-WAY RANKING BEHAVIOR
   - ROW_NUMBER() : Unique sequential (1, 2, 3, 4) - Deduplication & Pagination
   - DENSE_RANK() : Tied shared rank without gaps (1, 2, 2, 3) - Nth highest salary
   - RANK()       : Tied shared rank with gaps (1, 2, 2, 4) - Official standings
*/

/*
   SYNTAX RECALL 5: VALUE WINDOW FUNCTIONS & RUNNING TOTALS
   - LAG(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - LEAD(col, offset, default) OVER (PARTITION BY id ORDER BY date)
   - SUM(col) OVER (PARTITION BY id ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
*/

/*
   SYNTAX RECALL 6: DYNAMIC PINNED SORTING (CASE)
   ORDER BY 
       CASE 
           WHEN City = 'Pune' THEN 1
           WHEN City = 'Bengaluru' THEN 2
           ELSE 3
       END ASC,
       City DESC;
*/

-- ====================================================================
-- 🧪 SECTION 3: 50 HIGH-LEVEL INTERVIEW CHALLENGES (SUPER 50)
-- All solutions enclosed in comments below each challenge!
-- ====================================================================

-- --------------------------------------------------------------------
-- 🟢 BLOCK 1: FOUNDATION & FILTERING (Q01 – Q10)
-- --------------------------------------------------------------------

-- [Q01] Employees with Salary > 120,000 ordered by salary descending.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q01] ---
SELECT EmpID, EmpName, DeptID, Salary 
FROM Employees 
WHERE Salary > 120000.00 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q02] Find employees in Departments 1, 2, or 4 without multiple OR conditions.
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


-- [Q07] Retrieve the 5 highest-paid employees in the company using TOP.
-- Write your SQL Query below:



/* --- [SOLUTION KEY - Q07] ---
SELECT TOP 5 EmpID, EmpName, Salary 
FROM Employees 
ORDER BY Salary DESC;
-------------------------------- */


-- [Q08] Find the exact 2nd highest distinct salary using DENSE_RANK.
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


-- [Q09] Compute MIN, MAX, AVG, SUM salary and total employee headcount in one query.
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


-- [Q24] 2-Table Join: CustomerName, OrderID, OrderDate, TotalAmount.
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


-- [Q30] Same-department employee pairs without symmetric duplicate combinations (Emp1 < Emp2).
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
-- 🏆 SECTION 4: FINAL BOSS CUSTOMER INTELLIGENCE VIEW
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
