/* ==============================================================================
   DAILY TOPIC INDEX - 2026-08-22 (DAY 19)
   MODULE: ENTERPRISE SQL & RELATIONAL ARCHITECTURE
   TOPIC: WINDOW FUNCTIONS - RANKING FUNCTIONS & PARTITIONS
============================================================================== */

/*
DAY 19 (AUGUST 22) - WINDOW FUNCTIONS: RANKING & PARTITIONING

19.1 Window Functions Overview & 3 Core Categories (Ranking, Value-based, Aggregate)
19.2 Window Functions vs GROUP BY Aggregation (Row Preservation vs Row Collapsing)
19.3 The OVER() Clause Architecture (ORDER BY vs PARTITION BY)
19.4 ROW_NUMBER() Function (Sequential Unique Line Numbering, No Ties, No Gaps)
19.5 DENSE_RANK() Function (Ties Share Rank, Continuous Numbering, Zero Gaps)
19.6 RANK() Function (Ties Share Rank, Positional Numbering with Gaps)
19.7 NULL Handling in Sorting & Window Functions (SQL Server Default: NULLs First in ASC, Last in DESC)
19.8 PARTITION BY Sub-grouping Mechanics (Independent Window Calculation per Category/Department)
19.9 Combining PARTITION BY with ORDER BY for Department-wise Ranking
19.10 Logical Query Execution Order with Window Functions (FROM -> WHERE -> GROUP BY -> HAVING -> WINDOW -> SELECT -> ORDER BY)
19.11 The WHERE Clause Window Function Restriction Trap (Msg 4108) & Derived Table / CTE Workaround
19.12 Top-N per Group Filtering Pattern using DENSE_RANK() in Derived Tables
19.13 Excel-to-SQL Mental Model: Replicating Screen-Share Interview Ranking Tables
*/
