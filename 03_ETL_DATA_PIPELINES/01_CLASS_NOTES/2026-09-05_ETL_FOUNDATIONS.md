# 🚀 Module 03: ETL & Data Pipelines — Day 01 Class Notes
**Date:** 05 September 2026 | **Topic:** ETL Fundamentals, 4-Layer Architecture & Medallion Pipeline Design

---

## 1. Core ETL Definition & Pipeline Mechanism

An **ETL Pipeline** (Extract, Transform, Load) is an automated data plumbing system that moves data from raw business applications into analytical systems.

```
+----------------+      +-------------------+      +------------------+
| EXTRACT (Read) | ---> | TRANSFORM (Operate)| ---> |   LOAD (Write)   |
| From Sources   |      | Clean & Reshape   |      | Into Warehouse   |
+----------------+      +-------------------+      +------------------+
```

- **Extract (Read):** Reading raw data from OLTP databases, APIs, CSV files, IoT logs, or message queues.
- **Transform (Operate):** Data cleansing, type casting, deduplication, currency conversion, business aggregations, and masking sensitive PII.
- **Load (Write):** Persisting transformed datasets into analytical storage (Data Warehouse, Data Lake, or Data Marts).

---

## 2. The 4-Layer Enterprise Data Architecture

In modern production systems, data flows sequentially through 4 fundamental architectural tiers:

```
[ Tier 1: Source Layer ]
  - OLTP Databases (SQL Server, PostgreSQL)
  - Third-party APIs (Stripe, Salesforce)
  - Streaming Logs & Events (Kafka, Webhooks)
        |
        v
[ Tier 2: Staging / Transformation Layer ]
  - Ingestion buffer & schema validation
  - Data cleansing & normalization
  - Business rules & deduplication
        |
        v
[ Tier 3: Enterprise Data Warehouse (EDW) Layer ]
  - Star Schema / Snowflake Schema
  - Fact Tables (Transactions, Orders)
  - Dimension Tables (Customers, Products, Dates)
        |
        v
[ Tier 4: Reporting & BI Serving Layer ]
  - Power BI, Tableau, Looker Dashboards
  - Executive KPIs & Operational ML Models
```

---

## 3. Medallion Lakehouse Architecture (Bronze, Silver, Gold)

Modern Big Data Lakehouses categorize pipeline storage into 3 progressive refinement zones:

- 🥉 **Bronze Layer (Raw Ingestion):**
  - Exact 1-to-1 raw copy of source data.
  - Append-only, schema-agnostic, preserved for audit trails and reprocessing.
- 🥈 **Silver Layer (Cleansed & Conformed):**
  - Filtered, deduplicated, enriched, and validated data.
  - Normalized schemas with standardized naming and data types.
- 🥇 **Gold Layer (Curated Business Aggregates):**
  - High-performance aggregated star schemas, KPI summaries, and analytics-ready dimensional tables.

---

## 4. Real-World Case Study: Amazon E-Commerce Order Pipeline

```
1. Customer clicks "Place Order" on Amazon app -> OLTP Transaction DB.
2. ETL Extractor reads hourly order deltas.
3. Transformer cleanses address formats, validates coupon codes, and joins customer profiles.
4. Loader writes cleansed facts into Amazon Redshift / Snowflake EDW.
5. BI Dashboard renders real-time hourly GMV and inventory replenishment alerts.
```

---

## 5. Historical Context: Batch Windows & Telecom Midnight Cutoff Analogy

- **The Old Postpaid Phone Bill Problem**:
  In early telecom systems, computing power was limited. Phone calls were cut off or unmetered at 12:00 AM midnight because massive **nightly batch ETL jobs** ran to aggregate billions of call records (CDRs) and compute monthly billing statements.
- **Modern Contrast**:
  Today, batch windows are complemented by real-time streaming architectures (Kafka, Spark Streaming) for instantaneous processing.
