/* ============================================================
               DAY 10 PRACTICE QUESTIONS (11 AUGUST 2026)
               TOPICS: DEFAULT CONSTRAINT, IDENTITY AUTO-INCREMENT,
                       10 DATA INSERTION PATTERNS, SET IDENTITY_INSERT
               REVISION: DAYS 1 - 9 (CONSTRAINTS, PRIMARY KEY, CHECK, UPDATE)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - DEFAULT & IDENTITY Declaration]:
/*
Task: Write DDL queries:
1. Create table 'Demo_Default' with: ItemID INT PRIMARY KEY, Country VARCHAR(20) DEFAULT 'India', LogDate DATETIME DEFAULT GETDATE().
2. Create table 'Demo_Identity' with: AutoID INT PRIMARY KEY IDENTITY(1, 1), ItemName VARCHAR(20).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - IDENTITY Seed & Increment Variants]:
/*
Task: Write DDL queries:
1. Create table 'Seq_100' with: CustomID INT PRIMARY KEY IDENTITY(100, 10), BatchName VARCHAR(20).
2. Create table 'Seq_500' with: RegID INT PRIMARY KEY IDENTITY(500, 1), CustomerName VARCHAR(30).
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - DEFAULT Keyword in INSERT]:
/*
Task: Write INSERT statements into 'Demo_Default':
1. Explicitly passing DEFAULT keyword for Country column.
2. Omitting Country column in INSERT column list.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - SET IDENTITY_INSERT Commands]:
/*
Task: Write the syntax to turn IDENTITY_INSERT ON for table 'Demo_Identity', insert an explicit ID = 999, and turn IDENTITY_INSERT OFF.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 9 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-9 Revision - Schema Creation & Constraints]:
/*
Task:
1. Create table 'EmployeeMaster' with: EmpID INT PRIMARY KEY IDENTITY(1, 1), EmpName VARCHAR(30) NOT NULL, Dept VARCHAR(20) CHECK (Dept IN ('HR', 'IT', 'Finance')), Salary INT CHECK (Salary > 0), City VARCHAR(20) DEFAULT 'Nagpur'.
2. Insert 4 records demonstrating IDENTITY auto-generation and DEFAULT city.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-9 Revision - Selective Queries & Aggregates]:
/*
Task: Select Dept, COUNT(EmpID) AS EmpCount, AVG(Salary) AS AvgSal from 'EmployeeMaster' grouped by Dept HAVING AVG(Salary) > 30000.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - DEFAULT System Functions & Values]:
/*
Scenario: Auditing automatic default column population.
Task:
1. Create table 'OrderTracking' (OrderID INT PRIMARY KEY IDENTITY(1001, 1), OrderItem VARCHAR 30, Status VARCHAR 15 DEFAULT 'Pending', OrderDate DATETIME DEFAULT GETDATE()).
2. Insert a row supplying values for ALL columns explicitly.
3. Insert a row passing DEFAULT keyword for Status.
4. Insert a row omitting Status and OrderDate.
5. Select all records and verify default values.
*/

-- Write your SQL Queries below:




-- QUESTION 8 [Scenario - Auto-Increment Gaps & Manual Identity Insertion]:
/*
Scenario: E-commerce order log identity auto-increment behavior.
Task:
1. Create table 'AutoInvoice' (InvoiceNo INT PRIMARY KEY IDENTITY(500, 5), CustomerName VARCHAR 30).
2. Insert 3 rows without passing InvoiceNo.
3. Attempt to manually insert InvoiceNo = 999 and explain the resulting error message.
4. Enable SET IDENTITY_INSERT ON, insert InvoiceNo = 999, and turn SET IDENTITY_INSERT OFF.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 9 [Scenario - 10 Data Insertion Patterns Drill]:
/*
Scenario: Data Engineering pipeline insertion flexibility testing.
Task: Using table 'EmployeeMaster' from Question 5, write INSERT queries demonstrating:
1. Full column insertion in exact matching order.
2. Full column insertion using explicit column list.
3. Column list in non-matching table order.
4. Omitted optional column (relying on DEFAULT).
5. Omitted multiple optional columns.
6. Explicit DEFAULT keyword usage.
7. Multi-row bulk insertion in a single statement.
8. Insertion with expressions/functions in value list.
9. Insertion with NULL in an optional column.
10. Explicit IDENTITY override (with IDENTITY_INSERT ON).
*/

-- Write your 10 SQL INSERT Queries below:




-- QUESTION 10 [Scenario - Customer Onboarding System Validation]:
/*
Scenario: Customer management database setup.
Task:
1. Create table 'CustomerDirectory' with CustomerID INT PRIMARY KEY IDENTITY(1, 1), FullName VARCHAR 40 NOT NULL, Email VARCHAR 50 UNIQUE, Country VARCHAR 20 DEFAULT 'India', JoinedDate DATETIME DEFAULT GETDATE().
2. Insert 3 customers testing IDENTITY auto-generation and DEFAULT Country.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Auto-Increment Gap Analysis]:
/*
Task:
1. What happens to the IDENTITY sequence if an INSERT transaction fails due to a constraint check (e.g. CHECK constraint failure)?
2. Does SQL Server reuse or rollback the failed identity integer?
*/

-- Write your answers in comments below:




-- QUESTION 12 [Logic Builder - IDENTITY_INSERT Scoping Rules]:
/*
Task:
1. How many tables can have SET IDENTITY_INSERT ON simultaneously in a single session?
2. What happens if you forget to turn SET IDENTITY_INSERT OFF after manual insertion?
*/

-- Write your answers in comments below:




-- QUESTION 13 [Debugging - SET IDENTITY_INSERT Errors]:
/*
Task: Identify why the query 'INSERT INTO AutoInvoice (InvoiceNo, CustomerName) VALUES (700, 'Arpit');' fails when IDENTITY_INSERT is OFF, and write the fix.
*/

-- Write your explanation & corrected query below:




-- QUESTION 14 [Debugging - Column List Mismatch in IDENTITY_INSERT]:
/*
Task: Explain why 'SET IDENTITY_INSERT AutoInvoice ON; INSERT INTO AutoInvoice VALUES (705, 'Aditya');' fails when explicit column list is omitted.
*/

-- Write your explanation in comments below:




/* ============================================================
                   END OF DAY 10 PRACTICE
   ============================================================ */
