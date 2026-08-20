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




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 2: TOTAL SPEND AGGREGATION (LEFT JOIN VS INNER JOIN)
-- Requirement: Display Customer Name along with their Total Spend across all orders.
-- Write two queries: 
-- (a) Using INNER JOIN (Only purchasing customers)
-- (b) Using LEFT JOIN (Include all registered customers, showing 0.00 for non-purchasing customers)
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Part a - INNER JOIN):




-- Write your SQL Query below (Part b - LEFT JOIN with ISNULL):




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 3: FILTERED MULTI-TABLE AGGREGATION WITH HAVING & SORTING
-- Requirement: Display Customer Name and Total Spend for customers whose name contains the letter 'a',
-- whose total lifetime spend exceeds 200,000, sorted by total amount in ascending order.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 4: TEMPORAL QUARTER FILTERING ON 3-TABLE JOIN
-- Requirement: Display Customer Name, Product Name, Order Date, and Order Quarter for all orders 
-- placed strictly in the 1st Quarter (Jan-Mar) or 3rd Quarter (Jul-Sep) of any year.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 5: ANSI CROSS JOIN CARTESIAN COMBINATIONS
-- Requirement: 
-- (a) Write a query to generate all possible pairings of Customers and Products (Cartesian product).
-- (b) Write a query to generate all possible 3-table combinations (Customer x Product x Orders).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Part a):




-- Write your SQL Query below (Part b):




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 6: TOURNAMENT ROUND-ROBIN FIXTURES (CROSS JOIN MATRIX)
-- Requirement: Using the `MatchTeams` table, write a query to generate a complete round-robin fixture list 
-- where every team plays every other team once as Home Team and once as Away Team (excluding self-matches).
-- Columns required: HomeTeam, HomeCity, AwayTeam, AwayCity.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 TASK 7: NON-ANSI EQUI JOIN VS ANSI INNER JOIN COMPARISON
-- Requirement: Write two queries to join Customer and Orders:
-- (a) Using legacy comma syntax with WHERE equality filter.
-- (b) Using ANSI SQL-92 `INNER JOIN ... ON` standard syntax.
-- Verify that both queries return identical result sets and explain why ANSI syntax is preferred in enterprise code.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Part a - Legacy Equi Join):




-- Write your SQL Query below (Part b - ANSI Inner Join):



