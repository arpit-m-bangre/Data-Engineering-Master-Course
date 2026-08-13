/* ============================================================
               DAY 10 PRACTICE QUESTIONS (11 AUGUST 2026)
               TOPICS: DEFAULT CONSTRAINT, 10 INSERTION PATTERNS,
                       IDENTITY (AUTO INCREMENT), FOREIGN KEY ARCHITECTURE
               REVISION: DAYS 1 - 9 (PK, UNIQUE, CHECK, GROUP BY, DML)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 10 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - DEFAULT, IDENTITY & FOREIGN KEY]:
/*
Task: Write simple DDL statements for:
1. Create table 'Demo_Default' with: City VARCHAR(20) DEFAULT 'Pune'.
2. Create table 'Demo_Identity' with: LogID INT IDENTITY(100, 1).
3. Create parent table 'Demo_Parent' (PKID INT PRIMARY KEY).
4. Create child table 'Demo_Child' (FKID INT FOREIGN KEY REFERENCES Demo_Parent(PKID)).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Basic Syntax - Explicit DEFAULT Keyword & Identity Values]:
/*
Task:
1. Insert a row into 'Demo_Default' using the explicit DEFAULT keyword.
2. Insert 3 rows into 'Demo_Identity' providing values for un-identity columns and observe auto-generated sequence.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 9 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-9 Revision - Schema & Constraints]:
/*
Task:
1. Create table 'PatientMaster' with: PatientID (INT PRIMARY KEY), PatientName (VARCHAR 30 NOT NULL), Age (INT CHECK (Age BETWEEN 0 AND 120)), WardType (VARCHAR 15 CHECK (WardType IN ('General', 'ICU', 'Private'))), TotalBill (INT CHECK (TotalBill >= 0)).
2. Insert 5 records.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Days 1-9 Revision - Aggregations & HAVING Filter]:
/*
Task: Write a GROUP BY query on 'PatientMaster' returning WardType, COUNT(PatientID), and AVG(TotalBill) for WardTypes with AVG(TotalBill) > 15000.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - DEFAULT Fallbacks & Account Initialization]:
/*
Scenario: E-commerce user account initialization.
Task:
1. Create table 'CustomerAccounts' (AccountID INT PRIMARY KEY, AccountType VARCHAR 15 DEFAULT 'Standard', CreditLimit INT DEFAULT 5000 CHECK (CreditLimit >= 1000)).
2. Insert a record providing ONLY AccountID and verify default fallback values.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Scenario - 10 Data Insertion Patterns Drill]:
/*
Scenario: Demonstrating all data insertion variations in production SQL.
Task: Write queries demonstrating the 10 data insertion patterns:
1. Pattern 1: All columns matching sequence.
2. Pattern 2: Explicit column list.
3. Pattern 3: Multiple specific columns.
4. Pattern 4: Multi-row INSERT.
5. Pattern 5: Multi-row specific columns.
6. Pattern 6: Omitted column DEFAULT fallback.
7. Pattern 7: Explicit DEFAULT keyword.
8. Pattern 8: Explicit NULL insertion.
9. Pattern 9: INSERT INTO ... SELECT.
10. Pattern 10: INSERT INTO ... SELECT with WHERE.
*/

-- Write your SQL Queries below:




-- QUESTION 7 [Scenario - AUTO INCREMENT (IDENTITY) Sequence Generation]:
/*
Scenario: Transaction log sequence generation.
Task:
1. Create table 'AuditLog' (LogID INT IDENTITY(1000, 5), EventDescription VARCHAR 50).
2. Insert 4 records providing ONLY EventDescription values.
3. Query all rows and observe LogID sequence (1000, 1005, 1010, 1015).
4. Explain why IDENTITY can only be applied to numeric data types.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 8 [Scenario - FOREIGN KEY Architecture & Violation Checks]:
/*
Scenario: Parent-Child relationship between Customers (Parent) and Orders (Child).
Task:
1. Create Parent table 'CustomerParent' (CustPKID INT PRIMARY KEY, CustomerName VARCHAR 30).
2. Create Child table 'OrdersChild' (OrderID INT PRIMARY KEY, CustFKID INT FOREIGN KEY REFERENCES CustomerParent(CustPKID), OrderAmount INT).
3. Insert 3 parent rows (1, 2, 3) and child rows referencing 1 and 2.
4. Test inserting a child row with CustFKID = 99 and record the error.
5. Test deleting parent row CustPKID = 1 and record the error.
*/

-- Write your SQL Queries & explanations below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DESTRUCTION RULES
-- ============================================================

-- QUESTION 9 [Logic Builder - Parent vs Child Protection Rules]:
/*
Task:
1. Explain why you cannot delete a parent row while active child records point to it.
2. Explain why TRUNCATE TABLE CustomerParent fails even if the child table OrdersChild contains 0 rows.
*/

-- Write your explanation in comments below:




-- QUESTION 10 [Debugging - Fix FK Insertion & Teardown Errors]:
/*
Task: Identify and fix errors in the following 2 queries:
1. INSERT INTO OrdersChild VALUES (101, 999, 5000); (PK 999 does not exist in parent)
2. DROP TABLE CustomerParent; (while child table OrdersChild still exists)
*/

-- Write your explanations & corrected sequence below:




/* ============================================================
                   END OF DAY 10 PRACTICE
   ============================================================ */
