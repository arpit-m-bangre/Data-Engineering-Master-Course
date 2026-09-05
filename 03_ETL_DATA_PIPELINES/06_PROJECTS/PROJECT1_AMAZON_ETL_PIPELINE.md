# 🏗️ PROJECT 1: End-to-End Enterprise E-Commerce ETL Pipeline (Amazon Case Study)
**Module:** 03_ETL_DATA_PIPELINES | **Status:** Active Project Blueprint

---

## 1. Executive Project Summary

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

### Silver Table: `clean_orders`
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

### Gold Table: `fact_daily_sales`
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
