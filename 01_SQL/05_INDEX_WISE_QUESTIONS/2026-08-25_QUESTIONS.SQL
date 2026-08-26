-- ====================================================================================================
-- 🎯 14 TARGETED PRACTICE DRILLS — 2026-08-25 (DAY 21)
-- 🏢 MODULE 01: Enterprise SQL Engine & Analytical Query Architecture
-- 🎯 TOPIC: Value Window Functions (LEAD & LAG), Running Aggregate Windows & Period-over-Period Deltas
-- ⚠️ CONSTITUTIONAL STANDARD: Exactly 14 targeted questions with blank query blocks for practice.
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('UserLogins', 'U') IS NOT NULL DROP TABLE UserLogins;
IF OBJECT_ID('DailySales', 'U') IS NOT NULL DROP TABLE DailySales;
IF OBJECT_ID('StockTrans', 'U') IS NOT NULL DROP TABLE StockTrans;
IF OBJECT_ID('EmpPayroll', 'U') IS NOT NULL DROP TABLE EmpPayroll;

-- 1. Table: EmpPayroll
CREATE TABLE EmpPayroll
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary     DECIMAL(10,2) NOT NULL,
    HireDate   DATE NOT NULL
);

INSERT INTO EmpPayroll (EmpID, EmpName, Department, Salary, HireDate) VALUES
(101, 'Aarav Sharma',   'Engineering', 125000.00, '2022-03-15'),
(102, 'Priya Patel',    'Engineering', 140000.00, '2023-01-10'),
(103, 'Rohan Verma',    'Engineering', 110000.00, '2024-08-20'),
(104, 'Sneha Rao',      'Engineering', 150000.00, '2021-05-12'),
(105, 'Vikram Malhotra','Marketing',   95000.00,  '2022-06-01'),
(106, 'Ananya Sen',     'Marketing',   115000.00, '2023-02-15'),
(107, 'Karan Joshi',    'Marketing',   85000.00,  '2024-11-20'),
(108, 'Neha Gupta',     'Finance',     105000.00, '2021-10-05'),
(109, 'Amit Singh',     'Finance',     135000.00, '2023-12-01'),
(110, 'Pooja Nair',     'Finance',     90000.00,  '2024-04-18');

-- 2. Table: DailySales
CREATE TABLE DailySales
(
    TxnID    INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NOT NULL,
    Region   VARCHAR(30) NOT NULL,
    Revenue  DECIMAL(10,2) NOT NULL
);

INSERT INTO DailySales (SaleDate, Region, Revenue) VALUES
('2026-08-01', 'North', 15000.00),
('2026-08-02', 'North', 18000.00),
('2026-08-03', 'North', 14000.00),
('2026-08-04', 'North', 22000.00),
('2026-08-05', 'North', 25000.00),
('2026-08-01', 'South', 12000.00),
('2026-08-02', 'South', 11000.00),
('2026-08-03', 'South', 16000.00),
('2026-08-04', 'South', 19000.00),
('2026-08-05', 'South', 17000.00);

-- 3. Table: StockTrans
CREATE TABLE StockTrans
(
    TransID   INT IDENTITY(1,1) PRIMARY KEY,
    ItemName  VARCHAR(50) NOT NULL,
    TransDate DATE NOT NULL,
    Quantity  INT NOT NULL
);

INSERT INTO StockTrans (ItemName, TransDate, Quantity) VALUES
('Server Blade', '2026-08-01', 50),
('Server Blade', '2026-08-02', 45),
('Server Blade', '2026-08-03', 60),
('Server Blade', '2026-08-04', 30),
('GPU Unit',     '2026-08-01', 20),
('GPU Unit',     '2026-08-02', 25),
('GPU Unit',     '2026-08-03', 15),
('GPU Unit',     '2026-08-04', 35);

-- 4. Table: UserLogins
CREATE TABLE UserLogins
(
    LoginID   INT IDENTITY(1,1) PRIMARY KEY,
    UserID    INT NOT NULL,
    LoginTime DATETIME NOT NULL
);

