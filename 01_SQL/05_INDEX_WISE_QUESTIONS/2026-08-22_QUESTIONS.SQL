-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — PRACTICE DRILL SET
-- 📅 DATE: 22 AUGUST 2026 (SATURDAY) | BATCH: ONLINE BATCH 15 (DAY 19)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: WINDOW FUNCTIONS — RANKING ENGINES (ROW_NUMBER, DENSE_RANK, RANK) & PARTITIONS
-- ⚠️ MANDATORY RULE: ALL 14 DRILLS MUST BE SOLVED USING WINDOW FUNCTIONS (OVER / PARTITION BY / ORDER BY)
-- 📁 TOTAL QUESTIONS: EXACTLY 14 TARGETED DRILLS
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SEED DATASETS
-- ====================================================================================================

-- Clean up practice tables
IF OBJECT_ID('DrillHospitalWaitTimes', 'U') IS NOT NULL DROP TABLE DrillHospitalWaitTimes;
IF OBJECT_ID('DrillOrderStream', 'U') IS NOT NULL DROP TABLE DrillOrderStream;
IF OBJECT_ID('DrillStockTickers', 'U') IS NOT NULL DROP TABLE DrillStockTickers;
IF OBJECT_ID('DrillRegionalSales', 'U') IS NOT NULL DROP TABLE DrillRegionalSales;
IF OBJECT_ID('DrillStudentScores', 'U') IS NOT NULL DROP TABLE DrillStudentScores;
IF OBJECT_ID('DrillPayrollMaster', 'U') IS NOT NULL DROP TABLE DrillPayrollMaster;

-- 1. Table: DrillPayrollMaster (Corporate Compensation Stream)
CREATE TABLE DrillPayrollMaster (
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    Dept        VARCHAR(30) NOT NULL,
    Salary      INT NOT NULL,
    ExperienceYears INT NOT NULL
);

-- 2. Table: DrillStudentScores (Exam Scoreboard)
CREATE TABLE DrillStudentScores (
    StudentID   INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    Subject     VARCHAR(30) NOT NULL,
    Score       INT,
    BatchYear   INT NOT NULL
);

-- 3. Table: DrillRegionalSales (Quarterly Revenue)
CREATE TABLE DrillRegionalSales (
    SaleID      INT PRIMARY KEY,
    RepName     VARCHAR(50) NOT NULL,
    Region      VARCHAR(30) NOT NULL,
    Quarter     VARCHAR(10) NOT NULL,
    Revenue     DECIMAL(12,2) NOT NULL
);

-- 4. Table: DrillStockTickers (Daily Equity Close Stream)
CREATE TABLE DrillStockTickers (
    TickerID    INT PRIMARY KEY,
    Symbol      VARCHAR(10) NOT NULL,
    TradeDate   DATE NOT NULL,
    ClosePrice  DECIMAL(10,2) NOT NULL,
    Volume      BIGINT NOT NULL
);

-- 5. Table: DrillOrderStream (E-Commerce Order Fulfillment)
CREATE TABLE DrillOrderStream (
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    OrderDate   DATE NOT NULL,
    OrderTotal  DECIMAL(10,2) NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL
);

-- 6. Table: DrillHospitalWaitTimes (Clinical Operations)
CREATE TABLE DrillHospitalWaitTimes (
    PatientID   INT PRIMARY KEY,
    PatientName VARCHAR(50) NOT NULL,
    Department  VARCHAR(30) NOT NULL,
    WaitMinutes INT NOT NULL,
    Severity    INT NOT NULL
);

-- Seed DrillPayrollMaster Data
INSERT INTO DrillPayrollMaster (EmpID, EmpName, Dept, Salary, ExperienceYears) VALUES
(101, 'Amit Sharma',   'Engineering', 95000, 6),
(102, 'Priya Nair',    'Engineering', 120000, 10),
(103, 'Rahul Verma',   'Engineering', 95000, 5),
(104, 'Sneha Patil',   'Engineering', 75000, 3),
(105, 'Rohan Deshmukh','Marketing',   65000, 4),
(106, 'Neha Gupta',    'Marketing',   85000, 7),
(107, 'Vikas Joshi',   'Marketing',   85000, 6),
(108, 'Ananya Roy',    'HR',          50000, 2),
(109, 'Suresh Menon',  'HR',          70000, 5),
(110, 'Deepak Rao',    'HR',          70000, 6);

