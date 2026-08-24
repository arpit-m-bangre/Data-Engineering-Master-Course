-- ====================================================================================================
-- 🎯 14 TARGETED PRACTICE DRILLS — 2026-08-24 (DAY 20)
-- 🏢 MODULE 01: Enterprise SQL Engine & Analytical Query Architecture
-- 🎯 TOPIC: Common Table Expressions (CTEs), CTE with Window Functions & Zero-Loss Deduplication
-- ⚠️ CONSTITUTIONAL STANDARD: Exactly 14 targeted questions with blank query blocks for practice.
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

IF OBJECT_ID('OrderStream', 'U') IS NOT NULL DROP TABLE OrderStream;
IF OBJECT_ID('InventoryBatch', 'U') IS NOT NULL DROP TABLE InventoryBatch;
IF OBJECT_ID('DoctorConsults', 'U') IS NOT NULL DROP TABLE DoctorConsults;
IF OBJECT_ID('CorporateEmployees', 'U') IS NOT NULL DROP TABLE CorporateEmployees;

-- 1. CorporateEmployees
CREATE TABLE CorporateEmployees
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Role       VARCHAR(50) NOT NULL,
    Salary     INT NOT NULL,
    JoinDate   DATE NOT NULL
);

INSERT INTO CorporateEmployees (EmpID, EmpName, Department, Role, Salary, JoinDate) VALUES
(101, 'Arun Verma', 'Engineering', 'Lead Architect', 150000, '2021-03-15'),
(102, 'Bhavna Roy', 'Engineering', 'Senior DE', 120000, '2022-01-10'),
(103, 'Chetan Das', 'Engineering', 'DE Trainee', 60000, '2024-06-01'),
(104, 'Divya Nair', 'Engineering', 'Senior DE', 120000, '2022-05-20'),
(105, 'Esha Paul', 'Marketing', 'Head of Growth', 130000, '2020-11-01'),
(106, 'Farhan Ali', 'Marketing', 'Campaign Lead', 90000, '2023-02-15'),
(107, 'Gauri Sen', 'Marketing', 'SEO Specialist', 70000, '2024-01-15'),
(108, 'Harish Rao', 'Finance', 'Financial Director', 160000, '2019-08-12'),
(109, 'Indira Iyer', 'Finance', 'Auditor', 95000, '2023-04-10'),
(110, 'Jayant Joshi', 'Finance', 'Tax Analyst', 95000, '2023-07-01');

-- 2. InventoryBatch (Product Supply Stream with Duplicate Ingestion Records)
CREATE TABLE InventoryBatch
(
    BatchID     INT IDENTITY(1,1) PRIMARY KEY,
    SKU         VARCHAR(20) NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    Warehouse   VARCHAR(30) NOT NULL,
    Quantity    INT NOT NULL,
    CostPrice   DECIMAL(10,2) NOT NULL,
    LoggedDate  DATE NOT NULL
);

INSERT INTO InventoryBatch (SKU, ProductName, Warehouse, Quantity, CostPrice, LoggedDate) VALUES
('SKU-101', 'Dell Monitor 27"', 'Warehouse-A', 50, 18500.00, '2026-08-01'),
('SKU-102', 'Logitech MX Master', 'Warehouse-B', 120, 7500.00, '2026-08-02'),
('SKU-103', 'Ergonomic Desk', 'Warehouse-A', 30, 24000.00, '2026-08-03'),
('SKU-101', 'Dell Monitor 27"', 'Warehouse-A', 50, 18500.00, '2026-08-01'), -- Duplicate
('SKU-101', 'Dell Monitor 27"', 'Warehouse-A', 50, 18500.00, '2026-08-01'), -- Duplicate
('SKU-104', 'USB-C Docking Station', 'Warehouse-C', 80, 12000.00, '2026-08-05'),
('SKU-102', 'Logitech MX Master', 'Warehouse-B', 120, 7500.00, '2026-08-02'), -- Duplicate
('SKU-105', 'Mechanical Keyboard', 'Warehouse-A', 95, 6500.00, '2026-08-08');

-- 3. DoctorConsults
CREATE TABLE DoctorConsults
(
    ConsultID   INT IDENTITY(1,1) PRIMARY KEY,
    PatientName VARCHAR(50) NOT NULL,
    DoctorName  VARCHAR(50) NOT NULL,
    Specialty   VARCHAR(50) NOT NULL,
    Fee         INT NOT NULL,
    ConsultDate DATE NOT NULL
);

INSERT INTO DoctorConsults (PatientName, DoctorName, Specialty, Fee, ConsultDate) VALUES
('Ramesh Shah', 'Dr. Mehta', 'Cardiology', 1500, '2026-08-01'),
('Suresh Patil', 'Dr. Mehta', 'Cardiology', 1500, '2026-08-05'),
('Mahesh Kale', 'Dr. Rao', 'Cardiology', 1200, '2026-08-02'),
('Anita Roy', 'Dr. Sen', 'Neurology', 2000, '2026-08-03'),
('Kavita Deshmukh', 'Dr. Sen', 'Neurology', 2000, '2026-08-10'),
('Pooja Kadam', 'Dr. Verma', 'Orthopedics', 1000, '2026-08-04'),
('Sunil Shinde', 'Dr. Verma', 'Orthopedics', 1000, '2026-08-12');

-- 4. OrderStream
CREATE TABLE OrderStream
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    Region      VARCHAR(30) NOT NULL,
    OrderAmount DECIMAL(10,2) NOT NULL,
    OrderDate   DATE NOT NULL
);

INSERT INTO OrderStream (OrderID, CustomerID, Region, OrderAmount, OrderDate) VALUES
(1001, 1, 'West', 45000.00, '2026-08-01'),
(1002, 1, 'West', 85000.00, '2026-08-15'),
(1003, 2, 'North', 32000.00, '2026-08-05'),
(1004, 2, 'North', 32000.00, '2026-08-20'),
(1005, 3, 'South', 125000.00, '2026-08-10'),
(1006, 3, 'South', 95000.00, '2026-08-22'),
(1007, 4, 'West', 67000.00, '2026-08-18'),
(1008, 5, 'East', 15000.00, '2026-08-12');

-- ====================================================================================================
-- 📝 PHASE 1: 14 TARGETED PRACTICE QUESTIONS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- QUESTION 1: Basic CTE In-Memory Projection
-- Write a CTE named 'HighSalaryCTE' to select all employees earning more than 100,000, and query all columns from the CTE.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 2: Top Earner Per Department via CTE & ROW_NUMBER
-- Using CorporateEmployees, write a CTE to find the single highest-paid employee in each department.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 3: Global 2nd Highest Distinct Salary via DENSE_RANK
-- Write a CTE query to find the employee(s) who earn the exact 2nd highest distinct salary in the company.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 4: Department-Wise 3rd Highest Earner
-- Write a CTE query using DENSE_RANK() to display the 3rd highest paid employee in each department.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 5: Oldest Employee Per Department (Seniority Ranking)
-- Write a CTE using ROW_NUMBER() ordered by JoinDate ASC to find the most senior employee in every department.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 6: Chained CTE Pipelining
-- Create two chained CTEs: CTE1 filters employees in 'Engineering' or 'Finance', and CTE2 calculates the average salary of those filtered employees. Select the final average from CTE2.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 7: Full-Row Duplicate Identification in Inventory
-- Write a CTE with ROW_NUMBER() partitioned by (SKU, ProductName, Warehouse, Quantity, CostPrice, LoggedDate) to list all redundant duplicate records in InventoryBatch.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 8: Zero-Loss Inventory Deduplication (DELETE via CTE)
-- Write a CTE query to permanently DELETE all duplicate records from InventoryBatch, retaining strictly 1 master record per batch.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 9: Highest Paid Doctor per Specialty
-- Using DoctorConsults, write a CTE to find the doctor who charges the highest fee in each medical specialty. Handle fee ties cleanly.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 10: Latest Consultation per Patient
-- Write a CTE to retrieve each patient's most recent consultation record by ConsultDate.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 11: Regional 2nd Highest Order Amount
-- Using OrderStream, write a CTE to find the 2nd highest order amount placed within each Region.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 12: Customer-Level Cumulative Order Counter
-- Write a CTE to assign a sequential OrderNumber (1, 2, 3...) to every order placed by each CustomerID ordered by OrderDate.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 13: CTE Aggregation with Salary Disparity Filter
-- Write a CTE that calculates the department average salary, and join it back to CorporateEmployees to find all employees earning at least 30,000 above their department's average salary.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- QUESTION 14: Top 2 Orders Per Customer Filter
-- Write a CTE to return the Top 2 highest-value orders placed by every CustomerID from OrderStream.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:




