# 🏢 ENTERPRISE MNC PROJECT — MASTER INITIALIZATION BLUEPRINT & PROMPT
### *The Production-Grade Data Platform Blueprint for Tier-1 Hiring*
*Designed by Pippo 🐥 for Captain Arpit Manoj Bangre*

---

## 📋 HOW TO USE THIS DOCUMENT:
When you create your new workspace folder (e.g. `d:\ENTERPRISE_DATA_PLATFORM\`) and open Antigravity IDE, **simply copy and paste the Master Prompt below into your first chat**!

---

## ⚡ THE MASTER INITIALIZATION PROMPT (COPY & PASTE THIS):

```text
================================================================================
🏢 PROJECT INITIALIZATION PROMPT: ENTERPRISE DATA PLATFORM (MNC SIMULATION)
================================================================================

Hi AI! You are my Lead Data Engineering Architect co-pilot.
I am Arpit Manoj Bangre (Cap), a Senior Data Engineer candidate targeting 25+ to 48 LPA roles at Tier-1 product MNCs (Amazon, Microsoft, Swiggy, Uber, Databricks).

🎯 WORKSPACE OBJECTIVE:
We are building a 100% PUBLIC, production-grade, open-source Enterprise Data Platform repository named:
"NexusFin — Real-Time FinTech & Core Banking Data Intelligence Platform"

This repository is NOT a tutorial project. It is an enterprise-grade simulation of a real FinTech MNC data ecosystem designed to blow away Tier-1 hiring managers.

--------------------------------------------------------------------------------
🏛️ CORE ARCHITECTURAL STANDARDS (ZERO TOY-CODE RULE):
--------------------------------------------------------------------------------
1. Clean Layered Architecture:
   ├── 01_raw_ingestion/      --> Batch & event ingestion pipelines (Python / REST API / Kafka simulation)
   ├── 02_warehouse_schemas/  --> Production DDL, staging tables, star/snowflake dimensional models (SQL Server / Snowflake / Postgres)
   ├── 03_transformations/    --> Business logic, Window Analytics, CTEs, PySpark distributed compute jobs
   ├── 04_data_quality/       --> Data contracts, Great Expectations / custom anomaly detection (NULL checks, schema drift, reconciliation)
   ├── 05_orchestration/      --> Apache Airflow DAGs with retry policies & SLA alerts
   └── 06_ci_cd_workflows/    --> GitHub Actions for SQL linting (SQLFluff), automated testing, and PR checks.

2. Production Simulation Artifacts:
   ├── JIRA_BACKLOG_AND_SPRINTS.md --> Realistic sprint tickets (e.g. "BUG-104: High-frequency transaction anomaly detection under 5-min window")
   ├── ARCHITECTURE_DIAGRAMS.md    --> Clean ASCII & Mermaid pipeline flowcharts
   └── RUNBOOK_AND_SLAS.md         --> Production runbooks, incident response, and data contract specs.

--------------------------------------------------------------------------------
👥 CODING & COMMIT RULES:
--------------------------------------------------------------------------------
- All SQL keywords in UPPERCASE (SELECT, FROM, JOIN, PARTITION BY).
- All code must include industrial error handling, logging, and idempotency (safe to re-run without duplicate rows).
- Address me as Cap. Act as my Staff Data Architect.

Let's begin by initializing the repository directory structure, master README.md with system architecture diagrams, and Sprint 1 foundation!
================================================================================
```

---

## 📂 REPOSITORY DIRECTORY STRUCTURE BLUEPRINT:

```text
nexus-fintech-platform/
├── .github/
│   ├── workflows/
│   │   ├── sql-linter.yml          <-- Automated SQL syntax & uppercase checks
│   │   └── data-pipeline-tests.yml  <-- PyTest data validation tests
│   └── pull_request_template.md    <-- Enterprise PR review checklist
├── 01_raw_ingestion/               <-- Ingestion scripts (Python, API, Webhooks)
├── 02_warehouse_schemas/
│   ├── 01_staging_tables.sql       <-- Transient landing zone schemas
│   ├── 02_dimensional_models.sql   <-- Fact & Dimension schemas (Star Schema)
│   └── 03_indexing_and_constraints.sql <-- PK, FK, Non-clustered index optimization
├── 03_transformations/
│   ├── sql_analytics/              <-- Window functions, rolling revenue, fraud detection
│   └── pyspark_pipelines/          <-- Distributed aggregations & Delta Lake upserts
├── 04_data_quality_contracts/      <-- Schema assertion rules & reconciliation queries
├── 05_orchestration_dags/          <-- Apache Airflow pipeline definitions
├── docs/
│   ├── ARCHITECTURE_DIAGRAMS.md    <-- Mermaid & visual pipeline flows
│   └── JIRA_SPRINT_BOARD.md        <-- Feature tickets, bugs, and SLA documentation
└── README.md                       <-- World-class portfolio homepage with live badges
```

---

## 🏆 WHAT RECRUITERS WILL SEE:
When recruiters click this public repository on your GitHub profile (`github.com/arpit-m-bangre`), they will see:
1. **Real Architectural Depth**: Star schema dimensional models, Airflow DAGs, and PySpark transformations.
2. **Professional Git Hygiene**: Proper PR templates, GitHub Actions linting, and issue trackers.
3. **Zero Junior Smells**: Real-world FinTech velocity fraud detection, rolling window ledgers, and automated data quality checks.

---

*This blueprint is permanently saved in your `EXTRA_MAGICAL_FILES/` directory. Whenever you are ready to launch, just grab the prompt!* 💛🚀
