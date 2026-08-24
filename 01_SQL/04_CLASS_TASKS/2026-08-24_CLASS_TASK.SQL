-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 24 AUGUST 2026 (Day 20)
-- 🎯 TOPIC: Common Table Expressions (CTEs), CTE with Window Functions & In-Place Deduplication
-- ⚠️ MANDATORY RULE: ALL TASKS MUST BE SOLVED USING COMMON TABLE EXPRESSIONS (WITH ... AS)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

-- Clean up existing tables
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('PersonRegistry', 'U') IS NOT NULL DROP TABLE PersonRegistry;
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
IF OBJECT_ID('Emp', 'U') IS NOT NULL DROP TABLE Emp;

-- 1. Table: Emp (Corporate Payroll Data)
CREATE TABLE Emp
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary     INT NOT NULL
);

INSERT INTO Emp (EmpID, EmpName, Department, Salary) VALUES
(101, 'Rahul Sharma', 'IT', 95000),
(102, 'Pooja Verma', 'HR', 65000),
(103, 'Amit Patel', 'IT', 120000),
(104, 'Sneha Rao', 'Finance', 85000),
(105, 'Vikas Gupta', 'IT', 110000),
(106, 'Neha Singh', 'HR', 72000),
(107, 'Karan Mehta', 'Finance', 85000),
(108, 'Suresh Reddy', 'IT', 120000);

-- 2. Table: StudentInfo (Examination Registry with Duplicate Rows)
CREATE TABLE StudentInfo
(
    StudentID   INT IDENTITY(1,1) PRIMARY KEY,
    RollNo      INT NOT NULL,
    StudentName VARCHAR(50) NOT NULL,
    Subject     VARCHAR(50) NOT NULL,
    Marks       INT NOT NULL,
    EmailID     VARCHAR(100) NOT NULL,
    City        VARCHAR(50) NOT NULL,
    MobileNo    VARCHAR(15) NOT NULL
);

INSERT INTO StudentInfo (RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo) VALUES
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'),
(2, 'Diya Sharma', 'Science', 85, 'diya@test.com', 'Mumbai', '9876543211'),
(3, 'Rohan Joshi', 'Maths', 78, 'rohan@test.com', 'Pune', '9876543212'),
(4, 'Isha Kapoor', 'English', 95, 'isha@test.com', 'Delhi', '9876543213'),
(5, 'Ananya Sen', 'Science', 88, 'ananya@test.com', 'Kolkata', '9876543214'),
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'), -- Duplicate
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'), -- Duplicate
(3, 'Rohan Joshi', 'Maths', 78, 'rohan@test.com', 'Pune', '9876543212'); -- Duplicate

-- 3. Table: PersonRegistry (Gender Sequencing Registry)
CREATE TABLE PersonRegistry
(
    PersonID INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Gender   CHAR(1) NOT NULL -- 'M' or 'F'
);

INSERT INTO PersonRegistry (FullName, Gender) VALUES
('Rahul', 'M'),
('Priya', 'F'),
('Amit', 'M'),
('Sneha', 'F'),
('Vikas', 'M'),
('Pooja', 'F'),
('Rohan', 'M'),
('Kavita', 'F');

-- 4. Table: Customers (E-Commerce Customer Hub)
CREATE TABLE Customers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Aditi Sharma', 'Pune'),
(2, 'Manish Tiwari', 'Mumbai'),
(3, 'Rohan Mehra', 'Pune'),
(4, 'Pooja Hegde', 'Bangalore'),
(5, 'Vikram Malhotra', 'Mumbai');

-- 5. Table: Orders (Transactional Order Stream)
CREATE TABLE Orders
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ProductID   VARCHAR(20) NOT NULL,
    OrderDate   DATE NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Amount) VALUES
(501, 1, 'P-LAPTOP', '2026-08-01', 75000.00),
(502, 1, 'P-PHONE',  '2026-08-15', 35000.00),
(503, 1, 'P-TAB',    '2026-08-20', 25000.00),
(504, 2, 'P-MONITOR','2026-08-05', 18000.00),
(505, 2, 'P-DESK',   '2026-08-22', 45000.00),
(506, 3, 'P-CHAIR',  '2026-08-10', 12000.00),
(507, 3, 'P-MOUSE',  '2026-08-24', 3500.00),
(508, 4, 'P-KEYBOARD','2026-08-18', 6000.00),
(509, 5, 'P-LAPTOP', '2026-08-02', 82000.00),
(510, 5, 'P-PHONE',  '2026-08-21', 54000.00);

-- ====================================================================================================
-- 📝 PHASE 1: FACULTY CLASS & HOMEWORK TASKS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- TASK 1: Global 3rd Maximum Salary via CTE & DENSE_RANK
-- Objective: Write a CTE query to return the employee(s) earning the exact 3rd highest distinct salary across the entire company.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 2: Department-Wise 2nd Highest Earner
-- Objective: Write a CTE query to return the 2nd highest earner within each department using PARTITION BY.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 3: Nth Highest Examination Marks (6th Highest Marks)
-- Objective: From StudentInfo, find the student record(s) with the 6th highest marks using DENSE_RANK inside a CTE.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 4: Flag & Identify Full-Row Redundant Duplicates
-- Objective: Write a CTE using ROW_NUMBER() partitioned across all identity columns (RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo) to display only the redundant duplicate rows (RowOccurrence > 1).
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 5: Atomic Base Table Deduplication (DELETE via CTE)
-- Objective: Write a CTE DELETE query to permanently delete all duplicate records from StudentInfo while preserving exactly one master original row per entity.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 6: Alternating Gender Sequence (M / F / M / F)
-- Objective: From PersonRegistry, display all records in an alternating male-female order (M, F, M, F...) using CTE and ROW_NUMBER().
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 7: Most Recent / Latest Order Per Customer
-- Objective: Using Orders table, display each customer's most recent order by OrderDate using ROW_NUMBER inside a CTE.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- TASK 8: Multi-Table Analytical CTE — City-Wise 2nd Highest Order Amount
-- Objective: Join Customers and Orders inside a CTE to find the 2nd highest order amount placed in each city.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




