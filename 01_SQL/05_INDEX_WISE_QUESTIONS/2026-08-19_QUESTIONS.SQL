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

SELECT * FROM PracticeEmployees;
SELECT * FROM PracticeDepartments;

select EmpName,DeptName,Location  
from PracticeEmployees as e  join PracticeDepartments as d 
on e.DeptID = d.DeptID

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PASS):
   - Logic: 100% Correct. Explicit 'JOIN' defaults to INNER JOIN.
   - Best Practice Tip: Qualify projected columns with table aliases (e.g. e.EmpName, d.DeptName, d.Location)
     to prevent performance overhead during query parsing.
   
   -- 🚀 CLEAN STANDARD QUERY:
   SELECT 
       e.EmpName, 
       d.DeptName, 
       d.Location
   FROM PracticeEmployees AS e
   INNER JOIN PracticeDepartments AS d
       ON e.DeptID = d.DeptID;
*/


-- Q02. Write a query using LEFT JOIN between PracticeEmployees and PracticeDepartments 
--      to display EmpName, Salary, and DeptName. Ensure employees with no department are included.
-- Write your SQL Query below:

select EmpName,Salary,DeptName 
from PracticeEmployees as e left join PracticeDepartments as d 
on e.DeptID = d.DeptID

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PERFECT):
   - Logic: Flawless LEFT JOIN. Correctly retains Vikram Roy (DeptID NULL) with NULL DeptName.
*/


-- Q03. Write a query using RIGHT JOIN between PracticeEmployees and PracticeDepartments 
--      to display DeptName, Location, and EmpName. Ensure departments with zero employees are shown.
-- Write your SQL Query below:

select DeptName,location,EmpName 
from PracticeEmployees as e right join PracticeDepartments as d 
on e.DeptID = d.DeptID

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PERFECT):
   - Logic: Flawless RIGHT JOIN. Correctly retains Human Resources (0 employees) with NULL EmpName.
*/


-- Q04. Write a query using FULL OUTER JOIN between PracticeEmployees and PracticeDepartments 
--      to display EmpName and DeptName, capturing all matched and unmatched records from both tables.
-- Write your SQL Query below:

select EmpName , DeptName 
from PracticeEmployees as e full outer join PracticeDepartments as d 
on e.DeptID = d.DeptID

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PERFECT):
   - Logic: 100% Correct. Preserves unmatched records from both tables.
*/


-- ====================================================================================================
-- ⚙️ PHASE 2: COLUMN AMBIGUITY & ANTI-JOIN DRILLS (Q05 - Q08)
-- ====================================================================================================

-- Q05. Join PracticeEmployees and PracticeProjects on ProjectID. 
--      Select ProjectID, EmpName, ProjectName, and Budget without triggering the "Ambiguous column name" error.
-- Write your SQL Query below:

select p.ProjectID ,e.projectID,EmpName,ProjectName ,Budget 
from PracticeEmployees as e full join PracticeProjects as p 
on e.ProjectID = p.ProjectID 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 0.9 / 1.0 - PASS WITH NOTE):
   - Logic: You correctly used table aliases (p.ProjectID, e.ProjectID) to avoid the ambiguity error!
   - Pro Tip: When doing a FULL JOIN, selecting either p.ProjectID or e.ProjectID can produce NULL if that
     specific side is unmatched. Use COALESCE(e.ProjectID, p.ProjectID) AS ProjectID for clean production data.
   
   -- 🚀 OPTIMIZED PRODUCTION QUERY:
   SELECT 
       COALESCE(e.ProjectID, p.ProjectID) AS ProjectID,
       e.EmpName,
       p.ProjectName,
       p.Budget
   FROM PracticeEmployees AS e
   FULL OUTER JOIN PracticeProjects AS p
       ON e.ProjectID = p.ProjectID;
*/


-- Q06. Write an Anti-Join query using LEFT JOIN to find all PracticeEmployees 
--      who are NOT currently assigned to any project (ProjectID is NULL or unassigned).
-- Write your SQL Query below:

SELECT * FROM PracticeEmployees;
SELECT * FROM PracticeProjects;

select * 
from PracticeEmployees as e left join PracticeProjects as p 
on e.ProjectID = p.ProjectID 
where e.ProjectID is null 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 0.7 / 1.0 - ANTI-JOIN TRAP CAUGHT):
   - ⚠️ CRITICAL ANTI-JOIN TRAP: You wrote 'WHERE e.ProjectID IS NULL'.
     In an Anti-Join pattern, you MUST filter on the RIGHT table's key column: 'WHERE p.ProjectID IS NULL'.
   - Reason: If an employee has a non-null ProjectID that does not exist in PracticeProjects (an orphan ID), 
     'e.ProjectID IS NULL' fails to catch it, but 'p.ProjectID IS NULL' catches ALL unassigned/unmatched rows!
   
   -- 🚀 CORRECT TEXTBOOK ANTI-JOIN:
   SELECT e.*
   FROM PracticeEmployees AS e
   LEFT JOIN PracticeProjects AS p
       ON e.ProjectID = p.ProjectID
   WHERE p.ProjectID IS NULL;