-- Seed DrillStudentScores Data
INSERT INTO DrillStudentScores (StudentID, StudentName, Subject, Score, BatchYear) VALUES
(1, 'Aarav',  'Mathematics', 98, 2026),
(2, 'Aditi',  'Mathematics', 98, 2026),
(3, 'Rohan',  'Mathematics', 92, 2026),
(4, 'Sneha',  'Mathematics', 85, 2026),
(5, 'Pooja',  'Mathematics', NULL, 2026),
(6, 'Vikas',  'Science',     95, 2026),
(7, 'Priya',  'Science',     95, 2026),
(8, 'Karan',  'Science',     91, 2026),
(9, 'Ananya', 'Science',     80, 2026);

-- Seed DrillRegionalSales Data
INSERT INTO DrillRegionalSales (SaleID, RepName, Region, Quarter, Revenue) VALUES
(201, 'Kunal Kapoor',  'North', 'Q1', 450000.00),
(202, 'Divya Shinde',  'North', 'Q1', 620000.00),
(203, 'Gaurav Roy',    'North', 'Q1', 620000.00),
(204, 'Tanvi Joshi',   'North', 'Q1', 310000.00),
(205, 'Manish Patel',  'South', 'Q1', 580000.00),
(206, 'Bhavna Sen',    'South', 'Q1', 750000.00),
(207, 'Ritu Sharma',   'South', 'Q1', 490000.00),
(208, 'Chetan Rao',    'West',  'Q1', 890000.00),
(209, 'Farhan Ali',    'West',  'Q1', 890000.00);

-- Seed DrillStockTickers Data
INSERT INTO DrillStockTickers (TickerID, Symbol, TradeDate, ClosePrice, Volume) VALUES
(301, 'INFY',  '2026-08-20', 1850.50, 1200000),
(302, 'INFY',  '2026-08-21', 1890.00, 1500000),
(303, 'INFY',  '2026-08-22', 1875.25, 980000),
(304, 'TCS',   '2026-08-20', 4150.00, 850000),
(305, 'TCS',   '2026-08-21', 4220.00, 1100000),
(306, 'TCS',   '2026-08-22', 4220.00, 950000);

-- Seed DrillOrderStream Data
INSERT INTO DrillOrderStream (OrderID, CustomerID, OrderDate, OrderTotal, OrderStatus) VALUES
(401, 801, '2026-08-01', 1200.00, 'Delivered'),
(402, 801, '2026-08-10', 4500.00, 'Delivered'),
(403, 801, '2026-08-15', 850.00,  'Delivered'),
(404, 802, '2026-08-03', 15000.00,'Delivered'),
(405, 802, '2026-08-18', 9200.00, 'Delivered'),
(406, 803, '2026-08-05', 3100.00, 'Delivered');

-- Seed DrillHospitalWaitTimes Data
INSERT INTO DrillHospitalWaitTimes (PatientID, PatientName, Department, WaitMinutes, Severity) VALUES
(501, 'Patient A', 'Emergency',  15, 1),
(502, 'Patient B', 'Emergency',  35, 2),
(503, 'Patient C', 'Emergency',  35, 2),
(504, 'Patient D', 'Cardiology', 45, 2),
(505, 'Patient E', 'Cardiology', 60, 3),
(506, 'Patient F', 'Pediatrics', 20, 1),
(507, 'Patient G', 'Pediatrics', 25, 2);


-- ====================================================================================================
-- 📝 PHASE 1: TARGETED PRACTICE DRILLS (WINDOW FUNCTIONS)
-- ====================================================================================================

-- ==============================================================================
-- QUESTION 1: BASIC ROW NUMBER GENERATION
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Write a query to assign a unique sequential row number (1, 2, 3...) to every employee
--            ordered by Salary in DESCENDING order.
-- Output Columns: EmpID, EmpName, Dept, Salary, RowNum
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 2: GLOBAL DENSE RANK VS RANK COMPARISON
-- Table: DrillStudentScores(StudentID, StudentName, Subject, Score, BatchYear)
-- Objective: Display StudentID, StudentName, Subject, Score along with both DENSE_RANK()
--            and RANK() ordered by Score DESC for students in the 'Mathematics' subject.
-- Output Columns: StudentID, StudentName, Score, DenseRankScore, RankScore
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 3: DEPARTMENT-WISE SALARY DENSE RANKING
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Rank employees within each department separately based on Salary DESC using DENSE_RANK().
-- Output Columns: Dept, EmpName, Salary, DeptSalaryRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 4: TOP EARNER IN EVERY DEPARTMENT (WITH TIES)
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Write a CTE or Subquery to retrieve only the top earner(s) in each department.
--            Ensure that if multiple employees tie for the top salary, all of them are returned.
-- Output Columns: Dept, EmpName, Salary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 5: 2ND HIGHEST SALARY PER DEPARTMENT
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Find the employee(s) who earn the 2nd highest unique salary level in their department.
-- Technique: Use DENSE_RANK() inside a CTE and filter WHERE DeptSalaryRank = 2.
-- Output Columns: Dept, EmpName, Salary, DeptSalaryRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 6: REGIONAL SALES TOP 2 PERFORMERS
-- Table: DrillRegionalSales(SaleID, RepName, Region, Quarter, Revenue)
-- Objective: Retrieve the top 2 sales representatives per Region based on Revenue DESC.
--            Use DENSE_RANK() to allow ties.
-- Output Columns: Region, RepName, Revenue, SalesRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 7: SUBJECT-WISE TOP SCORER
-- Table: DrillStudentScores(StudentID, StudentName, Subject, Score, BatchYear)
-- Objective: Find the top scorer in each Subject. Exclude records where Score IS NULL.
-- Output Columns: Subject, StudentName, Score
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 8: MOST RECENT 2 ORDERS PER CUSTOMER
-- Table: DrillOrderStream(OrderID, CustomerID, OrderDate, OrderTotal, OrderStatus)
-- Objective: For every customer, retrieve their latest 2 orders based on OrderDate DESC.
-- Technique: ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC).
-- Output Columns: CustomerID, OrderID, OrderDate, OrderTotal, OrderRecencyRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 9: HIGHEST CLOSE PRICE PER STOCK TICKER SYMBOL
-- Table: DrillStockTickers(TickerID, Symbol, TradeDate, ClosePrice, Volume)
-- Objective: Find the trading day that registered the highest ClosePrice for each stock Symbol.
-- Output Columns: Symbol, TradeDate, ClosePrice
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 10: DETERMINISTIC TIE-BREAKING IN ROW_NUMBER
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Generate a strict unique row number per department ordered by Salary DESC.
--            In case of salary ties, break the tie by ExperienceYears DESC, and then EmpID ASC.
-- Output Columns: Dept, EmpName, Salary, ExperienceYears, DeterministicRowNum
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 11: BOTTOM 2 LONGEST WAIT TIMES PER HOSPITAL DEPARTMENT
-- Table: DrillHospitalWaitTimes(PatientID, PatientName, Department, WaitMinutes, Severity)
-- Objective: Identify patients experiencing the top 2 longest wait times in each clinical department.
-- Output Columns: Department, PatientName, WaitMinutes, WaitRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 12: GLOBAL 3RD HIGHEST SALARY ACROSS ENTIRE COMPANY
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Find all employees who earn the exact 3rd highest distinct salary across the entire company.
-- Output Columns: EmpName, Dept, Salary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 13: MULTI-LEVEL PARTITIONING (DEPARTMENT & EXPERIENCE TIER)
-- Table: DrillPayrollMaster(EmpID, EmpName, Dept, Salary, ExperienceYears)
-- Objective: Categorize employees into Senior (Exp >= 6) and Junior (Exp < 6),
--            and assign a DENSE_RANK() within each Department + Experience Category partition based on Salary DESC.
-- Output Columns: Dept, ExperienceTier, EmpName, Salary, PartitionRank
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 14: IDENTIFYING RANK GAPS IN INTERVIEW AUDITS
-- Table: DrillStudentScores(StudentID, StudentName, Subject, Score, BatchYear)
-- Objective: Write a query comparing ROW_NUMBER(), DENSE_RANK(), and RANK() on DrillStudentScores
--            ordered by Score DESC, and calculate the numeric gap: (RANK() - DENSE_RANK()).
-- Output Columns: StudentName, Score, RowNum, DenseRnk, PositionalRnk, RankGap
-- ==============================================================================

-- Write your SQL Query below:




