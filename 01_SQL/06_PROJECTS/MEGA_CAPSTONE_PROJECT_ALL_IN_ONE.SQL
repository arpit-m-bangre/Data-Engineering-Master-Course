-- ====================================================================================================
-- 🏢 ENTERPRISE SQL MASTER MEGA CAPSTONE PROJECT (ALL-IN-ONE)
-- 🎯 TITLE: Global Multi-Domain FinTech & E-Commerce Lakehouse Ingestion, Analytics & Audit Engine
-- 📅 MILESTONE: Consolidates Full 28-Day SQL Relational Engineering Syllabus
-- 👨‍💻 ARCHITECT: Arpit Manoj Bangre (Cap) | Lead AI Co-Pilot: Pippo
-- 🎯 TARGET ARCHITECTURE: Tier-1 Production Relational OLTP/OLAP Staging & Warehousing Engine
-- ====================================================================================================

-- ====================================================================================================
-- 📋 SYLLABUS DOMAINS CONSOLIDATED IN THIS ARCHITECTURE:
-- 1. DDL & DML Schema Engineering (CREATE, ALTER, DROP, TRUNCATE, UPDATE, DELETE)
-- 2. Declarative Integrity & Retrofitting (PK, UNIQUE, CHECK, DEFAULT, IDENTITY, FK Referential Integrity)
-- 3. High-Performance Filtering & String Functions (LIKE, CHARINDEX, SUBSTRING, LEN, REPLACE, TRIM)
-- 4. Advanced Date & Time Arithmetic (DATEADD, DATEDIFF, DATEPART, FORMAT, CAST/CONVERT)
-- 5. Multi-Table Relational Joins & Set Ops (INNER, LEFT, RIGHT, FULL, CROSS, SELF JOIN, UNION ALL)
-- 6. Analytical Aggregations & Conditional Logic (GROUP BY, HAVING, CASE WHEN Expressions)
-- 7. Advanced Window Functions (ROW_NUMBER, RANK, DENSE_RANK, LEAD, LAG, Running SUM/AVG OVER Partition)
-- 8. Common Table Expressions (CTEs) & Production Deduplication Pipelines
-- 9. ACID Transactions & Error Handling (BEGIN TRANSACTION, COMMIT, ROLLBACK, TRY...CATCH)
-- 10. Stored Procedures & Business Rule Automation (Dynamic Parameters, Idempotent Processing)
-- 11. Materialized Reporting Views & Performance Query Layer
-- 12. Enterprise Physical Indexing Architecture (Clustered Index vs Non-Clustered Covering Indexes)
-- 13. Automated Audit & Compliance Triggers (AFTER INSERT/UPDATE/DELETE Change Data Capture)
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: CLEAN SLATE ENVIRONMENT TEARDOWN (IDEMPOTENT RESET)
-- ====================================================================================================

IF OBJECT_ID('dbo.trg_AuditWalletChanges', 'TR') IS NOT NULL DROP TRIGGER dbo.trg_AuditWalletChanges;
IF OBJECT_ID('dbo.vw_ExecutiveCustomerRevenueLeaderboard', 'V') IS NOT NULL DROP VIEW dbo.vw_ExecutiveCustomerRevenueLeaderboard;
IF OBJECT_ID('dbo.vw_DailyMerchantSettlementSummary', 'V') IS NOT NULL DROP VIEW dbo.vw_DailyMerchantSettlementSummary;
IF OBJECT_ID('dbo.usp_IngestAndProcessStreamingOrders', 'P') IS NOT NULL DROP PROCEDURE dbo.usp_IngestAndProcessStreamingOrders;
IF OBJECT_ID('dbo.usp_ProcessWalletFundTransfer', 'P') IS NOT NULL DROP PROCEDURE dbo.usp_ProcessWalletFundTransfer;

IF OBJECT_ID('dbo.AuditTransactionLogs', 'U') IS NOT NULL DROP TABLE dbo.AuditTransactionLogs;
IF OBJECT_ID('dbo.FactOrderSettlements', 'U') IS NOT NULL DROP TABLE dbo.FactOrderSettlements;
IF OBJECT_ID('dbo.FactOrdersWarehouse', 'U') IS NOT NULL DROP TABLE dbo.FactOrdersWarehouse;
IF OBJECT_ID('dbo.RawOrderStreamingStaging', 'U') IS NOT NULL DROP TABLE dbo.RawOrderStreamingStaging;
IF OBJECT_ID('dbo.DimCustomerWallets', 'U') IS NOT NULL DROP TABLE dbo.DimCustomerWallets;
IF OBJECT_ID('dbo.DimProducts', 'U') IS NOT NULL DROP TABLE dbo.DimProducts;
IF OBJECT_ID('dbo.DimMerchants', 'U') IS NOT NULL DROP TABLE dbo.DimMerchants;
IF OBJECT_ID('dbo.DimCustomers', 'U') IS NOT NULL DROP TABLE dbo.DimCustomers;

PRINT '>> [PHASE 0]: Environment cleaned and ready for Mega Capstone Deployment.';
GO

-- ====================================================================================================
-- 🏗️ PHASE 1: CORE DIMENSIONAL SCHEMA & DECLARATIVE CONSTRAINTS
-- ====================================================================================================

-- 1. DimCustomers (Customer Dimension with Identity, PK, Unique Email & Check Constraints)
CREATE TABLE dbo.DimCustomers
(
    CustomerID       INT IDENTITY(1001, 1) CONSTRAINT PK_DimCustomers PRIMARY KEY,
    CustomerUUID     UNIQUEIDENTIFIER DEFAULT NEWID(),
    FullName         VARCHAR(100) NOT NULL,
    Email            VARCHAR(150) NOT NULL CONSTRAINT UQ_DimCustomers_Email UNIQUE,
    PhoneNumber      VARCHAR(20) NULL,
    CustomerTier     VARCHAR(20) DEFAULT 'Standard' CONSTRAINT CK_DimCustomers_Tier CHECK (CustomerTier IN ('Standard', 'Silver', 'Gold', 'Platinum')),
    City             VARCHAR(50) NOT NULL,
    State            VARCHAR(50) NOT NULL,
    PostalCode       VARCHAR(15) NOT NULL,
    RegistrationDate DATETIME2(0) DEFAULT SYSDATETIME(),
    IsActive         BIT DEFAULT 1
);

-- 2. DimMerchants (Merchant Dimension with Self-Referencing Hierarchy for Parent Enterprises)
CREATE TABLE dbo.DimMerchants
(
    MerchantID       INT IDENTITY(501, 1) CONSTRAINT PK_DimMerchants PRIMARY KEY,
    MerchantName     VARCHAR(120) NOT NULL,
    MerchantCategory VARCHAR(50) NOT NULL CONSTRAINT CK_DimMerchants_Category CHECK (MerchantCategory IN ('Electronics', 'Cloud Services', 'FinTech', 'Healthcare', 'Retail')),
    CommissionRate   DECIMAL(5, 4) DEFAULT 0.0250 CONSTRAINT CK_DimMerchants_Rate CHECK (CommissionRate BETWEEN 0.0000 AND 0.3000),
    ParentMerchantID INT NULL CONSTRAINT FK_DimMerchants_Parent FOREIGN KEY REFERENCES dbo.DimMerchants(MerchantID),
    City             VARCHAR(50) NOT NULL,
    Country          VARCHAR(50) DEFAULT 'India',
    CreatedAt        DATETIME2(0) DEFAULT SYSDATETIME()
);

-- 3. DimProducts (Product Catalog with Price Checks and Default Stock)
CREATE TABLE dbo.DimProducts
(
    ProductID       INT IDENTITY(2001, 1) CONSTRAINT PK_DimProducts PRIMARY KEY,
    MerchantID      INT NOT NULL CONSTRAINT FK_DimProducts_Merchant FOREIGN KEY REFERENCES dbo.DimMerchants(MerchantID) ON DELETE CASCADE,
    ProductName     VARCHAR(150) NOT NULL,
    ProductCategory VARCHAR(50) NOT NULL,
    UnitPrice       DECIMAL(12, 2) NOT NULL CONSTRAINT CK_DimProducts_Price CHECK (UnitPrice > 0),
    StockQuantity   INT DEFAULT 0 CONSTRAINT CK_DimProducts_Stock CHECK (StockQuantity >= 0),
    IsDiscontinued  BIT DEFAULT 0,
    CreatedAt       DATETIME2(0) DEFAULT SYSDATETIME()
);

-- 4. DimCustomerWallets (Customer Digital Balance with Non-Negative Balance Check)
CREATE TABLE dbo.DimCustomerWallets
(
    WalletID       INT IDENTITY(3001, 1) CONSTRAINT PK_DimCustomerWallets PRIMARY KEY,
    CustomerID     INT NOT NULL CONSTRAINT FK_DimCustomerWallets_Customer FOREIGN KEY REFERENCES dbo.DimCustomers(CustomerID),
    WalletCurrency VARCHAR(5) DEFAULT 'INR' CONSTRAINT CK_DimCustomerWallets_Currency CHECK (WalletCurrency IN ('INR', 'USD', 'EUR', 'GBP')),
    CurrentBalance DECIMAL(14, 2) DEFAULT 0.00 CONSTRAINT CK_DimCustomerWallets_Balance CHECK (CurrentBalance >= 0.00),
    LastUpdated    DATETIME2(0) DEFAULT SYSDATETIME()
);

-- 5. AuditTransactionLogs (Change Data Capture & Audit Trail)
CREATE TABLE dbo.AuditTransactionLogs
(
    AuditID        INT IDENTITY(1, 1) CONSTRAINT PK_AuditTransactionLogs PRIMARY KEY,
    WalletID       INT NOT NULL,
    CustomerID     INT NOT NULL,
    ActionType     VARCHAR(20) NOT NULL,
    OldBalance     DECIMAL(14, 2) NOT NULL,
    NewBalance     DECIMAL(14, 2) NOT NULL,
    AmountChanged  DECIMAL(14, 2) NOT NULL,
    ChangedBy      VARCHAR(100) DEFAULT SYSTEM_USER,
    AuditTimestamp DATETIME2(3) DEFAULT SYSDATETIME()
);

PRINT '>> [PHASE 1]: Core dimensional models, constraints and audit architecture created successfully.';
GO

-- ====================================================================================================
-- ⚡ PHASE 2: AUDIT TRIGGER CREATION (CHANGE DATA CAPTURE ON WALLETS)
-- ====================================================================================================

CREATE TRIGGER dbo.trg_AuditWalletChanges
ON dbo.DimCustomerWallets
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.AuditTransactionLogs (WalletID, CustomerID, ActionType, OldBalance, NewBalance, AmountChanged, ChangedBy, AuditTimestamp)
    SELECT
        i.WalletID,
        i.CustomerID,
        CASE
            WHEN i.CurrentBalance > d.CurrentBalance THEN 'WALLET_CREDIT'
            WHEN i.CurrentBalance < d.CurrentBalance THEN 'WALLET_DEBIT'
            ELSE 'NO_CHANGE'
        END AS ActionType,
        d.CurrentBalance AS OldBalance,
        i.CurrentBalance AS NewBalance,
        ABS(i.CurrentBalance - d.CurrentBalance) AS AmountChanged,
        SYSTEM_USER,
        SYSDATETIME()
    FROM inserted i
    INNER JOIN deleted d ON i.WalletID = d.WalletID
    WHERE i.CurrentBalance <> d.CurrentBalance;
END;
GO

PRINT '>> [PHASE 2]: Automated Wallet Balance Audit Trigger deployed.';
GO

-- ====================================================================================================
-- 📥 PHASE 3: SEEDING MASTER DATA (INGESTION & HIERARCHY SETUP)
-- ====================================================================================================

-- 1. Seed Parent & Subsidiary Merchants
INSERT INTO dbo.DimMerchants (MerchantName, MerchantCategory, CommissionRate, ParentMerchantID, City, Country) VALUES
('Reliance Global Conglomerate', 'Retail', 0.0150, NULL, 'Mumbai', 'India'),             -- MerchantID: 501
('Jio Cloud Platform',          'Cloud Services', 0.0200, 501,  'Navi Mumbai', 'India'),    -- MerchantID: 502
('Reliance Digital TechMart',    'Electronics',    0.0300, 501,  'Mumbai', 'India'),         -- MerchantID: 503
('HDFC Payments Hub',           'FinTech',        0.0100, NULL, 'Mumbai', 'India'),         -- MerchantID: 504
('Tata Consumer Ventures',       'Retail',         0.0220, NULL, 'Pune', 'India'),           -- MerchantID: 505
('Apollo Health System',        'Healthcare',     0.0180, NULL, 'Hyderabad', 'India');      -- MerchantID: 506

