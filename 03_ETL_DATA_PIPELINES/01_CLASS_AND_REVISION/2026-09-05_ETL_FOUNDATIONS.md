# 🚀 ETL Day 01: Foundations, 4-Layer Architecture & Medallion Design
**Module:** 03_ETL_DATA_PIPELINES | **Date:** 05 September 2026 | **Type:** High-Yield Class Note & 7-Step Revision

---

## 1. Executive Summary & Core Mental Models

An **ETL Pipeline** (Extract, Transform, Load) is the automated data transport and transformation backbone of data engineering. It extracts raw data from production OLTP applications, transforms and cleanses it in a staging area, and loads it into analytical data warehouses for executive business intelligence.

### 🌟 Real-Life Analogies
1. **The Modern Water Purification Plant (ETL Pipeline)**:
   - **Extract (Pumping Raw River Water)**: Ingesting messy, unvalidated raw data from various source streams (OLTP databases, APIs, IoT sensors).
   - **Transform (Filtration, Boiling & Mineral Addition)**: Removing impurities, filtering duplicate rows, standardizing formats, and adding calculated business metrics.
   - **Load (Bottling & Distribution)**: Filling sealed, clean mineral water bottles (Fact and Dimension tables) and stocking them for customer consumption (Power BI / Tableau reports).
2. **The Telecom 12:00 AM Postpaid Call Cutoff (Batch Processing Paradigm)**:
   - In early telecom networks, computing power was constrained. Networks ran huge nightly batch ETL jobs at midnight (12:00 AM) to aggregate millions of call detail records (CDRs) and compute taxes. If a call crossed midnight, legacy batch boundaries would drop or miscalculate it. Modern streaming pipelines (Kafka, Flink) solve this with continuous event processing.

---

## 2. Technical Vocabulary & Definitions

| Term | Simple Meaning | Real-World Context |
| :--- | :--- | :--- |
| **ETL** | Extract, Transform, Load | Traditional pipeline where data is transformed before loading into target storage. |
| **ELT** | Extract, Load, Transform | Modern cloud pipeline where raw data lands in cloud warehouse first, transformed via SQL. |
| **OLTP** | Online Transaction Processing | Fast row-based transactional databases (e.g. Postgres, MySQL, SQL Server). |
| **OLAP** | Online Analytical Processing | Columnar analytical databases built for large-scale aggregation (e.g. Snowflake, Redshift). |
| **Bronze Layer** | Raw, immutable landing zone | Exact copy of source data preserved for auditing and reprocessing. |
| **Silver Layer** | Cleansed & validated zone | Deduplicated, filtered, and conformed relational entities. |
| **Gold Layer** | Curated business metrics zone | High-speed aggregated star schemas and dimensional data marts. |
| **Idempotency** | Reproducible execution guarantee | Running a pipeline N times produces the exact same result without duplicate rows. |
| **Change Data Capture (CDC)** | Delta record streaming | Capturing only inserted, updated, or deleted rows from transaction logs instead of full dumps. |

---

## 3. The 4-Layer Enterprise Data Architecture

```
[ Layer 1: SOURCE TIER ]
  • OLTP App Databases (PostgreSQL / SQL Server)
  • Payment Webhooks (Stripe / PayPal JSON APIs)
  • Clickstream & Sensor Logs (Kafka Topics)
         │
         ▼
[ Layer 2: STAGING & TRANSFORMATION TIER ]
  • Schema Validation & Null Imputation
  • Deduplication & UTC Timezone Normalization
  • Referential Integrity & Customer-Order Joins
         │
         ▼
[ Layer 3: ENTERPRISE DATA WAREHOUSE (EDW) TIER ]
  • Fact Tables: FactOrders, FactPayments, FactUsage
  • Dimension Tables: DimCustomers, DimProducts, DimDates
  • Star Schema & Snowflake Schema Modeling
         │
         ▼
[ Layer 4: REPORTING & BI SERVING TIER ]
  • Executive Dashboards (Power BI, Tableau, Looker)
  • Automated Revenue & Inventory Replenishment Alerts
  • Downstream Machine Learning Feature Stores
```

---

## 4. Medallion Lakehouse Sub-Layer Architecture

```
+---------------+---------------------+--------------------+--------------------+
| Attribute     | Bronze (Raw)        | Silver (Cleaned)   | Gold (Curated)     |
+---------------+---------------------+--------------------+--------------------+
| Data Quality  | Raw / Dirty         | Cleansed & Validated| Highly Aggregated |
| Schema State  | Schema-on-Read      | Strictly Enforced  | Star / Snowflake   |
| Primary Users | Data Engineers      | Analysts / ML Eng  | Business / C-Suite |
| Volume        | Full Raw History    | Filtered Entities  | Compact Aggregates |
| Latency       | Seconds / Minutes   | Hourly Batches     | Daily / Live Marts |
+---------------+---------------------+--------------------+--------------------+
```

---

## 5. Practical Code Blueprint: Silver Layer Cleansing Pipeline

```sql
-- Silver Transformation: Cleansing Raw Ingested E-Commerce Orders
WITH CleanedOrders AS (
    SELECT 
        CAST(raw_payload:order_id AS INT) AS OrderID,
        CAST(raw_payload:customer_id AS INT) AS CustomerID,
        TRIM(UPPER(CAST(raw_payload:customer_name AS VARCHAR(100)))) AS CustomerName,
        TRY_CAST(raw_payload:order_amount AS DECIMAL(10,2)) AS OrderAmount,
        COALESCE(CAST(raw_payload:order_status AS VARCHAR(20)), 'PENDING') AS OrderStatus,
        TRY_CAST(raw_payload:transaction_time AS DATETIME) AS TransactionTimeUTC,
        ROW_NUMBER() OVER (
            PARTITION BY CAST(raw_payload:order_id AS INT) 
            ORDER BY TRY_CAST(raw_payload:transaction_time AS DATETIME) DESC
        ) AS DeduplicationRank
    FROM bronze_ecommerce_orders
)
SELECT 
    OrderID,
    CustomerID,
    CustomerName,
    OrderAmount,
    OrderStatus,
    TransactionTimeUTC
FROM CleanedOrders
WHERE DeduplicationRank = 1
  AND OrderAmount > 0;
```

---

## 6. 10 Critical Pipeline Bug Traps & Tier-1 Interview Scenarios

1. **Transforming Inside Production OLTP Databases**:
   - *Trap*: Running heavy aggregation queries (`GROUP BY`, `JOIN` 10M rows) on the live checkout database, crashing production for users.
   - *Fix*: Extract raw deltas to staging first; perform transformations on dedicated compute clusters.
2. **Schema Drift**:
   - *Trap*: Source application changes a column data type unexpectedly, crashing downstream ingestion.
   - *Fix*: Use schema-on-read in Bronze and defensive type casting (`TRY_CAST`) in Silver.
3. **Missing Pipeline Idempotency**:
   - *Trap*: If a job fails at 85% and retries, it inserts duplicate records.
   - *Fix*: Use `MERGE` / `UPSERT` statements or atomic date-partition overwrites.
4. **Timezone Mixing**:
   - *Trap*: Aggregating transactions from London, Mumbai, and New York without converting to UTC.
   - *Fix*: Normalize all timestamps to UTC in the Silver layer.
5. **Full Table Scans for Daily Deltas**:
   - *Trap*: Reading 500 million historical rows every night to find 10,000 new rows.
   - *Fix*: Implement Change Data Capture (CDC) or timestamp watermarking.
6. **Hardcoded Credentials**:
   - *Trap*: Storing database passwords in plain text in ETL scripts.
   - *Fix*: Integrate cloud secret managers (AWS Secrets Manager, Azure Key Vault).
7. **Silent Data Corruption**:
   - *Trap*: Null values propagating through arithmetic formulas, zeroing out financial totals.
   - *Fix*: Apply `COALESCE` / `ISNULL` defaults before mathematical transformations.
8. **Late-Arriving Data**:
   - *Trap*: Offline mobile apps uploading Monday records on Thursday, causing missing revenue reports.
   - *Fix*: Implement event-time processing windows and re-aggregation watermarks.
9. **No Data Quality Assertions**:
   - *Trap*: Source API sends 0 rows due to an outage, pipeline exits successfully, and dashboards display blank graphs.
   - *Fix*: Add row count anomaly checks and fail-fast alerting.
10. **Granular Rows in Gold Layer**:
    - *Trap*: Storing raw un-aggregated transactional rows in Gold, destroying dashboard load speeds.
    - *Fix*: Keep Gold strictly for aggregated star schemas and executive summary marts.

---

## 7. Self-Assessment Flashcards

- **Q1: What is the difference between ETL and ELT?**
  - *Answer*: ETL transforms data before writing to target storage; ELT loads raw data into cloud warehouses first and leverages warehouse compute for transformations.
- **Q2: Which Medallion tier stores raw, immutable source data?**
  - *Answer*: The Bronze Layer.
- **Q3: What are the 4 tiers of enterprise data architecture?**
  - *Answer*: 1. Source Tier, 2. Staging/Transformation Tier, 3. EDW Tier, 4. Reporting/BI Tier.
- **Q4: Why must ETL pipelines be idempotent?**
  - *Answer*: So that network retries or job restarts never create duplicate records or corrupt data.
