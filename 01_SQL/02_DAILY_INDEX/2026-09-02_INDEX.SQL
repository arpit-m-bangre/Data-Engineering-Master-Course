-- ====================================================================================================
-- 📑 DAILY TOPIC INDEX - 02 SEPTEMBER 2026 (DAY 25)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 🎯 TOPIC: T-SQL Server Functions Part 2 — LEFT, RIGHT, TRIM, CAST/CONVERT & Dynamic String Parsing
-- ====================================================================================================

/*
TOPIC BREAKDOWN:
----------------
1. Positional String Slicing: LEFT() & RIGHT()
   - LEFT(string, length): Prefix extraction from start boundary
   - RIGHT(string, length): Suffix extraction from end boundary
   - Practical business use cases: Slicing department prefixes, serial years, product codes
2. Whitespace Cleansing & Sanitization: TRIM(), LTRIM(), RTRIM()
   - TRIM(string): Removing leading and trailing whitespace and tabs
   - LTRIM(string): Stripping leading boundary whitespace
   - RTRIM(string): Stripping trailing boundary whitespace
   - Storage footprint audit using LEN() before and after cleansing
3. Data Type Transformation: CAST() vs CONVERT()
   - CAST(expression AS data_type): ANSI-SQL compliant type conversion
   - CONVERT(data_type, expression [, style]): T-SQL specific type conversion with style codes
   - Common date conversion styles: 1 (mm/dd/yy), 101 (mm/dd/yyyy), 103 (dd/mm/yyyy), 112 (yyyymmdd), 120 (yyyy-mm-dd hh:mi:ss)
   - Runtime type conversion in aggregates: SUM(CONVERT(INT, column))
   - Runtime casting (SELECT/Aggregation) vs Permanent schema mutation (DDL ALTER TABLE ... ALTER COLUMN)
4. Character & Substring Location: CHARINDEX()
   - CHARINDEX(substring, string [, start_location]): 1-based index positioning
   - Handling pattern absence (returns 0)
5. Dynamic Text Parsing & Cleansing Pipeline (Faculty Homework Drill)
   - Dynamic Full Name splitting into First Name and Second Name (Last Name)
   - Parsing first name via LEFT(FullName, CHARINDEX(' ', FullName) - 1)
   - Parsing second name via SUBSTRING(FullName, CHARINDEX(' ', FullName) + 1, LEN(FullName))
   - Alternative parsing via RIGHT(FullName, LEN(FullName) - CHARINDEX(' ', FullName))
   - Edge case handling: Single names without spaces, trailing spaces, middle names
6. Enterprise Query Architecture & Interview Playbook
   - Scenario-based interview problem solving methodology
   - Strategic prioritization: Clauses, Date Functions, Joins, Window Functions, CASE Statements, Server Functions, ISNULL
   - Performance Law: Avoiding Correlated Subqueries in favor of set-based Joins & Window Functions
   - Enterprise Database Objects Roadmap: Stored Procedures, Views, Triggers, Indexes
*/
