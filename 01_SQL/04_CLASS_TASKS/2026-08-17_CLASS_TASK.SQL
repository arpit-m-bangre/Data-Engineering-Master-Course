-- ============================================================================
-- 🎓 FACULTY IN-CLASS EXERCISE & TASK SOLUTIONS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 17 AUGUST 2026 (Day 14)
-- 🎯 TOPIC: Practical Date & DateTime Functions Exercises
-- ============================================================================

-- ============================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATA
-- ============================================================================

IF OBJECT_ID('Newdate', 'U') IS NOT NULL DROP TABLE Newdate;
IF OBJECT_ID('CustomerSales', 'U') IS NOT NULL DROP TABLE CustomerSales;

CREATE TABLE Newdate
(
    id          INT PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    joiningdate DATE NOT NULL
);

INSERT INTO Newdate (id, name, joiningdate)
VALUES
(1, 'a', '02/13/2025'),
(2, 'b', '04/23/2024'),
(3, 'c', '11/20/2026');

CREATE TABLE CustomerSales
(
    OrderID     INT PRIMARY KEY,
    CustomerID  INT NOT NULL,
    CustomerName VARCHAR(50) NOT NULL,
    OrderDate   DATE NOT NULL,
    SaleAmount  DECIMAL(10,2) NOT NULL
);

INSERT INTO CustomerSales (OrderID, CustomerID, CustomerName, OrderDate, SaleAmount)
VALUES
(101, 1, 'Customer Alpha', '2026-01-15', 5000.00),
(102, 2, 'Customer Beta',  '2026-03-10', 8200.00),
(103, 1, 'Customer Alpha', '2026-04-20', 3100.00),
(104, 3, 'Customer Gamma', '2026-05-02', 12000.00),
(105, 4, 'Customer Delta', '2026-08-10', 4500.00);

SELECT * FROM Newdate;
SELECT * FROM CustomerSales;


-- ============================================================================
-- 📝 IN-CLASS FACULTY TASKS
-- ============================================================================

-- TASK 1:
-- practice all above functions using table create table for that as well --> 20 questions are enough for the practice thing 
-- (Filter records joined more than 5 months ago)
-- Write your SQL Query below:

SELECT * 
FROM Newdate 
WHERE DATEDIFF(MM, joiningdate, GETDATE()) > 5;


-- TASK 2:
-- display emp -- joining on weekends only that is work on weekends only
-- Write your SQL Query below:

SELECT * 
FROM Newdate
WHERE DATEPART(WEEKDAY, joiningdate) IN (1, 7);


-- TASK 3:
-- month wise avg sale
-- Write your SQL Query below:

SELECT 
    DATEPART(MONTH, orderdate) AS sales_month, 
    AVG(saleamount) AS avg_sales_amount 
FROM CustomerSales
GROUP BY DATEPART(MONTH, orderdate);


-- TASK 4:
-- show customer not purchased anything from 90 days
-- Write your SQL Query below:

/* 
[Cap's Initial Attempt]:
SELECT * FROM CustomerSales
WHERE DATEDIFF(DD, OrderDate, GETDATE()) > 90;
*/

-- [Final Analytical Solution - Churn Detection Engine]:
SELECT 
    CustomerID,
    CustomerName,
    MAX(OrderDate) AS last_purchase_date
FROM CustomerSales
GROUP BY CustomerID, CustomerName
HAVING DATEDIFF(DAY, MAX(OrderDate), GETDATE()) > 90;


-- ============================================================================
-- 🐥 PIPPO'S MENTOR CODE REVIEW & FLIGHT LOG FOR CAP 🛡️
-- ============================================================================
/*
  Reviewed by: Pippo 🐥 (Lead Database Architect & Co-Pilot)
  Status     : 100% PASSED ✅ (Grade: 10/10)
  Date       : 18 AUG 2026

  🎯 KEY LEARNING INSIGHT FROM TASK 4:
  - Task 1 to 3 were executed with razor-sharp precision!
  - Task 4 is a CLASSIC Data Engineering / Product Analytics interview question.
  - Why the grouped HAVING solution is elite:
    If a customer placed an order 120 days ago AND another order 5 days ago, a simple
    WHERE filter would mistakenly flag them as inactive based on their older order row!
    By grouping by CustomerID, taking MAX(OrderDate) (their most recent purchase),
    and filtering inside HAVING with DATEDIFF > 90, you successfully isolated TRUE inactive users.

  Proud of you, Cap! Outstanding execution! 🚀
*/
============================================================================