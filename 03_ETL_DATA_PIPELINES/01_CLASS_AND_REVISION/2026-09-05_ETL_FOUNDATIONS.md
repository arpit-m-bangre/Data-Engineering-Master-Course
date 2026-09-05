# 🚀 ETL Day 01: Foundations, 4-Layer Architecture & Medallion Design
**Module:** 03_ETL_DATA_PIPELINES | **Date:** 05 September 2026 | **Framework:** 5-Pillar High-Yield Precision

---

## 🏛️ PILLAR 1: NORTH STAR & REAL-WORLD ANALOGIES

An **ETL Pipeline** (Extract, Transform, Load) is the automated transport system of data engineering. It pulls raw, chaotic data from transactional apps, cleanses and shapes it, and loads it into fast analytical warehouses for business decisions.

### 🌟 3 Crystal-Clear Analogies:
1. **The Modern Water Purification Plant (ETL Flow)**:
   - **Extract (Pumping River Water)**: Pumping raw, muddy water from rivers and lakes (dirty transactional OLTP databases, third-party webhook JSONs).
   - **Transform (Sediment Filtration & Chlorination)**: Removing dirt, filtering chemical impurities, standardizing pH balance, and adding minerals (deduplicating rows, fixing NULLs, casting types, computing KPIs).
   - **Load (Bottling & Supermarket Stocking)**: Packing certified, pure mineral water into sealed bottles (Star Schema Fact/Dim tables) ready for immediate customer drinking (Power BI / Tableau executive dashboards).
2. **The 5-Star Restaurant Kitchen (Staging & Cleansing)**:
   - You never serve raw, unwashed farm vegetables directly to the dining table (OLTP raw data). 
   - The sous-chef brings crates to the prep station (**Staging Area**), washes, peels, chops, and discards rotten pieces (**Silver Tier**), and the master chef plates the final gourmet dish for guests (**Gold Tier**).
3. **The Telecom 12:00 AM Postpaid Cutoff (Batch Processing Boundary)**:
   - In early 2G networks, billing mainframes lacked power to calculate charges during the day. At midnight (12:00 AM), massive batch jobs locked accounts to calculate taxes. If your phone call crossed midnight, the system dropped your call! Modern distributed streaming (Kafka/Flink) processes every call event in sub-second time, eliminating the midnight batch bottleneck forever.

---

## 🏛️ PILLAR 2: ARCHITECTURAL BLUEPRINT & TRADE-OFF MATRIX

### 4-Layer Enterprise Pipeline Blueprint:
```text
[ Layer 1: SOURCE TIER ] (Dirty, High-Speed Transaction Logs)
  • PostgreSQL / MySQL / SQL Server Apps, Stripe JSON Webhooks, Kafka Clickstreams
         │
         ▼ (Extract: Incremental Change Data Capture / Event Ingestion)
[ Layer 2: STAGING & TRANSFORMATION TIER ] (The Kitchen Prep Station)
  • Schema Validation, Deduplication, Null Handling, UTC Normalization
         │
         ▼ (Transform: Medallion Lakehouse Processing - Bronze -> Silver -> Gold)
[ Layer 3: ENTERPRISE DATA WAREHOUSE TIER ] (The Curated Vault)
  • Star Schemas: FactSales, DimCustomers, DimProducts, DimDates
         │
         ▼ (Load: Fast Analytical Delivery)
[ Layer 4: REPORTING & BI SERVING TIER ] (Business Decision Engine)
  • Executive C-Suite Dashboards (Power BI, Looker), Automated Alerts & ML Features
```

### Medallion Tier Comparison Matrix:
| Attribute | Bronze Layer (Raw Landing) | Silver Layer (Cleansed & Enriched) | Gold Layer (Curated Business Marts) |
| :--- | :--- | :--- | :--- |
| **Purpose** | 100% Immutable Raw Audit Copy | Deduplicated, Typed & Conformed | High-Speed Star Schemas & Aggregates |
| **Data Quality** | Raw, dirty, duplicates allowed | Cleaned, validated, NULLs resolved | Highly governed, 100% verified KPIs |
| **Schema State** | Schema-on-Read (JSON / Parquet) | Strictly Enforced Relational Schema | Dimensional Models (Fact & Dim tables) |
| **Target Audience**| Data Engineers & Pipeline Systems | Data Analysts & ML Engineers | C-Suite Executives & Business Units |
| **Query Speed** | Slow / Scan-Heavy | Moderate / Entity-Filtered | Ultra-Fast / Sub-Second Aggregations |

---

## 🏛️ PILLAR 3: PRODUCTION CODE BLUEPRINT

### Robust Silver Cleansing & Deduplication Logic (T-SQL):
```sql
-- Production Pattern: Extract raw JSON from Bronze, cleanse, deduplicate, and load into Silver
WITH CleanedRawPayloads AS (
    SELECT 
        TRY_CAST(JSON_VALUE(RawPayload, '$.order_id') AS INT) AS OrderID,
        TRY_CAST(JSON_VALUE(RawPayload, '$.customer_id') AS INT) AS CustomerID,
        TRIM(UPPER(COALESCE(JSON_VALUE(RawPayload, '$.customer_name'), 'UNKNOWN'))) AS CustomerName,
        TRY_CAST(JSON_VALUE(RawPayload, '$.amount') AS DECIMAL(10,2)) AS OrderAmount,
        COALESCE(JSON_VALUE(RawPayload, '$.order_status'), 'PENDING') AS OrderStatus,
        TRY_CAST(JSON_VALUE(RawPayload, '$.order_timestamp') AS DATETIME2) AS OrderTimeUTC,
        -- Deduplication Window: Keep latest record per OrderID
        ROW_NUMBER() OVER (
            PARTITION BY JSON_VALUE(RawPayload, '$.order_id') 
            ORDER BY TRY_CAST(JSON_VALUE(RawPayload, '$.order_timestamp') AS DATETIME2) DESC
        ) AS RowRank
    FROM bronze_ecommerce_orders
    WHERE RawPayload IS NOT NULL
)
INSERT INTO silver_ecommerce_orders (
    OrderID, CustomerID, CustomerName, OrderAmount, OrderStatus, OrderTimeUTC, IngestedAtUTC
)
SELECT 
    OrderID, CustomerID, CustomerName, OrderAmount, OrderStatus, OrderTimeUTC, GETUTCDATE()
FROM CleanedRawPayloads
WHERE RowRank = 1
  AND OrderID IS NOT NULL
  AND OrderAmount > 0;
```

---

## 🏛️ PILLAR 4: 5 DEADLY PRODUCTION FAILURES & SENIOR DE FIXES

1. **Failure 1: Heavy Transformations Running Directly on Production OLTP**
   - *The Disaster:* Data team runs a massive `GROUP BY` query on the live checkout DB; connection pool pegs to 100%, and mobile customers cannot place orders.
   - *Senior Fix:* Never run ETL on OLTP. Extract raw transaction deltas via Change Data Capture (CDC) or Read Replicas to Staging/Bronze first.
2. **Failure 2: Non-Idempotent Pipeline Retries (Duplicate Data Explosion)**
   - *The Disaster:* A nightly batch job fails at 80% due to a 2-second network blip. An automated scheduler restarts the job, inserting duplicate records and doubling company revenue metrics.
   - *Senior Fix:* Design idempotent loads using `MERGE` / `UPSERT` statements or atomic partition overwrite strategies (`DELETE WHERE DateKey = X` then `INSERT`).
3. **Failure 3: Silent Data Corruption via Hard Data Type Casting (`CAST` vs `TRY_CAST`)**
   - *The Disaster:* Source system sends `"amount": "null"` or `"N/A"`. Traditional `CAST(col AS INT)` crashes the entire ETL job at 3:00 AM.
   - *Senior Fix:* Always use defensive conversion functions (`TRY_CAST` / `TRY_CONVERT`) coupled with dead-letter queue routing for corrupt rows.
4. **Failure 4: Timezone Mixing Across Multinational Hubs**
   - *The Disaster:* Aggregating orders from London (GMT), Tokyo (JST), and New York (EST) using local server times, corrupting daily financial cutoff borders.
   - *Senior Fix:* Convert every incoming event timestamp to `UTC` in the Silver layer immediately upon ingestion.
5. **Failure 5: Schema Drift Breaking Downstream Analytics**
   - *The Disaster:* Source backend team adds or renames an API key without notice, breaking downstream star schemas.
   - *Senior Fix:* Use Schema-on-Read in Bronze (raw JSON / Parquet) and validate schema rules defensively in Silver with automated Slack alerts on drift.

---

## 🏛️ PILLAR 5: TIER-1 INTERVIEW KNOCKOUT Q&A

- **Q1: What is the fundamental difference between ETL and ELT, and when do you choose ELT?**
  - **Winning Answer:** ETL transforms data in an external compute engine before loading it into storage (best for strict PII masking and legacy systems). ELT loads raw data directly into scalable cloud warehouses (Snowflake/BigQuery) and uses the warehouse's MPP compute for transformations (best for modern cloud pipelines, flexibility, and reduced infrastructure complexity).
- **Q2: How do you guarantee idempotency in a high-volume data ingestion pipeline?**
  - **Winning Answer:** By ensuring that executing a job multiple times with the same input produces identical target state. We achieve this by using unique business key deduplication (`ROW_NUMBER()`), deterministic surrogate keys, atomic partition overwrites, or transactional `MERGE` operations.
- **Q3: Why is Medallion Architecture (Bronze -> Silver -> Gold) superior to a single data warehouse table?**
  - **Winning Answer:** It provides architectural isolation: Bronze preserves 100% raw history for audit and disaster reprocessing; Silver provides clean, conformed, enterprise-wide truth; and Gold delivers sub-second, aggregated star schemas tailored for executive business intelligence without risk of analytical queries overloading raw layers.
