-- ====================================================================================================
-- 🎯 14 TARGETED PRACTICE DRILLS: CONDITIONAL LOGIC & CASE EXPRESSIONS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 2026-08-26 (Day 22)
-- 🎯 FOCUS: Simple/Searched CASE, Conditional Aggregations, Dynamic Sorting & NULL Handling
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('OrderItems', 'U') IS NOT NULL DROP TABLE OrderItems;
IF OBJECT_ID('Transactions', 'U') IS NOT NULL DROP TABLE Transactions;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('StudentScores', 'U') IS NOT NULL DROP TABLE StudentScores;

CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

INSERT INTO Departments (DeptID, DeptName) VALUES
(1, 'Engineering'), (2, 'Analytics'), (3, 'Finance'), (4, 'Marketing');

CREATE TABLE Employees
(
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    DeptID      INT NOT NULL FOREIGN KEY REFERENCES Departments(DeptID),
    Salary      DECIMAL(10,2) NOT NULL,
    JoiningDate DATE NOT NULL,
    PerformanceRating INT NULL
);

INSERT INTO Employees (EmpID, EmpName, DeptID, Salary, JoiningDate, PerformanceRating) VALUES
(101, 'Aarav Sharma',   1, 145000.00, '2022-03-15', 5),
(102, 'Priya Patel',    1, 135000.00, '2024-01-10', 4),
(103, 'Rohan Verma',    1, 95000.00,  '2025-08-20', 3),
(104, 'Sneha Rao',      2, 125000.00, '2023-05-12', NULL),
(105, 'Vikram Malhotra',2, 110000.00, '2024-06-01', 2),
(106, 'Ananya Sen',     3, 85000.00,  '2021-02-15', 5),
(107, 'Karan Joshi',    4, 65000.00,  '2025-11-20', 1);

CREATE TABLE Products
(
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Category    VARCHAR(50) NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL,
    StockQty    INT NOT NULL
);

INSERT INTO Products (ProductID, ProductName, Category, UnitPrice, StockQty) VALUES
(501, 'MacBook Pro M3', 'Hardware', 2000.00, 15),
(502, 'Dell UltraSharp','Hardware', 450.00,  5),
(503, 'Cloud DB License','Software',1200.00, 50),
(504, 'Office Suite Pro','Software',250.00,  0),
(505, 'Ergonomic Desk', 'Furniture',800.00,  8);

CREATE TABLE Transactions
(
    TxnID       INT IDENTITY(1001, 1) PRIMARY KEY,
    AccountID   INT NOT NULL,
    TxnType     VARCHAR(10) NOT NULL, -- 'CREDIT' or 'DEBIT'
    Amount      DECIMAL(10,2) NOT NULL,
    TxnDate     DATE NOT NULL,
    Status      VARCHAR(20) NOT NULL  -- 'SUCCESS', 'FAILED', 'PENDING'
);

INSERT INTO Transactions (AccountID, TxnType, Amount, TxnDate, Status) VALUES
(1, 'CREDIT', 5000.00, '2026-01-10', 'SUCCESS'),
(1, 'DEBIT',  1200.00, '2026-01-15', 'SUCCESS'),
(1, 'DEBIT',  8000.00, '2026-02-01', 'FAILED'),
(2, 'CREDIT', 15000.00,'2026-02-10', 'SUCCESS'),
(2, 'DEBIT',  3000.00, '2026-03-05', 'SUCCESS'),
(3, 'DEBIT',  450.00,  '2026-03-12', 'PENDING');

CREATE TABLE StudentScores
(
    StudentID INT PRIMARY KEY,
    Exam1     INT NULL,
    Exam2     INT NULL,
    Exam3     INT NULL
);

INSERT INTO StudentScores (StudentID, Exam1, Exam2, Exam3) VALUES
(1, 85, 90, 92),
(2, 70, NULL, 65),
(3, NULL, NULL, 50),
(4, NULL, NULL, NULL),
(5, 45, 52, 48);


-- ====================================================================================================
-- 📝 QUESTION 1 (BASIC SEARCHED CASE: SALARY BANDING)
-- Categorize each employee into a SalaryBand:
-- - >= 130000 -> 'Tier 1 (High)'
-- - 90000 to 129999 -> 'Tier 2 (Mid)'
-- - < 90000 -> 'Tier 3 (Entry)'
-- Output: EmpID, EmpName, Salary, SalaryBand
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 2 (SIMPLE CASE: DEPARTMENT CODE REPLACEMENT)
-- Display EmpName, DeptID, and DeptCategory using Simple CASE on DeptID:
-- - 1 -> 'Core Engineering'
-- - 2 -> 'Data & Insights'
-- - 3 or 4 -> 'Business Operations'
-- - Else -> 'General Staff'
-- Output: EmpName, DeptID, DeptCategory
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 3 (NULL RESILIENT PERFORMANCE EVALUATION)
-- Display EmpName, PerformanceRating, and AppraisalStatus:
-- - If Rating IS NULL -> 'Rating Pending'
-- - Rating >= 4 -> 'Eligible for Promotion'
-- - Rating = 3 -> 'Meets Standard'
-- - Rating <= 2 -> 'Needs Improvement'
-- Output: EmpName, PerformanceRating, AppraisalStatus
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 4 (CONDITIONAL INVENTORY REORDER FLAG)
-- For the Products table, create a StockStatus flag:
-- - StockQty = 0 -> 'Out of Stock (Urgent)'
-- - StockQty BETWEEN 1 AND 10 -> 'Low Stock (Reorder)'
-- - StockQty > 10 -> 'In Stock'
-- Output: ProductID, ProductName, StockQty, StockStatus
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 5 (CONDITIONAL PIVOT AGGREGATION: TRANSACTION TOTALS)
-- From the Transactions table, compute the total SuccessCredit and total SuccessDebit per AccountID in a single query:
-- Output: AccountID, TotalSuccessCredit, TotalSuccessDebit, NetBalance (Credit - Debit)
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 6 (NULL RESILIENT MULTI-COLUMN SCORE AVERAGE)
-- In StudentScores, compute the valid average across Exam1, Exam2, Exam3 ignoring NULLs.
-- Count only non-null exams in denominator (e.g. if Exam1=70 and Exam3=65, avg = (70+65)/2).
-- If all are NULL, return 0.
-- Output: StudentID, ValidExamCount, CompositeAverage
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 7 (CUSTOM DYNAMIC SORTING: HARDWARE FIRST)
-- Display all products sorted such that:
-- - Category 'Hardware' comes first
-- - Category 'Software' comes second
-- - All other categories come last
-- - Within the same category, sort by UnitPrice in descending order.
-- Output: ProductID, ProductName, Category, UnitPrice
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 8 (GROUP BY CASE CALCULATION VIA CTE)
-- Categorize products into PriceSegments:
-- - UnitPrice >= 1000 -> 'Premium'
-- - UnitPrice BETWEEN 300 AND 999 -> 'Standard'
-- - UnitPrice < 300 -> 'Budget'
-- Group by PriceSegment and calculate ProductCount and AverageStockQty.
-- Output: PriceSegment, ProductCount, AverageStockQty
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 9 (TEMPORAL SENIORITY STATUS CALCULATION)
-- Calculate employee tenure as of '2026-08-26' using DATEDIFF(YEAR, JoiningDate, '2026-08-26'):
-- - Tenure >= 4 years -> 'Veteran Lead'
-- - Tenure BETWEEN 2 AND 3 years -> 'Mid-Level Specialist'
-- - Tenure < 2 years -> 'Recent Associate'
-- Output: EmpID, EmpName, JoiningDate, TenureYears, SeniorityStatus
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 10 (CONDITIONAL BONUS MULTIPLIER VIA JOIN)
-- Calculate each employee's AnnualBonus:
-- - Performance Rating 5 -> 20% of Salary (Salary * 0.20)
-- - Performance Rating 4 -> 15% of Salary
-- - Performance Rating 3 -> 10% of Salary
-- - Performance Rating 1, 2, or NULL -> 0 Bonus
-- Output: EmpName, DeptName, Salary, PerformanceRating, BonusAmount, TotalCompensation
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 11 (DEPARTMENT SALARY LEADERBOARD LABELING)
-- Using DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC):
-- Label Rank 1 as 'Top Earner', Rank 2 as 'Runner Up', and remaining as 'Team Member'.
-- Output: DeptID, EmpName, Salary, SalaryRank, EarnerLabel
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 12 (TRANSACTION AUDIT SEVERITY GRADING)
-- From the Transactions table:
-- If Status = 'FAILED' AND Amount >= 5000 -> 'Critical Alert'
-- If Status = 'FAILED' AND Amount < 5000 -> 'Minor Failure'
-- If Status = 'PENDING' -> 'In Review'
-- If Status = 'SUCCESS' -> 'Normal Cleared'
-- Output: TxnID, AccountID, Amount, Status, AuditGrade
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 13 (CONDITIONAL STRING FORMATTING & TITLE PREFIX)
-- Generate a formatted employee display card:
-- Prefix 'Chief ' if Salary >= 130000, prefix 'Senior ' if Salary BETWEEN 100000 AND 129999, else prefix 'Engineer '.
-- Output: EmpID, FormattedTitle (e.g. 'Chief Aarav Sharma (Engineering)')
-- ====================================================================================================
-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 QUESTION 14 (TWO-TIER FINANCIAL RISK INDEX)
-- For each AccountID in Transactions:
-- Calculate FailureRate = (Count of Failed Txns * 100.0) / Total Txns
-- If FailureRate >= 50% -> 'High Risk Account'
-- If FailureRate BETWEEN 1% AND 49% -> 'Moderate Risk Account'
-- If FailureRate = 0% -> 'Clean Standing'
-- Output: AccountID, TotalTxns, FailedTxns, FailureRate, RiskClassification
-- ====================================================================================================
-- Write your SQL Query below:




