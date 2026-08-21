-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — PRACTICE DRILL SET
-- 📅 DATE: 21 AUGUST 2026 (FRIDAY) | BATCH: ONLINE BATCH 15 (DAY 18)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: SELF JOIN MECHANICS, HIERARCHIES & FRAUD ANOMALY DETECTION
-- ⚠️ MANDATORY RULE: ALL 14 DRILLS MUST BE SOLVED STRICTLY USING SELF JOIN ONLY (Table A1 JOIN Table A2)
-- 📁 TOTAL QUESTIONS: EXACTLY 14 TARGETED DRILLS
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SEED DATASETS
-- ====================================================================================================

-- Clean up practice tables
IF OBJECT_ID('PracticeTransactions', 'U') IS NOT NULL DROP TABLE PracticeTransactions;
IF OBJECT_ID('PracticeAccounts', 'U') IS NOT NULL DROP TABLE PracticeAccounts;
IF OBJECT_ID('PracticeOrders', 'U') IS NOT NULL DROP TABLE PracticeOrders;
IF OBJECT_ID('PracticeCatalog', 'U') IS NOT NULL DROP TABLE PracticeCatalog;
IF OBJECT_ID('PracticeStudents', 'U') IS NOT NULL DROP TABLE PracticeStudents;
IF OBJECT_ID('PracticeStaff', 'U') IS NOT NULL DROP TABLE PracticeStaff;

-- 1. Table: PracticeStaff (Employees, Managers & Seniority Hierarchy)
CREATE TABLE PracticeStaff
(
    StaffID    INT PRIMARY KEY,
    StaffName  VARCHAR(50) NOT NULL,
    ManagerID  INT,
    DeptID     INT NOT NULL,
    Salary     INT NOT NULL,
    JoinDate   DATE NOT NULL
);

-- 2. Table: PracticeStudents (Geographical Distribution)
CREATE TABLE PracticeStudents
(
    StudentID   INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    City        VARCHAR(50) NOT NULL
);

-- 3. Table: PracticeCatalog (Product Category Pricing)
CREATE TABLE PracticeCatalog
(
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    CategoryID  INT NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL
);

-- 4. Table: PracticeOrders (Order History & Velocity)
CREATE TABLE PracticeOrders
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    OrderDate   DATE NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL
);

-- 5. Table: PracticeAccounts (User Profiles & Identity Verification)
CREATE TABLE PracticeAccounts
(
    AccountID    INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    Email        VARCHAR(100) NOT NULL,
    CreatedDate  DATE NOT NULL
);

-- 6. Table: PracticeTransactions (Banking Geo-Velocity Stream)
CREATE TABLE PracticeTransactions
(
    TxnID    INT PRIMARY KEY,
    CustID   INT NOT NULL,
    City     VARCHAR(50) NOT NULL,
    TxnTime  DATETIME NOT NULL,
    Amount   DECIMAL(10,2) NOT NULL
);

-- Seed PracticeStaff Data
INSERT INTO PracticeStaff (StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate) VALUES
(1,  'Amit Sharma',   3,    10, 28000, '2023-01-15'),
(2,  'Rahul Verma',   1,    10, 35000, '2023-04-10'),
(3,  'Priya Nair',    NULL, 10, 60000, '2020-05-01'), -- CEO / Director
(4,  'Sneha Patil',   3,    20, 30000, '2022-08-20'),
(5,  'Rohan Kulkarni',2,    20, 42000, '2024-01-10'), -- Higher salary than Manager (Rahul)
(6,  'Neha Gupta',    4,    30, 28000, '2021-11-05'),
(7,  'Vikas Joshi',   3,    10, 35000, '2023-08-14'), -- Same dept and salary as Rahul
(8,  'Ananya Roy',    1,    20, 65000, '2024-03-01'), -- Higher salary gap (> 25k) in Dept 20
(9,  'Suresh Menon',  4,    30, 75000, '2020-02-15'), -- Senior in Dept 30
(10, 'Deepak Rao',    4,    30, 30000, '2023-10-25');

-- Seed PracticeStudents Data
INSERT INTO PracticeStudents (StudentID, StudentName, City) VALUES
(101, 'Arun',    'Pune'),
(102, 'Bhavna',  'Mumbai'),
(103, 'Chetan',  'Pune'),
(104, 'Divya',   'Delhi'),
(105, 'Esha',    'Mumbai'),
(106, 'Farhan',  'Pune'),
(107, 'Gaurav',  'Bengaluru');

-- Seed PracticeCatalog Data
INSERT INTO PracticeCatalog (ProductID, ProductName, CategoryID, UnitPrice) VALUES
(201, 'Basic Laptop',     1, 40000.00),
(202, 'Pro Laptop',       1, 75000.00),
(203, 'Gaming Laptop',    1, 95000.00),
(204, 'Standard Mouse',   2, 500.00),
(205, 'Gaming Mouse',     2, 2200.00),
(206, 'Office Keybd',     2, 1200.00),
(207, '24-inch Monitor',  3, 14000.00),
(208, '32-inch Monitor',  3, 29000.00);

-- Seed PracticeOrders Data
INSERT INTO PracticeOrders (OrderID, CustomerID, OrderDate, Amount) VALUES
(301, 501, '2026-08-01', 1500.00),
(302, 501, '2026-08-02', 3200.00), -- Consecutive Day for 501
(303, 502, '2026-08-05', 850.00),
(304, 503, '2026-08-10', 9400.00),
(305, 503, '2026-08-11', 2100.00), -- Consecutive Day for 503
(306, 501, '2026-08-15', 600.00),
(307, 504, '2026-08-18', 4100.00),
(308, 504, '2026-08-19', 1800.00); -- Consecutive Day for 504

-- Seed PracticeAccounts Data
INSERT INTO PracticeAccounts (AccountID, CustomerName, Email, CreatedDate) VALUES
(401, 'Rajesh Kumar',  'rajesh.k@gmail.com', '2025-01-10'),
(402, 'Sunita Rao',    'sunita.r@yahoo.com', '2025-02-14'),
(403, 'Amit Verma',    'amit.v@outlook.com', '2025-03-01'),
(404, 'Rajesh Kumar',  'rajesh.k@gmail.com', '2025-06-20'), -- Duplicate Email Anomaly
(405, 'Kavita Sen',    'kavita.s@gmail.com', '2025-07-15'),
(406, 'Amit V.',       'amit.v@outlook.com', '2025-08-05'); -- Duplicate Email Anomaly

-- Seed PracticeTransactions Data
INSERT INTO PracticeTransactions (TxnID, CustID, City, TxnTime, Amount) VALUES
(1001, 801, 'Pune',      '2026-08-21 09:00:00', 5000.00),
(1002, 801, 'Mumbai',    '2026-08-21 09:04:00', 12000.00), -- Fraud: 4 min difference in different city
(1003, 802, 'Delhi',     '2026-08-21 10:15:00', 800.00),
(1004, 803, 'Hyderabad', '2026-08-21 11:30:00', 3500.00),
(1005, 803, 'Chennai',   '2026-08-21 11:38:00', 25000.00), -- Fraud: 8 min difference in different city
(1006, 801, 'Pune',      '2026-08-21 16:00:00', 1500.00);


-- ====================================================================================================
-- 📝 PHASE 1: TARGETED PRACTICE DRILLS (STRICTLY SELF JOIN ONLY)
-- ====================================================================================================

-- ==============================================================================
-- QUESTION 1: BASIC EMPLOYEE TO MANAGER MAPPING
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (E.ManagerID = M.StaffID)
-- Objective: Write a query to display every employee's name along with their direct manager's name.
-- Output Columns: EmployeeName, ManagerName
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 2: EMPLOYEES OUTEARNING DIRECT MANAGERS
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (E.ManagerID = M.StaffID AND E.Salary > M.Salary)
-- Objective: Find all employees who earn a higher salary than their direct manager.
-- Output Columns: EmployeeName, EmployeeSalary, ManagerName, ManagerSalary, SalaryDifference
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 3: ALL EMPLOYEES INCLUDING TOP EXECUTIVES (ROOT MANAGERS)
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF LEFT JOIN on PracticeStaff (E.ManagerID = M.StaffID)
-- Objective: List all employees and their managers using LEFT JOIN so top executives (with NULL ManagerID) are included.
-- Output Columns: EmployeeName, ManagerName
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 4: CO-WORKERS UNDER THE SAME DIRECT MANAGER
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (E1.ManagerID = E2.ManagerID AND E1.StaffID < E2.StaffID)
-- Objective: Find all unique pairs of employees who report to the exact same manager.
-- Requirement: Ensure no duplicate pairs (e.g., show (A, B) but not (B, A)) and exclude self-matches.
-- Output Columns: ManagerID, Employee1_Name, Employee2_Name
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 5: DEPARTMENTAL PEERS WITH IDENTICAL SALARIES
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (E1.DeptID = E2.DeptID AND E1.Salary = E2.Salary AND E1.StaffID < E2.StaffID)
-- Objective: Find pairs of employees working in the same department who draw the exact same salary.
-- Output Columns: DeptID, Employee1_Name, Employee2_Name, Salary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 6: EXTREME SALARY DISPARITY IN SAME DEPARTMENT
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (E1.DeptID = E2.DeptID AND E2.Salary - E1.Salary > 25000)
-- Objective: Find pairs of employees in the same department where the salary gap is strictly greater than 25,000.
-- Output Columns: DeptID, LowerPaidEmp, LowerSalary, HigherPaidEmp, HigherSalary, SalaryGap
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 7: STUDENTS LIVING IN THE SAME CITY
-- Table: PracticeStudents(StudentID, StudentName, City)
-- Technique: SELF JOIN on PracticeStudents (S1.City = S2.City AND S1.StudentID < S2.StudentID)
-- Objective: Write a query to find all unique pairs of students who reside in the same city.
-- Output Columns: City, Student1_Name, Student2_Name
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 8: SAME CATEGORY PRODUCT PRICE COMPARISON
-- Table: PracticeCatalog(ProductID, ProductName, CategoryID, UnitPrice)
-- Technique: SELF JOIN on PracticeCatalog (P1.CategoryID = P2.CategoryID AND P1.UnitPrice < P2.UnitPrice)
-- Objective: Find products where there exists another product in the same category that is priced higher.
-- Output Columns: CategoryID, ProductName, ProductPrice, MoreExpensiveProduct, HigherPrice
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 9: CONSECUTIVE DAY ORDERS PER CUSTOMER
-- Table: PracticeOrders(OrderID, CustomerID, OrderDate, Amount)
-- Technique: SELF JOIN on PracticeOrders (O1.CustomerID = O2.CustomerID AND DATEDIFF(DAY, O1.OrderDate, O2.OrderDate) = 1)
-- Objective: Identify customers who placed orders on two consecutive calendar days.
-- Output Columns: CustomerID, FirstOrderID, FirstDate, SecondOrderID, SecondDate
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 10: DUPLICATE ACCOUNT DETECTION BY EMAIL
-- Table: PracticeAccounts(AccountID, CustomerName, Email, CreatedDate)
-- Technique: SELF JOIN on PracticeAccounts (A1.Email = A2.Email AND A1.AccountID < A2.AccountID)
-- Objective: Find all pairs of distinct account IDs that share the exact same email address.
-- Output Columns: Email, AccountID_1, CustomerName_1, AccountID_2, CustomerName_2
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 11: SENIORITY & SALARY INVERSION AUDIT
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (S1.DeptID = S2.DeptID AND S1.JoinDate < S2.JoinDate AND S1.Salary < S2.Salary)
-- Objective: Find staff members who joined earlier than a colleague in the same department but earn a lower salary.
-- Output Columns: DeptID, SeniorStaffName, SeniorSalary, SeniorJoinDate, JuniorStaffName, JuniorSalary, JuniorJoinDate
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 12: EMPLOYEES HIRED IN THE SAME CALENDAR YEAR
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: SELF JOIN on PracticeStaff (DATEPART(YEAR, S1.JoinDate) = DATEPART(YEAR, S2.JoinDate) AND S1.JoinDate <> S2.JoinDate AND S1.StaffID < S2.StaffID)
-- Objective: Find all unique pairs of staff members who were hired in the exact same calendar year, but on different calendar dates.
-- Output Columns: HireYear, Staff1_Name, JoinDate1, Staff2_Name, JoinDate2
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 13: TWO-TIER MANAGEMENT (EMPLOYEE, MANAGER, GRAND-MANAGER)
-- Table: PracticeStaff(StaffID, StaffName, ManagerID, DeptID, Salary, JoinDate)
-- Technique: MULTI SELF JOIN on PracticeStaff (E.ManagerID = M.StaffID LEFT JOIN PracticeStaff GM ON M.ManagerID = GM.StaffID)
-- Objective: Write a query using multiple Self Joins to display Employee Name, Direct Manager Name, and Grand-Manager Name (Manager's Manager).
-- Output Columns: EmployeeName, ManagerName, GrandManagerName
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 14: GEO-TEMPORAL BANKING VELOCITY FRAUD DETECTION
-- Table: PracticeTransactions(TxnID, CustID, City, TxnTime, Amount)
-- Technique: SELF JOIN on PracticeTransactions (T1.CustID = T2.CustID AND T1.City <> T2.City AND T1.TxnID < T2.TxnID AND DATEDIFF(MINUTE, T1.TxnTime, T2.TxnTime) BETWEEN 0 AND 10)
-- Objective: Detect suspicious activity where the same customer had two transactions in different cities within 10 minutes of each other.
-- Output Columns: CustID, Txn1_ID, City1, Time1, Txn2_ID, City2, Time2, MinutesApart
-- ==============================================================================

-- Write your SQL Query below:



