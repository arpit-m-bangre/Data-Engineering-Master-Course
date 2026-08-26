-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 26 AUGUST 2026 (Day 22)
-- 🎯 TOPIC: Conditional Logic (CASE Expressions), Conditional Aggregations & Dynamic Custom Sorting
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
IF OBJECT_ID('Marks', 'U') IS NOT NULL DROP TABLE Marks;
IF OBJECT_ID('CustomerDeliveries', 'U') IS NOT NULL DROP TABLE CustomerDeliveries;

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
(101, 'Aarav Sharma',   1, '2024-03-15', 145000.00),
(102, 'Priya Patel',    1, '2025-01-10', 140000.00),
(103, 'Rohan Verma',    1, '2023-08-20', 110000.00),
(104, 'Sneha Rao',      1, '2021-05-12', 110000.00),
(105, 'Vikram Malhotra',2, '2024-06-01', 135000.00),
(106, 'Ananya Sen',     2, '2025-02-15', 130000.00),
(107, 'Karan Joshi',    2, '2024-11-20', 95000.00),
(108, 'Neha Gupta',     3, '2023-10-05', 120000.00),
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
(2, 'Meera Iyer',    'Pune'),
(3, 'Sunil Chawla',  'Mumbai'),
(4, 'Kavita Deshmukh','Delhi'),
(5, 'Arjun Reddy',   'Pune'),
(6, 'Divya Joshi',   'Ahmedabad'),
(7, 'Sanjay Roy',    'Kolkata');

-- 4. Table: Orders
CREATE TABLE Orders
(
    OrderID      INT PRIMARY KEY,
    CustomerID   INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate    DATE NOT NULL,
    OrderAmount  DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderAmount) VALUES
(1001, 1, '2026-01-15', 5000.00),  -- Q1
(1002, 2, '2026-04-20', 8200.00),  -- Q2
(1003, 3, '2026-07-10', 4500.00),  -- Q3
(1004, 4, '2026-10-05', 12000.00), -- Q4
(1005, 5, '2026-02-18', 3500.00),  -- Q1
(1006, 6, '2026-08-22', 9100.00),  -- Q3
(1007, 7, '2026-11-30', 6400.00);  -- Q4

-- 5. Table: Marks
CREATE TABLE Marks
(
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    M1        INT NULL,
    M2        INT NULL
);

INSERT INTO Marks (M1, M2) VALUES
(20, 30), (30, 40), (50, 30), (20, 10), (10, 10), (20, 25),
(NULL, 20), (NULL, 25), (NULL, NULL), (30, NULL);

-- 6. Table: CustomerDeliveries
CREATE TABLE CustomerDeliveries
(
    DeliveryID   INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID   INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate    DATE NOT NULL,
    DeliveryDate DATE NULL
);

INSERT INTO CustomerDeliveries (CustomerID, OrderDate, DeliveryDate) VALUES
(1, '2026-08-10', '2026-08-14'), -- Delivered
(2, '2026-08-12', NULL),         -- Pending (>= 7 days from 2026-08-26)
(3, '2026-08-22', NULL),         -- In Progress (< 7 days from 2026-08-26)
(4, '2026-08-18', '2026-08-21'), -- Delivered
(5, '2026-08-15', NULL);         -- Pending (>= 7 days from 2026-08-26)


-- ====================================================================================================
-- 📝 TASK 1: FACULTY HOMEWORK 1 — DEPARTMENT-WISE SALARY RANK CLASSIFICATION
-- ====================================================================================================
/*
Problem Statement:
For each department, assign a dense salary rank.
Classify salaries using a CASE expression:
- Rank 1: 'Highest Salary'
- Rank 2: '2nd Highest Salary'
- All other ranks: 'Common Salary'
Output columns: DeptName, EmpID, EmpName, Salary, SalaryRank, SalaryClassification
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 2: FACULTY HOMEWORK 2 — CUSTOM PINNED SORTING (PUNE FIRST, REST DESCENDING)
-- ====================================================================================================
/*
Problem Statement:
Retrieve all customers such that customers from 'Pune' ALWAYS appear at the very top (1st priority),
and all other cities are sorted in descending alphabetical order.
Output columns: CustomerID, CustomerName, City
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 3: FACULTY HOMEWORK 3 — CUSTOMER QUARTER ORDER SEGMENTATION
-- ====================================================================================================
/*
Problem Statement:
Join Customers and Orders.
Display CustomerName, OrderAmount, OrderDate, QuarterNumber (using DATEPART).
Classify the order season using CASE:
- If placed in Quarter 1 (Jan-Mar) or Quarter 3 (Jul-Sep): print 'Middle Season'
- Otherwise (Quarter 2 or Quarter 4): print 'Closing Season'
Output columns: CustomerName, OrderAmount, OrderDate, QuarterNumber, SeasonClassification
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 4: CLASS SCENARIO 1 — NULL-RESILIENT ARITHMETIC & STATUS COUNTS
-- ====================================================================================================
/*
Problem Statement:
From the Marks table:
1. Compute safe addition of M1 and M2:
   - If both are NULL -> 0
   - If M1 is NULL -> M2
   - If M2 is NULL -> M1
   - Else -> M1 + M2
2. In a CTE, assign Status:
   - Total >= 70: 'Best'
   - Total BETWEEN 50 AND 70: 'Average'
   - Else: 'Below Average'
3. In the outer query, return Status and StatusCount (COUNT(*)).
Output columns: Status, StatusCount
*/

-- Write your SQL Query below:




-- ====================================================================================================
-- 📝 TASK 5: CLASS SCENARIO 2 — MULTI-TIER DELIVERY STATUS TRACKING
-- ====================================================================================================
/*
Problem Statement:
From CustomerDeliveries joined with Customers:
Compute OrderStatus based on reference date '2026-08-26':
- If DeliveryDate IS NOT NULL: 'Delivered'
- If DeliveryDate IS NULL AND DATEDIFF(DAY, OrderDate, '2026-08-26') >= 7: 'Pending'
- If DeliveryDate IS NULL AND DATEDIFF(DAY, OrderDate, '2026-08-26') < 7: 'In Progress'
Output columns: CustomerID, CustomerName, OrderDate, DeliveryDate, DaysElapsed, OrderStatus
*/

-- Write your SQL Query below:




