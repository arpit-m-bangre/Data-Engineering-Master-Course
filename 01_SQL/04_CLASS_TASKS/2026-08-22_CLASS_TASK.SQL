-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 22 AUGUST 2026 (Day 19)
-- 🎯 TOPIC: Window Functions — Ranking Engines (ROW_NUMBER, DENSE_RANK, RANK) & Partitioning
-- ⚠️ MANDATORY RULE: ALL TASKS MUST BE SOLVED USING WINDOW FUNCTIONS (OVER / PARTITION BY / ORDER BY)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

-- Clean up existing tables
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
IF OBJECT_ID('DeptSalary', 'U') IS NOT NULL DROP TABLE DeptSalary;
IF OBJECT_ID('EmployeeSales', 'U') IS NOT NULL DROP TABLE EmployeeSales;

-- 1. Table: StudentInfo (Student Examination Registry)
CREATE TABLE StudentInfo (
    StudentID    INT IDENTITY(1,1) PRIMARY KEY,
    StudentName  VARCHAR(50) NOT NULL,
    Subject      VARCHAR(50) NOT NULL,
    Marks        INT,
    Department   VARCHAR(50) NOT NULL
);

-- 2. Table: DeptSalary (Departmental Payroll Registry)
CREATE TABLE DeptSalary (
    ID    INT IDENTITY(1,1) PRIMARY KEY,
    Dept  VARCHAR(20) NOT NULL,
    Sal   INT NOT NULL
);

-- 3. Table: EmployeeSales (Monthly Regional Sales Stream)
CREATE TABLE EmployeeSales (
    SaleID       INT IDENTITY(1,1) PRIMARY KEY,
    EmpName      VARCHAR(50) NOT NULL,
    Region       VARCHAR(30) NOT NULL,
    SalesMonth   VARCHAR(20) NOT NULL,
    SalesAmount  DECIMAL(12,2) NOT NULL
);

-- Seed StudentInfo Dataset (Includes Ties and NULL)
INSERT INTO StudentInfo (StudentName, Subject, Marks, Department) VALUES
('Aarav',  'SQL', 99,   'HR'),
('Aditi',  'SQL', 99,   'ENTC'),
('Rohan',  'SQL', 98,   'MECH'),
('Sneha',  'SQL', 98,   'MECH'),
('Pooja',  'SQL', 98,   'HR'),
('Vikas',  'SQL', 94,   'ENTC'),
('Priya',  'SQL', 90,   'MECH'),
('Karan',  'SQL', 90,   'HR'),
('Ananya', 'SQL', 85,   'ENTC'),
('Nikhil', 'SQL', 85,   'MECH'),
('Varun',  'SQL', 85,   'HR'),
('Meera',  'SQL', 80,   'ENTC'),
('Tanvi',  'SQL', 80,   'HR'),
('Deepak', 'SQL', 70,   'MECH'),
('Rahul',  'SQL', 70,   'ENTC'),
('Arjun',  'SQL', NULL, 'HR');

-- Seed DeptSalary Dataset (Faculty In-Class Grid)
INSERT INTO DeptSalary (Dept, Sal) VALUES
('HR', 20000), ('ENTC', 30000), ('MECH', 50000),
('HR', 40000), ('HR', 40000), ('MECH', 40000),
('MECH', 40000), ('ENTC', 35000), ('HR', 30000),
('ENTC', 25000), ('MECH', 30000), ('MECH', 25000),
('HR', 30000), ('HR', 20000), ('ENTC', 25000),
('ENTC', 20000), ('MECH', 20000);

-- Seed EmployeeSales Dataset
INSERT INTO EmployeeSales (EmpName, Region, SalesMonth, SalesAmount) VALUES
('Amit Sharma',   'North', 'August', 45000.00),
('Rahul Verma',   'North', 'August', 62000.00),
('Priya Nair',    'North', 'August', 62000.00),
('Sneha Patil',   'South', 'August', 38000.00),
('Rohan Deshmukh','South', 'August', 75000.00),
('Neha Gupta',    'South', 'August', 51000.00),
('Vikas Joshi',   'West',  'August', 89000.00),
('Ananya Roy',    'West',  'August', 41000.00),
('Suresh Menon',  'West',  'August', 89000.00);


-- ====================================================================================================
-- 📝 PHASE 1: IN-CLASS & HOMEWORK SCENARIO TASKS
-- ====================================================================================================

-- ==============================================================================
-- TASK 1: GLOBAL MARKS RANKING BENCHMARK (ROW_NUMBER VS DENSE_RANK VS RANK)
-- Table: StudentInfo(StudentID, StudentName, Subject, Marks, Department)
-- Objective: Generate side-by-side comparison of ROW_NUMBER(), DENSE_RANK(), and RANK()
--            ordered by Marks in DESCENDING order.
-- Output Columns: StudentID, StudentName, Marks, Department, RowNum_Pos, DenseRank_Val, Rank_Pos
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 2: DEPARTMENT-WISE SALARY PARTITION GRID
-- Table: DeptSalary(ID, Dept, Sal)
-- Objective: Compute ROW_NUMBER(), DENSE_RANK(), and RANK() partitioned by Dept
--            and sorted by Sal in DESCENDING order.
-- Output Columns: Dept, Sal, Dept_RowNum, Dept_DenseRank, Dept_Rank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 3: TOP 3 HIGHEST SCORING STUDENTS GLOBALLY
-- Table: StudentInfo(StudentID, StudentName, Marks, Department)
-- Objective: Retrieve students who scored in the top 3 unique mark brackets (DENSE_RANK <= 3).
-- Constraint: Use CTE or Subquery to overcome Msg 4108 WHERE clause restriction.
-- Output Columns: StudentName, Department, Marks, MarkRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 4: HIGHEST EARNER IN EACH DEPARTMENT (DEPARTMENT TOPPER)
-- Table: DeptSalary(ID, Dept, Sal)
-- Objective: Find the employee/entry with the highest salary in every department.
--            If there is a tie for the top salary, display all tied entries.
-- Technique: DENSE_RANK() OVER (PARTITION BY Dept ORDER BY Sal DESC) = 1 inside a CTE/Subquery.
-- Output Columns: Dept, Sal, DeptRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 5: 2ND HIGHEST UNIQUE MARK IN THE ENTIRE INSTITUTE
-- Table: StudentInfo(StudentID, StudentName, Marks, Department)
-- Objective: Find all students who secured exactly the 2nd highest unique mark.
-- Output Columns: StudentName, Marks, Department
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 6: REGIONAL SALES LEADERBOARD (TOP 2 SALES LEADERS PER REGION)
-- Table: EmployeeSales(SaleID, EmpName, Region, SalesMonth, SalesAmount)
-- Objective: Find the top 2 sales performers in each region for the month of August.
--            Include all ties for rank 1 or 2 using DENSE_RANK().
-- Output Columns: Region, EmpName, SalesAmount, RegionalRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 7: 2ND HIGHEST SALARY PER DEPARTMENT
-- Table: DeptSalary(ID, Dept, Sal)
-- Objective: Find the 2nd highest salary level in each department.
-- Output Columns: Dept, Sal, RankPosition
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 8: LOWEST 2 EARNERS IN EACH DEPARTMENT (BOTTOM-N ANALYSIS)
-- Table: DeptSalary(ID, Dept, Sal)
-- Objective: Identify employees receiving the bottom 2 salary levels in each department.
-- Technique: DENSE_RANK() OVER (PARTITION BY Dept ORDER BY Sal ASC) <= 2.
-- Output Columns: Dept, Sal, BottomRank
-- ==============================================================================

-- Write your SQL Query below:




