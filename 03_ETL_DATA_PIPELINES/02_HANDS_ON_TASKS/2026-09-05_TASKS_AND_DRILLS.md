# 🎯 Module 03: ETL & Data Pipelines — Day 01 Tasks & Practice Drills
**Date:** 05 September 2026 | **Module:** 03_ETL_DATA_PIPELINES | **Status:** Active Practice & Design Deck

---

# SECTION 1: FACULTY ARCHITECTURAL DESIGN TASKS

You are tasked as the Lead Data Architect to design end-to-end data pipeline blueprints for high-volume enterprise systems.

---

### Task 1: 4-Layer Architecture Mapping for Amazon E-Commerce
**Requirement:** Map out the exact components, data models, and storage technologies across all 4 architectural tiers for Amazon's Order Processing Pipeline:
- Tier 1: Source Layer
- Tier 2: Staging / Transformation Layer
- Tier 3: Data Warehouse (EDW) Layer
- Tier 4: Reporting & BI Serving Layer

#### Your Solution Blueprint below:




---

### Task 2: Medallion Architecture Specification (Bronze, Silver, Gold)
**Requirement:** Define schema rules, data quality checks, retention policies, and transformation operations for:
1. **Bronze Layer**:
2. **Silver Layer**:
3. **Gold Layer**:

#### Your Solution Blueprint below:




---

### Task 3: Historical Telecom Batch Window & Mitigation Architecture
**Requirement:**
1. Explain why legacy telecom postpaid billing systems had the 12:00 AM batch boundary problem.
2. Design a modern hybrid architecture (using Event Streaming + Micro-batching) that prevents call drops and enables real-time balance calculations.

#### Your Solution Blueprint below:




---

### Task 4: Idempotency & Failure Recovery Design
**Requirement:** Write the logical algorithm and SQL/Python pseudo-code to ensure an ETL ingestion job loading 1,000,000 orders can safely restart after failing midway without creating duplicate records.

#### Your Solution Blueprint below:




---

# SECTION 2: 14 TARGETED PRACTICE DRILLS

---

### QUESTION 01: Core Definition of ETL
**Task:** Define the three phases of ETL (Extract, Transform, Load) and explain the primary responsibility of each stage in a data engineering ecosystem.

#### Write your answer below:




---

### QUESTION 02: ETL vs ELT Paradigm Comparison
**Task:** Compare traditional ETL with modern cloud ELT. When would you choose ELT over ETL in an enterprise data project?

#### Write your answer below:




---

### QUESTION 03: 4-Tier Architecture Overview
**Task:** List and describe the 4 tiers of enterprise data architecture from source applications to business decision-making.

#### Write your answer below:




---

### QUESTION 04: OLTP vs OLAP Storage Engines
**Task:** Explain why analytics should never be run directly against an OLTP production database, and how the staging layer resolves this issue.

#### Write your answer below:




---

### QUESTION 05: The Bronze Layer in Medallion Architecture
**Task:** What is the primary purpose of the Bronze layer? Why must raw data be kept immutable and append-only?

#### Write your answer below:




---

### QUESTION 06: The Silver Layer & Data Cleansing
**Task:** Name at least 5 critical transformation tasks performed in the Silver tier before data is shared with data analysts.

#### Write your answer below:




---

### QUESTION 07: The Gold Layer & Dimensional Modeling
**Task:** Describe the structure and purpose of the Gold layer. What type of schemas (e.g., Star Schema) are typically stored here?

#### Write your answer below:




---

### QUESTION 08: Amazon E-Commerce Order Ingestion Flow
**Task:** Walk through the end-to-end data lifecycle when a customer places an order on Amazon, tracing it from mobile checkout to the CFO's morning dashboard.

#### Write your answer below:




---

### QUESTION 09: Telecom 12:00 AM Batch Window Analysis
**Task:** Explain the historical root cause behind telecom postpaid billing cutoffs at 12:00 AM midnight and what architectural limitation caused it.

#### Write your answer below:




---

### QUESTION 10: Batch vs Real-Time Streaming Latency Tradeoffs
**Task:** Compare Batch Processing with Real-Time Event Streaming across cost, complexity, data freshness, and compute requirements.

#### Write your answer below:




---

### QUESTION 11: Idempotency in Pipeline Design
**Task:** What does idempotency mean in data engineering pipelines? What happens during network failure if an ETL job is NOT idempotent?

#### Write your answer below:




---

### QUESTION 12: Change Data Capture (CDC) Mechanics
**Task:** Explain the concept of Change Data Capture (CDC) and how it optimizes ETL extraction compared to full daily database dumps.

#### Write your answer below:




---

### QUESTION 13: Schema Drift & Defensive Pipeline Engineering
**Task:** Describe the problem of Schema Drift and explain two techniques data engineers use to prevent downstream pipelines from breaking.

#### Write your answer below:




---

### QUESTION 14: Data Quality Validation & Alerting
**Task:** Design a basic data quality assertion checklist that every Silver-tier ingestion pipeline must pass before promoting data to Gold.

#### Write your answer below:




