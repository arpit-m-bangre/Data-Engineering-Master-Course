/* ============================================================
               DATA ENGINEERING PROJECT 6 (PROJECT6.SQL)
               TITLE: ENTERPRISE FINANCIAL ANALYTICS & WINDOWED LEADERBOARD ENGINE
               TOPICS COVERED: DAYS 1 - 19 (ADVANCED WINDOW FUNCTIONS MILESTONE)
               (Window Functions Architecture, ROW_NUMBER(), DENSE_RANK(), RANK(),
                PARTITION BY Multi-Dimension Slicing, Top-N Leaders per Department,
                Salary Outlier Auditing, CTEs & Analytic Ranking Pipelines)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
A Global FinTech & Cloud Enterprise requires an automated real-time
analytic ranking engine to monitor multi-regional revenue streams,
employee performance tiers, executive salary distributions, and customer
order recency patterns across worldwide operations.

You must design the relational warehouse, seed high-volume transactional
data across diverse departments and regional nodes, enforce deterministic
ranking rules, construct multi-tier CTE pipelines to extract Top-N performers,
and solve complex financial outlier and salary tiering audits.
=============================================================== */

-- ============================================================
-- 2. ENTERPRISE SCHEMA CREATION & ENVIRONMENT SETUP
-- ============================================================

-- Clean up existing project tables
IF OBJECT_ID('CorporatePayroll', 'U') IS NOT NULL DROP TABLE CorporatePayroll;
IF OBJECT_ID('RegionalRevenue', 'U') IS NOT NULL DROP TABLE RegionalRevenue;
IF OBJECT_ID('AccountActivity', 'U') IS NOT NULL DROP TABLE AccountActivity;

-- 1. Table: CorporatePayroll (Global Workforce & Compensation)
CREATE TABLE CorporatePayroll
(
    EmpID          INT PRIMARY KEY IDENTITY(1001, 1),
    EmpName        VARCHAR(50) NOT NULL,
    Department     VARCHAR(30) NOT NULL,
    Designation    VARCHAR(40) NOT NULL,
    Salary         INT NOT NULL,
    PerformanceScore INT NOT NULL,
    HireDate       DATE NOT NULL
);

-- 2. Table: RegionalRevenue (Quarterly Regional Financial Streams)
CREATE TABLE RegionalRevenue
(
    StreamID       INT PRIMARY KEY IDENTITY(5001, 1),
    Region         VARCHAR(30) NOT NULL,
    SalesManager   VARCHAR(50) NOT NULL,
    FiscalQuarter  VARCHAR(10) NOT NULL,
    RevenueAmount  DECIMAL(14,2) NOT NULL,
    TargetAmount   DECIMAL(14,2) NOT NULL
);

-- 3. Table: AccountActivity (Customer High-Frequency Trading Log)
CREATE TABLE AccountActivity
(
    TxnID          INT PRIMARY KEY IDENTITY(9001, 1),
    AccountID      INT NOT NULL,
    TxnType        VARCHAR(20) NOT NULL,
    TxnAmount      DECIMAL(12,2) NOT NULL,
    TxnTimestamp   DATETIME NOT NULL
);

-- ============================================================
-- 3. ENTERPRISE DATA POPULATION & SEEDING
-- ============================================================

-- Seed CorporatePayroll
INSERT INTO CorporatePayroll (EmpName, Department, Designation, Salary, PerformanceScore, HireDate) VALUES
('Amit Sharma',    'Engineering', 'Senior Architect', 145000, 96, '2020-03-15'),
('Priya Nair',     'Engineering', 'Principal Engineer', 160000, 99, '2019-01-10'),
('Rahul Verma',    'Engineering', 'Data Engineer',     110000, 92, '2022-06-01'),
('Sneha Patil',    'Engineering', 'Data Engineer',     110000, 94, '2022-08-15'),
('Rohan Deshmukh', 'Engineering', 'Junior Engineer',    80000, 88, '2024-02-01'),
('Neha Gupta',     'Product',     'Product Lead',      135000, 95, '2021-04-12'),
('Vikas Joshi',    'Product',     'Associate PM',       95000, 91, '2023-09-01'),
('Ananya Roy',     'Product',     'Associate PM',       95000, 89, '2023-11-15'),
('Suresh Menon',   'Marketing',   'Marketing Director',130000, 97, '2018-07-20'),
('Deepak Rao',     'Marketing',   'Growth Manager',     90000, 85, '2022-10-05'),
('Kavita Sen',     'Marketing',   'Growth Manager',     90000, 90, '2023-01-18'),
('Tanvi Joshi',    'HR',          'HR Lead',            85000, 93, '2021-05-25'),
('Manish Patel',   'HR',          'Recruiter',          60000, 87, '2023-07-10'),
('Bhavna Shah',    'HR',          'Recruiter',          60000, 84, '2024-01-05');

