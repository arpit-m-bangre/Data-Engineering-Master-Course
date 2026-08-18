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

select * from Newdate
select * from CustomerSales


-- ============================================================================
-- 📝 IN-CLASS FACULTY TASKS
-- ============================================================================

-- TASK 1:
-- practice all above functions using table create table for that as well --> 20 questions are enough for the practice thing 
-- (Filter records joined more than 5 months ago)
-- Write your SQL Query below:

select * from Newdate 
where datediff(mm,joiningdate,getdate()) > 5 


-- TASK 2:
-- display emp -- joining on weekends only that is work on weekends only
-- Write your SQL Query below:

select * from Newdate
where datepart(weekday,joiningdate) in (1,7)


-- TASK 3:
-- month wise avg sale
-- Write your SQL Query below:

select datepart(MONTH,orderdate) as sales_month, avg(saleamount) as avg_sales_amount from CustomerSales
group by datepart(MONTH,orderdate)




-- TASK 4:
-- show customer not purchased anything from 90 days
-- Write your SQL Query below:


/* 
my attempt 
select * from CustomerSales
where datediff(dd,OrderDate,getdate())>90
*/


-- gpt helped me 

SELECT 
    CustomerID,
    CustomerName,
    MAX(OrderDate) AS last_purchase_date
FROM CustomerSales
GROUP BY CustomerID, CustomerName
HAVING DATEDIFF(DAY, MAX(OrderDate), GETDATE()) > 90;