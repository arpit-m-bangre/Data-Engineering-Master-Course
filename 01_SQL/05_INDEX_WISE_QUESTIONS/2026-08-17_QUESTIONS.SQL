-- ===================================================
-- 📋 PRACTICE QUESTIONS: DATE & DATETIME FUNCTIONS
-- 🏢 MODULE 01: SQL Relational Architecture
-- 📆 CLASS DATE: 17 AUGUST 2026 (Day 14)
-- 🎯 TOPIC: GETDATE, DATEDIFF, DATEPART, DATEADD, EOMONTH
-- ===================================================

-- ===================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SCHEMA CREATION
-- ===================================================

-- Drop existing demo tables if they exist:
IF OBJECT_ID('EmpOnboarding', 'U') IS NOT NULL DROP TABLE EmpOnboarding;
IF OBJECT_ID('CustomerSales', 'U') IS NOT NULL DROP TABLE CustomerSales;
IF OBJECT_ID('InsurancePolicies', 'U') IS NOT NULL DROP TABLE InsurancePolicies;
IF OBJECT_ID('UserSubscriptions', 'U') IS NOT NULL DROP TABLE UserSubscriptions;

-- Table 1: Employee Onboarding Records
CREATE TABLE EmpOnboarding
(
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    Department  VARCHAR(30) NOT NULL,
    JoiningDate DATE NOT NULL,
    BirthDate   DATE NOT NULL,
    Salary      DECIMAL(10,2) NOT NULL
);

-- Table 2: Customer Sales Orders
CREATE TABLE CustomerSales
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    CustomerName VARCHAR(50) NOT NULL,
    OrderDate   DATETIME NOT NULL,
    OrderAmount DECIMAL(10,2) NOT NULL
);

-- Table 3: Insurance Policy Records
CREATE TABLE InsurancePolicies
(
    PolicyID    INT PRIMARY KEY,
    HolderName  VARCHAR(50) NOT NULL,
    StartDate   DATE NOT NULL,
    TenureYears INT NOT NULL,
    PremiumAmt  DECIMAL(10,2) NOT NULL
);

-- Table 4: User Software Subscriptions
CREATE TABLE UserSubscriptions
(
    SubID       INT PRIMARY KEY,
    UserName    VARCHAR(50) NOT NULL,
    Tier        VARCHAR(20) NOT NULL,
    SubDate     DATE NOT NULL,
    IsActive    BIT NOT NULL DEFAULT 1
);

-- Seed Enterprise Data:
INSERT INTO EmpOnboarding (EmpID, EmpName, Department, JoiningDate, BirthDate, Salary)
VALUES
(101, 'Aarav Sharma',  'Engineering', '2024-02-17', '1995-05-12', 85000.00),
(102, 'Priya Patel',   'Analytics',   '2024-08-10', '1998-11-23', 72000.00),
(103, 'Rohan Verma',   'Data Ops',    '2025-01-05', '1993-08-15', 68000.00),
(104, 'Ananya Gupta',  'Engineering', '2025-06-21', '2000-02-29', 91000.00),
(105, 'Karan Malhotra','Analytics',   '2026-08-16', '1997-04-18', 65000.00),
(106, 'Sneha Reddy',   'Data Ops',    '2026-08-17', '1999-10-05', 78000.00);

INSERT INTO CustomerSales (OrderID, CustomerID, CustomerName, OrderDate, OrderAmount)
VALUES
(501, 1, 'TechCorp Ltd',  '2026-01-15 10:30:00', 45000.00),
(502, 2, 'Global Logistics','2026-03-22 14:15:00', 12500.00),
(503, 1, 'TechCorp Ltd',  '2026-05-10 09:45:00', 31000.00),
(504, 3, 'Retail Giant',  '2026-07-04 18:20:00', 68000.00),
(505, 4, 'Apex Health',   '2026-08-01 11:00:00', 15000.00),
(506, 2, 'Global Logistics','2026-08-16 16:30:00', 22000.00);

INSERT INTO InsurancePolicies (PolicyID, HolderName, StartDate, TenureYears, PremiumAmt)
VALUES
(901, 'Vikram Seth',  '2021-03-15', 5, 25000.00),
(902, 'Meera Nair',   '2023-09-01', 3, 18000.00),
(903, 'Amit Roy',     '2025-11-20', 2, 35000.00),
(904, 'Divya Kapoor', '2026-02-10', 1, 12000.00);

INSERT INTO UserSubscriptions (SubID, UserName, Tier, SubDate, IsActive)
VALUES
(1, 'John Doe',     'Enterprise', '2026-01-01', 1),
(2, 'Jane Smith',   'Pro',        '2026-05-15', 1),
(3, 'Bob Johnson',  'Free',       '2026-07-20', 0),
(4, 'Alice Brown',  'Enterprise', '2026-08-10', 1);


-- ===================================================
-- 🔰 PHASE 1: BASIC SYNTAX DRILLS (Q1 TO Q5)
-- ===================================================

-- Q1. Write a query to return the current system
--     date and timestamp, labeled as CurrentTime.
-- Write your SQL Query below:




-- Q2. Calculate the difference in months between
--     each employee's JoiningDate and GETDATE().
--     Display EmpName, JoiningDate, and MonthsServed.
-- Write your SQL Query below:




-- Q3. Extract the numeric Quarter and Month from
--     each OrderDate in CustomerSales.
-- Write your SQL Query below:




-- Q4. For every policy in InsurancePolicies, calculate
--     the NextSemiAnnualPremiumDate by adding 6
--     months to StartDate using DATEADD.
-- Write your SQL Query below:




-- Q5. Use the EOMONTH function to display each
--     employee's JoiningDate alongside the exact
--     last date of that joining month.
-- Write your SQL Query below:





-- ===================================================
-- 🔄 PHASE 2: CUMULATIVE REVISION (Q6 TO Q10)
-- ===================================================

-- Q6. Write a query to find all employees whose
--     joining date was strictly on a weekend
--     (Saturday or Sunday). Display EmpName and JoiningDate.
-- Write your SQL Query below:




-- Q7. Calculate the total OrderAmount and average
--     OrderAmount grouped by the order's Month
--     (extracted using DATEPART).
-- Write your SQL Query below:




-- Q8. Retrieve all CustomerSales orders that were
--     placed during Quarter 1 or Quarter 2 of 2026.
--     Use DATEPART(QQ, ...) in the WHERE clause.
-- Write your SQL Query below:




-- Q9. Calculate each employee's approximate age in
--     years by computing the DATEDIFF in years
--     between BirthDate and GETDATE().
-- Write your SQL Query below:




-- Q10. Find all InsurancePolicies where the policy
--      is scheduled to mature within the current year
--      (i.e., DATEADD in years to StartDate = 2026).
-- Write your SQL Query below:





-- ===================================================
-- 🏢 PHASE 3: ENTERPRISE SCENARIOS (Q11 TO Q15)
-- ===================================================

-- Q11.1 (Customer Churn Analysis):
--       Find all customers who have NOT placed any
--       order in the last 90 days relative to
--       '2026-08-17'.
-- Write your SQL Query below:




-- Q11.2 (Recent Activity Window):
--       Find all orders placed within the last
--       14 days relative to '2026-08-17'.
-- Write your SQL Query below:




-- Q12. (HR Payroll Anniversary & Bonus):
--       Identify employees who have completed at least
--       18 months of tenure at the company. Display
--       EmpName, Department, JoiningDate, and MonthsServed.
-- Write your SQL Query below:




-- Q13. (Financial Quarter Reporting):
--       Write a query to calculate total sales revenue
--       broken down by Year and Quarter. Group by
--       both temporal attributes and order chronologically.
-- Write your SQL Query below:




-- Q14. (Subscription Grace Period Calculation):
--       For all active subscriptions in UserSubscriptions,
--       display SubID, UserName, SubDate, and calculate:
--       - RenewalDate (SubDate + 1 Year)
--       - GracePeriodEnd (RenewalDate + 15 Days)
-- Write your SQL Query below:




-- Q15. (Leap Year Birth Date Detection):
--       Find any employee born on a leap year date
--       (where month is February and day is 29).
-- Write your SQL Query below:





-- ===================================================
-- 🧠 PHASE 4: LOGIC BUILDER & DEBUGGING (Q16 TO Q20)
-- ===================================================

-- Q16. [BUG FIX]: The junior developer wrote this query
--      to find difference in milliseconds over 2 months,
--      but it throws an Integer Overflow error (Msg 535).
--      Rewrite it using seconds (SS) or minutes (N).
--      Broken Query:
--      SELECT DATEDIFF(MS, '2026-06-01', GETDATE());
-- Write your SQL Query below:




-- Q17. [BUG FIX]: The query below fails with Msg 241
--      due to invalid character conversion. Fix the date
--      literal to standard ISO format (YYYY-MM-DD).
--      Broken Query:
--      SELECT DATEDIFF(DD, '31/02/2026', GETDATE());
-- Write your SQL Query below:




-- Q18. [BOUNDARY TRAP LOGIC]:
--      Explain why DATEDIFF(YY, '2025-12-31', '2026-01-01')
--      returns 1 even though only 1 day elapsed.
--      Write a query comparing DATEDIFF in YY vs DD.
-- Write your SQL Query below:




-- Q19. [EOMONTH REVENUE RECONCILIATION]:
--      Write a query to list each OrderID, OrderDate,
--      and calculate the MonthEndDeadline using EOMONTH.
--      Also calculate how many days remained in that
--      month using DATEDIFF between OrderDate and MonthEndDeadline.
-- Write your SQL Query below:




-- Q20. [COMPREHENSIVE METRIC DASHBOARD]:
--      Write a single query for EmpOnboarding displaying:
--      - EmpID, EmpName
--      - DayOfWeekJoined (e.g. 1, 2... 7)
--      - FullYearsCompleted (DATEDIFF in YY from JoiningDate)
--      - NextQuarterStart (EOMONTH + 1 Day for quarter)
--      - CurrentStatus: 'Senior' if tenure >= 24 months, else 'Junior'
-- Write your SQL Query below:



