/* ====================================================================
   DAILY TOPIC INDEX — 2026-08-25 (DAY 21)
   TOPIC: Value Window Functions (LEAD & LAG), Running Aggregate Windows,
          Inventory Delta Analysis & Period-over-Period Reporting
   MODULE: 01_SQL Relational Architecture & Analytical Engine
   ==================================================================== */

-- 1. Value Window Functions Mechanics & Execution Engine
--    1.1 Definition: Inter-row navigation without expensive self-joins
--    1.2 LEAD(expression, [offset], [default]): Peeking into forward N rows in partition
--    1.3 LAG(expression, [offset], [default]): Peeking into backward N rows in partition
--    1.4 Default Value Handling: Avoiding NULL traps via custom fallback parameters

-- 2. Partitioning & Sorting Execution Rules
--    2.1 Global sequence vs Partition-scoped boundaries (PARTITION BY Clause)
--    2.2 Mandatory ORDER BY requirement within OVER() clause for deterministic offsets
--    2.3 In-memory window buffering vs Physical tempdb spilling

-- 3. Enterprise Delta Pipeline & Inventory Analysis
--    3.1 Daily Stock Inventory shift calculation (Current Stock - Next Day Stock)
--    3.2 Wrapping LEAD/LAG inside CTEs for mathematical delta transformations
--    3.3 Period-over-Period (MoM, YoY) comparative analytics pipelines

-- 4. Running / Cumulative Aggregate Window Functions
--    4.1 Cumulative Running Sum: `SUM(Metric) OVER (PARTITION BY ... ORDER BY ...)`
--    4.2 Running Minimum / Maximum: `MIN(Metric) / MAX(Metric) OVER (...)`
--    4.3 Default Frame Specification: `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`

-- 5. Multi-Row Sequence & Boundary Comparison Patterns
--    5.1 Finding sandwiched values: `PreviousValue < CurrentValue < NextValue`
--    5.2 Identifying order gaps & dormancy: `DATEDIFF(day, LAG(OrderDate), OrderDate) >= 30`
--    5.3 Order amount drop patterns: Comparing 2nd order amount vs 50% of 1st order amount
