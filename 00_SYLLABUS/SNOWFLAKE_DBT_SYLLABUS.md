# ❄️ SNOWFLAKE & dbt MASTER CURRICULUM & ARCHITECTURAL ROADMAP

> **Curriculum Source:** `00_SYLLABUS/SNOWFLAKE_DBT_SYLLABUS.pdf`  
> **Course Scope:** Enterprise Cloud Data Warehousing & Modern Analytics Engineering Stack  
> **Target Role:** Senior Data Engineer / Analytics Engineer (Tier-1 Enterprise Systems)  
> **Total Timeline:** 25 Days (1.5 Hours/Day Intensive Hands-on Execution)

---

## 🏛️ 1. MODERN DATA STACK (MDS) ARCHITECTURAL OVERVIEW

In modern data platforms, Snowflake and dbt work together in an **ELT (Extract - Load - Transform)** paradigm:

```
[ EXTRACT & LOAD (EL) ]
AWS S3 / Azure Blob / GCS / Kafka / APIs
                │
                ▼  (Snowpipe / COPY INTO / Storage Integrations)
╔══════════════════════════════════════════════════════════════════════════════════╗
║                        SNOWFLAKE CLOUD DATA PLATFORM                             ║
║                                                                                  ║
║  ┌────────────────────────────────────────────────────────────────────────────┐  ║
║  │ 1. Cloud Services: Security, Metadata, Optimization, Access Control        │  ║
║  ├────────────────────────────────────────────────────────────────────────────┤  ║
║  │ 2. Virtual Warehouses: Elastic Compute (XS to 4XL), Auto-Suspend & Resume  │  ║
║  ├────────────────────────────────────────────────────────────────────────────┤  ║
║  │ 3. Centralized Storage: Micro-partitions, Zero-Copy Clones, Time Travel   │  ║
║  └────────────────────────────────────────────────────────────────────────────┘  ║
╚══════════════════════════════════════════════════════════════════════════════════╝
                │
                ▼  (dbt: In-Warehouse SQL Transformations + Testing + DAG)
╔══════════════════════════════════════════════════════════════════════════════════╗
║                        dbt (DATA BUILD TOOL) PIPELINE                            ║
║                                                                                  ║
║  [RAW Data] ──▶ [Staging: stg_] ──▶ [Intermediate: int_] ──▶ [Marts: dim_/fct_]  ║
║                                                                                  ║
║  • Automated Quality Checks: unique, not_null, accepted_values, relationships    ║
║  • SCD-2 Historical Tracking: dbt Snapshots                                      ║
║  • Auto-Generated Documentation & Interactive Lineage Graph                      ║
╚══════════════════════════════════════════════════════════════════════════════════╝
                │
                ▼
[ ANALYTICS & APPS: Power BI / Tableau / Streamlit / Cortex AI ]
```

---

## ❄️ 2. MODULE 1: SNOWFLAKE CLOUD DATA PLATFORM (25 DAYS)

### Phase 1: Foundations & Architecture
* **01. Snowflake Overview:**
  * Fundamental Data Types & semi-structured data support (VARIANT, JSON, PARQUET, AVRO).
  * Data Lake vs. Database vs. Data Warehouse vs. Lakehouse paradigms.
  * OLTP (Row-oriented) vs. OLAP (Columnar distributed).
  * Normalization (3NF) vs. Denormalization (Star & Snowflake dimensional schemas).
  * On-Premise legacy data warehouses vs. Cloud-Native platforms.

* **02. Snowflake Architecture (Multi-Cluster Shared Data):**
  * Shared-Disk Architecture vs. Shared-Nothing Architecture vs. Multi-Cluster Shared-Data Architecture.
  * 3-Layer Decoupled Architecture:
    1. Cloud Services Layer (Authentication, metadata, query parser & cost optimizer).
    2. Virtual Compute Layer (Independent, isolated Virtual Warehouses).
    3. Hybrid Storage Layer (Scalable columnar micro-partition storage).
  * Key advantages: True compute-storage separation, near-zero maintenance, instant elasticity.

* **03. Snowflake UI & Workspaces:**
  * Classic Web UI vs. Modern Snowsight UI.
  * Snowflake SQL Worksheets, Snowpark Workspaces, Visual Query Profiler, and Charting.

---

### Phase 2: Elastic Compute & Storage Objects
* **04. Virtual Warehouses (Compute Engine):**
  * T-shirt Sizing (X-Small to 4X-Large) and compute credit allocation.
  * Vertical Scaling (Resizing warehouse for large queries) vs. Horizontal Scaling (Multi-Cluster Warehouses for high concurrency).
  * Auto-Suspend and Auto-Resume policies for aggressive cost control.
  * Concurrency scaling, query queuing mechanics, and warehouse management best practices.
  * Hands-on: Create, resize, suspend, resume, and monitor warehouse compute credits.

* **05. Database Objects & Table Types:**
  * Databases, Schemas, and Namespace hierarchy.
  * Standard Permanent Tables (with Time Travel & Fail-safe).
  * Transient Tables (No Fail-safe, reduced cost for ETL staging).
  * Temporary Tables (Session-scoped for scratch calculations).
  * External Tables (Querying cloud storage in place).
  * Dynamic Tables (Declarative automated transformation pipelines).
  * Stages and Scheduled Tasks.

---

### Phase 3: Snowflake Core Superpowers
* **06. Caching Architecture:**
  * Query Result Cache (24-hour persistent metadata cache with $0 compute cost).
  * Local Disk / SSD Warehouse Cache (Data cached on compute nodes).
  * Remote Metadata Cache (Stored in Cloud Services layer).

* **07. Time Travel:**
  * Querying point-in-time data using `AT` and `BEFORE` clauses (up to 90 days).
  * Recovering accidentally dropped tables, schemas, or databases using `UNDROP`.
  * Restoring historical records without backups.

* **08. Fail-Safe:**
  * 7-day non-configurable disaster recovery protection managed exclusively by Snowflake Support.
  * Storage cost implications and lifecycle management.

* **09. Zero-Copy Cloning:**
  * Instant cloning of multi-terabyte databases, schemas, and tables (`CREATE TABLE ... CLONE ...`).
  * Metadata-only pointer replication with zero additional storage costs until new data is modified.

* **10. Micro-Partitions & Clustering:**
  * Automated columnar micro-partitioning (50 MB - 500 MB uncompressed blocks).
  * Natural clustering, partition pruning, and Clustering Depth.
  * Defining custom Clustering Keys for massive multi-terabyte tables.

* **11. Materialized Views (MV):**
  * Pre-computed query acceleration with automated background refresh.

* **12. Dynamic Tables:**
  * Declarative data transformation pipelines defined with simple SQL statements and target lag (`TARGET_LAG = '5 minutes'`).

* **13. Stored Procedures & User Defined Functions (UDFs):**
  * Writing procedural business logic in SQL, JavaScript, and Python (Snowpark).

---

### Phase 4: Enterprise Ingestion Pipelines & Cloud Integrations
* **14. Refresh Strategies:**
  * Full Refresh vs. Incremental Delta Load patterns.

* **15. Data Loading Overview:**
  * Ingesting local files, batch cloud loads, and real-time streaming.

* **16. Snowflake Stages:**
  * Internal Stages: User Stages (`@~`), Table Stages (`@%`), Named Internal Stages (`@mystage`).
  * External Stages: Connecting directly to cloud object stores.
  * Comparison and selection matrices for production pipelines.

* **17. File Formats:**
  * Creating reusable schemas for CSV, TSV, JSON, PARQUET, AVRO, ORC, and XML.

* **18. Stage Commands:**
  * `PUT` (Upload local file to internal stage).
  * `GET` (Download staged file to local machine).
  * `LIST` (Inspect contents of a stage).
  * `REMOVE` (Purge staged files).

* **19. The `COPY INTO` Command:**
  * Syntax, batch ingestion mechanics, and loading files from stages into production tables.

* **20. `COPY INTO` Production Options:**
  * `ON_ERROR = CONTINUE | SKIP_FILE | ABORT_STATEMENT`.
  * `PURGE = TRUE | FALSE` (Automated cleanup of loaded files).
  * `FORCE = TRUE | FALSE` (Reloading modified files).
  * `MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE`.
  * `VALIDATION_MODE = RETURN_ERRORS | RETURN_ROWS` (Dry-run validation before committing data).

* **21. Error Handling & Ingestion Auditing:**
  * Handling bad/corrupted records, inspecting rejected rows, troubleshooting load failures using `VALIDATE()` table functions.

* **22. Loading from External Cloud Storage:**
  * AWS S3 Integration (IAM Roles, External IDs, CloudFormation).
  * Azure Blob Storage Integration (Storage Accounts, App Registrations, Service Principals).
  * Google Cloud Storage (GCS) Integration (Service Accounts).
  * Cloud `STORAGE INTEGRATION` objects for credential-free, secure staging.

---

### Phase 5: Continuous Ingestion, CDC & Advanced AI
* **23. Snowpipe (Serverless Automated Ingestion):**
  * Why Snowpipe over batch `COPY INTO`.
  * Continuous data ingestion architecture.
  * Auto-Ingest via Cloud Event Notifications (AWS SQS, Azure Event Grid, GCP Pub/Sub).
  * Snowpipe REST APIs, pipe management, and latency monitoring.

* **24. Streams & Tasks (Change Data Capture - CDC):**
  * Snowflake Streams for row-level CDC (INSERT, UPDATE, DELETE tracking).
  * Snowflake Tasks for cron-based serverless SQL scheduling and DAG execution.

* **25. Query Performance Tuning:**
  * Visual Query Profile analysis, finding table scans, resolving spilling to local/remote storage.

* **26. Cost Optimization Basics:**
  * Warehouse auto-suspend optimization, monitoring credit consumption, resource monitors.

* **27. Snowflake Cortex AI & CLI:**
  * Cortex CLI, running Large Language Models (LLMs) and vector embeddings directly inside Snowflake.

* **28. Streamlit in Snowflake:**
  * Building native Python web dashboards directly inside the Snowflake workspace.

---

## 🔨 3. MODULE 2: dbt (DATA BUILD TOOL) — MODERN TRANSFORMATION ENGINE

### Phase 1: Introduction & Architecture
* **01. dbt Introduction:**
  * What is dbt and why it was introduced.
  * Problems solved: Moving from fragile procedural ETL scripts to software-engineered SQL pipelines.
  * Why modern enterprise teams use dbt for ELT transformation.

* **02. Why dbt with Snowflake?**
  * Snowflake handles raw compute & storage; dbt handles SQL logic, dependencies, and documentation.
  * Modular SQL development, version control integration, automated data quality testing.

* **03. Core Features of dbt:**
  * Modularity (DRY - Don't Repeat Yourself), Git version control, auto-documentation, Jinja templating, dependency DAG management.

* **04. dbt Core vs. dbt Cloud:**
  * Architecture, CLI interface, orchestration, cost vs. maintenance comparison.

---

### Phase 2: Environment Setup & Project Configuration
* **05. Environment Setup:**
  * Installing Git, Python virtual environments (`venv`), VS Code.
  * Installing `dbt-snowflake` adapter.
  * Initializing projects via `dbt init`.
  * Configuring connection profiles in `profiles.yml` and project settings in `dbt_project.yml`.
  * Validating configuration via `dbt debug` and troubleshooting setup errors.

* **06. dbt Project Structure:**
  * Complete walkthrough of core directories: `models/`, `macros/`, `tests/`, `seeds/`, `snapshots/`, `analyses/`, `target/`, and `logs/`.

---

### Phase 3: Building Medallion Data Pipelines in dbt
* **07. Building the First End-to-End dbt Project:**
  * **Snowflake Setup:** Database, schemas, raw tables, and seed data.
  * **Source Layer:** Declaring upstream raw sources in `source.yml` using `{{ source('raw_schema', 'table_name') }}`.
  * **Staging Layer (`stg_`):** Column renaming, data type casting, basic deduplication.
  * **Intermediate Layer (`int_`):** Applying complex business logic, joins, and aggregations.
  * **Marts Layer (`fct_` / `dim_`):** Final dimensional models ready for BI tools and executive reporting.
  * **Model Execution & DAG:** Running pipelines via `dbt run`, lineage graphs, and model referencing using `{{ ref('model_name') }}`.

* **08. dbt Models & Materialization Strategies:**
  * What is a model: SQL `SELECT` file compiled into DDL/DML.
  * **Materialization Types:**
    * `view`: Recreated on every run as a database view.
    * `table`: Rebuilt as a physical table.
    * `incremental`: Only processes new or modified records (huge compute cost savings for Big Data).
    * `ephemeral`: Injected as CTEs into downstream models without creating physical database objects.
    * `materialized_view`: Native Snowflake materialized view.
  * Naming standards: `stg_`, `int_`, `fct_`, `dim_`, `mart_`.

---

### Phase 4: Jinja, Testing, Documentation & Advanced Governance
* **09. Jinja Templating:**
  * Introduction to Jinja: Writing dynamic SQL with code generation.
  * Variables (`{{ var('my_var') }}`), Loops (`{% for %}`), Conditional logic (`{% if %}` / `{% else %}`).
  * Practical enterprise patterns: Dynamic pivoting, multi-column transformations, environment toggling.
  * Built-in dbt functions and writing custom reusable Macros.

* **10. Testing & Automated Documentation:**
  * **Schema Tests (Out of the Box):** `unique`, `not_null`, `accepted_values`, `relationships` (referential integrity).
  * **Custom Business Tests:** Writing custom SQL test assertions (`dbt test`).
  * **Source Freshness Tests:** Ensuring upstream pipeline data is fresh (`dbt source freshness`).
  * **Automated Catalog & Documentation:** Interactive data lineage graphs and column dictionaries (`dbt docs generate` & `dbt docs serve`).

* **11. Advanced Enterprise dbt Features:**
  * **dbt Snapshots:** Automated Type-2 Slowly Changing Dimensions (SCD-2) tracking history using `check` and `timestamp` strategies.
  * **dbt Seeds:** Ingesting static reference CSV files into Snowflake (`dbt seed`).
  * **Hooks:** `pre-hook` and `post-hook` SQL statements (grants, auditing logs).
  * **Packages:** Installing third-party libraries (e.g., `dbt-utils`, `codegen`).
  * **Metrics Layer Basics:** Semantic definitions for standardized company-wide metrics.

---

## 🎯 4. HOW THIS CONNECTS TO OUR 200-DAY ROADMAP

| Current Phase | Upcoming Module | How Today's Learning Directly Powers This |
| :--- | :--- | :--- |
| **01_SQL (Current)** | SQL Queries & Joins | The exact SQL, Joins, Aggregations & Window Functions you write today become the code inside **dbt SQL models**. |
| **02_PYTHON (Next)** | Python & Data Structures | Python is used to write **Snowpark Stored Procedures** and automate **dbt CLI execution**. |
| **03_ETL & PIPELINES** | Ingestion & Staging | Ingestion mechanics connect directly into **Snowflake Internal/External Stages** and **AWS S3 integrations**. |
| **05_DATA_WAREHOUSING**| **Snowflake + dbt** | You will build enterprise dimensional Lakehouses with automated tests, CI/CD, and real-time streaming pipelines. |

---
*Roadmap curated and synchronized by Pippo 🐥 for Cap (Data Engineering Master Course).*
