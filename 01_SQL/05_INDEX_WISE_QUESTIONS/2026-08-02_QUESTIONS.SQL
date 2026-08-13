/* ============================================================
               DAY 2 PRACTICE QUESTIONS & SOLUTIONS (2 AUGUST 2026)
               TOPICS: SQL FILTERS, WHERE CLAUSE, COMPARISON OPERATORS,
                       IN, BETWEEN, NULLS, LOGICAL OPERATORS, LIKE WILDCARDS
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - Relational & Equality Filters]:
/*
Task: Write queries on table 'EmpData(EmpID INT, EmpName VARCHAR 30, Dept VARCHAR 20, Salary INT)':
1. Select employees where Salary = 30000.
2. Select employees where Salary > 40000.
3. Select employees where Dept <> 'HR'.
*/

-- Solution:
SELECT * FROM EmpData WHERE Salary = 30000;
SELECT * FROM EmpData WHERE Salary > 40000;
SELECT * FROM EmpData WHERE Dept <> 'HR';


-- QUESTION 2 [Basic Syntax - IN, BETWEEN & NULL Filters]:
/*
Task: Write queries on table 'EmpData':
1. Select employees where Dept IN ('HR', 'IT').
2. Select employees where Salary BETWEEN 20000 AND 50000.
3. Select employees where Dept IS NULL.
*/

-- Solution:
SELECT * FROM EmpData WHERE Dept IN ('HR', 'IT');
SELECT * FROM EmpData WHERE Salary BETWEEN 20000 AND 50000;
SELECT * FROM EmpData WHERE Dept IS NULL;


-- ============================================================
-- SECTION 2: DAY 1 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Day 1 Revision - Table Setup & Ingestion]:
/*
Task:
1. Create table 'CorporateClients' with: ClientID (INT), CompanyName (VARCHAR 40), IndustrySector (VARCHAR 25), AnnualRevenue (INT), CreditScore (INT), ContactEmail (VARCHAR 50).
2. Insert 5 sample records including 1 row with NULL IndustrySector and 1 row with NULL ContactEmail.
*/

-- Solution:
CREATE TABLE CorporateClients
(
    ClientID       INT,
    CompanyName    VARCHAR(40),
    IndustrySector VARCHAR(25),
    AnnualRevenue  INT,
    CreditScore    INT,
    ContactEmail   VARCHAR(50)
);

INSERT INTO CorporateClients VALUES (1, 'TechNova Solutions', 'Technology', 1200000, 780, 'contact@technova.com');
INSERT INTO CorporateClients VALUES (2, 'Apex Healthcare', 'Healthcare', 850000, 720, 'info@apexhealth.org');
INSERT INTO CorporateClients VALUES (3, 'Global Logistics', NULL, 450000, 640, 'support@globallogistics.com');
INSERT INTO CorporateClients VALUES (4, 'BlueSky Retail', 'Retail', 300000, 590, NULL);
INSERT INTO CorporateClients VALUES (5, 'Omega Finance', 'Finance', 950000, 810, 'admin@omegafinance.com');


-- QUESTION 4 [Day 1 Revision - Selective Ingestion & Retrieval]:
/*
Task:
1. Insert a client providing only ClientID, CompanyName, and AnnualRevenue.
2. Retrieve all clients where CreditScore IS NULL.
*/

-- Solution:
INSERT INTO CorporateClients (ClientID, CompanyName, AnnualRevenue) VALUES (6, 'Alpha Corp', 500000);
SELECT * FROM CorporateClients WHERE CreditScore IS NULL;


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Financial Risk Account Screening]:
/*
Scenario: Bank compliance audit flagging corporate accounts.
Task:
1. Select all clients with AnnualRevenue >= 500,000.
2. Select all clients where IndustrySector <> 'Technology'.
3. Select clients with AnnualRevenue BETWEEN 200,000 AND 800,000 AND CreditScore >= 650.
*/

-- Solution:
SELECT * FROM CorporateClients WHERE AnnualRevenue >= 500000;
SELECT * FROM CorporateClients WHERE IndustrySector <> 'Technology';
SELECT * FROM CorporateClients WHERE AnnualRevenue BETWEEN 200000 AND 800000 AND CreditScore >= 650;


-- QUESTION 6 [Scenario - Security Pattern Matching with LIKE Wildcards]:
/*
Scenario: Searching client email domains and company prefixes.
Task:
1. Find clients whose CompanyName starts with 'Tech'.
2. Find clients whose ContactEmail ends with '.org'.
3. Find clients whose CompanyName contains 'Global'.
*/

-- Solution:
SELECT * FROM CorporateClients WHERE CompanyName LIKE 'Tech%';
SELECT * FROM CorporateClients WHERE ContactEmail LIKE '%.org';
SELECT * FROM CorporateClients WHERE CompanyName LIKE '%Global%';


-- QUESTION 7 [Scenario - Single-Character & Range Wildcards]:
/*
Task:
1. Find clients whose CompanyName has 'o' as the second character ('_o%').
2. Find clients whose CompanyName starts with letters A through F ('[A-F]%').
3. Find clients whose CompanyName does NOT start with letters A, B, or C ('[^A-C]%').
*/

-- Solution:
SELECT * FROM CorporateClients WHERE CompanyName LIKE '_o%';
SELECT * FROM CorporateClients WHERE CompanyName LIKE '[A-F]%';
SELECT * FROM CorporateClients WHERE CompanyName LIKE '[^A-C]%';


-- QUESTION 8 [Scenario - Multi-Condition Logical Filters (AND / OR)]:
/*
Task:
1. Select clients where IndustrySector = 'Finance' AND CreditScore > 750.
2. Select clients where IndustrySector = 'Healthcare' OR AnnualRevenue > 1000000.
3. Select clients where (IndustrySector = 'IT' OR IndustrySector = 'Finance') AND CreditScore BETWEEN 600 AND 800.
*/

-- Solution:
SELECT * FROM CorporateClients WHERE IndustrySector = 'Finance' AND CreditScore > 750;
SELECT * FROM CorporateClients WHERE IndustrySector = 'Healthcare' OR AnnualRevenue > 1000000;
SELECT * FROM CorporateClients WHERE (IndustrySector = 'IT' OR IndustrySector = 'Finance') AND CreditScore BETWEEN 600 AND 800;


-- ============================================================
-- SECTION 4: LOGIC BUILDER & METADATA DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - NULL Behavior in Relational Operators]:
/*
Task:
1. Why does 'WHERE Dept <> 'HR'' fail to return rows where Dept is NULL?
2. Write a corrected query that returns both non-HR departments AND NULL departments.
*/

-- Solution:
/*
1. EXPLANATION: Relational comparison operators (=, <>) evaluate NULL comparisons as UNKNOWN, so NULL rows are excluded automatically.
*/

-- 2. Corrected Query:
SELECT * FROM CorporateClients WHERE IndustrySector <> 'Technology' OR IndustrySector IS NULL;


-- QUESTION 10 [Metadata - System Catalog Queries]:
/*
Task:
1. Write a query to retrieve all table names from INFORMATION_SCHEMA.TABLES.
2. Write a query to retrieve all column names for 'CorporateClients' from INFORMATION_SCHEMA.COLUMNS.
*/

-- Solution:
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'CorporateClients';


/* ============================================================
                   END OF DAY 2 PRACTICE & SOLUTIONS
   ============================================================ */
