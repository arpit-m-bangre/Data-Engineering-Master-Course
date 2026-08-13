/* ============================================================
               DAY 2 PRACTICE QUESTIONS (2 AUGUST 2026)
               TOPICS: SQL FILTERS, WHERE CLAUSE, COMPARISON OPERATORS,
                       IN, BETWEEN, NULLS, LOGICAL OPERATORS, LIKE WILDCARDS
               REVISION: DAY 1 (TABLE CREATION, DATA TYPES, DML)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Relational & Equality Operators]:
/*
Task: Write queries on table 'EmpData(EmpID INT, EmpName VARCHAR 30, Dept VARCHAR 20, Salary INT)':
1. Select employees where Salary = 30000.
2. Select employees where Salary > 40000.
3. Select employees where Salary <= 25000.
4. Select employees where Dept <> 'HR'.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - IN & NOT IN List Filtering]:
/*
Task: Write queries on 'EmpData':
1. Select employees where Dept IN ('HR', 'IT').
2. Select employees where Dept NOT IN ('Admin', 'Sales').
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - BETWEEN & Range Bounds]:
/*
Task: Write queries on 'EmpData':
1. Select employees where Salary BETWEEN 20000 AND 50000.
2. Select employees where Salary NOT BETWEEN 30000 AND 70000.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - IS NULL & IS NOT NULL]:
/*
Task: Write queries on 'EmpData':
1. Select employees where Dept IS NULL.
2. Select employees where Dept IS NOT NULL.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAY 1 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Day 1 Revision - Table Setup & Ingestion]:
/*
Task:
1. Create table 'CorporateClients' with: ClientID (INT), CompanyName (VARCHAR 40), IndustrySector (VARCHAR 25), AnnualRevenue (INT), CreditScore (INT), ContactEmail (VARCHAR 50).
2. Insert 5 sample records including 1 row with NULL IndustrySector and 1 row with NULL ContactEmail.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Day 1 Revision - Selective Ingestion & Retrieval]:
/*
Task:
1. Insert a client providing only ClientID, CompanyName, and AnnualRevenue.
2. Retrieve all clients where CreditScore IS NULL.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Financial Risk Account Screening]:
/*
Scenario: Bank compliance audit flagging corporate accounts.
Task:
1. Select all clients with AnnualRevenue >= 500,000.
2. Select all clients where IndustrySector <> 'Technology'.
3. Select clients with AnnualRevenue BETWEEN 200,000 AND 800,000 AND CreditScore >= 650.
*/

-- Write your SQL Queries below:




-- QUESTION 8 [Scenario - Security Pattern Matching with LIKE Wildcards]:
/*
Scenario: Searching client email domains and company prefixes.
Task:
1. Find clients whose CompanyName starts with 'Tech'.
2. Find clients whose ContactEmail ends with '.org'.
3. Find clients whose CompanyName contains 'Global'.
*/

-- Write your SQL Queries below:




-- QUESTION 9 [Scenario - Single-Character & Range Wildcards]:
/*
Task:
1. Find clients whose CompanyName has 'o' as the second character ('_o%').
2. Find clients whose CompanyName starts with letters A through F ('[A-F]%').
3. Find clients whose CompanyName does NOT start with letters A, B, or C ('[^A-C]%').
*/

-- Write your SQL Queries below:




-- QUESTION 10 [Scenario - Multi-Condition Logical Filters (AND / OR)]:
/*
Task:
1. Select clients where IndustrySector = 'Finance' AND CreditScore > 750.
2. Select clients where IndustrySector = 'Healthcare' OR AnnualRevenue > 1000000.
3. Select clients where (IndustrySector = 'IT' OR IndustrySector = 'Finance') AND CreditScore BETWEEN 600 AND 800.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & METADATA DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Relational Operator Behavior on NULLs]:
/*
Task:
1. Why does 'WHERE Dept <> 'HR'' fail to return rows where Dept is NULL?
2. Write a corrected query that returns both non-HR departments AND NULL departments.
*/

-- Write your explanation and SQL Query below:




-- QUESTION 12 [Logic Builder - Operator Precedence (AND over OR)]:
/*
Task: Explain why 'WHERE IndustrySector = 'IT' OR IndustrySector = 'Finance' AND CreditScore > 700' produces different results than 'WHERE (IndustrySector = 'IT' OR IndustrySector = 'Finance') AND CreditScore > 700'.
*/

-- Write your explanation in comments below:




-- QUESTION 13 [Metadata - System Catalog Queries]:
/*
Task:
1. Write a query to retrieve all table names from INFORMATION_SCHEMA.TABLES.
2. Write a query to retrieve all column names for 'CorporateClients' from INFORMATION_SCHEMA.COLUMNS.
*/

-- Write your SQL Queries below:




-- QUESTION 14 [Debugging - Fix Incorrect WHERE Operator Syntax]:
/*
Task: Identify and fix errors in the following 2 queries:
1. SELECT * FROM CorporateClients WHERE CreditScore = NULL;
2. SELECT * FROM CorporateClients WHERE AnnualRevenue BETWEEN 200000, 500000;
*/

-- Write your corrected SQL Queries below:




/* ============================================================
                   END OF DAY 2 PRACTICE
   ============================================================ */
