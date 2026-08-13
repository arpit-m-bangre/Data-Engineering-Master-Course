/* ============================================================
               DATA ENGINEERING PROJECT 5 (PROJECT5.SQL)
               TITLE: RETAIL SUPPLY CHAIN & REFERENTIAL INTEGRITY PIPELINE
               TOPICS COVERED: DAYS 1 - 11 (CUMULATIVE MASTER PROJECT)
               (Full End-to-End Pipeline, Multi-Tier Relational Architecture,
                FOREIGN KEY Constraints, Parent vs Child Destruction Rules,
                DELETE/TRUNCATE/DROP Referential Integrity Testing)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
An International Retail Supply Chain Enterprise requires a 3-tier 
relational data warehouse linking Global Suppliers (Tier 1 Parent), 
Inventory Products (Tier 2 Child/Parent), and Line Items (Tier 3 Child).
You must build the relational architecture, enforce Foreign Key constraints,
test referential integrity protections, build end-to-end analytical pipelines,
and design a safe bottom-up schema teardown script.
=============================================================== */

-- ============================================================
-- 2. 3-TIER RELATIONAL SCHEMA CREATION
-- ============================================================

-- Task 1: Tier 1 Parent Table - 'SuppliersMaster'
CREATE TABLE SuppliersMaster
(
    SupplierID   INT PRIMARY KEY IDENTITY(100, 1),
    SupplierName VARCHAR(40) NOT NULL,
    Country      VARCHAR(20) DEFAULT 'India',
    Rating       INT CHECK (Rating BETWEEN 1 AND 5)
);

-- Task 2: Tier 2 Relational Table - 'ProductsMaster' (Child to Suppliers, Parent to LineItems)
CREATE TABLE ProductsMaster
(
    ProductID    INT PRIMARY KEY IDENTITY(500, 1),
    ProductName  VARCHAR(40) NOT NULL,
    SupplierID   INT FOREIGN KEY REFERENCES SuppliersMaster(SupplierID), -- Foreign Key Reference
    Category     VARCHAR(25),
    UnitPrice    INT CHECK (UnitPrice > 0)
);

-- Task 3: Tier 3 Child Table - 'OrderLineItems' (Child to Products)
CREATE TABLE OrderLineItems
(
    LineItemID   INT PRIMARY KEY IDENTITY(1000, 1),
    ProductID    INT FOREIGN KEY REFERENCES ProductsMaster(ProductID),   -- Foreign Key Reference
    Quantity     INT CHECK (Quantity > 0),
    LineTotal    INT
);


-- ============================================================
-- 3. RELATIONAL INGESTION & DATA POPULATION
-- ============================================================

-- Populate Suppliers (Tier 1)
INSERT INTO SuppliersMaster (SupplierName, Country, Rating) VALUES ('TechAsia Imports', 'India', 5);
INSERT INTO SuppliersMaster (SupplierName, Country, Rating) VALUES ('Nordic Freight', 'Nepal', 4);
INSERT INTO SuppliersMaster (SupplierName, Country, Rating) VALUES ('Global Apex', 'India', 3);
INSERT INTO SuppliersMaster (SupplierName, Country, Rating) VALUES ('Unreferenced Supplier', 'India', 2); -- ID 103 (No products)

-- Populate Products (Tier 2)
INSERT INTO ProductsMaster (ProductName, SupplierID, Category, UnitPrice) VALUES ('Monitors 4K', 100, 'Electronics', 25000);
INSERT INTO ProductsMaster (ProductName, SupplierID, Category, UnitPrice) VALUES ('Wireless Keyboards', 100, 'Electronics', 1500);
INSERT INTO ProductsMaster (ProductName, SupplierID, Category, UnitPrice) VALUES ('Industrial Cables', 101, 'Hardware', 800);

-- Populate Order Line Items (Tier 3)
INSERT INTO OrderLineItems (ProductID, Quantity, LineTotal) VALUES (500, 2, 50000);
INSERT INTO OrderLineItems (ProductID, Quantity, LineTotal) VALUES (501, 10, 15000);


-- ============================================================
-- 4. REFERENTIAL INTEGRITY TESTING & ERROR VERIFICATION
-- ============================================================

-- Task 4 [Foreign Key Insertion Violation Test]:
-- Write an INSERT attempting to add a product referencing non-existent SupplierID = 999 and observe FK error.
-- Write your SQL Query below (keep commented after testing):
/*
INSERT INTO ProductsMaster (ProductName, SupplierID, Category, UnitPrice) VALUES ('Invalid Prod', 999, 'Hardware', 500);
-- Error: The INSERT statement conflicted with the FOREIGN KEY constraint "FK__ProductsM__Suppl...".
*/


-- Task 5 [DELETE Testing - Unreferenced vs Referenced Parent Rows]:
-- 1. Execute DELETE on unreferenced SupplierID = 103 (Succeeds).
DELETE FROM SuppliersMaster WHERE SupplierID = 103;

-- 2. Execute DELETE on referenced SupplierID = 100 (Fails).
/*
DELETE FROM SuppliersMaster WHERE SupplierID = 100;
-- Error: The DELETE statement conflicted with the REFERENCE constraint "FK__ProductsM__Suppl...".
*/


-- Task 6 [TRUNCATE & DROP Boundary Tests on Parent Tables]:
-- Write comments explaining why TRUNCATE TABLE SuppliersMaster and DROP TABLE SuppliersMaster fail even if child rows are cleared, and document the required bottom-up teardown order.
/*
EXPLANATION & TEARDOWN ORDER:
- TRUNCATE checks schema metadata references and is blocked whenever a Foreign Key references the table.
- DROP TABLE fails until referencing child tables are removed first.

SAFE 3-STEP TEARDOWN ORDER:
Step 1: DROP TABLE OrderLineItems; -- Drop Tier 3 Child First
Step 2: DROP TABLE ProductsMaster;  -- Drop Tier 2 Child/Parent Second
Step 3: DROP TABLE SuppliersMaster; -- Drop Tier 1 Parent Last
*/


-- ============================================================
-- 5. MASTER END-TO-END ANALYTICAL PIPELINE QUERY
-- ============================================================

-- Task 7 [Master Pipeline Query]:
-- Write a multi-clause query on SuppliersMaster returning Country, COUNT(SupplierID) AS TotalSuppliers, AVG(Rating * 1.0) AS AvgRating.
-- Filter rows WHERE Rating >= 3 in WHERE clause.
-- Group by Country.
-- Filter groups HAVING COUNT(SupplierID) >= 1.
-- Sort output by AvgRating DESCENDING.
-- Write your SQL Query below:




/* ============================================================
                    END OF PROJECT 5
   ============================================================ */
