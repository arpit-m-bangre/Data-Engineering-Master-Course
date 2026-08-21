-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 21 AUGUST 2026 (Day 18)
-- 🎯 TOPIC: Self Join Mechanics, Hierarchies & Scenario-Based Anomaly Engines
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

-- Clean up existing tables
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;

-- 1. Table: Employees (Hierarchical HR Org & Department Data)
CREATE TABLE Employees
(
    EmployeeID   INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    ManagerID    INT,
    DepartmentID INT NOT NULL,
    Salary       INT NOT NULL,
    HireDate     DATE NOT NULL
);

-- 2. Table: Customers (City & Contact Registry)
CREATE TABLE Customers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL,
    Email        VARCHAR(100) NOT NULL
);

-- 3. Table: Products (Catalog & Pricing)
CREATE TABLE Products
(
    ProductID    INT PRIMARY KEY,
    ProductName  VARCHAR(50) NOT NULL,
    CategoryID   INT NOT NULL,
    Price        DECIMAL(10,2) NOT NULL
);

-- 4. Table: Orders (Transactional Sales Stream)
CREATE TABLE Orders
(
    OrderID      INT PRIMARY KEY,
    CustomerID   INT NOT NULL,
    OrderDate    DATE NOT NULL,
    TotalAmount  DECIMAL(10,2) NOT NULL
);

-- Seed Employees Dataset
INSERT INTO Employees (EmployeeID, EmployeeName, ManagerID, DepartmentID, Salary, HireDate) VALUES
(1,  'Amit Sharma',   3,    10, 25000, '2023-01-15'),
(2,  'Rahul Verma',   1,    10, 32000, '2023-03-20'),
(3,  'Priya Nair',    NULL, 10, 50000, '2021-06-10'), -- CEO / Director (No Manager)
(4,  'Sneha Patil',   3,    20, 28000, '2023-01-15'),
(5,  'Rohan Kulkarni',2,    20, 55000, '2024-02-01'), -- Earns more than Rahul (Manager)
(6,  'Neha Gupta',    4,    30, 25000, '2022-11-12'),
(7,  'Vikas Joshi',   3,    10, 32000, '2023-08-05'),
(8,  'Ananya Roy',    1,    20, 48000, '2023-03-20'),
(9,  'Suresh Menon',  4,    30, 60000, '2021-04-18'), -- Senior in Dept 30
(10, 'Deepak Rao',    4,    30, 25000, '2024-09-01');

-- Seed Customers Dataset
INSERT INTO Customers (CustomerID, CustomerName, City, Email) VALUES
(101, 'Arun Mehta',    'Pune',      'arun.mehta@gmail.com'),
(102, 'Bhavna Shah',   'Mumbai',    'bhavna@yahoo.com'),
(103, 'Chetan Joshi',  'Pune',      'chetan.j@outlook.com'),
(104, 'Divya Kapoor',  'Delhi',     'divya.k@gmail.com'),
(105, 'Esha Deshmukh', 'Mumbai',    'bhavna@yahoo.com'), -- Duplicate Email Anomaly
(106, 'Farhan Khan',   'Pune',      'farhan.khan@gmail.com'),
(107, 'Gaurav Shinde', 'Bengaluru', 'gaurav.s@gmail.com'),
(108, 'Hitesh Patel',  'Mumbai',    'arun.mehta@gmail.com'); -- Duplicate Email Anomaly

-- Seed Products Dataset
INSERT INTO Products (ProductID, ProductName, CategoryID, Price) VALUES
(201, 'Standard Laptop',   1, 45000.00),
(202, 'Gaming Laptop',     1, 85000.00),
(203, 'Ultrabook Slim',    1, 62000.00),
(204, 'Wireless Mouse',    2, 800.00),
(205, 'Ergonomic Mouse',   2, 2500.00),
(206, 'Mechanical Keybd',  2, 4500.00),
(207, '4K Monitor 27in',   3, 28000.00),
(208, 'Curved Monitor',    3, 35000.00);

-- Seed Orders Dataset
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(501, 101, '2026-08-01', 1200.00),
(502, 101, '2026-08-02', 4500.00), -- Consecutive Day Order for Customer 101
(503, 102, '2026-08-05', 800.00),
(504, 103, '2026-08-10', 15000.00),
(505, 103, '2026-08-11', 3200.00), -- Consecutive Day Order for Customer 103
(506, 101, '2026-08-15', 750.00),
(507, 104, '2026-08-18', 2100.00),
(508, 104, '2026-08-20', 4300.00);


-- ====================================================================================================
-- 📝 PHASE 1: IN-CLASS & HOMEWORK SCENARIO TASKS
-- ====================================================================================================

-- ==============================================================================
-- TASK 1: EMPLOYEE & MANAGER SALARY COMPARISON
-- Table: Employees(EmployeeID, EmployeeName, ManagerID, Salary)
-- Objective: Find all employees who earn more than their direct manager.
-- Output Columns: EmployeeName, EmployeeSalary, ManagerName, ManagerSalary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 2: EMPLOYEES WITH THE SAME MANAGER
-- Table: Employees(EmployeeID, EmployeeName, ManagerID, Salary)
-- Objective: Find pairs of employees who report to the same manager.
-- Requirement: Avoid showing duplicate pairs (e.g. A-B and B-A) and do not match an employee with themselves.
-- Output Columns: ManagerID, Employee1_Name, Employee2_Name
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 3: EMPLOYEES IN SAME DEPARTMENT WITH SAME SALARY
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary)
-- Objective: Find employees who work in the same department and have the exact same salary.
-- Requirement: Each pair should appear only once.
-- Output Columns: DepartmentID, Employee1_Name, Employee2_Name, Salary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 4: CUSTOMERS FROM SAME CITY
-- Table: Customers(CustomerID, CustomerName, City)
-- Objective: Find all unique pairs of customers who live in the same city.
-- Requirement: Do not display duplicate pairs or self-matches.
-- Output Columns: City, Customer1_Name, Customer2_Name
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 5: PRODUCT PRICE COMPARISON WITHIN SAME CATEGORY
-- Table: Products(ProductID, ProductName, CategoryID, Price)
-- Objective: Find products where another product in the same category costs more than the current product.
-- Output Columns: CategoryID, ProductName, ProductPrice, MoreExpensiveProduct, HigherPrice
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 6: EMPLOYEE SALARY DIFFERENCE IN SAME DEPARTMENT
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary)
-- Objective: Find pairs of employees from the same department whose salary difference is strictly greater than 20,000.
-- Output Columns: DepartmentID, LowerPaidEmp, LowerSalary, HigherPaidEmp, HigherSalary, SalaryDifference
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 7: CONSECUTIVE ORDERS DETECTION
-- Table: Orders(OrderID, CustomerID, OrderDate, TotalAmount)
-- Objective: Find customers who placed two orders on consecutive days (difference of exactly 1 day).
-- Output Columns: CustomerID, FirstOrderID, FirstOrderDate, SecondOrderID, SecondOrderDate
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 8: DUPLICATE EMAIL DETECTION ACROSS CUSTOMER IDS
-- Table: Customers(CustomerID, CustomerName, Email)
-- Objective: Find customers having the same email address, but different CustomerIDs.
-- Output Columns: CustomerID_1, CustomerName_1, CustomerID_2, CustomerName_2, Email
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 9: EMPLOYEES HIRED IN THE SAME YEAR ON DIFFERENT DATES
-- Table: Employees(EmployeeID, EmployeeName, HireDate)
-- Objective: Find pairs of employees who were hired in the same calendar year, but on different dates.
-- Requirement: Avoid duplicate pairs.
-- Output Columns: HireYear, Employee1_Name, HireDate1, Employee2_Name, HireDate2
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 10: EMPLOYEE & SENIOR EMPLOYEE COMPARISON (TIER-1 INTERVIEW PATTERN)
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary, HireDate)
-- Objective: Find employees who have another colleague in the same department who was hired earlier AND earns a higher salary.
-- Output Columns: DepartmentID, EmployeeName, HireDate, Salary, SeniorColleagueName, SeniorHireDate, SeniorSalary
-- ==============================================================================

-- Write your SQL Query below:



