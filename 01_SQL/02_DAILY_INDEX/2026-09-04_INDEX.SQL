-- ====================================================================================================
-- 📑 DAILY TOPIC INDEX - 04 SEPTEMBER 2026 (DAY 27)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: Stored Procedures (Deduplication), Virtual vs Materialized Views & Indexing Mechanics
-- ====================================================================================================

/*
TOPIC BREAKDOWN:
----------------
1. Stored Procedures (SPs) & Automated Deduplication
   - Stored Procedure Architecture: Pre-compiled execution plans, reduced network traffic & parameterization
   - Creating Stored Procedures: CREATE PROCEDURE usp_Name AS BEGIN ... END
   - Deduplication Engine: Encapsulating CTE + ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...) inside SPs
   - Procedural Modification: ALTER PROCEDURE vs DROP & CREATE (preserving permissions and metadata)
   - Executing Procedures: EXEC / EXECUTE mechanics & returning parameterized duplicate rows
2. Views: Virtual Tables & Logical Abstractions
   - Virtual Table Concept: Saved SELECT query definition stored in data dictionary without row persistence
   - View Creation & Modification: CREATE VIEW vw_Name AS SELECT ... and ALTER VIEW
   - Dynamic Computed Logic inside Views: Embedding searched CASE expressions for row-level categorization
   - Querying Views: Transparent SELECT * FROM vw_Name matching table semantics
   - Views vs Stored Procedures: Table-like composability (JOINs, WHERE) vs procedural block execution
   - Standard (Virtual) Views vs Materialized (Indexed) Views: Query expansion vs physical clustered B-tree storage
3. Indexing Architecture & Physical Storage Engine
   - Non-Clustered Indexes: Auxiliary B-Tree structure storing index keys and row locators (RID/Clustered Key)
   - Index Inspection: System procedure sp_helpindex for index diagnostic auditing
   - Clustered Index Mechanics: Physical ordering of leaf-level data pages (1 Clustered Index per table)
   - Primary Key Auto-Clustering: Default clustered index generation upon PRIMARY KEY constraint definition
   - Heap Tables vs Clustered Tables: Unordered heap allocation (p12) vs physically sorted B-Tree (p11)
   - Retrofitting Clustered Indexes on Heap Tables: CREATE CLUSTERED INDEX and physical page reorganization
4. Tier-1 Data Engineering Interview Scenarios
   - Performance trade-offs: Non-Clustered Index read speed vs DML (INSERT/UPDATE/DELETE) write overhead
   - Materialized / Indexed View requirements (WITH SCHEMABINDING, unique clustered index)
   - Deduplication in production pipelines: Automated purge vs audit review procedures
*/