-- Seed RegionalRevenue
INSERT INTO RegionalRevenue (Region, SalesManager, FiscalQuarter, RevenueAmount, TargetAmount) VALUES
('North America', 'John Miller',    '2026-Q1', 1250000.00, 1000000.00),
('North America', 'Sarah Connor',   '2026-Q1', 1420000.00, 1100000.00),
('North America', 'David Clark',    '2026-Q1', 980000.00,  1000000.00),
('Europe',        'Hans Weber',     '2026-Q1', 1100000.00, 950000.00),
('Europe',        'Claire Dubois',  '2026-Q1', 1350000.00, 1050000.00),
('Europe',        'Marco Rossi',    '2026-Q1', 1100000.00, 900000.00),
('Asia-Pacific',  'Arun Patel',     '2026-Q1', 1650000.00, 1200000.00),
('Asia-Pacific',  'Mei Ling',       '2026-Q1', 1650000.00, 1300000.00),
('Asia-Pacific',  'Kenji Sato',     '2026-Q1', 1200000.00, 1000000.00);

-- Seed AccountActivity
INSERT INTO AccountActivity (AccountID, TxnType, TxnAmount, TxnTimestamp) VALUES
(8001, 'Deposit',    50000.00, '2026-08-20 09:15:00'),
(8001, 'Withdrawal', 12000.00, '2026-08-20 14:30:00'),
(8001, 'Transfer',   25000.00, '2026-08-21 11:00:00'),
(8002, 'Deposit',    95000.00, '2026-08-20 10:00:00'),
(8002, 'Transfer',   40000.00, '2026-08-22 16:45:00'),
(8003, 'Deposit',    30000.00, '2026-08-21 08:30:00'),
(8003, 'Withdrawal', 15000.00, '2026-08-21 17:15:00'),
(8003, 'Transfer',   10000.00, '2026-08-22 09:20:00');

-- ============================================================
-- 4. ANALYTIC PIPELINE TASKS (WINDOW FUNCTIONS & CTEs)
-- ============================================================

-- Task 1 [Global vs Partitioned Ranking Architecture]:
-- Write a query on CorporatePayroll generating:
-- 1. Global Salary Rank using DENSE_RANK()
-- 2. Department-wise Salary Rank using DENSE_RANK()
-- 3. Department-wise Sequential Row Number using ROW_NUMBER()
-- Output Columns: EmpID, EmpName, Department, Salary, GlobalRank, DeptRank, DeptRowNum
-- Write your SQL Query below:




-- Task 2 [Top 2 Highest Paid Employees per Department]:
-- Using a Common Table Expression (CTE) and DENSE_RANK(), retrieve the top 2 highest paid employees in every department.
-- Output Columns: Department, EmpName, Designation, Salary, DeptSalaryRank
-- Write your SQL Query below:




-- Task 3 [Departmental Salary Gap Analysis (Max vs 2nd Max)]:
-- Using CTEs, find the exact salary difference between the highest and 2nd highest salary earners in each department.
-- Output Columns: Department, TopSalary, SecondTopSalary, SalarySpread
-- Write your SQL Query below:




-- Task 4 [Regional Revenue Leaderboard with Ties]:
-- Using RegionalRevenue, find the Top 1 Sales Manager in each Region based on RevenueAmount DESC.
-- If multiple managers share the top revenue, return all tied managers using DENSE_RANK().
-- Output Columns: Region, SalesManager, RevenueAmount, FiscalQuarter
-- Write your SQL Query below:




-- Task 5 [High-Frequency Trading: Most Recent 2 Transactions per Account]:
-- For every AccountID in AccountActivity, extract their latest 2 transactions based on TxnTimestamp DESC.
-- Output Columns: AccountID, TxnID, TxnType, TxnAmount, TxnTimestamp, RecencyRank
-- Write your SQL Query below:




/* ============================================================
                    END OF PROJECT 6
   ============================================================ */