-- 2. Seed Customers
INSERT INTO dbo.DimCustomers (FullName, Email, PhoneNumber, CustomerTier, City, State, PostalCode) VALUES
('Arpit Manoj Bangre', 'arpit.bangre@enterprise.io', '+91-9876543210', 'Platinum', 'Nagpur',    'Maharashtra', '440001'),
('Rahul Sharma',       'rahul.sharma@fintech.com',   '+91-9823456789', 'Gold',     'Mumbai',    'Maharashtra', '400001'),
('Priya Kulkarni',     'priya.kulkarni@cloud.io',    '+91-9765432109', 'Silver',   'Pune',      'Maharashtra', '411001'),
('Amit Verma',         'amit.verma@quantfund.org',   '+91-9654321098', 'Platinum', 'Bangalore', 'Karnataka',   '560001'),
('Sneha Patel',        'sneha.patel@datascience.in', '+91-9543210987', 'Standard', 'Hyderabad', 'Telangana',   '500001'),
('Vikram Malhotra',    'vikram.m@investments.co',    '+91-9432109876', 'Gold',     'Delhi',     'Delhi',       '110001');

-- 3. Seed Digital Wallets
INSERT INTO dbo.DimCustomerWallets (CustomerID, WalletCurrency, CurrentBalance) VALUES
(1001, 'INR', 250000.00),
(1002, 'INR', 85000.00),
(1003, 'INR', 45000.00),
(1004, 'INR', 190000.00),
(1005, 'INR', 15000.00),
(1006, 'INR', 60000.00);

-- 4. Seed Product Catalog
INSERT INTO dbo.DimProducts (MerchantID, ProductName, ProductCategory, UnitPrice, StockQuantity) VALUES
(503, 'Ultra-Wide Curved Gaming Monitor', 'Electronics',    45000.00, 50),
(503, 'Mechanical Wireless Keyboard',     'Electronics',     7500.00, 120),
(502, 'Enterprise Cloud GPU Instance',    'Cloud Services', 35000.00, 500),
(502, 'Serverless Lakehouse Storage 10TB','Cloud Services', 12000.00, 1000),
(505, 'Organic Himalayan Tea Box',        'Retail',          1200.00, 300),
(506, 'Comprehensive Health Body Checkup','Healthcare',      4999.00, 200);

PRINT '>> [PHASE 3]: Master Dimensional Data, Wallets, and Products Seeded.';
GO

-- ====================================================================================================
-- 📦 PHASE 4: STAGING, FACT TABLES & INDEXING ARCHITECTURE
-- ====================================================================================================

-- 1. RawOrderStreamingStaging (Simulates High-Volume Kafka Ingestion with Duplicates & Raw Dirty Strings)
CREATE TABLE dbo.RawOrderStreamingStaging
(
    StagingID        INT IDENTITY(1,1) PRIMARY KEY,
    RawTransactionID VARCHAR(60),
    CustomerEmail    VARCHAR(150),
    MerchantID       INT,
    ProductID        INT,
    Quantity         INT,
    RawUnitPrice     VARCHAR(50),
    PaymentMode      VARCHAR(30),
    RawTimestamp     VARCHAR(50),
    IngestionBatchID VARCHAR(50)
);

-- 2. FactOrdersWarehouse (Cleansed, Normalized & Partitioned Relational Fact Table)
CREATE TABLE dbo.FactOrdersWarehouse
(
    OrderWarehouseID   BIGINT IDENTITY(100001, 1) CONSTRAINT PK_FactOrdersWarehouse PRIMARY KEY,
    TransactionUUID    VARCHAR(60) NOT NULL CONSTRAINT UQ_FactOrders_TxUUID UNIQUE,
    CustomerID         INT NOT NULL CONSTRAINT FK_FactOrders_Customer FOREIGN KEY REFERENCES dbo.DimCustomers(CustomerID),
    MerchantID         INT NOT NULL CONSTRAINT FK_FactOrders_Merchant FOREIGN KEY REFERENCES dbo.DimMerchants(MerchantID),
    ProductID          INT NOT NULL CONSTRAINT FK_FactOrders_Product FOREIGN KEY REFERENCES dbo.DimProducts(ProductID),
    Quantity           INT NOT NULL CONSTRAINT CK_FactOrders_Qty CHECK (Quantity > 0),
    UnitPrice          DECIMAL(12, 2) NOT NULL,
    GrossAmount        AS (Quantity * UnitPrice) PERSISTED,
    DiscountPercent    DECIMAL(5, 2) DEFAULT 0.00,
    DiscountAmount     AS ((Quantity * UnitPrice) * (DiscountPercent / 100.00)) PERSISTED,
    NetAmount          AS ((Quantity * UnitPrice) - ((Quantity * UnitPrice) * (DiscountPercent / 100.00))) PERSISTED,
    MerchantCommission AS (((Quantity * UnitPrice) - ((Quantity * UnitPrice) * (DiscountPercent / 100.00))) * 0.0250) PERSISTED,
    PaymentMode        VARCHAR(30) NOT NULL,
    OrderStatus        VARCHAR(20) DEFAULT 'Completed' CONSTRAINT CK_FactOrders_Status CHECK (OrderStatus IN ('Pending', 'Completed', 'Refunded', 'Cancelled')),
    OrderDate          DATETIME2(0) NOT NULL,
    ProcessedAt        DATETIME2(0) DEFAULT SYSDATETIME()
);

