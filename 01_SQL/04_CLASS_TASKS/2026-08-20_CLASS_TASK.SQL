-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 20 AUGUST 2026 (Day 17)
-- 🎯 TOPIC: Multi-Table Joins (3+ Tables), CROSS JOIN Matrix Pairing, Equi Joins & Quarter Filtering
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

-- Clean up existing tables
IF OBJECT_ID('MatchTeams', 'U') IS NOT NULL DROP TABLE MatchTeams;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Product', 'U') IS NOT NULL DROP TABLE Product;
IF OBJECT_ID('Customer', 'U') IS NOT NULL DROP TABLE Customer;

-- Table 1: Customer Master
CREATE TABLE Customer
(
    custid   INT PRIMARY KEY,
    Custname VARCHAR(50) NOT NULL,
    city     VARCHAR(50) NOT NULL
);

-- Table 2: Product Catalog
CREATE TABLE Product
(
    Pid      INT PRIMARY KEY,
    Pname    VARCHAR(50) NOT NULL,
    price    DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Table 3: Orders Transactions
CREATE TABLE Orders
(
    oid      INT PRIMARY KEY,
    custid   INT,
    pid      INT,
    quantity INT NOT NULL,
    T_date   DATE NOT NULL
);

-- Table 4: MatchTeams (For Tournament Pairing Drills)
CREATE TABLE MatchTeams
(
    TeamID   INT PRIMARY KEY,
    TeamName VARCHAR(50) NOT NULL,
    City     VARCHAR(50) NOT NULL
);

-- Seed Customer Data
INSERT INTO Customer (custid, Custname, city) VALUES
(1, 'Amit',   'Pune'),
(2, 'Puja',   'Pune'),
(3, 'Neha',   'Mumbai'),
(4, 'Sumit',  'Nagpur'),
(5, 'Amit',   'Mumbai'),
(6, 'Leena',  'Nagpur'),
(7, 'Rajesh', 'Bangalore');

-- Seed Product Data
INSERT INTO Product (Pid, Pname, price, category) VALUES
(101, 'Laptop',   50000.00, 'Electronics'),
(102, 'Mobile',   40000.00, 'Electronics'),
(103, 'Soap',       500.00, 'Grocery'),
(104, 'Headphone', 2500.00, 'Electronics'),
(105, 'Desk Lamp', 1500.00, 'Home Decor');

-- Seed Orders Data
INSERT INTO Orders (oid, custid, pid, quantity, T_date) VALUES
(1000, 1, 101, 2,  '2024-01-10'),
(1001, 1, 102, 5,  '2025-02-11'),
(1002, 4, 103, 10, '2026-08-20'),
(1003, 3, 101, 5,  '2022-01-01'),
(1004, 2, 104, 3,  '2025-07-15'),
(1005, 5, 102, 2,  '2026-09-05'),
(1006, 1, 105, 4,  '2026-03-25');

-- Seed MatchTeams Data
INSERT INTO MatchTeams (TeamID, TeamName, City) VALUES
(1, 'Mumbai Indians',   'Mumbai'),
(2, 'Chennai Super Kings', 'Chennai'),
(3, 'Royal Challengers', 'Bengaluru'),
(4, 'Kolkata Knight Riders', 'Kolkata');

-- Verify Seed Data
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM MatchTeams;


-- ====================================================================================================
-- 📝 IN-CLASS & HOMEWORK TASKS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 1: 3-WAY MULTI-TABLE PROJECTION & COMPUTED REVENUE
-- Requirement: Display Customer Name, Product Name, Product Category, Quantity, Unit Price, 
-- and Total Line Amount (Quantity * Price) using ANSI standard 3-table join.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:

-- [Your Attempt]:
select 
    custname,
    pname,
    category,
    quantity,
    price,
    (quantity*price) as total_line_amount
from customer c 
left join orders o on c.custid = o.custid 
full join  product p on o.pid = p.pid;

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 7.0 / 10.0):
   - Verdict: Correct mathematical logic for line amount, but minor relational defects.
   - Feedback: 
     1. FULL JOIN on Product was unnecessary — standard orders lookup requires INNER JOIN or LEFT JOIN.
     2. Best practice is to prefix all columns with table aliases (c.Custname, p.Pname, o.quantity, p.price).
     3. Keywords should strictly be in UPPERCASE.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY]:
SELECT 
    c.Custname,
    p.Pname,
    p.category,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS total_line_amount
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid;


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 2: TOTAL SPEND AGGREGATION (LEFT JOIN VS INNER JOIN)
-- Requirement: Display Customer Name along with their Total Spend across all orders.
-- Write two queries: 
-- (a) Using INNER JOIN (Only purchasing customers)
-- (b) Using LEFT JOIN (Include all registered customers, showing 0.00 for non-purchasing customers)
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Part a - INNER JOIN):

-- [Your Attempt]:
select Custname,sum(price) as total_spend 
from customer c 
inner join orders o on c.custid = o.custid 
inner join  product p on o.pid = p.pid 
group by Custname;

/* 
   🐥 PIPPO EVALUATION REMARK (Part a - Score: 3.0 / 5.0):
   - Verdict: Group by structure correct, but fatal calculation bug.
   - Fatal Bug: Used SUM(price) instead of SUM(quantity * price). If customer bought 5 laptops, 
     your query counted 50,000 once instead of 250,000!
   - Best Practice: Group by both `c.custid, c.Custname` to prevent merging duplicate names.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part a]:
SELECT 
    c.custid,
    c.Custname,
    SUM(o.quantity * p.price) AS total_spend
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
GROUP BY c.custid, c.Custname;


-- Write your SQL Query below (Part b - LEFT JOIN with ISNULL):

-- [Your Attempt]:
select Custname,sum(price) as total_spend 
from customer c 
left join orders o on c.custid = o.custid 
left join  product p on o.pid = p.pid 
group by Custname;
-- don't know how to use isnull

/* 
   🐥 PIPPO EVALUATION REMARK (Part b - Score: 2.0 / 5.0):
   - Verdict: Left join structure correct, but missed ISNULL() and repeated SUM(price) bug.
   - ISNULL Syntax Guide: `ISNULL(SUM(o.quantity * p.price), 0.00) AS total_spend`.
   - How it works: Replaces NULL aggregate with 0.00 for non-purchasing customers (Leena, Rajesh).
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part b]:
SELECT 
    c.custid,
    c.Custname,
    ISNULL(SUM(o.quantity * p.price), 0.00) AS total_spend
FROM Customer c
LEFT JOIN Orders o ON c.custid = o.custid
LEFT JOIN Product p ON o.pid = p.pid
GROUP BY c.custid, c.Custname;


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 3: FILTERED MULTI-TABLE AGGREGATION WITH HAVING & SORTING
-- Requirement: Display Customer Name and Total Spend for customers whose name contains the letter 'a',
-- whose total lifetime spend exceeds 200,000, sorted by total amount in ascending order.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:

-- [Your Attempt]:
select custname,sum(price) as total_spend 
from customer c 
left join orders o on c.custid = o.custid 
left join  product p on o.pid = p.pid
where custname like '%a%' 
group by Custname
having sum(price) > 200000
order by total_spend asc;

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 6.5 / 10.0):
   - Verdict: Filtering (LIKE '%a%'), HAVING syntax, and ORDER BY were spot-on!
   - Defect: Repeated SUM(price) bug instead of SUM(quantity * price).
   - Tip: With HAVING > 200000, non-purchasing customers are eliminated, so INNER JOIN is preferred.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY]:
SELECT 
    c.custid,
    c.Custname,
    SUM(o.quantity * p.price) AS total_spend
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
WHERE c.Custname LIKE '%a%'
GROUP BY c.custid, c.Custname
HAVING SUM(o.quantity * p.price) > 200000
ORDER BY total_spend ASC;


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 4: TEMPORAL QUARTER FILTERING ON 3-TABLE JOIN
-- Requirement: Display Customer Name, Product Name, Order Date, and Order Quarter for all orders 
-- placed strictly in the 1st Quarter (Jan-Mar) or 3rd Quarter (Jul-Sep) of any year.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:

-- [Your Attempt]:
select custname ,pname ,t_date,datepart(qq,t_date) 
from customer c 
left join orders o on c.custid = o.custid 
left join  product p on o.pid = p.pid 
where datepart(qq,t_date) in (1,3);

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 7.5 / 10.0):
   - Verdict: Very clean temporal logic (`DATEPART(qq, t_date) IN (1,3)`)!
   - Defect: Missing column alias on `DATEPART(qq, o.T_date) AS order_quarter` (creates `(No column name)`).
   - Join Choice: Since filtering on orders, INNER JOIN is cleaner than LEFT JOIN.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY]:
SELECT 
    c.Custname,
    p.Pname,
    o.T_date,
    DATEPART(qq, o.T_date) AS order_quarter
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
WHERE DATEPART(qq, o.T_date) IN (1, 3);


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 5: ANSI CROSS JOIN CARTESIAN COMBINATIONS
-- Requirement: 
-- (a) Write a query to generate all possible pairings of Customers and Products (Cartesian product).
-- (b) Write a query to generate all possible 3-table combinations (Customer x Product x Orders).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Part a):

-- [Your Attempt]:
select * from Customer,Product;

select * 
from Customer cross join Product;

/* 
   🐥 PIPPO EVALUATION REMARK (Part a - Score: 5.0 / 5.0):
   - Verdict: 100% PERFECT! Both legacy comma Cartesian and ANSI CROSS JOIN correctly demonstrated.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part a]:
SELECT * 
FROM Customer 
CROSS JOIN Product;


-- Write your SQL Query below (Part b):

-- [Your Attempt]:
select * from Customer,Product,Orders;

select * 
from Customer cross join Product cross join orders;

/* 
   🐥 PIPPO EVALUATION REMARK (Part b - Score: 4.0 / 5.0):
   - Verdict: Excellent 3-table Cartesian product chaining!
   - Minor: Ensure uppercase SQL keywords.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part b]:
SELECT * 
FROM Customer 
CROSS JOIN Product 
CROSS JOIN Orders;


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 6: TOURNAMENT ROUND-ROBIN FIXTURES (CROSS JOIN MATRIX)
-- Requirement: Using the `MatchTeams` table, write a query to generate a complete round-robin fixture list 
-- where every team plays every other team once as Home Team and once as Away Team (excluding self-matches).
-- Columns required: HomeTeam, HomeCity, AwayTeam, AwayCity.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:

-- [Your Attempt]:
SELECT TeamName as hometeam , city as homecity  
FROM TeamName cross join TeamName 
where teamid <> teamid;
-- no idea how to solve 

/* 
   🐥 PIPPO EVALUATION REMARK (Score: 3.0 / 10.0):
   - Verdict: Good conceptual intuition on `teamid <> teamid`, but syntax broke.
   - Core Rule: When joining a table to itself, you MUST give distinct aliases: `MatchTeams t1 CROSS JOIN MatchTeams t2`.
   - Filter: `WHERE t1.TeamID <> t2.TeamID` excludes self-matches and generates all 12 fixtures (4 teams * 3 opponents).
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY]:
SELECT 
    t1.TeamName AS HomeTeam,
    t1.City     AS HomeCity,
    t2.TeamName AS AwayTeam,
    t2.City     AS AwayCity
FROM MatchTeams t1
CROSS JOIN MatchTeams t2
WHERE t1.TeamID <> t2.TeamID
ORDER BY t1.TeamID, t2.TeamID;


-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 7: NON-ANSI EQUI JOIN VS ANSI INNER JOIN COMPARISON
-- Requirement: Write two queries to join Customer and Orders:
-- (a) Using legacy comma syntax with WHERE equality filter.
-- (b) Using ANSI SQL-92 `INNER JOIN ... ON` standard syntax.
-- Verify that both queries return identical result sets and explain why ANSI syntax is preferred in enterprise code.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below (Part a - Legacy Equi Join):

-- [Your Attempt]:
select * 
from Customer c 
inner join orders o on c.custid = o.custid;

/* 
   🐥 PIPPO EVALUATION REMARK (Part a - Score: 3.5 / 5.0):
   - Verdict: Query works, but labels were accidentally flipped (you wrote ANSI syntax under Legacy section).
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part a (Legacy Equi Join)]:
SELECT 
    c.custid,
    c.Custname,
    c.city,
    o.oid,
    o.pid,
    o.quantity,
    o.T_date
FROM Customer c, Orders o
WHERE c.custid = o.custid;


-- Write your SQL Query below (Part b - ANSI Inner Join):

-- [Your Attempt]:
select * 
from Customer as c,orders as o
where 
c.custid = o.custid;

/* 
   🐥 PIPPO EVALUATION REMARK (Part b - Score: 3.0 / 5.0):
   - Verdict: Query works, but wrote Legacy syntax under ANSI section and omitted the enterprise explanation.
*/

-- 💡 [PIPPO'S GOLDEN PRODUCTION QUERY - Part b (ANSI Inner Join)]:
SELECT 
    c.custid,
    c.Custname,
    c.city,
    o.oid,
    o.pid,
    o.quantity,
    o.T_date
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid;

-- ====================================================================================================
-- 🐥 PIPPO'S STRICT MENTOR EVALUATION & ARCHITECTURAL REVIEW
-- ====================================================================================================
/*
====================================================================================================
                       📋 MENTOR SCORECARD: 44.5 / 70.0 (GRADE: B-)
====================================================================================================
Cap, good effort sitting down and grinding through these 7 tasks! But as your senior database architect,
I must be 100% strict and honest with you so you develop Tier-1 production instincts:

🔴 THE 4 CRITICAL MISTAKES TO FIX PERMANENTLY:

1. ❌ THE FATAL TOTAL SPEND BUG: `SUM(price)` vs `SUM(quantity * price)` (Tasks 2 & 3)
   - If Customer buys 5 Laptops ($50,000 each), your query calculated total spend as $50,000 instead of $250,000!
   - In any e-commerce/financial pipeline, Total Line Spend is ALWAYS: `quantity * price`.
   - Formula: `SUM(o.quantity * p.price) AS total_spend`

2. ❌ LOWERCASE SQL KEYWORDS (Constitutional Law #2 Violation across ALL 7 tasks)
   - In SSMS and enterprise code reviews, writing `select`, `from`, `left join`, `group by` in lowercase
     will get your pull request immediately rejected. 
   - ALWAYS write `SELECT`, `FROM`, `INNER JOIN`, `GROUP BY`, `HAVING`, `ORDER BY` in UPPERCASE!

3. ❌ SELF-JOIN / CARTESIAN MATRIX ALIASING (Task 6)
   - You wrote `FROM TeamName cross join TeamName where teamid <> teamid`.
   - Rule: You CANNOT join a table to itself without giving each instance a UNIQUE table alias!
   - Correct: `FROM MatchTeams AS t1 CROSS JOIN MatchTeams AS t2 WHERE t1.TeamID <> t2.TeamID`

4. ❌ HOW TO USE `ISNULL()` (Task 2b)
   - When using `LEFT JOIN`, customers with 0 orders produce `NULL` for sum of spending.
   - Syntax: `ISNULL(SUM(o.quantity * p.price), 0.00) AS total_spend`
   - How it works: If the first parameter is NULL, SQL Server replaces it with the second parameter (0.00).

====================================================================================================
                        🏆 GOLDEN PRODUCTION REFERENCE SOLUTIONS
====================================================================================================

-- [TASK 1: GOLDEN SOLUTION]
SELECT 
    c.Custname,
    p.Pname,
    p.category,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS total_line_amount
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid;

-- [TASK 2a: INNER JOIN GOLDEN SOLUTION]
SELECT 
    c.custid,
    c.Custname,
    SUM(o.quantity * p.price) AS total_spend
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
GROUP BY c.custid, c.Custname;

-- [TASK 2b: LEFT JOIN WITH ISNULL GOLDEN SOLUTION]
SELECT 
    c.custid,
    c.Custname,
    ISNULL(SUM(o.quantity * p.price), 0.00) AS total_spend
FROM Customer c
LEFT JOIN Orders o ON c.custid = o.custid
LEFT JOIN Product p ON o.pid = p.pid
GROUP BY c.custid, c.Custname;

-- [TASK 3: GOLDEN SOLUTION]
SELECT 
    c.custid,
    c.Custname,
    SUM(o.quantity * p.price) AS total_spend
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
WHERE c.Custname LIKE '%a%'
GROUP BY c.custid, c.Custname
HAVING SUM(o.quantity * p.price) > 200000
ORDER BY total_spend ASC;

-- [TASK 4: GOLDEN SOLUTION]
SELECT 
    c.Custname,
    p.Pname,
    o.T_date,
    DATEPART(qq, o.T_date) AS order_quarter
FROM Customer c
INNER JOIN Orders o ON c.custid = o.custid
INNER JOIN Product p ON o.pid = p.pid
WHERE DATEPART(qq, o.T_date) IN (1, 3);

-- [TASK 6: GOLDEN TOURNAMENT FIXTURE SOLUTION]
SELECT 
    t1.TeamName AS HomeTeam,
    t1.City     AS HomeCity,
    t2.TeamName AS AwayTeam,
    t2.City     AS AwayCity
FROM MatchTeams t1
CROSS JOIN MatchTeams t2
WHERE t1.TeamID <> t2.TeamID
ORDER BY t1.TeamID, t2.TeamID;

-- [TASK 7: WHY ANSI SQL-92 IS MANDATORY IN ENTERPRISE]
-- 1. Separation of Concerns: ANSI isolates JOIN logic in `ON` and row filtering in `WHERE`.
-- 2. Anti-Bug Guarantee: In legacy syntax, forgetting a WHERE condition causes accidental Cartesian products.
-- 3. Outer Join Support: ANSI allows LEFT/RIGHT/FULL joins cleanly without proprietary legacy operators (*=).
*/
====================================================================================================
