/* ============================================================
               DATA ENGINEERING PROJECT 1 (PROJECT1.SQL)
               TITLE: E-COMMERCE SALES & CUSTOMER ANALYTICS PIPELINE
               TOPICS COVERED: DAYS 1 - 4
               (Table Creation, Data Types, Ingestion, Computed Projections,
                Arithmetic Operators, UPDATE, DELETE, WHERE, Pattern Matching)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
You are a Data Engineer at an E-commerce platform. The management
wants you to build a database module to manage customer profiles 
and order transactions, compute dynamic financial projections, 
apply promotional price adjustments, and perform data cleansing.
=============================================================== */

-- ============================================================
-- 2. SCHEMA DEFINITION & TABLE SETUP
-- ============================================================

-- Clean up existing tables
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;

-- Task 1: Create the 'Customers' table
CREATE TABLE Customers
(
    CustomerID    INT PRIMARY KEY,
    CustomerName  VARCHAR(40) NOT NULL,
    City          VARCHAR(25) NOT NULL,
    Email         VARCHAR(50),
    TotalOrders   INT NOT NULL,
    AccountStatus VARCHAR(15) NOT NULL
);

-- Task 2: Create the 'Orders' table
CREATE TABLE Orders
(
    OrderID      INT PRIMARY KEY,
    CustomerID   INT NOT NULL,
    ItemCategory VARCHAR(25) NOT NULL,
    Quantity     INT NOT NULL,
    UnitPrice    DECIMAL(10,2) NOT NULL,
    PaymentMode  VARCHAR(15) NOT NULL,
    OrderStatus  VARCHAR(15) NOT NULL
);


-- ============================================================
-- 3. DATA POPULATION (INGESTION)
-- ============================================================

-- Insert Customer Records
INSERT INTO Customers (CustomerID, CustomerName, City, Email, TotalOrders, AccountStatus) VALUES 
(101, 'Arpit Bangre', 'Nagpur', 'arpit.b@gmail.com', 12, 'Active'),
(102, 'Rahul Patil',  'Pune',   'rahul.p@yahoo.com', 5,  'Active'),
(103, 'Sneha Joshi',  'Mumbai', 'sneha.j@gmail.com', 8,  'Active'),
(104, 'Priya Sharma', 'Nagpur', 'priya.s@outlook.com', 2, 'Inactive'),
(105, 'Amit Verma',   'Delhi',  'amit.v@gmail.com', 15, 'Active'),
(106, 'Pushpak Kale', 'Bhopal', NULL, 0, 'Closed');

-- Insert Order Records
INSERT INTO Orders (OrderID, CustomerID, ItemCategory, Quantity, UnitPrice, PaymentMode, OrderStatus) VALUES 
(5001, 101, 'Electronics', 2, 25000.00, 'UPI', 'Delivered'),
(5002, 102, 'Apparel',     4, 1500.00,  'Credit Card', 'Delivered'),
(5003, 103, 'Electronics', 1, 65000.00, 'UPI', 'Delivered'),
(5004, 101, 'Home Decor',  3, 3500.00,  'Debit Card', 'Pending'),
(5005, 105, 'Electronics', 1, 45000.00, 'Credit Card', 'Cancelled'),
(5006, 104, 'Apparel',     2, 2000.00,  'Cash', 'Delivered');


-- ============================================================
-- 4. ANALYTICS & PIPELINE EXECUTION TASKS
-- ============================================================

-- Task 3: Retrieve all active customers located in 'Nagpur' or 'Pune'.
-- ------------------------------------------------------------
-- [Cap Original]:
-- SELECT * FROM Customers WHERE City IN ('nagpur','pune')
-- [Pippo Audit]: ❌ INCOMPLETE FILTER. Missed AccountStatus = 'Active'.
-- [Master Production Query]:
SELECT 
    CustomerID,
    CustomerName,
    City,
    Email,
    TotalOrders,
    AccountStatus
FROM Customers 
WHERE City IN ('Nagpur', 'Pune') 
  AND AccountStatus = 'Active';


-- Task 4: Retrieve all delivered orders where UnitPrice is BETWEEN 2000 AND 30000 AND PaymentMode IN ('UPI', 'Credit Card').
-- ------------------------------------------------------------
-- [Cap Original]:
-- SELECT * FROM Orders WHERE UnitPrice BETWEEN 2000 AND 30000 AND PaymentMode IN ('upi','credit card')
-- [Pippo Audit]: ❌ INCOMPLETE FILTER. Missed OrderStatus = 'Delivered'.
-- [Master Production Query]:
SELECT 
    OrderID,
    CustomerID,
    ItemCategory,
    Quantity,
    UnitPrice,
    PaymentMode,
    OrderStatus
FROM Orders
WHERE UnitPrice BETWEEN 2000 AND 30000 
  AND PaymentMode IN ('UPI', 'Credit Card')
  AND OrderStatus = 'Delivered';


-- Task 5: Find all customers whose Email contains 'gmail' AND CustomerName starts with 'A' or 'S'.
-- ------------------------------------------------------------
-- [Cap Original]:
-- SELECT * FROM Customers WHERE Email LIKE '%gmail%' AND CustomerName LIKE '[a,s]%'
-- [Pippo Audit]: ⚠️ SYNTAX WARNING. Avoid comma in [a,s] (matches literal comma). Use [AS]%.
-- [Master Production Query]:
SELECT 
    CustomerID,
    CustomerName,
    Email,
    City,
    AccountStatus
FROM Customers
WHERE Email LIKE '%gmail%' 
  AND CustomerName LIKE '[AS]%';


-- Task 6: Compute dynamic output columns for Orders:
-- - TotalOrderValue = Quantity * UnitPrice
-- - DiscountedValue = TotalOrderValue * 0.90 (-10% promo discount)
-- - TaxedValue = TotalOrderValue * 1.18 (+18% GST)
-- ------------------------------------------------------------
-- [Cap Original]:
-- SELECT Quantity*UnitPrice AS totalOrderValue, (Quantity*UnitPrice)*0.90 AS DiscountedValue, (Quantity*UnitPrice)*1.18 AS TotalOrderValue FROM Orders
-- [Pippo Audit]: ❌ ALIAS OVERWRITE BUG. 3rd column named TotalOrderValue instead of TaxedValue.
-- [Master Production Query]:
SELECT 
    OrderID,
    CustomerID,
    ItemCategory,
    Quantity,
    UnitPrice,
    (Quantity * UnitPrice) AS TotalOrderValue,
    (Quantity * UnitPrice * 0.90) AS DiscountedValue,
    (Quantity * UnitPrice * 1.18) AS TaxedValue
FROM Orders;


-- Task 7: Update UnitPrice = UnitPrice * 0.95 (5% price reduction) for all orders in 'Electronics' category.
-- ------------------------------------------------------------
-- [Cap Original]:
-- UPDATE Orders SET UnitPrice = UnitPrice * 0.95 (NO WHERE CLAUSE!)
-- [Pippo Audit]: 🚨 CRITICAL PRODUCTION BUG. Missing WHERE clause updated entire table!
-- [Master Production Query]:
UPDATE Orders 
SET UnitPrice = UnitPrice * 0.95 
WHERE ItemCategory = 'Electronics';

SELECT * FROM Orders WHERE ItemCategory = 'Electronics';


-- Task 8: Update Customer AccountStatus = 'VIP' for customers with TotalOrders >= 10.
-- ------------------------------------------------------------
-- [Cap Original]:
-- UPDATE Customers SET AccountStatus = 'vip' WHERE TotalOrders>=10
-- [Pippo Audit]: ✅ LOGIC 100% CORRECT. Enforce uppercase SQL keywords & casing.
-- [Master Production Query]:
UPDATE Customers 
SET AccountStatus = 'VIP' 
WHERE TotalOrders >= 10;

SELECT * FROM Customers WHERE AccountStatus = 'VIP';


-- Task 9: Delete obsolete records from Customers where AccountStatus = 'Closed' OR Email IS NULL.
-- ------------------------------------------------------------
-- [Cap Original]:
-- DELETE Customers WHERE AccountStatus='closed' OR Email IS NULL
-- [Pippo Audit]: ✅ LOGIC 100% CORRECT. Standard ANSI syntax: DELETE FROM Customers.
-- [Master Production Query]:
DELETE FROM Customers 
WHERE AccountStatus = 'Closed' 
   OR Email IS NULL;

SELECT * FROM Customers;


-- Task 10: Retrieve all customer records where CustomerName contains both letters and numbers, or whose City is NOT IN ('Mumbai', 'Delhi').
-- ------------------------------------------------------------
-- [Cap Original]:
-- SELECT * FROM Customers WHERE CustomerName LIKE '%[a-z0-9]%' AND city NOT IN ('mumbai','delhi')
-- [Pippo Audit]: ❌ LOGIC BUG. Used AND instead of OR, and %[a-z0-9]% checks single char, not BOTH letters & numbers.
-- [Master Production Query]:
SELECT 
    CustomerID,
    CustomerName,
    City,
    Email,
    TotalOrders,
    AccountStatus
FROM Customers 
WHERE (CustomerName LIKE '%[0-9]%' AND CustomerName LIKE '%[A-Za-z]%')
   OR City NOT IN ('Mumbai', 'Delhi');


/* ============================================================
                    END OF PROJECT 1 AUDIT
   ============================================================ */
