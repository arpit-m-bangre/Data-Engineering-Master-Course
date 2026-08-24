-- ====================================================================================================
-- 🏢 ENTERPRISE DATA ENGINEERING PROJECT 07
-- 🎯 PROJECT TITLE: Customer Loyalty, Order Velocity & Automated Deduplication Pipeline
-- 📆 RELEASE DATE: 2026-08-24 (DAY 20 MILESTONE)
-- 🏢 MODULE: Enterprise SQL Relational Architecture & Analytic Query Engine
-- 🎯 TARGET ARCHITECTURE: Tier-1 Production Data Pipelines (Amazon / Flipkart / Swiggy Scale)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: DATABASE & WAREHOUSE SCHEMA SETUP
-- ====================================================================================================

IF OBJECT_ID('CustomerLoyaltyMart', 'U') IS NOT NULL DROP TABLE CustomerLoyaltyMart;
IF OBJECT_ID('RawTransactionStaging', 'U') IS NOT NULL DROP TABLE RawTransactionStaging;
IF OBJECT_ID('DimCustomer', 'U') IS NOT NULL DROP TABLE DimCustomer;
IF OBJECT_ID('DimLoyaltyTier', 'U') IS NOT NULL DROP TABLE DimLoyaltyTier;

-- 1. DimLoyaltyTier (Master Loyalty Rules)
CREATE TABLE DimLoyaltyTier
(
    TierID         INT PRIMARY KEY,
    TierName       VARCHAR(20) NOT NULL,
    MinSpend       DECIMAL(12,2) NOT NULL,
    DiscountRate   DECIMAL(4,2) NOT NULL
);

INSERT INTO DimLoyaltyTier (TierID, TierName, MinSpend, DiscountRate) VALUES
(1, 'Bronze', 0.00, 0.00),
(2, 'Silver', 25000.00, 0.05),
(3, 'Gold', 75000.00, 0.10),
(4, 'Platinum', 150000.00, 0.15);

-- 2. DimCustomer (Customer Dimension)
CREATE TABLE DimCustomer
(
    CustomerID   INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    City         VARCHAR(50) NOT NULL,
    SignupDate   DATE NOT NULL
);

INSERT INTO DimCustomer (CustomerID, CustomerName, City, SignupDate) VALUES
(101, 'Arpit Bangre', 'Bangalore', '2025-01-10'),
(102, 'Rohan Verma', 'Mumbai', '2025-02-15'),
(103, 'Sneha Iyer', 'Pune', '2025-03-01'),
(104, 'Ananya Sen', 'Delhi', '2025-04-12'),
(105, 'Karan Malhotra', 'Bangalore', '2025-05-20');

-- 3. RawTransactionStaging (Simulates High-Volume Kafka Ingestion with Duplicates & Anomaly Retries)
CREATE TABLE RawTransactionStaging
(
    StagingID     INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID VARCHAR(30) NOT NULL,
    CustomerID    INT NOT NULL,
    Category      VARCHAR(30) NOT NULL,
    Amount        DECIMAL(10,2) NOT NULL,
    TxnTimestamp  DATETIME NOT NULL
);

-- Seed staging table with clean events AND duplicate network ingestion retries
INSERT INTO RawTransactionStaging (TransactionID, CustomerID, Category, Amount, TxnTimestamp) VALUES
('TXN-9001', 101, 'Electronics', 45000.00, '2026-08-01 10:15:00'),
('TXN-9002', 101, 'Electronics', 35000.00, '2026-08-05 14:30:00'),
('TXN-9003', 101, 'Home & Living', 18000.00, '2026-08-10 16:45:00'),
('TXN-9001', 101, 'Electronics', 45000.00, '2026-08-01 10:15:00'), -- Duplicate Ingestion
('TXN-9004', 102, 'Fashion', 12000.00, '2026-08-02 11:20:00'),
('TXN-9005', 102, 'Electronics', 85000.00, '2026-08-18 19:10:00'),
('TXN-9004', 102, 'Fashion', 12000.00, '2026-08-02 11:20:00'), -- Duplicate Ingestion
('TXN-9004', 102, 'Fashion', 12000.00, '2026-08-02 11:20:00'), -- Duplicate Ingestion (Triplicate)
('TXN-9006', 103, 'Books', 4500.00, '2026-08-04 09:00:00'),
('TXN-9007', 103, 'Electronics', 62000.00, '2026-08-12 18:25:00'),
('TXN-9008', 103, 'Home & Living', 24000.00, '2026-08-22 21:00:00'),
('TXN-9009', 104, 'Fashion', 8500.00, '2026-08-08 13:15:00'),
('TXN-9010', 105, 'Electronics', 110000.00, '2026-08-15 15:45:00'),
('TXN-9011', 105, 'Electronics', 55000.00, '2026-08-24 17:30:00');

-- ====================================================================================================
-- 🧹 PHASE 1: AUTOMATED DATA CLEANSING & DEDUPLICATION ENGINE (CTE DELETE)
-- ====================================================================================================

-- 1.1 Inspect and Audit Duplicate Ingestion Rows
WITH StagingAuditCTE AS
(
    SELECT StagingID, TransactionID, CustomerID, Category, Amount, TxnTimestamp,
           ROW_NUMBER() OVER 
           (
               PARTITION BY TransactionID, CustomerID, Category, Amount, TxnTimestamp 
               ORDER BY StagingID
           ) AS DuplicateOccurrence
    FROM RawTransactionStaging
)
SELECT * 
FROM StagingAuditCTE 
WHERE DuplicateOccurrence > 1;

-- 1.2 Atomic Cleanse: Remove Duplicates In-Place
WITH StagingCleanserCTE AS
(
    SELECT StagingID, TransactionID, CustomerID, Category, Amount, TxnTimestamp,
           ROW_NUMBER() OVER 
           (
               PARTITION BY TransactionID, CustomerID, Category, Amount, TxnTimestamp 
               ORDER BY StagingID
           ) AS DuplicateOccurrence
    FROM RawTransactionStaging
)
DELETE FROM StagingCleanserCTE
WHERE DuplicateOccurrence > 1;

-- ====================================================================================================
-- 🚀 PHASE 2: ADVANCED ANALYTICAL CTE PIPELINES (CHAINED TRANSFORMATIONS)
-- ====================================================================================================

-- 2.1 Chained CTE: Calculate Customer Aggregates, Category Dominance & Recency
WITH CustomerSpendCTE AS
(
    -- CTE 1: Customer Total Spend and Transaction Count
    SELECT CustomerID,
           COUNT(TransactionID) AS TotalOrders,
           SUM(Amount) AS TotalSpend,
           MAX(TxnTimestamp) AS LatestOrderTime
    FROM RawTransactionStaging
    GROUP BY CustomerID
),
CustomerLoyaltyAssignmentCTE AS
(
    -- CTE 2: Map to Loyalty Tier based on Spend Boundaries
    SELECT CS.CustomerID, CS.TotalOrders, CS.TotalSpend, CS.LatestOrderTime,
           LT.TierName, LT.DiscountRate
    FROM CustomerSpendCTE CS
    CROSS JOIN DimLoyaltyTier LT
    WHERE CS.TotalSpend >= LT.MinSpend
      AND CS.TotalSpend < CASE 
                            WHEN LT.TierID = 4 THEN 999999999.00 
                            ELSE (SELECT MinSpend FROM DimLoyaltyTier WHERE TierID = LT.TierID + 1)
                          END
),
RankedLoyaltyCustomersCTE AS
(
    -- CTE 3: Rank Customers Within Each Loyalty Tier
    SELECT C.CustomerID, C.CustomerName, C.City,
           LA.TotalOrders, LA.TotalSpend, LA.TierName, LA.DiscountRate, LA.LatestOrderTime,
           DENSE_RANK() OVER (PARTITION BY LA.TierName ORDER BY LA.TotalSpend DESC) AS TierRank
    FROM CustomerLoyaltyAssignmentCTE LA
    INNER JOIN DimCustomer C ON LA.CustomerID = C.CustomerID
)
-- 2.2 Final Analytical Mart Output
SELECT CustomerID, CustomerName, City, TierName, TotalSpend, TotalOrders, TierRank, LatestOrderTime
FROM RankedLoyaltyCustomersCTE
ORDER BY TotalSpend DESC;

-- ====================================================================================================
-- 🎯 PROJECT VERIFICATION AUDIT
-- ====================================================================================================
-- Confirm 0 redundant staging records remain
SELECT COUNT(*) AS CleanRowCount FROM RawTransactionStaging;
