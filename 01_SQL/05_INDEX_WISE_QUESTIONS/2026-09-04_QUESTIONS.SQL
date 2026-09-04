-- ====================================================================================================
-- 🎯 INDEX-WISE PRACTICE DRILLS (14 TARGETED QUESTIONS)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 TOPIC DATE: 04 SEPTEMBER 2026 (Day 27)
-- 🎯 TOPIC: Stored Procedures (Deduplication), Views (Virtual vs Materialized) & Indexing Mechanics
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP TEST ENVIRONMENT & DATASETS
-- ====================================================================================================

IF OBJECT_ID('dbo.CustomerTransactions', 'U') IS NOT NULL DROP TABLE dbo.CustomerTransactions;
IF OBJECT_ID('dbo.ProductsCatalog', 'U') IS NOT NULL DROP TABLE dbo.ProductsCatalog;
IF OBJECT_ID('dbo.HeapOrders', 'U') IS NOT NULL DROP TABLE dbo.HeapOrders;
IF OBJECT_ID('dbo.ClusteredOrders', 'U') IS NOT NULL DROP TABLE dbo.ClusteredOrders;

CREATE TABLE dbo.CustomerTransactions
(
    TransactionID INT,
    CustomerID    INT,
    CustomerName  VARCHAR(50),
    City          VARCHAR(50),
    Amount        DECIMAL(10,2),
    PaymentMode   VARCHAR(20),
    TxnDate       DATE
);

INSERT INTO dbo.CustomerTransactions (TransactionID, CustomerID, CustomerName, City, Amount, PaymentMode, TxnDate)
VALUES
(1, 101, 'Arpit Bangre', 'Nagpur', 2500.00, 'UPI',    '2026-09-01'),
(2, 102, 'Rahul Sharma', 'Mumbai', 4500.00, 'Card',   '2026-09-01'),
(3, 103, 'Priya Mehta',  'Pune',   1800.00, 'UPI',    '2026-09-02'),
-- Duplicate txn record 1
(1, 101, 'Arpit Bangre', 'Nagpur', 2500.00, 'UPI',    '2026-09-01'),
-- Duplicate txn record 2
(2, 102, 'Rahul Sharma', 'Mumbai', 4500.00, 'Card',   '2026-09-01'),
(2, 102, 'Rahul Sharma', 'Mumbai', 4500.00, 'Card',   '2026-09-01'),
(4, 104, 'Sneha Patel',  'Delhi',  6200.00, 'NetBank','2026-09-03');

CREATE TABLE dbo.ProductsCatalog
(
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category    VARCHAR(50)  NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL,
    StockQty    INT          NOT NULL
);

INSERT INTO dbo.ProductsCatalog (ProductID, ProductName, Category, UnitPrice, StockQty)
VALUES
(1, 'Enterprise SQL Server', 'Software', 1500.00, 50),
(2, 'Cloud Data Lakehouse',  'Cloud',    3200.00, 20),
(3, 'PySpark Cluster Node',  'Compute',  2800.00, 15),
(4, 'Airflow Orchestrator',  'DevOps',    950.00, 40),
(5, 'Power BI Gateway',      'BI',        450.00, 100);

CREATE TABLE dbo.HeapOrders
(
    OrderID INT,
    Details VARCHAR(50)
);

CREATE TABLE dbo.ClusteredOrders
(
    OrderID INT PRIMARY KEY,
    Details VARCHAR(50)
);

-- ====================================================================================================
-- 📝 14 TARGETED PRACTICE QUESTIONS
-- ====================================================================================================

-- ----------------------------------------------------------------------------------------------------
-- QUESTION 1: BASIC STORED PROCEDURE FOR FULL ROW DEDUPLICATION
-- Category: Stored Procedures & Deduplication
-- Task: Create a stored procedure `usp_GetDuplicateTransactions` that uses a CTE and ROW_NUMBER()
-- partitioned across all transaction columns to return all rows where row_occurrence > 1.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 2: PARAMETERIZED STORED PROCEDURE FOR FILTERING DUPLICATE THRESHOLD
-- Category: Parameterized Stored Procedures
-- Task: Create a stored procedure `usp_GetDuplicatesByMinCount` that accepts an integer parameter `@MinOccurrence INT`
-- and returns rows whose row occurrence count exceeds `@MinOccurrence`.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 3: MODIFYING STORED PROCEDURE TO INCLUDE ROW OCCURRENCE COUNT
-- Category: Procedure Maintenance
-- Task: Use ALTER PROCEDURE to update `usp_GetDuplicateTransactions` so that it returns the computed `row_occurrence`
-- column along with all original table attributes, ordered by CustomerID.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 4: EXECUTING STORED PROCEDURES WITH PARAMETERS
-- Category: Procedure Invocation
-- Task: Write T-SQL statements to execute `usp_GetDuplicateTransactions`, and execute `usp_GetDuplicatesByMinCount`
-- with parameter value 2.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 5: CREATING A STANDARD VIRTUAL VIEW FOR HIGH-VALUE TRANSACTIONS
-- Category: Views & Abstraction
-- Task: Create a view named `vw_HighValueTransactions` that exposes CustomerID, CustomerName, City, Amount,
-- and a computed column `SpendTier` ('Tier 1' when Amount >= 4000, else 'Tier 2').
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 6: QUERYING AND FILTERING VIRTUAL VIEWS
-- Category: View Querying
-- Task: Query `vw_HighValueTransactions` to display only customers from 'Mumbai' or 'Delhi' who belong to 'Tier 1'.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 7: MODIFYING VIEW DEFINITION VIA ALTER VIEW
-- Category: View Alteration
-- Task: Use ALTER VIEW to update `vw_HighValueTransactions` to include `PaymentMode` and `TxnDate`,
-- handling NULL payment modes by outputting 'Unknown'.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 8: CREATING A SINGLE-COLUMN NON-CLUSTERED INDEX
-- Category: Non-Clustered Indexes
-- Task: Create a non-clustered index named `idx_CustTxn_CustomerID` on `dbo.CustomerTransactions(CustomerID)`.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 9: CREATING A COMPOSITE NON-CLUSTERED INDEX
-- Category: Composite Indexes
-- Task: Create a composite non-clustered index named `idx_Products_Category_Price` on
-- `dbo.ProductsCatalog(Category, UnitPrice DESC)`.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 10: AUDITING INDEX METADATA VIA SP_HELPINDEX
-- Category: System Metadata Auditing
-- Task: Execute `sp_helpindex` on both `dbo.CustomerTransactions` and `dbo.ProductsCatalog` to inspect their index definitions.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 11: DEMONSTRATING PHYSICAL HEAP STORAGE VS CLUSTERED INDEX ORDERING
-- Category: Clustered Index Mechanics
-- Task: Insert unordered values (5, 2, 8, 1, 9) into both `dbo.HeapOrders` and `dbo.ClusteredOrders`.
-- Query both tables with simple SELECT * without ORDER BY and document the physical sort discrepancy.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 12: RETROFITTING CLUSTERED INDEX ON A HEAP TABLE
-- Category: Index Retrofitting
-- Task: Create a clustered index named `cdx_HeapOrders_OrderID` on `dbo.HeapOrders(OrderID)`.
-- Query `dbo.HeapOrders` again to observe the physical data page reorganization.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 13: DROPPING NON-CLUSTERED INDEXES SAFELY
-- Category: Index Lifecycle Management
-- Task: Write T-SQL code to drop the non-clustered index `idx_CustTxn_CustomerID` on table `dbo.CustomerTransactions`.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ----------------------------------------------------------------------------------------------------
-- QUESTION 14: ENTERPRISE AUDIT & EXPLAIN PLAN SCENARIO
-- Category: Tier-1 Production Architectural Analysis
-- Task: Explain in a structured comment why a Stored Procedure provides faster execution than an ad-hoc SQL query,
-- and why a table can have at most ONE Clustered Index but up to 999 Non-Clustered Indexes.
-- ----------------------------------------------------------------------------------------------------

-- Write your SQL Query below:






-- ====================================================================================================
