# 🏗️ PROJECT 1: End-to-End Enterprise E-Commerce ETL Pipeline (Amazon Case Study)
**Module:** 03_ETL_DATA_PIPELINES | **Status:** Production Architecture Blueprint

---

## 1. Executive Summary & Objective

This project designs and implements an enterprise-grade **4-Layer E-Commerce Data Pipeline** modeled after Amazon's retail operations. The system ingests raw transaction payloads, cleanses customer and product metadata, structures data into Medallion tiers (Bronze -> Silver -> Gold), and loads star schemas for executive revenue and inventory reporting.

---

## 2. Architecture & Medallion Pipeline Blueprint

```
+--------------------+
|  SOURCE APPLICATION|
|  - E-Commerce Orders
|  - Webhook Events  |
+---------+----------+
          |
          v
+---------+----------+
|  BRONZE TIER (Raw) |
|  - raw_orders_json |
|  - raw_events_log  |
+---------+----------+
          |
          v [Transform: Type Casting, Deduplication, Null Cleansing]
+---------+----------+
|  SILVER TIER       |
|  - clean_orders    |
|  - clean_customers |
|  - clean_products  |
+---------+----------+
          |
          v [Aggregate: Dimensional Star Schema & KPI Calculation]
+---------+----------+
|  GOLD TIER         |
|  - fact_daily_sales|
|  - dim_customer_ltv|
|  - dim_product_mrg |
+---------+----------+
          |
          v
+---------+----------+
|  BI & REPORTING    |
|  - Power BI Dash   |
|  - Executive KPIs  |
+--------------------+
```

---

## 3. Storage Schema Specifications

### 3.1 Bronze Landing Table
```sql
CREATE TABLE bronze_ecommerce_orders (
    RawIngestionID BIGINT IDENTITY(1,1) PRIMARY KEY,
    RawPayload NVARCHAR(MAX) NOT NULL,
    SourceSystem VARCHAR(50) NOT NULL,
    IngestedAtUTC DATETIME DEFAULT GETUTCDATE()
);
```

### 3.2 Silver Cleansed Table: `silver_ecommerce_orders`
```sql
CREATE TABLE silver_ecommerce_orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    OrderAmount DECIMAL(10,2) NOT NULL,
    OrderStatus VARCHAR(20) NOT NULL,
    OrderDate DATE NOT NULL,
    CreatedTimeUTC DATETIME NOT NULL,
    IngestedAt DATETIME DEFAULT GETDATE()
);
```

### 3.3 Gold Aggregated Table: `gold_fact_daily_sales`
```sql
CREATE TABLE gold_fact_daily_sales (
    DateKey INT PRIMARY KEY,
    TotalOrders INT NOT NULL,
    GrossRevenue DECIMAL(14,2) NOT NULL,
    NetRevenue DECIMAL(14,2) NOT NULL,
    ActiveBuyers INT NOT NULL,
    AverageOrderValue DECIMAL(10,2) NOT NULL
);
```

---

## 4. Production Transformation & Loading Logic

```sql
-- Silver Transformation: Cleansing & Deduplication
WITH DeduplicatedOrders AS (
    SELECT 
        TRY_CAST(JSON_VALUE(RawPayload, '$.order_id') AS INT) AS OrderID,
        TRY_CAST(JSON_VALUE(RawPayload, '$.customer_id') AS INT) AS CustomerID,
        TRY_CAST(JSON_VALUE(RawPayload, '$.product_id') AS INT) AS ProductID,
        TRY_CAST(JSON_VALUE(RawPayload, '$.amount') AS DECIMAL(10,2)) AS OrderAmount,
        COALESCE(JSON_VALUE(RawPayload, '$.status'), 'PENDING') AS OrderStatus,
        TRY_CAST(JSON_VALUE(RawPayload, '$.order_date') AS DATE) AS OrderDate,
        TRY_CAST(JSON_VALUE(RawPayload, '$.created_at') AS DATETIME) AS CreatedTimeUTC,
        ROW_NUMBER() OVER (
            PARTITION BY JSON_VALUE(RawPayload, '$.order_id') 
            ORDER BY IngestedAtUTC DESC
        ) AS RowRank
    FROM bronze_ecommerce_orders
)
INSERT INTO silver_ecommerce_orders (
    OrderID, CustomerID, ProductID, OrderAmount, OrderStatus, OrderDate, CreatedTimeUTC
)
SELECT 
    OrderID, CustomerID, ProductID, OrderAmount, OrderStatus, OrderDate, CreatedTimeUTC
FROM DeduplicatedOrders
WHERE RowRank = 1
  AND OrderID IS NOT NULL
  AND OrderAmount > 0;
```

---

## 5. Verification & Data Quality Assertions

- **Completeness**: `COUNT(OrderID) WHERE OrderID IS NULL = 0`.
- **Accuracy**: `GrossRevenue = NetRevenue + TotalDiscounts + TotalRefunds`.
- **Idempotency**: Running insertion pipeline twice does not increment row count.
