# 📚 Module 03: ETL & Data Pipelines — Master Combined Topic Index
**Status:** In Progress | **Module:** 03_ETL_DATA_PIPELINES | **Single Source of Truth (SSOT)**

---

## SECTION 1: CHRONOLOGICAL DAILY TOPIC INDEX

### DAY 01 (SEPTEMBER 05) - ETL ARCHITECTURE, 4-LAYER DATA PIPELINE & MEDALLION DESIGN
- **1.1 ETL Foundations**: Extract (Read), Transform (Operate/Cleanse), Load (Write)
- **1.2 4-Layer Architecture**: Source Tier -> Staging Tier -> Data Warehouse Tier -> Reporting Tier
- **1.3 Medallion Lakehouse Sub-Layers**: Bronze (Raw), Silver (Cleansed/Enriched), Gold (Business Marts)
- **1.4 Amazon E-Commerce Case Study**: High-throughput order ingestion, transformation, and BI aggregation
- **1.5 Batch Processing History**: Telecom 12:00 AM midnight billing window analogy vs modern event streaming

---

## SECTION 2: MASTER TOPIC INDEX BY ARCHITECTURAL DOMAIN

### A. DATA INGESTION & EXTRACTION (E)
- Source Connectors: RDBMS (SQL Server, Postgres), REST APIs, Cloud Object Storage (S3, ADLS)
- Ingestion Modes: Full Snapshot vs Incremental Change Data Capture (CDC)
- Ingestion Latency: Batch Schedules vs Real-Time Streaming

### B. DATA TRANSFORMATION & CLEANSING (T)
- Structural Validation: Schema enforcement, column data type coercion
- Data Quality: Deduplication, NULL imputation, anomaly rejection
- Business Logic: Currency conversion, tax calculations, temporal standardizations

### C. DATA LOADING & WAREHOUSING (L)
- Target Destinations: Snowflake, Databricks Delta Lake, Amazon Redshift, Azure Synapse
- Loading Strategies: Append-Only, Upsert (MERGE), Slowly Changing Dimensions (SCD Type 1 & 2)

### D. ARCHITECTURAL PATTERNS & LAKEHOUSE DESIGN
- 4-Tier Enterprise Pipeline Architecture
- Medallion Architecture (Bronze -> Silver -> Gold)
- Data Lakehouse vs Traditional Data Warehouse Tradeoffs