-- 3. FactOrderSettlements (Financial Ledger for Daily Merchant Payouts)
CREATE TABLE dbo.FactOrderSettlements
(
    SettlementID      BIGINT IDENTITY(1, 1) CONSTRAINT PK_FactOrderSettlements PRIMARY KEY,
    OrderWarehouseID  BIGINT NOT NULL CONSTRAINT FK_Settlement_Order FOREIGN KEY REFERENCES dbo.FactOrdersWarehouse(OrderWarehouseID),
    MerchantID        INT NOT NULL,
    GrossSettlement   DECIMAL(14, 2) NOT NULL,
    CommissionFee     DECIMAL(14, 2) NOT NULL,
    NetMerchantPayout DECIMAL(14, 2) NOT NULL,
    SettlementStatus  VARCHAR(20) DEFAULT 'Settled' CONSTRAINT CK_Settlement_Status CHECK (SettlementStatus IN ('Settled', 'OnHold', 'Disputed')),
    SettlementDate    DATE NOT NULL
);

-- Physical Non-Clustered Indexes for High-Speed Query Performance
CREATE NONCLUSTERED INDEX IX_FactOrders_CustomerID_OrderDate 
ON dbo.FactOrdersWarehouse(CustomerID, OrderDate)
INCLUDE (NetAmount, OrderStatus);

CREATE NONCLUSTERED INDEX IX_FactOrders_MerchantID_OrderDate 
ON dbo.FactOrdersWarehouse(MerchantID, OrderDate)
INCLUDE (NetAmount, MerchantCommission);

CREATE NONCLUSTERED INDEX IX_FactOrders_Product_Date 
ON dbo.FactOrdersWarehouse(ProductID, OrderDate);

PRINT '>> [PHASE 4]: Staging, Fact Tables, Constraints and Physical Non-Clustered Indexes Created.';
GO

-- ====================================================================================================
-- ⚙️ PHASE 5: STORED PROCEDURES (ACID TRANSACTIONS, CTE DEDUPLICATION & ETL PIPELINE)
-- ====================================================================================================

