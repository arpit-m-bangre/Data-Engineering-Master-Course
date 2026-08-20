-- ====================================================================================================
-- 🎓 DATA ENGINEERING MASTER COURSE — PRACTICE DRILL SET
-- 📅 DATE: 20 AUGUST 2026 (THURSDAY) | BATCH: ONLINE BATCH 15 (DAY 17)
-- 👨‍🏫 MODULE 1: ENTERPRISE SQL ARCHITECTURE & QUERY ENGINE
-- 🎯 TOPIC: MULTI-TABLE JOINS, ANSI CROSS JOIN, EQUI JOINS & TEMPORAL SPREAD
-- 📁 TOTAL QUESTIONS: EXACTLY 14 TARGETED DRILLS
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SCHEMA CREATION
-- ====================================================================================================

-- Clean up practice tables
IF OBJECT_ID('RetailShipments', 'U') IS NOT NULL DROP TABLE RetailShipments;
IF OBJECT_ID('RetailOrders', 'U') IS NOT NULL DROP TABLE RetailOrders;
IF OBJECT_ID('RetailProducts', 'U') IS NOT NULL DROP TABLE RetailProducts;
IF OBJECT_ID('RetailCustomers', 'U') IS NOT NULL DROP TABLE RetailCustomers;
IF OBJECT_ID('LeagueTeams', 'U') IS NOT NULL DROP TABLE LeagueTeams;
IF OBJECT_ID('ColorPalettes', 'U') IS NOT NULL DROP TABLE ColorPalettes;
IF OBJECT_ID('SizeCatalog', 'U') IS NOT NULL DROP TABLE SizeCatalog;

-- Table 1: RetailCustomers
CREATE TABLE RetailCustomers
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL,
    Tier         VARCHAR(20) NOT NULL
);

-- Table 2: RetailProducts
CREATE TABLE RetailProducts
(
    ProductID    INT PRIMARY KEY,
    ProductName  VARCHAR(50) NOT NULL,
    Category     VARCHAR(50) NOT NULL,
    UnitPrice    DECIMAL(10,2) NOT NULL
);

-- Table 3: RetailOrders
CREATE TABLE RetailOrders
(
    OrderID      INT PRIMARY KEY,
    CustomerID   INT,
    ProductID    INT,
    Quantity     INT NOT NULL,
    OrderDate    DATE NOT NULL,
    Status       VARCHAR(20) NOT NULL
);

-- Table 4: RetailShipments
CREATE TABLE RetailShipments
(
    ShipmentID   INT PRIMARY KEY,
    OrderID      INT,
    Carrier      VARCHAR(50) NOT NULL,
    DeliveryDate DATE
);

-- Table 5: LeagueTeams
CREATE TABLE LeagueTeams
(
    TeamID       INT PRIMARY KEY,
    TeamName     VARCHAR(50) NOT NULL,
    Conference   VARCHAR(20) NOT NULL
);

-- Table 6: ColorPalettes (For Cartesian Matrix Drills)
CREATE TABLE ColorPalettes
(
    ColorID      INT PRIMARY KEY,
    ColorName    VARCHAR(30) NOT NULL
);

-- Table 7: SizeCatalog (For Cartesian Matrix Drills)
CREATE TABLE SizeCatalog
(
    SizeID       INT PRIMARY KEY,
    SizeCode     VARCHAR(10) NOT NULL
);

-- Seed Data
INSERT INTO RetailCustomers (CustomerID, CustomerName, City, Tier) VALUES
(1, 'Arjun Mehta',   'Mumbai',    'Platinum'),
(2, 'Kavita Rao',    'Pune',      'Gold'),
(3, 'Suresh Nair',   'Bangalore', 'Silver'),
(4, 'Deepa Iyer',    'Chennai',   'Gold'),
(5, 'Ananya Sen',    'Kolkata',   'Platinum'),
(6, 'Ravi Verma',    'Delhi',     'Silver'),
(7, 'Pooja Kulkarni','Pune',      'Bronze');

INSERT INTO RetailProducts (ProductID, ProductName, Category, UnitPrice) VALUES
(101, 'Mechanical Keyboard', 'Electronics', 4500.00),
(102, 'Wireless Mouse',     'Electronics', 1800.00),
(103, '4K Gaming Monitor',   'Electronics', 28000.00),
(104, 'Ergonomic Chair',     'Furniture',   14000.00),
(105, 'USB-C Docking Station','Electronics', 6500.00),
(106, 'Standing Desk',       'Furniture',   22000.00);

INSERT INTO RetailOrders (OrderID, CustomerID, ProductID, Quantity, OrderDate, Status) VALUES
(501, 1, 101, 2, '2024-01-15', 'Delivered'),
(502, 1, 103, 1, '2024-02-20', 'Delivered'),
(503, 2, 102, 3, '2024-05-12', 'Delivered'),
(504, 3, 104, 1, '2024-07-18', 'Delivered'),
(505, 4, 101, 1, '2024-08-25', 'Delivered'),
(506, 5, 103, 2, '2024-11-05', 'Delivered'),
(507, 1, 105, 1, '2025-01-10', 'Delivered'),
(508, 2, 106, 1, '2025-03-22', 'Shipped'),
(509, 3, 102, 5, '2025-09-14', 'Shipped'),
(510, 6, 105, 2, '2025-10-30', 'Processing');

INSERT INTO RetailShipments (ShipmentID, OrderID, Carrier, DeliveryDate) VALUES
(901, 501, 'BlueDart', '2024-01-18'),
(902, 502, 'DTDC',     '2024-02-24'),
(903, 503, 'FedEx',    '2024-05-16'),
(904, 504, 'BlueDart', '2024-07-22'),
(905, 505, 'Delhivery','2024-08-29'),
(906, 506, 'FedEx',    '2024-11-10'),
(907, 507, 'BlueDart', '2025-01-14');

INSERT INTO LeagueTeams (TeamID, TeamName, Conference) VALUES
(1, 'Mumbai Strikers',   'West'),
(2, 'Delhi Daredevils',  'North'),
(3, 'Chennai Titans',    'South'),
(4, 'Kolkata Dynamos',   'East');

INSERT INTO ColorPalettes (ColorID, ColorName) VALUES
(1, 'Matte Black'), (2, 'Alpine White'), (3, 'Space Gray');

INSERT INTO SizeCatalog (SizeID, SizeCode) VALUES
(1, 'S'), (2, 'M'), (3, 'L'), (4, 'XL');


-- ====================================================================================================
-- 🟢 SECTION 1: BASIC & CONCEPTUAL MULTI-TABLE JOINS (QUESTIONS 1 - 4)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 1: 3-TABLE BASIC PROJECTION & REVENUE
-- Write an ANSI SQL query joining `RetailCustomers`, `RetailOrders`, and `RetailProducts`.
-- Display CustomerName, City, ProductName, Category, Quantity, UnitPrice, and LineRevenue (Quantity * UnitPrice).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 2: 4-TABLE SHIPMENT AUDIT CHAIN
-- Write an ANSI SQL query chaining 4 tables: `RetailCustomers` -> `RetailOrders` -> `RetailProducts` -> `RetailShipments`.
-- Display CustomerName, OrderID, ProductName, Carrier, OrderDate, and DeliveryDate.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 3: ANSI CROSS JOIN SKU MATRIX
-- In retail analytics, generating all product variant combinations is critical.
-- Write a query using ANSI `CROSS JOIN` to generate all possible SKU combinations between `ColorPalettes` and `SizeCatalog`.
-- Display ColorName, SizeCode, and a generated SKU formatted as 'SKU-' + ColorName + '-' + SizeCode.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 4: NON-ANSI COMMA JOIN VS ANSI INNER JOIN PROOF
-- Write a query using legacy comma syntax to join `RetailCustomers` and `RetailOrders` for customers in 'Pune'.
-- Then write the equivalent standard ANSI SQL-92 query. Both must return CustomerName, City, OrderID, and OrderDate.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below (Legacy Comma Syntax):




-- Write your SQL Query below (ANSI Standard Syntax):




-- ====================================================================================================
-- 🟡 SECTION 2: INTERMEDIATE & PRACTICAL AGGREGATIONS (QUESTIONS 5 - 8)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 5: CUSTOMER TOTAL SPEND (LEFT JOIN VS INNER JOIN BEHAVIOR)
-- Write an ANSI SQL query to calculate Total Spend and Total Units Purchased for EVERY customer in `RetailCustomers`.
-- Ensure customers who have zero orders are included with Total Spend = 0.00 and Total Units = 0.
-- Sort the result by Total Spend descending.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 6: CATEGORY REVENUE BY CUSTOMER TIER
-- Write an ANSI SQL query joining Customers, Orders, and Products to calculate Total Revenue per Customer Tier and Product Category.
-- Display Tier, Category, OrderCount (COUNT(OrderID)), and TotalRevenue (SUM(Quantity * UnitPrice)).
-- Sort by Tier ASC and TotalRevenue DESC.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 7: TEMPORAL QUARTER FILTERING (Q1 & Q3 PERFORMANCE)
-- Write an ANSI SQL query joining Customers, Orders, and Products.
-- Filter orders placed strictly in Quarter 1 or Quarter 3 across all years.
-- Display CustomerName, ProductName, OrderDate, OrderYear (YEAR(OrderDate)), and OrderQuarter (DATEPART(qq, OrderDate)).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 8: FILTERED AGGREGATION WITH HAVING & WILDCARDS
-- Write a query to find all Customers whose name starts with 'A' or contains 'v', whose lifetime spend 
-- across Electronics category exceeds 10,000.00.
-- Display CustomerName, City, and ElectronicsSpend. Sort by ElectronicsSpend DESC.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ====================================================================================================
-- 🔴 SECTION 3: ADVANCED & BUSINESS SCENARIOS (QUESTIONS 9 - 12)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 9: TOURNAMENT ROUND-ROBIN HOME & AWAY MATRIX (CROSS JOIN)
-- Using `LeagueTeams`, generate a complete home-away tournament schedule where every team plays every other team twice.
-- Exclude teams playing against themselves.
-- Columns: HomeTeam, HomeConference, AwayTeam, AwayConference, MatchType ('Inter-Conference' if conferences differ, else 'Intra-Conference').
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 10: 4-WAY ORDER FULFILLMENT & DELIVERY LEAD TIME
-- Join `RetailCustomers`, `RetailOrders`, `RetailProducts`, and `RetailShipments`.
-- Calculate the Delivery Lead Time in days using `DATEDIFF(day, OrderDate, DeliveryDate)`.
-- Display CustomerName, OrderID, ProductName, Carrier, OrderDate, DeliveryDate, and LeadTimeDays.
-- Filter only for orders that have actually been delivered (DeliveryDate IS NOT NULL).
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 11: UNFULFILLED ORDERS ANTI-JOIN (ORDERS WITHOUT SHIPMENTS)
-- In supply chain engineering, detecting unfulfilled orders is critical.
-- Write an ANSI SQL query using `LEFT JOIN` between `RetailOrders`, `RetailCustomers`, and `RetailShipments` 
-- to identify all orders that have NOT yet been assigned a shipment record (`ShipmentID IS NULL`).
-- Display OrderID, CustomerName, OrderDate, and Status.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 12: PRODUCT SALES PENETRATION & ZERO-SALE CATALOG ITEMS
-- Write a query joining `RetailProducts`, `RetailOrders`, and `RetailCustomers` using appropriate outer joins 
-- to list ALL products in the catalog along with the number of unique customers who bought them (`COUNT(DISTINCT CustomerID)`),
-- and total units sold. Products with zero sales must appear with 0 customers and 0 units.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query below:




-- ====================================================================================================
-- 🔥 SECTION 4: TIER-1 INTERVIEW TRAPS & ARCHITECTURAL DRILLS (QUESTIONS 13 - 14)
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 13: THE MULTI-TABLE CARTESIAN MULTIPLICATION TRAP
-- Consider 3 tables: `A` has 5 rows, `B` has 4 rows, and `C` has 3 rows.
-- A junior engineer writes: `SELECT * FROM A, B, C WHERE A.id = B.a_id;`
-- (Notice that Table C has NO join predicate in the WHERE clause!)
-- (a) How many rows will this query return if the `A.id = B.a_id` join condition matches exactly 6 pairs?
-- (b) Write the correct ANSI SQL-92 query that prevents accidental Cartesian multiplication with Table C.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query / Mathematical Answer below:




-- ----------------------------------------------------------------------------------------------------
-- 📌 QUESTION 14: MULTI-TABLE AGGREGATE GRAIN DISTORTION (FAN-OUT TRAP)
-- When joining `RetailCustomers` (1 row per customer) to `RetailOrders` (many orders) and `RetailShipments` (multiple partial shipments),
-- performing `SUM(UnitPrice * Quantity)` can multiply revenue if an order has multiple shipments.
-- Explain in comments how the fan-out issue occurs and write a clean SQL query to calculate customer total revenue 
-- accurately at the Order grain before joining shipments.
-- ----------------------------------------------------------------------------------------------------
-- Write your SQL Query / Architectural Explanation below:



