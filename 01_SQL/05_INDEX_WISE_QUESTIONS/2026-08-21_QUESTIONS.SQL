/* ==============================================================================
   PRACTICE QUESTIONS SET - 2026-08-21 (DAY 18)
   MODULE: 01_SQL
   TOPIC: SELF JOIN MECHANICS, HIERARCHIES & FRAUD ANOMALY DETECTION
   TOTAL QUESTIONS: 14 TARGETED PRACTICE DRILLS
============================================================================== */

-- ==============================================================================
-- QUESTION 1: BASIC EMPLOYEE TO MANAGER MAPPING
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), ManagerID INT, Salary INT)
-- Objective: Write a query to display every employee's name along with their direct manager's name.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 2: EMPLOYEES OUTEARNING DIRECT MANAGERS
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), ManagerID INT, Salary INT)
-- Objective: Find all employees who earn a higher salary than their direct manager.
-- Output Columns: EmployeeName, EmployeeSalary, ManagerName, ManagerSalary, SalaryDifference
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 3: ALL EMPLOYEES INCLUDING TOP EXECUTIVES (ROOT MANAGERS)
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), ManagerID INT, Salary INT)
-- Objective: List all employees and their managers. If an employee has no manager (e.g. CEO), display 'Top Executive' or NULL as ManagerName.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 4: CO-WORKERS UNDER THE SAME DIRECT MANAGER
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), ManagerID INT, Salary INT)
-- Objective: Find all unique pairs of employees who report to the exact same manager.
-- Requirement: Ensure no duplicate pairs (e.g., show (A, B) but not (B, A)) and exclude self-matches.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 5: DEPARTMENTAL PEERS WITH IDENTICAL SALARIES
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), DeptID INT, Salary INT)
-- Objective: Find pairs of employees working in the same department who draw the exact same salary.
-- Output Columns: DeptID, Employee1_Name, Employee2_Name, Salary
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 6: EXTREME SALARY DISPARITY IN SAME DEPARTMENT
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), DeptID INT, Salary INT)
-- Objective: Find pairs of employees in the same department where the salary gap is greater than 25,000.
-- Output Columns: DeptID, LowerPaidEmp, HigherPaidEmp, SalaryGap
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 7: STUDENTS LIVING IN THE SAME CITY
-- Schema: Students(StudentID INT, StudentName VARCHAR(50), City VARCHAR(50))
-- Objective: Write a query to find all unique pairs of students who reside in the same city.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 8: SAME CATEGORY PRODUCT PRICE COMPARISON
-- Schema: Products(ProductID INT, ProductName VARCHAR(50), CategoryID INT, UnitPrice DECIMAL(10,2))
-- Objective: Find products where there exists another product in the same category that is priced higher.
-- Output Columns: ProductName, ProductPrice, MoreExpensiveProduct, HigherPrice
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 9: CONSECUTIVE DAY ORDERS PER CUSTOMER
-- Schema: Orders(OrderID INT, CustomerID INT, OrderDate DATE, Amount DECIMAL(10,2))
-- Objective: Identify customers who placed orders on two consecutive calendar days.
-- Output Columns: CustomerID, FirstOrderID, FirstDate, SecondOrderID, SecondDate
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 10: DUPLICATE ACCOUNT DETECTION BY EMAIL
-- Schema: Accounts(AccountID INT, CustomerName VARCHAR(50), Email VARCHAR(100), CreatedDate DATE)
-- Objective: Find all pairs of distinct account IDs that share the exact same email address.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 11: SENIORITY & SALARY INVERSION AUDIT
-- Schema: Staff(StaffID INT, StaffName VARCHAR(50), DeptID INT, Salary INT, JoinDate DATE)
-- Objective: Find staff members who joined earlier than a colleague in the same department but earn a lower salary.
-- Output Columns: SeniorStaffName, SeniorSalary, SeniorJoinDate, JuniorStaffName, JuniorSalary, JuniorJoinDate
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 12: EMPLOYEES HIRED IN THE SAME CALENDAR YEAR
-- Schema: Staff(StaffID INT, StaffName VARCHAR(50), JoinDate DATE)
-- Objective: Find all unique pairs of staff members who were hired in the exact same calendar year, but on different calendar dates.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 13: TWO-TIER MANAGEMENT (EMPLOYEE, MANAGER, GRAND-MANAGER)
-- Schema: Employees(EmpID INT, EmpName VARCHAR(50), ManagerID INT)
-- Objective: Write a query using multiple Self Joins to display Employee Name, Direct Manager Name, and Grand-Manager Name (Manager's Manager).
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- QUESTION 14: GEO-TEMPORAL BANKING VELOCITY FRAUD DETECTION
-- Schema: Transactions(TxnID INT, CustID INT, City VARCHAR(50), TxnTime DATETIME, Amount DECIMAL(10,2))
-- Objective: Detect suspicious activity where the same customer had two transactions in different cities within 10 minutes of each other.
-- Output Columns: CustID, Txn1_ID, City1, Time1, Txn2_ID, City2, Time2, MinutesApart
-- ==============================================================================

-- Write your SQL Query below:



