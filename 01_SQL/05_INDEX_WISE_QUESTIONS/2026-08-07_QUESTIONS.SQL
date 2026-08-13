/* ============================================================
               DAY 7 PRACTICE QUESTIONS (7 AUGUST 2026)
               TOPICS: GROUP BY EXECUTION SEQUENCE, HAVING CLAUSE,
                       ORDER BY, ALIAS SCOPING, SCENARIO TASKS
               REVISION: DAYS 1 - 6 (WHERE, ALTER TABLE, AGGREGATES, TOP N)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 10 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - HAVING & ORDER BY Drills]:
/*
Task: Write simple queries on a table 'Sales(Salesperson VARCHAR 20, Region VARCHAR 15, Amount INT)':
1. Group by Region and show SUM(Amount).
2. Group by Region and show SUM(Amount) HAVING SUM(Amount) > 10000.
3. Select * from Sales ORDER BY Amount DESC.
4. Select Region, SUM(Amount) AS TotalSales from Sales GROUP BY Region ORDER BY TotalSales DESC.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Basic Syntax - Multi-Column Sorting]:
/*
Task: Write a query selecting Region, SUM(Amount) AS TotalSales from 'Sales' grouped by Region, sorted by TotalSales DESCENDING, and then Region ASCENDING.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 2: DAYS 1 - 6 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-6 Revision - Table Setup & Aggregations]:
/*
Task:
1. Create table 'OrdersMaster' with: OrderID (INT), CustomerName (VARCHAR 30), Category (VARCHAR 20), OrderAmount (INT), PaymentMethod (VARCHAR 15), DeliveryCity (VARCHAR 20).
2. Insert 10 sample orders across categories ('Electronics', 'Apparel', 'Home') and cities ('Mumbai', 'Pune', 'Delhi', 'Nagpur').
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Days 1-6 Revision - TOP N & Relational Filtering]:
/*
Task: Select TOP 5 orders from 'OrdersMaster' WHERE OrderAmount > 1000 AND PaymentMethod IN ('UPI', 'Credit Card') ORDER BY OrderAmount DESC.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: CLAUSE EXECUTION SEQUENCE & HAVING CLAUSE
-- ============================================================

-- QUESTION 5 [Execution Sequence & WHERE vs HAVING]:
/*
Task:
1. List the 6 SQL clause execution steps in order (FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY).
2. Write a query calculating Category-wise total sales (SUM(OrderAmount)), filtering out NULL categories using WHERE, and returning only categories where total sales > 10,000 using HAVING.
3. Explain why aggregate functions like SUM() or AVG() cannot be used in WHERE, but must be used in HAVING.
*/

-- Write your SQL Query & explanation below:




-- QUESTION 6 [Scenario Task 1 - Department Payroll Audit]:
/*
Scenario: Auditing department payroll for recent hires.
Task: Write a query returning Department and SUM(Salary) AS TotalSalary for employees hired after 2020 (JoinYear > 2020), returning only departments where TotalSalary > 300,000, sorted by TotalSalary DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 7 [Scenario Task 2 - High-Value Salesperson Performance]:
/*
Scenario: Identifying top performers selling high-value items.
Task: Write a query returning Salesperson and SUM(Amount) AS TotalSales for orders where UnitPrice > 500, returning only salespersons with TotalSales > 50,000, sorted by Salesperson ASCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 8 [Scenario Task 3 - Customer Order Frequency Audit]:
/*
Scenario: Customer loyalty audit.
Task: Write a query returning CustomerID and COUNT(OrderID) AS OrderCount for orders placed in 2023 with OrderAmount > 1000, returning only customers with at least 5 orders (COUNT(OrderID) >= 5), sorted by OrderCount DESCENDING.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & ALIAS SCOPING DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Alias Scoping Rules]:
/*
Task:
1. Why does 'HAVING TotalSales > 10000' fail when TotalSales is aliased in SELECT?
2. Why DOES 'ORDER BY TotalSales DESC' work when TotalSales is aliased in SELECT?
*/

-- Write your explanation in comments below:




-- QUESTION 10 [Debugging - Correct HAVING Alias & Execution Order Errors]:
/*
Task: Identify and fix errors in the following query:
SELECT Dept, SUM(Salary) AS TotalDeptSalary
FROM Employees
WHERE SUM(Salary) > 500000
GROUP BY Dept
ORDER BY TotalDeptSalary DESC;
*/

-- Write your corrected SQL Query below:




/* ============================================================
                   END OF DAY 7 PRACTICE
   ============================================================ */