-- Stored Procedure 1: Idempotent Ingestion, String Cleansing, CTE Deduplication & Warehouse Load
CREATE PROCEDURE dbo.usp_IngestAndProcessStreamingOrders
    @BatchID VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        PRINT '>> Starting Processing for Ingestion Batch: ' + @BatchID;

        -- Step A: Deduplicate Raw Staging Events using CTE & ROW_NUMBER Window Function
        ;WITH DeduplicatedStaging AS
        (
            SELECT
                LTRIM(RTRIM(RawTransactionID)) AS CleanTxID,
                LTRIM(RTRIM(LOWER(CustomerEmail))) AS CleanEmail,
                MerchantID,
                ProductID,
                CASE 
                    WHEN Quantity <= 0 THEN 1 
                    ELSE Quantity 
                END AS CleanQty,
                CAST(REPLACE(REPLACE(RawUnitPrice, '$', ''), ',', '') AS DECIMAL(12,2)) AS CleanUnitPrice,
                UPPER(LTRIM(RTRIM(PaymentMode))) AS CleanPaymentMode,
                TRY_CAST(RawTimestamp AS DATETIME2(0)) AS CleanOrderTimestamp,
                ROW_NUMBER() OVER 
                (
                    PARTITION BY LTRIM(RTRIM(RawTransactionID)) 
                    ORDER BY TRY_CAST(RawTimestamp AS DATETIME2(0)) DESC, StagingID DESC
                ) AS DuplicateRank
            FROM dbo.RawOrderStreamingStaging
            WHERE IngestionBatchID = @BatchID
        )
        -- Step B: Insert Unique, Cleaned Records into FactOrdersWarehouse
        INSERT INTO dbo.FactOrdersWarehouse 
        (
            TransactionUUID,
            CustomerID,
            MerchantID,
            ProductID,
            Quantity,
            UnitPrice,
            DiscountPercent,
            PaymentMode,
            OrderStatus,
            OrderDate
        )
        SELECT
            ds.CleanTxID,
            c.CustomerID,
            ds.MerchantID,
            ds.ProductID,
            ds.CleanQty,
            ds.CleanUnitPrice,
            CASE 
                WHEN c.CustomerTier = 'Platinum' THEN 10.00
                WHEN c.CustomerTier = 'Gold'     THEN 5.00
                ELSE 0.00
            END AS DiscountPercent,
            ds.CleanPaymentMode,
            'Completed' AS OrderStatus,
            ISNULL(ds.CleanOrderTimestamp, SYSDATETIME()) AS OrderDate
        FROM DeduplicatedStaging ds
        INNER JOIN dbo.DimCustomers c ON ds.CleanEmail = LOWER(c.Email)
        WHERE ds.DuplicateRank = 1
          AND NOT EXISTS (
              SELECT 1 FROM dbo.FactOrdersWarehouse fow 
              WHERE fow.TransactionUUID = ds.CleanTxID
          );

        -- Step C: Generate Daily Merchant Financial Settlement Records
        INSERT INTO dbo.FactOrderSettlements
        (
            OrderWarehouseID,
            MerchantID,
            GrossSettlement,
            CommissionFee,
            NetMerchantPayout,
            SettlementStatus,
            SettlementDate
        )
        SELECT
            fow.OrderWarehouseID,
            fow.MerchantID,
            fow.NetAmount,
            fow.MerchantCommission,
            (fow.NetAmount - fow.MerchantCommission),
            'Settled',
            CAST(fow.OrderDate AS DATE)
        FROM dbo.FactOrdersWarehouse fow
        WHERE NOT EXISTS (
            SELECT 1 FROM dbo.FactOrderSettlements fos 
            WHERE fos.OrderWarehouseID = fow.OrderWarehouseID
        );

        COMMIT TRANSACTION;
        PRINT '>> Ingestion & Settlement Pipeline Completed Successfully for Batch: ' + @BatchID;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        PRINT '>> [PIPELINE ERROR]: ' + @ErrorMessage;
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO

-- Stored Procedure 2: ACID Fund Transfer Engine between Customer Wallets
CREATE PROCEDURE dbo.usp_ProcessWalletFundTransfer
    @SenderCustomerID    INT,
    @ReceiverCustomerID  INT,
    @TransferAmount      DECIMAL(14, 2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF @TransferAmount <= 0.00
    BEGIN
        RAISERROR('Transfer amount must be strictly greater than zero.', 16, 1);
        RETURN;
    END;

    IF @SenderCustomerID = @ReceiverCustomerID
    BEGIN
        RAISERROR('Sender and receiver cannot be the identical customer.', 16, 1);
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check Sender Sufficient Balance with Row-Level Locking
        DECLARE @SenderBalance DECIMAL(14,2);
        SELECT @SenderBalance = CurrentBalance
        FROM dbo.DimCustomerWallets WITH (UPDLOCK, ROWLOCK)
        WHERE CustomerID = @SenderCustomerID;

        IF @SenderBalance IS NULL
        BEGIN
            RAISERROR('Sender wallet does not exist.', 16, 1);
        END;

        IF @SenderBalance < @TransferAmount
        BEGIN
            RAISERROR('Insufficient wallet balance for transfer.', 16, 1);
        END;

        -- 1. Debit Sender Wallet
        UPDATE dbo.DimCustomerWallets
        SET CurrentBalance = CurrentBalance - @TransferAmount,
            LastUpdated = SYSDATETIME()
        WHERE CustomerID = @SenderCustomerID;

        -- 2. Credit Receiver Wallet
        UPDATE dbo.DimCustomerWallets
        SET CurrentBalance = CurrentBalance + @TransferAmount,
            LastUpdated = SYSDATETIME()
        WHERE CustomerID = @ReceiverCustomerID;

        COMMIT TRANSACTION;
        PRINT '>> Wallet Fund Transfer of INR ' + CAST(@TransferAmount AS VARCHAR(20)) + ' Completed Successfully.';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END;
GO

PRINT '>> [PHASE 5]: Stored Procedures usp_IngestAndProcessStreamingOrders and usp_ProcessWalletFundTransfer compiled.';
GO

-- ====================================================================================================
-- 🧪 PHASE 6: PIPELINE EXECUTION & STREAMING INGESTION TEST
-- ====================================================================================================

-- 1. Ingest Dirty & Duplicate Streaming Records into Staging
INSERT INTO dbo.RawOrderStreamingStaging (RawTransactionID, CustomerEmail, MerchantID, ProductID, Quantity, RawUnitPrice, PaymentMode, RawTimestamp, IngestionBatchID) VALUES
('TXN-2026-001', 'arpit.bangre@enterprise.io', 503, 2001, 2, '45,000.00', 'UPI',         '2026-09-01 10:15:00', 'BATCH_SEP_01'),
('TXN-2026-001', 'arpit.bangre@enterprise.io', 503, 2001, 2, '45,000.00', 'UPI',         '2026-09-01 10:15:05', 'BATCH_SEP_01'), -- Duplicate Network Retry
('TXN-2026-002', 'rahul.sharma@fintech.com',   502, 2003, 3, '$35,000.00', 'CREDIT_CARD', '2026-09-01 11:30:00', 'BATCH_SEP_01'),
('TXN-2026-003', 'priya.kulkarni@cloud.io',    505, 2005, 5, '1200',        'NET_BANKING', '2026-09-01 14:00:00', 'BATCH_SEP_01'),
('TXN-2026-004', 'amit.verma@quantfund.org',   502, 2004, 1, '12,000.00',   'UPI',         '2026-09-02 09:45:00', 'BATCH_SEP_02'),
('TXN-2026-005', 'sneha.patel@datascience.in', 506, 2006, 1, '4,999.00',    'DEBIT_CARD',  '2026-09-02 16:20:00', 'BATCH_SEP_02'),
('TXN-2026-006', 'vikram.m@investments.co',    503, 2002, 4, '$7,500.00',   'CREDIT_CARD', '2026-09-03 18:00:00', 'BATCH_SEP_03'),
('TXN-2026-007', 'arpit.bangre@enterprise.io', 502, 2003, 2, '35,000.00',   'UPI',         '2026-09-04 12:10:00', 'BATCH_SEP_04');

-- 2. Execute Stored Procedure for Ingestion Batches
EXEC dbo.usp_IngestAndProcessStreamingOrders @BatchID = 'BATCH_SEP_01';
EXEC dbo.usp_IngestAndProcessStreamingOrders @BatchID = 'BATCH_SEP_02';
EXEC dbo.usp_IngestAndProcessStreamingOrders @BatchID = 'BATCH_SEP_03';
EXEC dbo.usp_IngestAndProcessStreamingOrders @BatchID = 'BATCH_SEP_04';

-- 3. Execute Wallet Transfer Test (ACID & Trigger Verification)
EXEC dbo.usp_ProcessWalletFundTransfer @SenderCustomerID = 1001, @ReceiverCustomerID = 1002, @TransferAmount = 25000.00;

PRINT '>> [PHASE 6]: Pipeline Staged Data Ingested, Deduplicated, Warehoused and Settled.';
GO

-- ====================================================================================================
-- 📊 PHASE 7: ENTERPRISE ANALYTICAL VIEWS & EXECUTIVE REPORTING LAYER
-- ====================================================================================================

-- 1. View: Executive Customer Revenue & Tier Performance Leaderboard
CREATE VIEW dbo.vw_ExecutiveCustomerRevenueLeaderboard
AS
SELECT
    c.CustomerID,
    c.FullName AS CustomerName,
    c.CustomerTier,
    c.City AS CustomerCity,
    COUNT(fow.OrderWarehouseID) AS TotalOrdersPlaced,
    SUM(fow.Quantity) AS TotalUnitsPurchased,
    SUM(fow.GrossAmount) AS TotalGrossSpend,
    SUM(fow.DiscountAmount) AS TotalDiscountSaved,
    SUM(fow.NetAmount) AS TotalNetRevenueGenerated,
    DENSE_RANK() OVER (ORDER BY SUM(fow.NetAmount) DESC) AS RevenueRank,
    ROUND(SUM(fow.NetAmount) * 100.0 / SUM(SUM(fow.NetAmount)) OVER (), 2) AS PercentageOfTotalCompanyRevenue
FROM dbo.DimCustomers c
INNER JOIN dbo.FactOrdersWarehouse fow ON c.CustomerID = fow.CustomerID
GROUP BY c.CustomerID, c.FullName, c.CustomerTier, c.City;
GO

-- 2. View: Merchant Settlement & Commission Analytics
CREATE VIEW dbo.vw_DailyMerchantSettlementSummary
AS
SELECT
    m.MerchantID,
    m.MerchantName,
    m.MerchantCategory,
    m.City AS MerchantCity,
    COUNT(fow.OrderWarehouseID) AS TotalSettledTransactions,
    SUM(fow.NetAmount) AS GrossOrderValue,
    SUM(fow.MerchantCommission) AS PlatformCommissionEarned,
    SUM(fow.NetAmount - fow.MerchantCommission) AS NetMerchantPayoutDisbursed
FROM dbo.DimMerchants m
INNER JOIN dbo.FactOrdersWarehouse fow ON m.MerchantID = fow.MerchantID
GROUP BY m.MerchantID, m.MerchantName, m.MerchantCategory, m.City;
GO

PRINT '>> [PHASE 7]: Analytical Views Created.';
GO

-- ====================================================================================================
-- 📈 PHASE 8: COMPREHENSIVE ADVANCED SQL ANALYTICAL DRILLS (ALL 28 TOPICS IN ACTION)
-- ====================================================================================================

PRINT '=== [QUERY 1: HIERARCHICAL SELF-JOIN FOR PARENT & SUBSIDIARY MERCHANTS] ===';
SELECT
    sub.MerchantID AS SubsidiaryID,
    sub.MerchantName AS SubsidiaryName,
    sub.MerchantCategory,
    ISNULL(parent.MerchantName, 'TOP-LEVEL ENTERPRISE PARENT') AS HoldingCompanyName
FROM dbo.DimMerchants sub
LEFT JOIN dbo.DimMerchants parent ON sub.ParentMerchantID = parent.MerchantID;

PRINT '=== [QUERY 2: TIME-SERIES WINDOW FUNCTIONS (RUNNING TOTALS, LEAD/LAG & GROWTH)] ===';
SELECT
    fow.OrderWarehouseID,
    fow.TransactionUUID,
    c.FullName AS CustomerName,
    CAST(fow.OrderDate AS DATE) AS OrderDate,
    fow.NetAmount,
    -- Running Cumulative Spend per Customer
    SUM(fow.NetAmount) OVER (
        PARTITION BY fow.CustomerID 
        ORDER BY fow.OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CumulativeCustomerSpend,
    -- Previous Transaction Amount (LAG)
    LAG(fow.NetAmount, 1, 0.00) OVER (
        PARTITION BY fow.CustomerID 
        ORDER BY fow.OrderDate
    ) AS PreviousOrderAmount,
    -- Delta vs Previous Transaction
    (fow.NetAmount - LAG(fow.NetAmount, 1, fow.NetAmount) OVER (
        PARTITION BY fow.CustomerID 
        ORDER BY fow.OrderDate
    )) AS OrderGrowthDelta
FROM dbo.FactOrdersWarehouse fow
INNER JOIN dbo.DimCustomers c ON fow.CustomerID = c.CustomerID;

PRINT '=== [QUERY 3: CHANGE DATA CAPTURE AUDIT TRAIL LOGS] ===';
SELECT
    AuditID,
    WalletID,
    CustomerID,
    ActionType,
    OldBalance,
    NewBalance,
    AmountChanged,
    ChangedBy,
    AuditTimestamp
FROM dbo.AuditTransactionLogs
ORDER BY AuditTimestamp DESC;

PRINT '=== [QUERY 4: EXECUTIVE REVENUE LEADERBOARD VIEW OUTPUT] ===';
SELECT * FROM dbo.vw_ExecutiveCustomerRevenueLeaderboard;

PRINT '=== [QUERY 5: MERCHANT SETTLEMENT SUMMARY VIEW OUTPUT] ===';
SELECT * FROM dbo.vw_DailyMerchantSettlementSummary;

-- ====================================================================================================
-- 🏁 END OF MEGA CAPSTONE PROJECT (ALL 28 SQL TOPICS CONSOLIDATED & AUDITED)
-- ====================================================================================================