INSERT INTO UserLogins (UserID, LoginTime) VALUES
(1, '2026-08-01 09:00:00'),
(1, '2026-08-01 14:30:00'),
(1, '2026-08-02 10:15:00'),
(1, '2026-08-05 18:00:00'),
(2, '2026-08-01 08:30:00'),
(2, '2026-08-03 11:00:00'),
(2, '2026-08-04 16:45:00');

-- ====================================================================================================
-- 🎯 14 TARGETED PRACTICE DRILLS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- DRILL 1: Basic LEAD lookahead on DailySales
-- Write a query to display SaleDate, Region, Revenue, and the Revenue of the very next day in the same Region.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: SaleDate, Region, Revenue, NextDayRevenue
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 2: Basic LAG lookback with Zero Default
-- Write a query to display SaleDate, Region, Revenue, and the previous day's Revenue. If no previous day exists, return 0.00 instead of NULL.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: SaleDate, Region, Revenue, PrevDayRevenue
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 3: Day-over-Day Revenue Variance Pipeline
-- Write a query using LAG to calculate the daily revenue change (Today Revenue - Yesterday Revenue) for the 'North' region.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: SaleDate, Revenue, PrevDayRevenue, DailyVariance
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 4: Identifying Positive Growth Days
-- Find all days in the 'North' region where Revenue was strictly greater than the previous day's Revenue.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: SaleDate, Revenue, PrevDayRevenue
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 5: 2-Day Lookahead (Offset = 2)
-- Display ItemName, TransDate, Quantity, and the Quantity from 2 days ahead (Offset 2) for each item.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: ItemName, TransDate, Quantity, QuantityIn2Days
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 6: Salary Comparison with Immediately Higher and Lower Paid Peers
-- For each employee in EmpPayroll, display their Salary, the Salary of the employee hired immediately before them, and the Salary of the employee hired immediately after them in the same Department.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: Department, EmpName, HireDate, Salary, PrevHireSalary, NextHireSalary
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 7: Sandwiched Salary Anomaly Detection
-- Find employees whose Salary is strictly greater than the previous hire's salary AND strictly less than the next hire's salary in their department.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: Department, EmpName, Salary, PrevHireSalary, NextHireSalary
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 8: Cumulative Running Total Revenue
-- Write a query to calculate the running cumulative total of Revenue for each Region ordered by SaleDate.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: Region, SaleDate, Revenue, CumulativeRevenue
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 9: Running Minimum Inventory Level
-- For each item in StockTrans, display the running minimum Quantity observed up to the current transaction date.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: ItemName, TransDate, Quantity, RunningMinQuantity
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 10: Running Maximum Salary per Department
-- For each department in EmpPayroll, display the running highest salary observed as employees were hired chronologically.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: Department, HireDate, EmpName, Salary, RunningMaxSalary
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 11: Consecutive Session Inactivity Gap (Hours)
-- For each login in UserLogins, calculate the difference in hours between the current login and the immediate previous login for that UserID.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: UserID, LoginTime, PrevLoginTime, GapInHours
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 12: Big Gap Alert (Logins >= 24 Hours Apart)
-- Filter and display only those logins where the gap since the previous login is at least 24 hours (1 full day).
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: UserID, PrevLoginTime, LoginTime, GapInHours
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 13: Percentage Change in Daily Revenue
-- Calculate the percentage change in Revenue compared to the previous day for each Region: `((Revenue - PrevRevenue) / PrevRevenue) * 100.0`.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: Region, SaleDate, Revenue, PrevRevenue, PctChange
*/
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- DRILL 14: Restock Drop Detection (Quantity Dropped by > 25%)
-- Find transactions where the current inventory Quantity dropped by more than 25% compared to the previous day's Quantity.
-- ----------------------------------------------------------------------------------------------------
/*
Expected Columns: ItemName, TransDate, Quantity, PrevQuantity, DropAmount
*/
-- Write your SQL Query below:



