-- ====================================================================================================
-- 🏢 ENTERPRISE DATA ENGINEERING PROJECT 08
-- 🎯 PROJECT TITLE: Stored Procedure Deduplication, Analytical Views & High-Performance Indexing Engine
-- 📆 RELEASE DATE: 2026-09-04 (DAY 27 MILESTONE)
-- 🏢 MODULE: Enterprise SQL Relational Architecture & Analytic Query Engine
-- 🎯 TARGET ARCHITECTURE: Tier-1 Production Data Lakehouse / Warehouse Staging (Uber / FinTech Scale)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: DATABASE & WAREHOUSE SCHEMA SETUP
-- ====================================================================================================

IF OBJECT_ID('dbo.vw_CustomerAnalytics', 'V') IS NOT NULL DROP VIEW dbo.vw_CustomerAnalytics;
IF OBJECT_ID('dbo.usp_IngestAndDeduplicateOrders', 'P') IS NOT NULL DROP PROCEDURE dbo.usp_IngestAndDeduplicateOrders;
IF OBJECT_ID('dbo.CleanOrdersWarehouse', 'U') IS NOT NULL DROP TABLE dbo.CleanOrdersWarehouse;
IF OBJECT_ID('dbo.RawOrderStaging', 'U') IS NOT NULL DROP TABLE dbo.RawOrderStaging;
IF OBJECT_ID('dbo.DimCustomer', 'U') IS NOT NULL DROP TABLE dbo.DimCustomer;
IF OBJECT_ID('dbo.DimMerchant', 'U') IS NOT NULL DROP TABLE dbo.DimMerchant;

-- 1. DimMerchant (Merchant Master Dimension)
CREATE TABLE dbo.DimMerchant
(
    MerchantID   INT PRIMARY KEY,
    MerchantName VARCHAR(100) NOT NULL,
    Category     VARCHAR(50)  NOT NULL,
    City         VARCHAR(50)  NOT NULL
);

INSERT INTO dbo.DimMerchant (MerchantID, MerchantName, Category, City) VALUES
(1, 'Cloud Services Ltd', 'Cloud Tech',   'Bangalore'),
(2, 'Retail SuperMart',   'E-Commerce',   'Mumbai'),
(3, 'FinTech Payments',   'Banking Tech', 'Pune'),
(4, 'AI Compute Hub',     'AI/ML',        'Hyderabad');

-- 2. DimCustomer (Customer Master Dimension)
CREATE TABLE dbo.DimCustomer
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email        VARCHAR(100) NOT NULL,
    City         VARCHAR(50)  NOT NULL,
    Tier         VARCHAR(20)  NOT NULL
);

INSERT INTO dbo.DimCustomer (CustomerID, CustomerName, Email, City, Tier) VALUES
(101, 'Arpit Bangre',  'arpit@datamaster.io', 'Nagpur',    'Enterprise'),
(102, 'Rahul Sharma',  'rahul@fintech.io',    'Mumbai',    'Corporate'),
(103, 'Priya Kulkarni','priya@cloudops.ai',   'Pune',      'Retail'),
(104, 'Amit Verma',    'amit@quant.io',       'Bangalore', 'Corporate'),
(105, 'Sneha Patel',   'sneha@neural.ai',     'Hyderabad', 'Enterprise');

-- 3. RawOrderStaging (Simulates High-Volume Streaming Ingestion with Duplicate Network Retries)
CREATE TABLE dbo.RawOrderStaging
(
    StagingID     INT IDENTITY(1,1),
    OrderID       VARCHAR(50),
    CustomerID    INT,
    MerchantID    INT,
    OrderAmount   DECIMAL(12,2),
    PaymentStatus VARCHAR(20),
    OrderDate     DATETIME
);

-- Seed raw staging table with clean records and simulated network duplicate retries
INSERT INTO dbo.RawOrderStaging (OrderID, CustomerID, MerchantID, OrderAmount, PaymentStatus, OrderDate) VALUES
('ORD-1001', 101, 1, 45000.00, 'COMPLETED', '2026-09-01 10:30:00'),
('ORD-1002', 102, 2, 12500.00, 'COMPLETED', '2026-09-01 11:15:00'),
('ORD-1003', 103, 3,  8200.00, 'PENDING',   '2026-09-02 09:45:00'),
('ORD-1004', 101, 4, 85000.00, 'COMPLETED', '2026-09-02 14:20:00'),
-- Duplicate network retries for ORD-1001
('ORD-1001', 101, 1, 45000.00, 'COMPLETED', '2026-09-01 10:30:00'),
-- Duplicate network retries for ORD-1002 (x2)
('ORD-1002', 102, 2, 12500.00, 'COMPLETED', '2026-09-01 11:15:00'),
('ORD-1002', 102, 2, 12500.00, 'COMPLETED', '2026-09-01 11:15:00'),
('ORD-1005', 105, 1, 92000.00, 'COMPLETED', '2026-09-03 16:00:00');

-- 4. CleanOrdersWarehouse (Target Production Enterprise Fact Table)
CREATE TABLE dbo.CleanOrdersWarehouse
(
    OrderSK       INT IDENTITY(1,1) PRIMARY KEY,
    OrderID       VARCHAR(50)   NOT NULL,
    CustomerID    INT           NOT NULL,
    MerchantID    INT           NOT NULL,
    OrderAmount   DECIMAL(12,2) NOT NULL,
    PaymentStatus VARCHAR(20)   NOT NULL,
    OrderDate     DATETIME      NOT NULL,
    IngestedAt    DATETIME      NOT NULL DEFAULT GETDATE()
);

-- ====================================================================================================
-- ⚡ PHASE 1: HIGH-PERFORMANCE INDEXING ARCHITECTURE
-- ====================================================================================================

-- 1. Non-Clustered Index on Foreign Key References for Join Optimization
CREATE NONCLUSTERED INDEX idx_CleanOrders_CustomerID
ON dbo.CleanOrdersWarehouse (CustomerID);

CREATE NONCLUSTERED INDEX idx_CleanOrders_MerchantID
ON dbo.CleanOrdersWarehouse (MerchantID);

-- 2. Composite Non-Clustered Index on Analytical Filter Predicates (Status + Date)
CREATE NONCLUSTERED INDEX idx_CleanOrders_Status_Date
ON dbo.CleanOrdersWarehouse (PaymentStatus, OrderDate DESC)
INCLUDE (OrderAmount);

-- ====================================================================================================
-- 🚀 PHASE 2: AUTOMATED INGESTION & DEDUPLICATION STORED PROCEDURE
-- ====================================================================================================

GO
CREATE PROCEDURE dbo.usp_IngestAndDeduplicateOrders
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Step 1: Extract Unique Records using CTE & ROW_NUMBER()
        WITH CTE_DeduplicatedStaging AS
        (
            SELECT OrderID, CustomerID, MerchantID, OrderAmount, PaymentStatus, OrderDate,
                   ROW_NUMBER() OVER
                   (
                       PARTITION BY OrderID, CustomerID, MerchantID, OrderAmount, PaymentStatus, OrderDate
                       ORDER BY OrderDate ASC
                   ) AS row_occurrence
            FROM dbo.RawOrderStaging
        )
        INSERT INTO dbo.CleanOrdersWarehouse (OrderID, CustomerID, MerchantID, OrderAmount, PaymentStatus, OrderDate)
        SELECT OrderID, CustomerID, MerchantID, OrderAmount, PaymentStatus, OrderDate
        FROM CTE_DeduplicatedStaging
        WHERE row_occurrence = 1;

        -- Step 2: Clear Staging Table after successful load
        TRUNCATE TABLE dbo.RawOrderStaging;

        COMMIT TRANSACTION;
        PRINT '>> Ingestion & Deduplication Pipeline Executed Successfully. All valid rows loaded.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- Execute Ingestion & Deduplication Stored Procedure
EXECUTE dbo.usp_IngestAndDeduplicateOrders;
GO

-- ====================================================================================================
-- 📊 PHASE 3: ENTERPRISE ANALYTICAL VIEWS LAYER
-- ====================================================================================================

CREATE VIEW dbo.vw_CustomerAnalytics
AS
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.City AS CustomerCity,
    c.Tier AS CustomerTier,
    COUNT(o.OrderSK) AS TotalOrdersPlaced,
    ISNULL(SUM(o.OrderAmount), 0.00) AS LifetimeSpend,
    ISNULL(AVG(o.OrderAmount), 0.00) AS AverageOrderValue,
    MAX(o.OrderDate) AS LastOrderDate,
    CASE 
        WHEN SUM(o.OrderAmount) >= 100000.00 THEN 'Platinum VIP'
        WHEN SUM(o.OrderAmount) >= 50000.00  THEN 'Gold Elite'
        WHEN SUM(o.OrderAmount) >= 10000.00  THEN 'Silver Preferred'
        ELSE 'Standard'
    END AS SpendCategory
FROM dbo.DimCustomer c
LEFT JOIN dbo.CleanOrdersWarehouse o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Email, c.City, c.Tier;
GO

-- ====================================================================================================
-- 🔍 PHASE 4: PRODUCTION VERIFICATION & AUDIT QUERIES
-- ====================================================================================================

-- 1. Inspect Clustered and Non-Clustered Indexes on Fact Table
EXECUTE sp_helpindex 'dbo.CleanOrdersWarehouse';

-- 2. Query Analytics View for High-Value Spenders
SELECT CustomerID, CustomerName, CustomerCity, TotalOrdersPlaced, LifetimeSpend, SpendCategory
FROM dbo.vw_CustomerAnalytics
WHERE SpendCategory IN ('Platinum VIP', 'Gold Elite')
ORDER BY LifetimeSpend DESC;

-- 3. Verify Zero Duplicates Loaded in Warehouse
SELECT OrderID, COUNT(*) AS DuplicateCount
FROM dbo.CleanOrdersWarehouse
GROUP BY OrderID
HAVING COUNT(*) > 1;
GO
