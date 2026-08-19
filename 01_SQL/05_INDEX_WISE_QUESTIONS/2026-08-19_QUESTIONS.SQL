-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — PRACTICE DRILL SET
-- 📅 DATE: 19 AUGUST 2026 (WEDNESDAY) | BATCH: ONLINE BATCH 15 (DAY 16)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: ANSI SQL RELATIONAL JOINS, COLUMN AMBIGUITY, ANTI-JOINS & GROUP AGGREGATIONS
-- 📁 TOTAL QUESTIONS: EXACTLY 14 TARGETED DRILLS
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SCHEMA CREATION
-- ====================================================================================================

-- Clean up practice tables
IF OBJECT_ID('OrderItems', 'U') IS NOT NULL DROP TABLE OrderItems;
IF OBJECT_ID('PracticeOrders', 'U') IS NOT NULL DROP TABLE PracticeOrders;
IF OBJECT_ID('PracticeCustomers', 'U') IS NOT NULL DROP TABLE PracticeCustomers;
IF OBJECT_ID('PracticeProjects', 'U') IS NOT NULL DROP TABLE PracticeProjects;
IF OBJECT_ID('PracticeEmployees', 'U') IS NOT NULL DROP TABLE PracticeEmployees;
IF OBJECT_ID('PracticeDepartments', 'U') IS NOT NULL DROP TABLE PracticeDepartments;

-- Table 1: PracticeDepartments
CREATE TABLE PracticeDepartments
(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

-- Table 2: PracticeEmployees
CREATE TABLE PracticeEmployees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    DeptID INT,
    Salary DECIMAL(10,2),
    ProjectID INT
);

-- Table 3: PracticeProjects
CREATE TABLE PracticeProjects
(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    Budget DECIMAL(12,2) NOT NULL
);

-- Table 4: PracticeCustomers
CREATE TABLE PracticeCustomers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    SignupDate DATE NOT NULL
);

-- Table 5: PracticeOrders
CREATE TABLE PracticeOrders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL
);

-- Table 6: OrderItems
CREATE TABLE OrderItems
(
    ItemID INT PRIMARY KEY,
    OrderID INT,
    ItemName VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- Seed Data:
INSERT INTO PracticeDepartments (DeptID, DeptName, Location)
VALUES
(10, 'Data Engineering', 'Bengaluru'),
(20, 'Machine Learning', 'Hyderabad'),
(30, 'Cloud Infrastructure', 'Pune'),
(40, 'Product Management', 'Mumbai'),
(50, 'Human Resources', 'Delhi');

INSERT INTO PracticeEmployees (EmpID, EmpName, DeptID, Salary, ProjectID)
VALUES
(101, 'Aarav Sharma', 10, 95000.00, 501),
(102, 'Priya Patel',  10, 88000.00, 501),
(103, 'Rohan Verma',  20, 92000.00, 502),
(104, 'Sneha Reddy',  30, 85000.00, 503),
(105, 'Vikram Roy',   NULL, 72000.00, NULL),
(106, 'Ananya Sen',   40, 98000.00, NULL);

INSERT INTO PracticeProjects (ProjectID, ProjectName, Budget)
VALUES
(501, 'Real-Time Streaming Pipeline', 500000.00),
(502, 'LLM Fine-Tuning Engine',       750000.00),
(503, 'Multi-Cloud Migration',        350000.00),
(504, 'Legacy Warehouse Sunset',      200000.00);

INSERT INTO PracticeCustomers (CustomerID, CustomerName, City, SignupDate)
VALUES
(1, 'TechCorp Global', 'Bengaluru', '2026-01-10'),
(2, 'RetailSphere',    'Mumbai',    '2026-02-15'),
(3, 'FinEdge Capital', 'Pune',      '2026-03-20'),
(4, 'HealthPulse',     'Hyderabad', '2026-04-05'),
(5, 'EduLearn Tech',   'Delhi',     '2026-05-12');

INSERT INTO PracticeOrders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(9001, 1, '2026-02-01', 15000.00),
(9002, 1, '2026-03-15', 22000.00),
(9003, 2, '2026-03-20', 8500.00),
(9004, 3, '2026-04-10', 45000.00),
(9005, 3, '2026-05-01', 12000.00);

INSERT INTO OrderItems (ItemID, OrderID, ItemName, Quantity, UnitPrice)
VALUES
(1, 9001, 'Spark Cluster Tier 1', 2, 7500.00),
(2, 9002, 'Kafka Message Queue',  4, 5500.00),
(3, 9003, 'PostgreSQL Database',  1, 8500.00),
(4, 9004, 'Snowflake Credits',    5, 9000.00),
(5, 9005, 'Airflow Managed Core', 2, 6000.00);

-- Verify Seed Data
SELECT * FROM PracticeDepartments;
SELECT * FROM PracticeEmployees;
SELECT * FROM PracticeProjects;
SELECT * FROM PracticeCustomers;
SELECT * FROM PracticeOrders;
SELECT * FROM OrderItems;


-- ====================================================================================================
-- 🔰 PHASE 1: BASIC JOIN SYNTAX DRILLS (Q01 - Q04)
-- ====================================================================================================

-- Q01. Write a query using INNER JOIN to display EmpName, DeptName, and Location 
--      for all employees who are assigned to a valid department.
-- Write your SQL Query below:




-- Q02. Write a query using LEFT JOIN between PracticeEmployees and PracticeDepartments 
--      to display EmpName, Salary, and DeptName. Ensure employees with no department are included.
-- Write your SQL Query below:




-- Q03. Write a query using RIGHT JOIN between PracticeEmployees and PracticeDepartments 
--      to display DeptName, Location, and EmpName. Ensure departments with zero employees are shown.
-- Write your SQL Query below:




-- Q04. Write a query using FULL OUTER JOIN between PracticeEmployees and PracticeDepartments 
--      to display EmpName and DeptName, capturing all matched and unmatched records from both tables.
-- Write your SQL Query below:




-- ====================================================================================================
-- ⚙️ PHASE 2: COLUMN AMBIGUITY & ANTI-JOIN DRILLS (Q05 - Q08)
-- ====================================================================================================

-- Q05. Join PracticeEmployees and PracticeProjects on ProjectID. 
--      Select ProjectID, EmpName, ProjectName, and Budget without triggering the "Ambiguous column name" error.
-- Write your SQL Query below:




-- Q06. Write an Anti-Join query using LEFT JOIN to find all PracticeEmployees 
--      who are NOT currently assigned to any project (ProjectID is NULL or unassigned).
-- Write your SQL Query below:




-- Q07. Write an Anti-Join query using RIGHT JOIN (or LEFT JOIN) to identify 
--      all PracticeProjects that have ZERO employees assigned to them.
-- Write your SQL Query below:




-- Q08. Write an Anti-Join query to display all PracticeCustomers 
--      who have never placed any order (zero records in PracticeOrders).
-- Write your SQL Query below:




-- ====================================================================================================
-- 📊 PHASE 3: JOINS WITH GROUP BY & AGGREGATIONS (Q09 - Q12)
-- ====================================================================================================

-- Q09. Calculate the total salary expenditure (SUM) and employee headcount (COUNT) 
--      for each Department. Ensure departments with no employees show 0 or NULL rather than being excluded.
-- Write your SQL Query below:




-- Q10. Calculate the total order spend (SUM of TotalAmount) and total orders placed 
--      by each customer. Display CustomerName, City, TotalSpend, and OrderCount.
-- Write your SQL Query below:




-- Q11. Display month-wise total revenue and average order amount from PracticeOrders. 
--      Display MonthName, TotalRevenue, and AvgOrderValue sorted chronologically.
-- Write your SQL Query below:




-- Q12. Write a query to find Departments where the Average Employee Salary is strictly greater than 85,000.
--      Display DeptName and AvgSalary.
-- Write your SQL Query below:




-- ====================================================================================================
-- 🚀 PHASE 4: 3-WAY MULTI-TABLE JOINS & ENTERPRISE PIPELINES (Q13 - Q14)
-- ====================================================================================================

-- Q13. Write a 3-way join connecting PracticeCustomers, PracticeOrders, and OrderItems.
--      Display CustomerName, OrderID, OrderDate, ItemName, Quantity, and UnitPrice.
-- Write your SQL Query below:




-- Q14. Join PracticeEmployees, PracticeDepartments, and PracticeProjects. 
--      Display EmpName, DeptName, ProjectName, and Budget. Include employees even if they lack a department or project.
-- Write your SQL Query below:




-- ====================================================================================================
