-- ====================================================================================================
-- 📑 DAILY TOPIC INDEX - 03 SEPTEMBER 2026 (DAY 26)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: Transaction Control (TCL), NULL Functions (ISNULL, COALESCE) & Subqueries vs CTEs
-- ====================================================================================================

/*
TOPIC BREAKDOWN:
----------------
1. Transaction Control Language (TCL) Mechanics
   - Autocommit mode vs Explicit Transactions (BEGIN TRANSACTION)
   - ROLLBACK mechanics: Reverting uncommitted DML modifications
   - COMMIT mechanics: Persisting mutations permanently to WAL/Transaction Log
   - Error 3903 analysis: Attempting ROLLBACK after COMMIT or without active BEGIN TRANSACTION
   - SQL Server DDL Rollback: Unique ability to rollback DROP TABLE / TRUNCATE inside transactions
2. NULL Value Management & Substitution
   - Filtering and mutating NULL fields via WHERE column IS NULL
   - T-SQL ISNULL(check_expression, replacement_value): 2-parameter deterministic replacement
   - ANSI-SQL COALESCE(val1, val2, ... valN): Multi-column cascading fallback evaluation
   - Performance and data type precedence comparison: ISNULL vs COALESCE
3. Subqueries vs Modern Enterprise CTEs & Window Functions
   - Scalar Subqueries: Finding N-th highest values via WHERE Marks < (SELECT MAX(Marks)...)
   - Performance penalties of Correlated / Nested subqueries in Big Data pipelines
   - Modern Industry Alternative 1: CTE + DENSE_RANK() OVER (ORDER BY Marks DESC)
   - Modern Industry Alternative 2: Replacing WHERE ID IN (SELECT ID...) with set-based INNER JOIN / EXISTS
   - Architectural perspective: When subqueries are required (Salesforce SOQL / dialect limitations) vs SQL Server / Snowflake CTE standards
4. Tier-1 Interview & Production Playbook
   - Financial audit and ETL fail-safe patterns using explicit transactions
   - Answering "Find Nth Highest Salary" without inefficient subquery nesting
   - Zero-data-loss null replacement strategies across dimensional warehouse staging
*/
