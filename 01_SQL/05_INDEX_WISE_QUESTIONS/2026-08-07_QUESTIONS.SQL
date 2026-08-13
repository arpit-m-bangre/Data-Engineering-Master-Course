/* ============================================================
               DAY 7 PRACTICE QUESTIONS (7 AUGUST 2026)
               TOPICS: GROUP BY EXECUTION SEQUENCE, HAVING CLAUSE,
                       ORDER BY, ALIAS SCOPING, SCENARIO TASKS
               REVISION: DAYS 1 - 6 (WHERE, ALTER TABLE, AGGREGATES, TOP N)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Basic HAVING Clause Syntax]:
/*
Task: Write queries on table 'Sales(Salesperson VARCHAR 20, Region VARCHAR 15, Amount INT)':
1. Group by Region and show SUM(Amount).
2. Group by Region and show SUM(Amount) HAVING SUM(Amount) > 10000.
3. Group by Region and show AVG(Amount) HAVING COUNT(Salesperson) >= 3.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - ORDER BY Sorting Options]:
/*
Task: Write queries on 'Sales':
1. Select * from Sales ORDER BY Amount DESC.
2. Select * from Sales ORDER BY Region ASC, Amount DESC.
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - GROUP BY + HAVING + ORDER BY]:
/*
Task: Write a query selecting Region, SUM(Amount) AS TotalSales from 'Sales' grouped by Region, returning only regions with TotalSales > 15000, sorted by TotalSales DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 4 [Syntax Drill - Combining WHERE with GROUP BY & HAVING]:
/*
Task: Write a query selecting Region, AVG(Amount) AS AvgAmount from 'Sales' WHERE Amount > 500, grouped by Region, HAVING AVG(Amount) > 2000.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 2: DAYS 1 - 6 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-6 Revision - Table Setup & Aggregations]:
/*
Task:
1. Create table 'OrdersMaster' with: OrderID (INT), CustomerName (VARCHAR 30), Category (VARCHAR 20), OrderAmount (INT), PaymentMethod (VARCHAR 15), DeliveryCity (VARCHAR 20).
2. Insert 10 sample orders across categories ('Electronics', 'Apparel', 'Home') and cities ('Mumbai', 'Pune', 'Delhi', 'Nagpur').
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-6 Revision - TOP N & Relational Filtering]:
/*
Task: Select TOP 5 orders from 'OrdersMaster' WHERE OrderAmount > 1000 AND PaymentMethod IN ('UPI', 'Credit Card') ORDER BY OrderAmount DESC.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: CLAUSE EXECUTION SEQUENCE & HAVING CLAUSE
-- ============================================================

-- QUESTION 7 [Execution Sequence & WHERE vs HAVING]:
/*
Task:
1. List the 6 SQL clause execution steps in order (FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY).
2. Write a query calculating Category-wise total sales (SUM(OrderAmount)), filtering out NULL categories using WHERE, and returning only categories where total sales > 10,000 using HAVING.
3. Explain why aggregate functions like SUM() or AVG() cannot be used in WHERE, but must be used in HAVING.
*/

-- Write your SQL Query & explanation below:




-- QUESTION 8 [Scenario Task 1 - Department Payroll Audit]:
/*
Scenario: Auditing department payroll for recent hires.
Task: Write a query returning Department and SUM(Salary) AS TotalSalary for employees hired after 2020 (JoinYear > 2020), returning only departments where TotalSalary > 300,000, sorted by TotalSalary DESCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 9 [Scenario Task 2 - High-Value Salesperson Performance]:
/*
Scenario: Identifying top performers selling high-value items.
Task: Write a query returning Salesperson and SUM(Amount) AS TotalSales for orders where UnitPrice > 500, returning only salespersons with TotalSales > 50,000, sorted by Salesperson ASCENDING.
*/

-- Write your SQL Query below:




-- QUESTION 10 [Scenario Task 3 - Customer Order Frequency Audit]:
/*
Scenario: Customer loyalty audit.
Task: Write a query returning CustomerID and COUNT(OrderID) AS OrderCount for orders placed in 2023 with OrderAmount > 1000, returning only customers with at least 5 orders (COUNT(OrderID) >= 5), sorted by OrderCount DESCENDING.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & ALIAS SCOPING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Alias Scoping Rules]:
/*
Task:
1. Why does 'HAVING TotalSales > 10000' fail when TotalSales is aliased in SELECT?
2. Why DOES 'ORDER BY TotalSales DESC' work when TotalSales is aliased in SELECT?
*/

-- Write your explanation in comments below:




-- QUESTION 12 [Logic Builder - WHERE vs HAVING Memory Rule]:
/*
Task: State the memory rule: What does WHERE filter vs what does HAVING filter, and which step during execution evaluates aggregate values?
*/

-- Write your answer in comments below:




-- QUESTION 13 [Debugging - Correct HAVING Alias & Execution Order Errors]:
/*
Task: Identify and fix errors in the following query:
SELECT Dept, SUM(Salary) AS TotalDeptSalary
FROM Employees
WHERE SUM(Salary) > 500000
GROUP BY Dept
ORDER BY TotalDeptSalary DESC;
*/

-- Write your corrected SQL Query below:




-- QUESTION 14 [Debugging - Invalid ORDER BY Alias with Space]:
/*
Task: Identify why 'ORDER BY Total Dept Salary DESC;' fails and write the corrected version.
*/

-- Write your explanation & corrected query below:




/* ============================================================
                   END OF DAY 7 PRACTICE
   ============================================================ */