*/


-- Q07. Write an Anti-Join query using RIGHT JOIN (or LEFT JOIN) to identify 
--      all PracticeProjects that have ZERO employees assigned to them.
-- Write your SQL Query below:

select * 
from PracticeEmployees e right join PracticeProjects p
on e.ProjectID = p.ProjectID 
where EmpName is null 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PASS):
   - Logic: Correct! Checking 'WHERE e.EmpName IS NULL' (or 'WHERE e.ProjectID IS NULL') 
     accurately isolates projects with 0 assigned staff.
*/


-- Q08. Write an Anti-Join query to display all PracticeCustomers 
--      who have never placed any order (zero records in PracticeOrders).
-- Write your SQL Query below:

select * 
from PracticeCustomers as c left join PracticeOrders as o 
on c.CustomerID = o.CustomerID 
where orderid is null 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PERFECT):
   - Logic: 100% Flawless Left Anti-Join implementation! 🎯
*/


-- ====================================================================================================
-- 📊 PHASE 3: JOINS WITH GROUP BY & AGGREGATIONS (Q09 - Q12)
-- ====================================================================================================

-- Q09. Calculate the total salary expenditure (SUM) and employee headcount (COUNT) 
--      for each Department. Ensure departments with no employees show 0 or NULL rather than being excluded.
-- Write your SQL Query below:

SELECT * FROM PracticeDepartments;
SELECT * FROM PracticeEmployees;

select DeptName ,sum(salary) as total_salary_exp , count(empid) as employee_headcount 
from PracticeDepartments as d full join PracticeEmployees as e
on d.DeptID = e.DeptID
group by DeptName

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PASS):
   - Logic: Great choice using COUNT(empid) instead of COUNT(*), which correctly yields 0 for empty departments.
   - Note: Prefer LEFT JOIN over FULL JOIN when preserving master table (PracticeDepartments).
*/


-- Q10. Calculate the total order spend (SUM of TotalAmount) and total orders placed 
--      by each customer. Display CustomerName, City, TotalSpend, and OrderCount.
-- Write your SQL Query below:

select CustomerName,City,sum(totalamount) as totalspend , count(orderid) as Ordercount 
from  PracticeCustomers as c left join PracticeOrders as p
on c.CustomerID = p.CustomerID 
group by CustomerName

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 0.6 / 1.0 - SSMS ENGINE ERROR):
   - ❌ SYNTAX / ENGINE ERROR: In SQL Server, selecting 'City' without placing it in the GROUP BY clause
     triggers Error 8120: "Column 'PracticeCustomers.City' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause."
   - Fix: Add City to GROUP BY.
   
   -- 🚀 CORRECT REPAIRED QUERY:
   SELECT 
       c.CustomerName,
       c.City,
       SUM(p.TotalAmount) AS totalspend,
       COUNT(p.OrderID) AS Ordercount
   FROM PracticeCustomers AS c
   LEFT JOIN PracticeOrders AS p
       ON c.CustomerID = p.CustomerID
   GROUP BY c.CustomerName, c.City;
*/


-- Q11. Display month-wise total revenue and average order amount from PracticeOrders. 
--      Display MonthName, TotalRevenue, and AvgOrderValue sorted chronologically.
-- Write your SQL Query below:

select month(orderdate) ,sum(totalamount) as total_revenue ,avg(totalamount) as avg_order_value 
from PracticeOrders as p left join OrderItems as i
on p.OrderID = i.OrderID 
group by month(orderdate) 
order by month(orderdate) 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 0.8 / 1.0 - LOGICAL FAN-OUT OBSERVATION):
   - Logic: Aggregations and grouping work.
   - ⚠️ DATA DUPLICATION WARNING: Joining PracticeOrders to child table OrderItems when aggregations 
     are run on parent column 'TotalAmount' can cause data duplication (fan-out) if an order has multiple items.
     Since TotalAmount is already on PracticeOrders, no join to OrderItems was required!
   - Readability: Use DATENAME(MONTH, OrderDate) for readable month names.
   
   -- 🚀 OPTIMIZED TIER-1 QUERY:
   SELECT 
       DATENAME(MONTH, OrderDate) AS MonthName,
       MONTH(OrderDate) AS MonthNumber,
       SUM(TotalAmount) AS TotalRevenue,
       AVG(TotalAmount) AS AvgOrderValue
   FROM PracticeOrders
   GROUP BY DATENAME(MONTH, OrderDate), MONTH(OrderDate)
   ORDER BY MonthNumber;
*/


-- Q12. Write a query to find Departments where the Average Employee Salary is strictly greater than 85,000.
--      Display DeptName and AvgSalary.
-- Write your SQL Query below:

SELECT * FROM PracticeDepartments;
SELECT * FROM PracticeEmployees;

select DeptName,avg(salary) as avg_emp_salary 
from PracticeDepartments as d left join PracticeEmployees as e
on d.DeptID = e.DeptID 
group by DeptName
having avg(salary) > 85000 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 1.0 / 1.0 - PERFECT):
   - Logic: 100% textbook execution of GROUP BY + HAVING filter on aggregated salary! 🎯
*/


-- ====================================================================================================
-- 🚀 PHASE 4: 3-WAY MULTI-TABLE JOINS & ENTERPRISE PIPELINES (Q13 - Q14)
-- ====================================================================================================

-- Q13. Write a 3-way join connecting PracticeCustomers, PracticeOrders, and OrderItems.
--      Display CustomerName, OrderID, OrderDate, ItemName, Quantity, and UnitPrice.
-- Write your SQL Query below:

-- 3 way join not tought till now 

/* 
   🐥 PIPPO CONCEPT LESSON & SOLUTION (Score: Unlocked & Explained):
   - Concept: A 3-Way Join simply chains join clauses sequentially.
     Step 1: Join Table A to Table B ON A.Key = B.Key
     Step 2: Join Table B to Table C ON B.Key2 = C.Key2
   
   -- 🚀 3-WAY JOIN SOLUTION QUERY:
   SELECT 
       c.CustomerName,
       o.OrderID,
       o.OrderDate,
       i.ItemName,
       i.Quantity,
       i.UnitPrice
   FROM PracticeCustomers AS c
   INNER JOIN PracticeOrders AS o
       ON c.CustomerID = o.CustomerID
   INNER JOIN OrderItems AS i
       ON o.OrderID = i.OrderID;
*/


-- Q14. Join PracticeEmployees, PracticeDepartments, and PracticeProjects. 
--      Display EmpName, DeptName, ProjectName, and Budget. Include employees even if they lack a department or project.
-- Write your SQL Query below:

-- 3 way join not tought till now 

/* 
   🐥 PIPPO CONCEPT LESSON & SOLUTION (Score: Unlocked & Explained):
   - Concept: Chaining multiple LEFT JOINS ensures the master entity (Employees) is NEVER lost, 
     even if Department or Project foreign keys are NULL.
   
   -- 🚀 MULTI-LEFT JOIN SOLUTION QUERY:
   SELECT 
       e.EmpName,
       d.DeptName,
       p.ProjectName,
       p.Budget
   FROM PracticeEmployees AS e
   LEFT JOIN PracticeDepartments AS d
       ON e.DeptID = d.DeptID
   LEFT JOIN PracticeProjects AS p
       ON e.ProjectID = p.ProjectID;
*/

-- ====================================================================================================
-- 🏆 PIPPO'S OFFICIAL DRILL EVALUATION & SCORECARD
-- ====================================================================================================
/*
   ========================================================================================
   STUDENT: Captain Arpit Manoj Bangre (Cap)
   DATE EVALUATED: 20 August 2026
   DRILL TOPIC: Relational Joins, Anti-Joins, Column Ambiguity & Aggregations
   TOTAL SCORE: 10.0 / 14.0 (71.4% - SOLID GRADE B)
   
   DETAILED SCORE BREAKDOWN:
   - Q01 (INNER JOIN Syntax)           : 1.0 / 1.0  (Clean join logic)
   - Q02 (LEFT JOIN Preservation)      : 1.0 / 1.0  (100% Correct)
   - Q03 (RIGHT JOIN Preservation)     : 1.0 / 1.0  (100% Correct)
   - Q04 (FULL OUTER JOIN)             : 1.0 / 1.0  (100% Correct)
   - Q05 (Ambiguity & Alias Resolution): 0.9 / 1.0  (Good alias use; COALESCE tip added)
   - Q06 (Left Anti-Join Project Trap) : 0.7 / 1.0  (Filter on right table key p.ProjectID)
   - Q07 (Right Anti-Join)             : 1.0 / 1.0  (Correct logic)
   - Q08 (Customer Order Anti-Join)    : 1.0 / 1.0  (100% Flawless)
   - Q09 (Dept Salary & Headcount)     : 1.0 / 1.0  (Great COUNT(empid) handling)
   - Q10 (Customer Spend & City Error) : 0.6 / 1.0  (Msg 8120 fix: add City to GROUP BY)
   - Q11 (Month Revenue & Fan-Out Trap): 0.8 / 1.0  (DATENAME & join fan-out lesson)
   - Q12 (HAVING Salary Filter)        : 1.0 / 1.0  (100% Flawless)
   - Q13 (3-Way Order Items Join)      : Untaught   (Concept explained + full query unlocked)
   - Q14 (3-Way Multi-Left Join)       : Untaught   (Concept explained + full query unlocked)
   
   MENTOR REMARKS:
   "Brilliant grit and honesty, Cap! Your understanding of core join behavior, anti-joins, 
    and aggregations is sharp. The only two traps were the classic Anti-Join right-table filter 
    (Q6) and the missing SELECT column in GROUP BY (Q10). 
    3-Way Joins are now completely unlocked and ready for you above. Keep up the high intensity!" — Pippo 🐥
   ========================================================================================
*/

