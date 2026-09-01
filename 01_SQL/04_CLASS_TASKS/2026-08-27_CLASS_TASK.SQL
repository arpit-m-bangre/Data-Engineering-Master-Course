-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & SURPRISE TEST TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 27 AUGUST 2026 (Day 23)
-- 🎯 TOPIC: Surprise Assessment — Advanced SQL Scenarios, Window Functions, LAG/LEAD, Self Joins & Fraud Analytics
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('OrderItems', 'U') IS NOT NULL DROP TABLE OrderItems;
IF OBJECT_ID('SalesTransactions', 'U') IS NOT NULL DROP TABLE SalesTransactions;
IF OBJECT_ID('Sales', 'U') IS NOT NULL DROP TABLE Sales;
IF OBJECT_ID('BankTransactions', 'U') IS NOT NULL DROP TABLE BankTransactions;
IF OBJECT_ID('UserAccounts', 'U') IS NOT NULL DROP TABLE UserAccounts;
IF OBJECT_ID('ProductPriceHistory', 'U') IS NOT NULL DROP TABLE ProductPriceHistory;
IF OBJECT_ID('EmployeeSalaries', 'U') IS NOT NULL DROP TABLE EmployeeSalaries;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;

-- 1. Table: EmployeeSalaries
CREATE TABLE EmployeeSalaries
(
    EmpID      INT NOT NULL,
    Salary     DECIMAL(10,2) NOT NULL,
    SalaryDate DATE NOT NULL
);

INSERT INTO EmployeeSalaries (EmpID, Salary, SalaryDate) VALUES
(101, 50000.00, '2025-01-01'),
(101, 55000.00, '2025-06-01'),
(101, 75000.00, '2026-01-01'), -- Jump > 30% (75k vs 55k = +36.36%)
(102, 60000.00, '2025-01-01'),
(102, 65000.00, '2026-01-01'), -- Jump < 30% (+8.33%)
(103, 40000.00, '2025-01-01'),
(103, 58000.00, '2026-01-01'); -- Jump > 30% (58k vs 40k = +45%)

-- 2. Table: ProductPriceHistory
CREATE TABLE ProductPriceHistory
(
    ProductID   INT NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    Price       DECIMAL(10,2) NOT NULL,
    PriceDate   DATE NOT NULL
);

INSERT INTO ProductPriceHistory (ProductID, ProductName, Price, PriceDate) VALUES
(501, '4K Gaming Monitor', 25000.00, '2026-05-10'),
(501, '4K Gaming Monitor', 27000.00, '2026-06-15'), -- change 1
(501, '4K Gaming Monitor', 24000.00, '2026-07-20'), -- change 2
(501, '4K Gaming Monitor', 29000.00, '2026-08-10'), -- change 3 (> 2 times in 90 days)
(502, 'Mechanical Keyboard', 4500.00, '2026-04-01'),
(502, 'Mechanical Keyboard', 4800.00, '2026-07-01'), -- change 1 in 90 days
(503, 'Wireless Mouse',     1200.00, '2026-06-01'),
(503, 'Wireless Mouse',     1500.00, '2026-07-01'), -- change 1
(503, 'Wireless Mouse',     1400.00, '2026-08-01'), -- change 2 (not > 2)
(503, 'Wireless Mouse',     1700.00, '2026-08-20'); -- change 3 (> 2 times in 90 days)

-- 3. Table: Customers & Orders
CREATE TABLE Customers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    SignupDate   DATE NOT NULL
);

CREATE TABLE Orders
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    OrderDate   DATE NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL
);

INSERT INTO Customers (CustomerID, CustomerName, SignupDate) VALUES
(1, 'Rajesh Kumar',  '2025-01-01'),
(2, 'Priya Sharma',  '2025-01-01'),
(3, 'Amit Patel',    '2025-01-01'),
(4, 'Sneha Rao',     '2025-01-01'),
(5, 'Vikram Malhotra','2025-01-01'),
(6, 'Ananya Sen',    '2025-01-01');

-- Customer 1 ordered in all 12 months
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
(101, 1, '2026-01-15', 5000.00), (102, 1, '2026-02-14', 4200.00),
(103, 1, '2026-03-10', 6100.00), (104, 1, '2026-04-18', 3900.00),
(105, 1, '2026-05-22', 7500.00), (106, 1, '2026-06-30', 8200.00),
(107, 1, '2026-07-12', 4900.00), (108, 1, '2026-08-05', 9100.00),
(109, 1, '2026-09-19', 5400.00), (110, 1, '2026-10-25', 6800.00),
(111, 1, '2026-11-11', 7700.00), (112, 1, '2026-12-20', 9500.00),
-- Other customers ordered in some months
(113, 2, '2026-01-10', 12000.00), (114, 2, '2026-04-15', 18000.00), (115, 2, '2026-08-20', 25000.00),
(116, 3, '2026-02-10', 8000.00),  (117, 3, '2026-06-15', 15000.00), (118, 3, '2026-11-20', 22000.00),
(119, 4, '2026-03-01', 30000.00), (120, 5, '2026-05-15', 35000.00), (121, 6, '2026-07-20', 15000.00);

-- 4. Table: Products & OrderItems
CREATE TABLE Products
(
    ProductID   INT PRIMARY KEY,
    CategoryID  INT NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    Price       DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderItems
(
    OrderID   INT,
    ProductID INT,
    Quantity  INT,
    Price     DECIMAL(10,2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 10, 'Dell XPS 15',      150000.00),
(2, 10, 'MacBook Pro 14',   150000.00), -- Same price as Dell XPS 15
(3, 10, 'Lenovo ThinkPad',  110000.00),
(4, 20, 'iPhone 15 Pro',    130000.00),
(5, 20, 'Samsung S24 Ultra',130000.00), -- Same price as iPhone 15 Pro
(6, 20, 'OnePlus 12',        65000.00);

INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price) VALUES
(101, 1, 3, 150000.00), -- Cat 10: 450,000
(102, 2, 4, 150000.00), -- Cat 10: 600,000 (Top in Cat 10)
(103, 3, 2, 110000.00), -- Cat 10: 220,000
(104, 4, 5, 130000.00), -- Cat 20: 650,000 (Top in Cat 20)
(105, 5, 3, 130000.00), -- Cat 20: 390,000
(106, 6, 4,  65000.00); -- Cat 20: 260,000

-- 5. Table: Employees & Sales
CREATE TABLE Employees
(
    EmpID   INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL
);

CREATE TABLE Sales
(
    SaleID   INT PRIMARY KEY,
    EmpID    INT NOT NULL,
    SaleDate DATE NOT NULL,
    Amount   DECIMAL(10,2) NOT NULL
);

INSERT INTO Employees (EmpID, EmpName) VALUES
(1, 'Rohan Sharma'), (2, 'Kavita Iyer'), (3, 'Deepak Verma');

INSERT INTO Sales (SaleID, EmpID, SaleDate, Amount) VALUES
(1, 1, '2026-07-05', 45000.00), (2, 2, '2026-07-15', 60000.00), (3, 3, '2026-07-25', 30000.00), -- Top July: Kavita (60k)
(4, 1, '2026-08-02', 80000.00), (5, 2, '2026-08-12', 75000.00), (6, 3, '2026-08-22', 90000.00); -- Top Aug: Deepak (90k)

-- 6. Table: SalesTransactions
CREATE TABLE SalesTransactions
(
    OrderID   INT PRIMARY KEY,
    OrderTime TIME NOT NULL,
    Amount    DECIMAL(10,2) NOT NULL
);

INSERT INTO SalesTransactions (OrderID, OrderTime, Amount) VALUES
(1, '09:15:00', 5000.00),
(2, '09:45:00', 7000.00),
(3, '14:10:00', 25000.00),
(4, '14:35:00', 40000.00), -- Peak hour 14:00 (Total = 65,000)
(5, '18:20:00', 15000.00),
(6, '18:50:00', 20000.00);

-- 7. Table: UserAccounts
CREATE TABLE UserAccounts
(
    UserID   INT PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Email    VARCHAR(100) NOT NULL
);

INSERT INTO UserAccounts (UserID, UserName, Email) VALUES
(1, 'Aarav Gupta',   'aarav@enterprise.com'),
(2, 'Pooja Nair',    'pooja@analytics.org'),
(3, 'Aarav G.',      'aarav@enterprise.com'), -- Duplicate email
(4, 'Siddharth Roy', 'siddharth@cloud.net'),
(5, 'Pooja N.',      'pooja@analytics.org');  -- Duplicate email

-- 8. Table: BankTransactions
CREATE TABLE BankTransactions
(
    TxnID      INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    City       VARCHAR(50) NOT NULL,
    TxnTime    DATETIME NOT NULL,
    Amount     DECIMAL(10,2) NOT NULL
);

INSERT INTO BankTransactions (TxnID, CustomerID, City, TxnTime, Amount) VALUES
(1001, 501, 'Mumbai',    '2026-08-27 10:30:00', 5000.00),
(1002, 501, 'Delhi',     '2026-08-27 10:30:00', 12000.00), -- FRAUD COLLISION (Same customer 501, same time, different city)
(1003, 502, 'Bengaluru', '2026-08-27 11:15:00', 8500.00),
(1004, 502, 'Bengaluru', '2026-08-27 11:15:00', 2000.00), -- Same city (Valid multi-swipe)
(1005, 503, 'Pune',      '2026-08-27 14:00:00', 3000.00),
(1006, 503, 'Kolkata',   '2026-08-27 14:00:00', 45000.00); -- FRAUD COLLISION (Same customer 503, same time, different city)


-- ====================================================================================================
-- 📝 PHASE 1: SURPRISE TEST SCENARIO TASKS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: SALARY GROWTH THRESHOLD (> 30% INCREASE OVER PREVIOUS)
-- Scenario: Find employees whose latest salary increased by more than 30% over their previous salary.
-- Expected Output: EmpID, LatestSalary, PrevSalary, SalaryDate
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:
with salarydata as 
(
select 
    empid,
    salary,
    salarydate,
    lag(salary) over (partition by empid order by salarydate ) as prevsalary,
    ROW_NUMBER() over ( partition by empid order by salarydate ) as rn 
from EmployeeSalaries
)
select 
    empid ,
    salary as latestsaslary,
    prevsalary,
    SalaryDate
from salarydata
where rn = 1 
    and (salary - prevsalary ) * 100 / prevsalary > 30 


-- ----------------------------------------------------------------------------------------------------
-- TASK 2: PRODUCT PRICE VOLATILITY (> 2 CHANGES IN 90 DAYS)
-- Scenario: Identify products whose unit price was modified more than twice in the past 90 days.
-- Expected Output: ProductID, ProductName, PriceChangeCount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:

with pricedata as 
(
select 
    productId,
    ProductName,
    price,
    pricedate,
    lag(price) over ( partition by productid order by pricedate) as prevprice 
from ProductPriceHistory
)
select 
    PRODUCTid,
    productname,
    count(*) as pricechangecount 
from pricedata
where price <> prevprice
    and prevprice is not null 
group by ProductID,ProductName


-- ----------------------------------------------------------------------------------------------------
-- TASK 3: CALENDAR YEAR COMPLETENESS (ORDERS IN ALL 12 MONTHS)
-- Scenario: Find customers who placed orders in all 12 distinct months of the year.
-- Expected Output: CustomerID, DistinctActiveMonths
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:
with cte as
(
select 
    CustomerID,count(distinct month(orderdate)) as count_of_months
from Orders
group by CustomerID
)
select * 
from cte 
where count_of_months = 12 

-- or 

select 
    CustomerID,count(distinct month(orderdate)) as count_of_months
from Orders
group by CustomerID
having count(distinct month(orderdate)) = 12


-- ----------------------------------------------------------------------------------------------------
-- TASK 4: IDENTICAL PRICE MATCHING (SELF JOIN DEDUPLICATION)
-- Scenario: Find all distinct pairs of products that share the exact same price without mirror duplicates.
-- Expected Output: Product1, Product2, MatchingPrice
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:

select * from Products


select 
    p1.ProductName as prodcut1,
    p2.ProductName as product2 ,
    p1.price as matchingprice 
from products p1  join products p2 on p1.price = p2.price 


-- ----------------------------------------------------------------------------------------------------
-- TASK 5: TOP 5 CUSTOMERS BY TOTAL LIFETIME SPEND
-- Scenario: Rank and return the top 5 customers based on cumulative lifetime order spend.
-- Expected Output: CustomerName, TotalSpent, SpendRank
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:

select top 5 CustomerID,sum(amount) as total_amount  
from orders
group by CustomerID
order by total_amount desc




-- ----------------------------------------------------------------------------------------------------
-- TASK 6: IDENTIFY PEAK SALES HOUR
-- Scenario: Find the single hour of the day that generated the highest total sales revenue.
-- Expected Output: PeakHour, TotalRevenue
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 7: TOP REVENUE GENERATING PRODUCT PER CATEGORY
-- Scenario: For each category, return the product that generated the highest total sales revenue.
-- Expected Output: CategoryID, ProductName, TotalRevenue
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 8: TOP PERFORMING EMPLOYEE PER MONTH
-- Scenario: Find the top performing employee (highest total sales amount) for each month.
-- Expected Output: SaleMonth, EmpName, TotalSales
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 9: DUPLICATE EMAIL IDENTIFICATION
-- Scenario: Find duplicate email addresses present in user accounts along with their frequency.
-- Expected Output: Email, DuplicateCount
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:





-- ----------------------------------------------------------------------------------------------------
-- TASK 10: BANKING FRAUD ENGINE (SIMULTANEOUS MULTI-CITY TRANSACTIONS)
-- Scenario: Detect potential fraud where a customer initiated transactions from different cities at the exact same timestamp.
-- Expected Output: CustomerID, City1, City2, TxnTime
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




