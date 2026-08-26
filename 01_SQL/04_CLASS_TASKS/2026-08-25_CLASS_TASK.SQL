-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 25 AUGUST 2026 (Day 21)
-- 🎯 TOPIC: Value Window Functions (LEAD/LAG), Period-over-Period Deltas & Enterprise Analytical Scenarios
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
IF OBJECT_ID('Stock', 'U') IS NOT NULL DROP TABLE Stock;
IF OBJECT_ID('CustomerOrders', 'U') IS NOT NULL DROP TABLE CustomerOrders;

-- 1. Table: Departments
CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'Engineering'),
(2, 'Data Analytics'),
(3, 'Finance'),
(4, 'Human Resources');

-- 2. Table: Employees
CREATE TABLE Employees
(
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    DeptID      INT NOT NULL FOREIGN KEY REFERENCES Departments(DeptID),
    JoiningDate DATE NOT NULL,
    Salary      DECIMAL(10,2) NOT NULL
);

INSERT INTO Employees (EmpID, EmpName, DeptID, JoiningDate, Salary) VALUES
(101, 'Aarav Sharma',   1, '2024-03-15', 125000.00),
(102, 'Priya Patel',    1, '2025-01-10', 140000.00),
(103, 'Rohan Verma',    1, '2023-08-20', 110000.00),
(104, 'Sneha Rao',      1, '2021-05-12', 150000.00), -- Joined > 3 years ago
(105, 'Vikram Malhotra',2, '2024-06-01', 130000.00),
(106, 'Ananya Sen',     2, '2025-02-15', 135000.00),
(107, 'Karan Joshi',    2, '2024-11-20', 95000.00),
(108, 'Neha Gupta',     3, '2023-10-05', 105000.00),
(109, 'Amit Singh',     3, '2024-12-01', 115000.00),
(110, 'Pooja Nair',     4, '2024-04-18', 85000.00);

-- 3. Table: Customers
CREATE TABLE Customers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Rajesh Kumar',  'Bengaluru'),
(2, 'Meera Iyer',    'Bengaluru'),
(3, 'Sunil Chawla',  'Mumbai'),
(4, 'Kavita Deshmukh','Mumbai'),
(5, 'Arjun Reddy',   'Hyderabad');

-- 4. Table: Orders
CREATE TABLE Orders
(
    OrderID      INT PRIMARY KEY,
    CustomerID   INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate    DATE NOT NULL,
    OrderAmount  DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
-- Rajesh Kumar (4 orders in 2026)
(1001, 1, '2026-01-10', 5000.00),
(1002, 1, '2026-02-15', 2000.00), -- Gap: 36 days (>=30)
(1003, 1, '2026-04-01', 7500.00), -- Gap: 45 days (>=30)
(1004, 1, '2026-05-10', 4500.00), -- Gap: 39 days (>=30)
-- Meera Iyer (4 orders in 2026)
(1005, 2, '2026-01-05', 8000.00),
(1006, 2, '2026-01-20', 3500.00), -- Gap: 15 days (<30), 2nd order < 50% of 1st (3500 < 4000)
(1007, 2, '2026-03-10', 9200.00), -- Gap: 49 days (>=30)
(1008, 2, '2026-06-15', 6100.00),
-- Sunil Chawla (2 orders in 2026)
(1009, 3, '2026-02-01', 4000.00),
(1010, 3, '2026-02-10', 5000.00),
-- Kavita Deshmukh (4 orders in 2026)
(1011, 4, '2026-01-12', 12000.00),
(1012, 4, '2026-02-28', 4500.00), -- Gap: 47 days (>=30), 2nd order < 50% of 1st (4500 < 6000)
(1013, 4, '2026-04-15', 8500.00),
(1014, 4, '2026-05-30', 9500.00),
-- Arjun Reddy (1 order)
(1015, 5, '2026-03-01', 3000.00);

-- 5. Table: Products & Product Orders
CREATE TABLE Products
(
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Category    VARCHAR(50) NOT NULL
);

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(501, 'MacBook Pro M3', 'Electronics'),
(502, 'Dell XPS 15',    'Electronics'),
(503, 'iPhone 16 Pro',  'Mobile'),
(504, 'Samsung S24',    'Mobile'),
(505, 'Sony WH-1000XM5','Audio'),
(506, 'Bose QC Ultra',  'Audio');

-- Clean and drop ProductSales
IF OBJECT_ID('ProductSales', 'U') IS NOT NULL DROP TABLE ProductSales;
CREATE TABLE ProductSales
(
    SalesID     INT IDENTITY(1,1) PRIMARY KEY,
    ProductID   INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    OrderDate   DATE NOT NULL,
    Quantity    INT NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL
);

INSERT INTO ProductSales (ProductID, OrderDate, Quantity, Amount) VALUES
(501, '2026-01-15', 5, 1000000.00),
(502, '2026-01-20', 3, 450000.00),
(503, '2026-01-10', 8, 960000.00),
(504, '2026-01-25', 6, 720000.00),
(501, '2026-02-14', 4, 800000.00),
(502, '2026-02-18', 6, 900000.00),
(505, '2026-01-05', 10, 300000.00),
(506, '2026-01-22', 8, 280000.00);

-- ====================================================================================================
-- 📝 TASK 1: FACULTY HOMEWORK — 50% ORDER DROP ANALYSIS
-- ====================================================================================================
/*
Problem Statement:
Find customers whose second order amount is strictly less than 50% of their first order amount.
Output columns: CustomerID, FirstOrderAmount, SecondOrderAmount, DropPercentage
*/

-- Write your SQL Query below:
-- table order 
-- display customer id , first order amount , second order amount ,drop percentage 
-- prartion by customer id order by order date 

-- ----------------------------------------------------------------------------------------------------
-- 🐥 PIPPO'S CODE REVIEW & ARCHITECT FEEDBACK (FOR CAP)
-- ----------------------------------------------------------------------------------------------------
/*
⭐ SCORE: 7.5 / 10  (Solid Architectural Intuition!)

🔥 What You Nailed:
- Perfect intuition using LEAD() with PARTITION BY CustomerID ORDER BY OrderDate!

💡 2 Key Architecture Traps in Initial Attempt:
1. Row Filtering Trap (Missing Order Anchoring):
   - Without ROW_NUMBER() = 1, LEAD() evaluates Order 1 -> Order 2, Order 2 -> Order 3, Order 3 -> Order 4.
   - The question specifically compares "1st Order vs 2nd Order", so we must filter on `OrderNumber = 1`.

2. Drop Math Trap (< 50 vs > 50% Drop):
   - If Order 1 = 8000 and Order 2 = 3500:
     Drop Amount = 8000 - 3500 = 4500 (56.25% drop).
     Since 56.25% > 50%, this is a drop of MORE than 50% (SecondOrder < 50% of FirstOrder).
   - In the initial query, `... < 50` was checking for drop < 50% instead of `SecondOrder < FirstOrder * 0.50` (Drop > 50%).
*/

-- [Cap's Initial Attempt]
WITH CTE AS 
(
    SELECT 
        CustomerID,
        OrderAmount AS FirstOrderAmount,
        LEAD(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS SecondOrderAmount 
    FROM Orders 
)
SELECT 
    *,
    (FirstOrderAmount - SecondOrderAmount) AS Diff,
    ((FirstOrderAmount - SecondOrderAmount) / FirstOrderAmount) * 100 AS Diff_Percentage 
FROM CTE 
WHERE ((FirstOrderAmount - SecondOrderAmount) / FirstOrderAmount) * 100 > 50;

-- [Final Correct Enterprise Production Solution]
WITH RankedOrdersCTE AS
(
    SELECT
        CustomerID,
        OrderAmount AS FirstOrderAmount,
        LEAD(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS SecondOrderAmount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderNumber
    FROM Orders
)
SELECT
    CustomerID,
    FirstOrderAmount,
    SecondOrderAmount,
    ((FirstOrderAmount - SecondOrderAmount) / FirstOrderAmount) * 100.0 AS DropPercentage
FROM RankedOrdersCTE
WHERE OrderNumber = 1
  AND SecondOrderAmount < (FirstOrderAmount * 0.50);

-- ====================================================================================================
-- 📝 TASK 2: SCENARIO 1 — EMPLOYEE SALARY ANALYSIS (TOP 2 PER DEPT IN LAST 3 YEARS)
-- ====================================================================================================
/*
Problem Statement:
Find the top 2 highest-paid employees in each department who joined the company in the last 3 years
(calculated from GETDATE() or current date 2026-08-25).
Output columns: DeptName, EmpID, EmpName, Salary, JoiningDate, SalaryRank
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 3: SCENARIO 2 — CUSTOMER MONTHLY ORDERS (>3 ORDERS IN 2026 & CITY RANK)
-- ====================================================================================================
/*
Problem Statement:
Find customers who placed more than 3 orders in 2026.
For each qualifying customer, display:
CustomerID, CustomerName, TotalOrders, TotalAmount, FirstOrderDate, LastOrderDate
Also assign a rank based on TotalAmount within each city (CityRank).
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 4: SCENARIO 3 — TOP-SELLING PRODUCT PER CATEGORY PER MONTH
-- ====================================================================================================
/*
Problem Statement:
For each category, find the top-selling product for every month of 2026 based on total sales amount.
Output columns: Category, Month, ProductName, TotalSales, ProductRank
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 5: SCENARIO 4 — EMPLOYEE JOINING TREND (MONTH-OVER-MONTH DIFFERENCE)
-- ====================================================================================================
/*
Problem Statement:
For every department, display the number of employees who joined in each month.
Also show:
DeptName, YearMonth, EmployeeCount, PreviousMonthCount, Difference
Use LAG() to compute the month-over-month variance.
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 6: SCENARIO 5 — CUSTOMER ORDER GAP ANALYSIS (>= 30 DAYS GAP)
-- ====================================================================================================
/*
Problem Statement:
Find customers whose latest order was at least 30 days after their previous order.
Output columns: CustomerID, CustomerName, PreviousOrderDate, LatestOrderDate, DaysGap
*/

-- Write your SQL Query below:



