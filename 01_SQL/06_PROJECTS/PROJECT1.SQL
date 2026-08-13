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

-- Task 1: Create the 'Customers' table
CREATE TABLE Customers
(
    CustomerID   INT,
    CustomerName VARCHAR(40),
    City         VARCHAR(25),
    Email        VARCHAR(50),
    TotalOrders  INT,
    AccountStatus VARCHAR(15)
);

-- Task 2: Create the 'Orders' table
CREATE TABLE Orders
(
    OrderID      INT,
    CustomerID   INT,
    ItemCategory VARCHAR(25),
    Quantity     INT,
    UnitPrice    INT,
    PaymentMode  VARCHAR(15),
    OrderStatus  VARCHAR(15)
);


-- ============================================================
-- 3. DATA POPULATION (INGESTION)
-- ============================================================

-- Insert Customer Records
INSERT INTO Customers VALUES (101, 'Arpit Bangre', 'Nagpur', 'arpit.b@gmail.com', 12, 'Active');
INSERT INTO Customers VALUES (102, 'Rahul Patil', 'Pune', 'rahul.p@yahoo.com', 5, 'Active');
INSERT INTO Customers VALUES (103, 'Sneha Joshi', 'Mumbai', 'sneha.j@gmail.com', 8, 'Active');
INSERT INTO Customers VALUES (104, 'Priya Sharma', 'Nagpur', 'priya.s@outlook.com', 2, 'Inactive');
INSERT INTO Customers VALUES (105, 'Amit Verma', 'Delhi', 'amit.v@gmail.com', 15, 'Active');
INSERT INTO Customers VALUES (106, 'Pushpak Kale', 'Bhopal', NULL, 0, 'Closed');

-- Insert Order Records
INSERT INTO Orders VALUES (5001, 101, 'Electronics', 2, 25000, 'UPI', 'Delivered');
INSERT INTO Orders VALUES (5002, 102, 'Apparel', 4, 1500, 'Credit Card', 'Delivered');
INSERT INTO Orders VALUES (5003, 103, 'Electronics', 1, 65000, 'UPI', 'Delivered');
INSERT INTO Orders VALUES (5004, 101, 'Home Decor', 3, 3500, 'Debit Card', 'Pending');
INSERT INTO Orders VALUES (5005, 105, 'Electronics', 1, 45000, 'Credit Card', 'Cancelled');
INSERT INTO Orders VALUES (5006, 104, 'Apparel', 2, 2000, 'Cash', 'Delivered');


-- ============================================================
-- 4. ANALYTICS & PIPELINE EXECUTION TASKS
-- ============================================================

-- Task 3: Retrieve all active customers located in 'Nagpur' or 'Pune'.
-- Write your SQL Query below:




-- Task 4: Retrieve all delivered orders where UnitPrice is BETWEEN 2000 AND 30000 AND PaymentMode IN ('UPI', 'Credit Card').
-- Write your SQL Query below:




-- Task 5: Find all customers whose Email contains 'gmail' AND CustomerName starts with 'A' or 'S'.
-- Write your SQL Query below:




-- Task 6: Compute dynamic output columns for Orders:
-- - TotalOrderValue = Quantity * UnitPrice
-- - DiscountedValue = TotalOrderValue * 0.90 (-10% promo discount)
-- - TaxedValue = TotalOrderValue * 1.18 (+18% GST)
-- Write your SQL Query below:




-- Task 7: Update UnitPrice = UnitPrice * 0.95 (5% price reduction) for all orders in 'Electronics' category.
-- Write your SQL Query below:




-- Task 8: Update Customer AccountStatus = 'VIP' for customers with TotalOrders >= 10.
-- Write your SQL Query below:




-- Task 9: Delete obsolete records from Customers where AccountStatus = 'Closed' OR Email IS NULL.
-- Write your SQL Query below:




-- Task 10: Retrieve all customer records where CustomerName contains both letters and numbers, or whose City is NOT IN ('Mumbai', 'Delhi').
-- Write your SQL Query below:




/* ============================================================
                    END OF PROJECT 1
   ============================================================ */
