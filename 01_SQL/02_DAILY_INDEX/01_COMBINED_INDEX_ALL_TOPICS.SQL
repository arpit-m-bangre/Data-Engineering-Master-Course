================================================================================
                    MASTER COMBINED SQL COURSE INDEX
                         (ALL TOPICS TILL NOW)
================================================================================

Folder: 01_SQL/01_CLASS_NOTES
Total Modules / Files: 14 Class Note Files (2026-08-01 to 2026-08-17)

================================================================================
SECTION 1: DAILY CLASS BREAKDOWN
================================================================================

1. DAY 1 (AUGUST 1) - SQL BASICS & ARCHITECTURE
   1.1 Basic SQL Theory (Data, Database, DBMS, RDBMS, SQL)
   1.2 Types of SQL Commands (DDL, DML, DQL, DCL, TCL)
   1.3 SQL Server & SSMS Environment Overview
   1.4 Database Objects & Table Concepts
   1.5 Primary Key & Foreign Key Principles
   1.6 Creating Tables (CREATE TABLE employee, employee1, StudentInfo)
   1.7 Data Extraction (SELECT *, SELECT specific columns)
   1.8 Basic Data Insertion (INSERT INTO, VARCHAR limits, NULL handling)

2. DAY 2 (AUGUST 2) - SQL CLAUSES & FILTERING OPERATORS
   2.1 Overview of SQL Clauses (WHERE, GROUP BY, HAVING, ORDER BY)
   2.2 Comparison Operators (=, <>, <, <=, >, >=) & ASCII Character Comparisons
   2.3 Special Operators (IN, NOT IN, IS NULL, IS NOT NULL, BETWEEN, NOT BETWEEN)
   2.4 Logical Operators (AND, OR)
   2.5 Pattern Matching (LIKE Operator with %, _, [A-Z], [^A-Z] Wildcards)
   2.6 Database Exploration (INFORMATION_SCHEMA.TABLES) & Batch Inserts

3. DAY 3 (AUGUST 3) - PRACTICAL FILTERING EXERCISES
   3.1 Range & List Filtering (Salary NOT BETWEEN & dept IN)
   3.2 Character Length & Boundary Pattern Matching (LIKE 'A____n')
   3.3 Exclusion Substring Filtering (Email NOT LIKE '%gmail%')
   3.4 Vowel Detection in Strings (Case-insensitive LIKE matching)
   3.5 Alphanumeric Pattern Detection ([A-Za-z] and [0-9])
   3.6 Range Filtering without BETWEEN or LIKE (>= and <=)

4. DAY 4 (AUGUST 4) - ARITHMETIC OPERATIONS, UPDATE, DELETE & DROP
   4.1 Supported Numeric Data Types (INT, FLOAT, DOUBLE, DECIMAL)
   4.2 Arithmetic Operators (+, -, *, /) & Computed Alias Columns
   4.3 DML Operations: DELETE Statement (Syntax, Purpose, WHERE Clause Usage)
   4.4 DML Operations: UPDATE Statement (Single/Multiple Columns, Conditional Updates)
   4.5 Handling NULL Values & Empty Strings ('') in UPDATE
   4.6 DDL Operations: DROP TABLE Statement & Object Cleanup
   4.7 Database Security & Permission Hierarchy (DBA Role vs Employee Permissions)

5. DAY 5 (AUGUST 5) - DATA DELETION METHODS & ALTER TABLE
   5.1 Comparative Analysis: DELETE (DML) vs TRUNCATE (DDL) vs DROP (DDL)
   5.2 Performance, Speed, and WHERE Clause Support
   5.3 ALTER TABLE Operations (ADD Column, DROP Column)
   5.4 ALTER COLUMN Operations (Changing Data Types INT <-> VARCHAR, Modifying Length)
   5.5 Object Renaming using sp_rename procedure (Table & Column renaming)

6. DAY 6 (AUGUST 6) - AGGREGATE FUNCTIONS, DISTINCT & TOP N
   6.1 Aggregate Functions (MIN, MAX, SUM, AVG, COUNT)
   6.2 Data Type Rules for Aggregates (Numeric requirements for SUM/AVG)
   6.3 NULL Handling in Aggregates (AVG ignores NULL, COUNT(*) counts NULL)
   6.4 DISTINCT Keyword & COUNT(DISTINCT) Syntax Rules
   6.5 TOP N Clause in SQL Server
   6.6 Introduction to GROUP BY Clause with Aggregate Functions

7. DAY 7 (AUGUST 7) - ADVANCED GROUP BY, HAVING & ORDER BY
   7.1 Execution Order of SQL Clauses (FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY)
   7.2 Combining GROUP BY with WHERE Clause Filters
   7.3 HAVING Clause vs WHERE Clause (Filtering Aggregate Groups vs Individual Rows)
   7.4 Column Alias Scoping in HAVING vs ORDER BY
   7.5 ORDER BY Clause (ASC & DESC Sorting Rules)
   7.6 9 Scenario-Based Class Tasks (Employees, Sales, Orders, Products, Transactions, Bookings, Subscriptions, Inventory, Expenses)

8. DAY 8 (AUGUST 8) - COMPLEX SCENARIOS & ERROR ANALYSIS
   8.1 Complex Scenario Questions Q1 to Q6 (Finance, Cities, Departments, Salary Audits, Promotions)
   8.2 In-Depth Analysis of Common Query Mistakes & Misconceptions
   8.3 Rule Summary: WHERE -> ROWS, HAVING -> GROUPS

9. DAY 9 (AUGUST 10) - SQL CONSTRAINTS & DATA VALIDATION
   9.1 Definition & Purpose of Constraints in SQL
   9.2 Data Validation vs Built-in Constraints
   9.3 PRIMARY KEY Constraint (Uniqueness, NOT NULL, Key Folder Inspection)
   9.4 UNIQUE Constraint (Uniqueness, Single NULL support, comparison with DISTINCT)
   9.5 NOT NULL Constraint & Combining NOT NULL + UNIQUE
   9.6 CHECK Constraint (Custom Range, Pattern, List, and Negation Filters)

10. DAY 10 (AUGUST 11) - DEFAULT, IDENTITY & FOREIGN KEY ARCHITECTURE
    10.1 DEFAULT Constraint & Combining DEFAULT with CHECK
    10.2 10 Main Patterns for Inserting Data in SQL
    10.3 AUTO INCREMENT (IDENTITY(start, increment)) Rules & Data Type Constraints
    10.4 FOREIGN KEY Concept & Relational Database Architecture (ETL Weight)
    10.5 Parent / Child Table Relationships & Referential Integrity Rules
    10.6 DELETE, TRUNCATE, and DROP Behavior on Parent vs Child Tables

11. DAY 11 (AUGUST 12) - PARENT VS CHILD TABLE DESTRUCTION TESTS
    11.1 Parent Protection vs Child Table Destruction Principles
    11.2 Practical Tests on DELETE (Unreferenced vs Referenced Rows)
    11.3 Practical Tests on TRUNCATE (Referenced Parent Table Failure)
    11.4 Practical Tests on DROP (Referenced Parent Table Failure)

12. DAY 12 (AUGUST 13) - RETROFITTING CONSTRAINTS & COLUMN PROPERTIES
    12.1 Parent/Child Destruction Rules Recap & Why TRUNCATE is DDL
    12.2 System Metadata Auditing (INFORMATION_SCHEMA.TABLES & TABLE_CONSTRAINTS)
    12.3 Data Pre-Cleaning Strategies for Existing Live Tables
    12.4 Retrofitting Constraints via ALTER TABLE ADD CONSTRAINT (UNIQUE, CHECK, FOREIGN KEY, DEFAULT)
    12.5 Column Property vs Table Constraint Distinction (NOT NULL & IDENTITY via ALTER COLUMN)
    12.6 Offline SQL Test 1 Analysis (18 MCQs: Execution Flow, Scoping, TRUNCATE Rollback inside Transactions)

13. DAY 13 (AUGUST 14) - SET OPERATORS & QUERY COMBINATION
    13.1 UNION Operator (Combining Result Sets without Duplicates)
    13.2 UNION ALL Operator (Combining Result Sets with Duplicates)
    13.3 INTERSECT Operator (Extracting Common Rows)
    13.4 EXCEPT Operator (Mathematical MINUS, Extracting Differences)
    13.5 Structural Validation Rules for Set Operations (Same Columns & Data Types)
    13.6 Applying Set Operators to Individual Columns vs Entire Tables

14. DAY 14 (AUGUST 17) - TEMPORAL DATA TYPES & DATE FUNCTIONS
    14.1 DATE & DATETIME Data Types in Enterprise Databases
    14.2 Datepart Interval Codes (YY, QQ, MM, DY, DD, WK, WEEKDAY, HH, N, S, MS)
    14.3 Valid Date Literal Formats (MM/DD/YYYY, YYYY-MM-DD ISO Standard)
    14.4 GETDATE() Function (Capturing Live System Clock Timestamps)
    14.5 DATEDIFF() Function (Calculating Time Differences Across Intervals)
    14.6 Boundary Counting Mechanics & Overflow Traps in DATEDIFF
    14.7 DATEPART() Function (Extracting Calendar & Clock Components)
    14.8 DATEADD() Function (Adding/Subtracting Time Horizons)
    14.9 EOMONTH() Function (Finding Month-End Dates & Leap Year Handling)
    14.10 Practical Table Scenarios (Churn Analysis, Weekend Onboarding, Aging)

================================================================================
SECTION 2: MASTER TOPIC INDEX BY CATEGORY
================================================================================

A. DATABASE CONCEPTS & ENVIRONMENT
   • Data, Database, DBMS, RDBMS Definitions
   • SQL Server Architecture & SSMS Navigation
   • Database Objects (Tables, Views, Stored Procedures, Functions, Triggers, Indexes)
   • Data Validation & DBA Security Permissions
   • Information Schema Auditing (INFORMATION_SCHEMA.TABLES, TABLE_CONSTRAINTS)

B. DATA DEFINITION LANGUAGE (DDL)
   • CREATE TABLE & Column Data Types (INT, FLOAT, DECIMAL, VARCHAR, CHAR, TEXT, DATE, DATETIME)
   • ALTER TABLE (ADD Column, DROP Column, ALTER COLUMN Data Type & Size)
   • Retrofitting Constraints on Existing Live Tables (ADD CONSTRAINT)
   • Column Properties Modification (ALTER COLUMN NOT NULL)
   • Object Renaming (sp_rename for Tables and Columns)
   • TRUNCATE TABLE vs DROP TABLE (DDL Storage Deallocation Mechanics)

C. DATA MANIPULATION LANGUAGE (DML)
   • INSERT INTO (10 Insertion Patterns, Multi-row, Column-specified, SELECT INTO)
   • UPDATE (Single/Multiple Columns, Arithmetic Calculations, Handling NULLs)
   • DELETE (Row-level deletion with WHERE clause)
   • Pre-cleaning Data Strategy before retrofitting constraints

D. DATA QUERY LANGUAGE (DQL) & CLAUSES
   • SELECT (Projections, Computed Output Columns, Aliases)
   • WHERE (Filtering Rows via Comparison, Logical, Range, List, Pattern Operators)
   • GROUP BY (Grouping Rows with Aggregate Functions)
   • HAVING (Filtering Aggregated Groups)
   • ORDER BY (Sorting Results by Single/Multiple Columns ASC/DESC)
   • TOP N Clause

E. OPERATORS & PATTERN MATCHING
   • Comparison: =, <>, <, <=, >, >=
   • Range & List: BETWEEN, NOT BETWEEN, IN, NOT IN
   • Nullability: IS NULL, IS NOT NULL
   • Logical: AND, OR
   • String Patterns: LIKE with %, _, [A-Z], [^A-Z]
   • Arithmetic: +, -, *, /
   • Set Operators: UNION, UNION ALL, INTERSECT, EXCEPT

F. AGGREGATE FUNCTIONS & UNICITY
   • MIN(), MAX(), SUM(), AVG(), COUNT(), COUNT(*)
   • NULL Values in Aggregate Calculations
   • DISTINCT & COUNT(DISTINCT)

G. CONSTRAINTS & KEYS
   • PRIMARY KEY (Unique + NOT NULL, 1 per table)
   • UNIQUE (Unique + 1 NULL allowed, retrofitting via ADD CONSTRAINT)
   • NOT NULL (Mandatory column property, retrofitting via ALTER COLUMN)
   • CHECK (Custom validation expressions, retrofitting via ADD CONSTRAINT)
   • DEFAULT (Automatic fallback values, retrofitting via ADD CONSTRAINT ... DEFAULT ... FOR)
   • IDENTITY (Auto-incrementing seed & step, column property rules on live tables)
   • FOREIGN KEY (Referential Integrity, Parent/Child Table Protection Rules, Retrofitting via ADD CONSTRAINT)

H. TEMPORAL & DATE FUNCTIONS
   • GETDATE() (Server timestamp retrieval)
   • DATEDIFF() (Interval difference, boundary crossing logic, integer overflow traps)
   • DATEPART() (Component extraction: Year, Quarter, Month, Weekday, Hour, Minute)
   • DATEADD() (Future/past date shift calculations, recurring cycles)
   • EOMONTH() (Month-end date generation, leap year auto-detection)
   • Real-world scenarios (Customer churn, SLAs, aging, anniversary alerts)

================================================================================
