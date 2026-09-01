-- ====================================================================================================
-- 📑 DAILY TOPIC INDEX - 01 SEPTEMBER 2026 (DAY 24)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: T-SQL Server Functions — String Manipulation, Slicing, Cleansing & Masking Engine
-- ====================================================================================================

/*
TOPIC BREAKDOWN:
----------------
1. T-SQL Server String Functions Overview (8 Primary Built-in Functions)
2. UPPER() & LOWER() Functions
   - Temporary case formatting in SELECT projections
   - Permanent data modification via DML UPDATE
   - Case-sensitivity check constraints and collation constraints (Latin1_General_BIN)
3. LEN() Function
   - Character count measurement
   - Trailing space exclusion vs leading/embedded space inclusion
   - Comparison with DATALENGTH() storage footprint
4. REVERSE() Function
   - Inverting character sequences
   - Mirror strings & extracting trailing boundary characters
5. REPLACE() Function
   - Search pattern substitution: REPLACE(string, old, new)
   - Nested replacement patterns and reversible restoration
6. REPLICATE() Function
   - Multiplying character strings for data masking and padding
7. String Concatenation: Operator '+' vs CONCAT()
   - Type mismatch errors in '+' operator
   - Null-coalescing behavior of CONCAT()
8. SUBSTRING() Function
   - 1-Based indexing syntax: SUBSTRING(string, start_pos, length)
   - Dynamic boundary slicing (First N chars, Last N chars)
9. Composite String Engineering
   - Combining String Functions with Temporal Functions (Dynamic Password Generators)
   - Masking sensitive PII (Phone numbers, Aadhar, Credit cards)
   - Simulating INITCAP (Title Casing) in T-SQL
   - Substring frequency counting formula: (LEN(str) - LEN(REPLACE(str, char, ''))) / LEN(char)
*/
