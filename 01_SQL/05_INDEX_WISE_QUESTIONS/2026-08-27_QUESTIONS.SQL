-- ====================================================================================================
-- 🎯 14 TARGETED PRACTICE DRILLS: ADVANCED SQL & ENTERPRISE SCENARIO LAB
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 2026-08-27 (Day 23)
-- 🎯 FOCUS: Window Functions, Value Offsets (LAG/LEAD), Self Joins, Temporal Math & Fraud Engines
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('OrderItems', 'U') IS NOT NULL DROP TABLE OrderItems;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Sales', 'U') IS NOT NULL DROP TABLE Sales;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('ProductPriceHistory', 'U') IS NOT NULL DROP TABLE ProductPriceHistory;
IF OBJECT_ID('EmployeeSalaries', 'U') IS NOT NULL DROP TABLE EmployeeSalaries;
IF OBJECT_ID('BankTransactions', 'U') IS NOT NULL DROP TABLE BankTransactions;
IF OBJECT_ID('CustomerProfiles', 'U') IS NOT NULL DROP TABLE CustomerProfiles;

-- 1. Table: EmployeeSalaries
CREATE TABLE EmployeeSalaries
(
    EmpID      INT,
    Salary     DECIMAL(10,2),
    SalaryDate DATE
);

INSERT INTO EmployeeSalaries (EmpID, Salary, SalaryDate) VALUES
(101, 50000.00, '2024-01-01'),
(101, 65000.00, '2025-01-01'), -- Jump 30%
(101, 60000.00, '2026-01-01'), -- Drop
(102, 70000.00, '2024-01-01'),
(102, 90000.00, '2025-01-01'), -- Jump 28.57%
(102, 120000.00,'2026-01-01'), -- Jump 33.33%
(103, 45000.00, '2025-01-01'),
(103, 40000.00, '2026-01-01'); -- Drop

-- 2. Table: Employees
CREATE TABLE Employees
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50),
    DeptID     INT,
    BaseSalary DECIMAL(10,2)
);

INSERT INTO Employees (EmpID, EmpName, DeptID, BaseSalary) VALUES
(1, 'Aarav Sharma',   10, 85000.00),
(2, 'Priya Patel',    10, 85000.00), -- Same dept, same salary
(3, 'Rohan Verma',    10, 95000.00),
(4, 'Sneha Rao',      20, 110000.00),
(5, 'Vikram Malhotra',20, 110000.00),-- Same dept, same salary
(6, 'Ananya Sen',     30, 70000.00),
(7, 'Karan Joshi',    30, 65000.00);

-- 3. Table: Products
CREATE TABLE Products
(
    ProductID   INT PRIMARY KEY,
    CategoryID  INT,
    ProductName VARCHAR(50),
    UnitPrice   DECIMAL(10,2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, UnitPrice) VALUES
(501, 1, 'Gaming Laptop',     120000.00),
(502, 1, 'Ultrabook Air',      95000.00),
(503, 1, 'Office Desktop',     45000.00),
(504, 2, 'Noise-Cancel Headset',15000.00),
(505, 2, 'Wireless Earbuds',    8000.00),
(506, 2, 'Studio Microphone',  12000.00);

-- 4. Table: ProductPriceHistory
CREATE TABLE ProductPriceHistory
(
    ProductID   INT,
    ProductName VARCHAR(50),
    Price       DECIMAL(10,2),
    PriceDate   DATE
);

INSERT INTO ProductPriceHistory (ProductID, ProductName, Price, PriceDate) VALUES
(501, 'Gaming Laptop', 130000.00, '2026-01-01'),
(501, 'Gaming Laptop', 110000.00, '2026-03-01'), -- Drop > 15% (15.38%)
(501, 'Gaming Laptop', 120000.00, '2026-05-01'),
(502, 'Ultrabook Air',  95000.00, '2026-01-01'),
(502, 'Ultrabook Air',  80000.00, '2026-04-01'), -- Drop > 15% (15.78%)
(503, 'Office Desktop', 45000.00, '2026-01-01'),
(503, 'Office Desktop', 42000.00, '2026-06-01'), -- Drop < 15%
(504, 'Noise-Cancel',   10000.00, '2026-01-01'),
(504, 'Noise-Cancel',   12000.00, '2026-02-01'),
(504, 'Noise-Cancel',   14000.00, '2026-03-01'),
(504, 'Noise-Cancel',   16000.00, '2026-04-01'); -- 3 consecutive price increases

-- 5. Table: Customers & Orders
CREATE TABLE Customers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City         VARCHAR(50)
);

CREATE TABLE Orders
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT,
    OrderDate   DATE,
    OrderAmount DECIMAL(10,2)
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Rajesh Kumar',  'Bengaluru'),
(2, 'Meera Iyer',    'Bengaluru'),
(3, 'Sunil Chawla',  'Bengaluru'),
(4, 'Kavita Deshmukh','Mumbai'),
(5, 'Arjun Reddy',   'Mumbai'),
(6, 'Divya Joshi',   'Mumbai'),
(7, 'Sanjay Roy',    'Delhi');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1001, 1, '2026-01-10', 15000.00), -- Q1
(1002, 1, '2026-04-12', 22000.00), -- Q2
(1003, 1, '2026-08-15', 18000.00), -- Q3 (3 distinct quarters)
(1004, 2, '2026-01-15', 30000.00),
(1005, 2, '2026-01-16', 12000.00), -- Consecutive day order (Jan 15 & 16)
(1006, 3, '2026-02-20', 5000.00),
(1007, 4, '2026-03-10', 45000.00),
(1008, 4, '2026-07-22', 50000.00),
(1009, 5, '2026-05-18', 25000.00),
(1010, 6, '2026-09-01', 10000.00),
(1011, 7, '2026-02-14', 18000.00);

-- 6. Table: Sales
CREATE TABLE Sales
(
    SaleID   INT PRIMARY KEY,
    EmpID    INT,
    SaleDate DATE,
    Amount   DECIMAL(10,2)
);

INSERT INTO Sales (SaleID, EmpID, SaleDate, Amount) VALUES
(1, 1, '2026-08-01', 50000.00),
(2, 2, '2026-08-05', 40000.00),
(3, 4, '2026-08-10', 60000.00),
(4, 5, '2026-08-15', 75000.00),
-- Emp 3, 6, 7 have 0 sales in Aug 2026
(5, 1, '2026-07-10', 30000.00);

-- 7. Table: CustomerProfiles
CREATE TABLE CustomerProfiles
(
    ProfileID   INT PRIMARY KEY,
    AccountName VARCHAR(50),
    PhoneNumber VARCHAR(20)
);

INSERT INTO CustomerProfiles (ProfileID, AccountName, PhoneNumber) VALUES
(1, 'Aarav Personal', '+91-9876543210'),
(2, 'Aarav Business', '+91-9876543210'), -- Duplicate phone
(3, 'Priya Patel',    '+91-9123456789'),
(4, 'Rohan Verma',    '+91-9988776655'),
(5, 'Rohan Tech',     '+91-9988776655'); -- Duplicate phone

-- 8. Table: BankTransactions
CREATE TABLE BankTransactions
(
    TxnID      INT PRIMARY KEY,
    CustomerID INT,
    City       VARCHAR(50),
    TxnTime    DATETIME,
    Amount     DECIMAL(10,2)
);

INSERT INTO BankTransactions (TxnID, CustomerID, City, TxnTime, Amount) VALUES
(1, 101, 'Mumbai',    '2026-08-27 10:00:00', 5000.00),
(2, 101, 'Delhi',     '2026-08-27 10:08:00', 12000.00), -- FRAUD (Diff city within 8 mins)
(3, 102, 'Bengaluru', '2026-08-27 11:00:00', 4000.00),
(4, 102, 'Bengaluru', '2026-08-27 11:05:00', 8000.00), -- Safe (Same city)
(5, 103, 'Pune',      '2026-08-27 12:00:00', 9000.00),
(6, 103, 'Hyderabad', '2026-08-27 15:00:00', 15000.00);-- Safe (> 10 mins apart)


-- ====================================================================================================
-- 📝 PHASE 1: 14 TARGETED PRACTICE DRILLS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- DRILL 01: Track Salary Jumps > 25% using LAG()
-- Task: Find all instances where an employee's salary increased by more than 25% over the previous record.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 02: Detect Salary Reductions using LAG()
-- Task: Find all salary revisions where an employee received a pay cut (current salary < previous salary).
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 03: Product Price Drop > 15%
-- Task: Identify products whose price decreased by more than 15% compared to the immediately preceding price.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 04: Consecutive Daily Orders by Customer
-- Task: Identify customers who placed orders on consecutive calendar days (date difference = 1 day).
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 05: Customers Active in at Least 3 Distinct Quarters
-- Task: Return customers who placed orders in at least 3 distinct calendar quarters within the year.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 06: Same Department Identical Salary Matching (Self Join)
-- Task: Find pairs of employees working in the same department who earn the exact same salary (no mirror pairs).
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 07: Top 3 Spenders per City (Partitioned DENSE_RANK)
-- Task: Rank and return the top 3 highest spending customers for each distinct city.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 08: Peak Revenue Day of the Week
-- Task: Find the day of the week (e.g., Monday, Saturday) that generated the highest total order amount.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 09: Lowest Revenue Product per Category
-- Task: For each category, return the product that generated the lowest total sales revenue.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 10: Inactive Employees in Current Month (Zero Sales)
-- Task: Identify all employees who generated zero sales in August 2026.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 11: Duplicate Phone Numbers with Distinct Account Names
-- Task: Find all phone numbers that are registered to more than one distinct account name.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 12: Fraud Detection: Multi-City Transactions within 10 Minutes
-- Task: Flag bank transactions where the same customer transacted from different cities within a 10-minute window.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 13: Three Consecutive Price Increases
-- Task: Identify products that experienced at least three consecutive price increases in their history.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- DRILL 14: Category-Wise Cumulative Running Total Revenue
-- Task: Compute a running cumulative sum of order amounts per customer ordered chronologically by OrderDate.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




