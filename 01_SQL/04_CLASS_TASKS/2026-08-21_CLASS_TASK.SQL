/* ==============================================================================
   FACULTY CLASS TASKS - 2026-08-21 (DAY 18)
   MODULE: SQL SERVER / T-SQL
   TOPIC: SELF JOIN SCENARIO-BASED PROBLEMS
============================================================================== */

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
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 3: EMPLOYEES IN SAME DEPARTMENT WITH SAME SALARY
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary)
-- Objective: Find employees who work in the same department and have the exact same salary.
-- Requirement: Each pair should appear only once.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 4: CUSTOMERS FROM SAME CITY
-- Table: Customers(CustomerID, CustomerName, City)
-- Objective: Find all unique pairs of customers who live in the same city.
-- Requirement: Do not display duplicate pairs or self-matches.
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 5: PRODUCT PRICE COMPARISON WITHIN SAME CATEGORY
-- Table: Products(ProductID, ProductName, CategoryID, Price)
-- Objective: Find products where another product in the same category costs more than the current product.
-- Output Columns: ProductName, ProductPrice, HigherPriceProductName, HigherPrice
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 6: EMPLOYEE SALARY DIFFERENCE IN SAME DEPARTMENT
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary)
-- Objective: Find pairs of employees from the same department whose salary difference is greater than 20,000.
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
-- ==============================================================================

-- Write your SQL Query below:




-- ==============================================================================
-- TASK 10: EMPLOYEE & SENIOR EMPLOYEE COMPARISON (TIER-1 INTERVIEW PATTERN)
-- Table: Employees(EmployeeID, EmployeeName, DepartmentID, Salary, HireDate)
-- Objective: Find employees who have another employee in the same department who was hired earlier AND earns a higher salary.
-- ==============================================================================

-- Write your SQL Query below:



