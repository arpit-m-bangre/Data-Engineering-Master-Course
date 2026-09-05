# 🎯 Module 03: ETL & Data Pipelines — Day 01 Class Tasks
**Date:** 05 September 2026 | **Module:** 03_ETL_DATA_PIPELINES

---

## Scenario Overview: Architectural Design for Global E-Commerce & Telecom

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



