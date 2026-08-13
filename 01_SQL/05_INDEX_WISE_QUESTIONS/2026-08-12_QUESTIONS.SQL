/* ============================================================
               DAY 11 PRACTICE QUESTIONS (12 AUGUST 2026)
               TOPICS: PARENT VS CHILD TABLE RELATIONSHIPS,
                       FOREIGN KEY ENFORCEMENT & DESTRUCTION TESTS
               REVISION: DAYS 1 - 10 (FULL CUMULATIVE MASTER REVIEW)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 10 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - FK Reference Syntax & Rules]:
/*
Task: Write simple DDL statements:
1. Write the inline syntax to define a Foreign Key constraint during CREATE TABLE.
2. Write the syntax to DROP a child table.
3. Write the syntax to DELETE a specific row using WHERE.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Basic Syntax - Teardown Order Principles]:
/*
Task: Write out the correct 2-step sequence to drop a parent table 'Dept' and child table 'Emp'.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 10 MASTER CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-10 Master Revision - Schema Setup]:
/*
Task:
1. Create Parent table 'SupplierMaster' with: SupplierID (INT PRIMARY KEY IDENTITY(100, 1)), SupplierName (VARCHAR 30 NOT NULL), Rating (INT DEFAULT 3 CHECK (Rating BETWEEN 1 AND 5)), City (VARCHAR 20 DEFAULT 'Mumbai').
2. Insert 5 supplier records.
3. Alter 'SupplierMaster' to ADD column 'ContactEmail' (VARCHAR 40 UNIQUE).
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Days 1-10 Master Revision - Aggregations & Sorting]:
/*
Task: Write a query on 'SupplierMaster' returning City-wise average Supplier Rating for cities having COUNT(SupplierID) >= 1, sorted by average rating DESCENDING.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: PARENT & CHILD DESTRUCTION TESTS
-- ============================================================

-- QUESTION 5 [Scenario - Referential Integrity Rule Matrix]:
/*
Scenario: Security audit establishing database table maintenance policies.
Task: Complete the rule matrix in comments:

   Operation         | Child Table (Referencing) | Parent Table (Referenced - Has FK References)
   ------------------|---------------------------|---------------------------------------------
   DELETE Row        |                           |
   TRUNCATE Table    |                           |
   DROP Table        |                           |
*/

-- Write your answers in comments below:




-- QUESTION 6 [Scenario - Testing DELETE on Unreferenced vs Referenced Rows]:
/*
Scenario: Database maintenance testing.
Task:
1. Create Parent table 'DeptParent' (DeptID INT PRIMARY KEY, DeptName VARCHAR 20).
2. Create Child table 'EmpChild' (EmpID INT PRIMARY KEY, EmpName VARCHAR 20, DeptID INT FOREIGN KEY REFERENCES DeptParent(DeptID)).
3. Insert Parent rows (10, 'HR'), (20, 'IT'), (30, 'Finance').
4. Insert Child rows referencing DeptID 10 and 20 only (DeptID 30 has NO child references).
5. Execute 'DELETE FROM DeptParent WHERE DeptID = 30' (Record result: Success).
6. Execute 'DELETE FROM DeptParent WHERE DeptID = 10' (Record error: Constraint Conflict).
*/

-- Write your SQL Queries & results below:




-- QUESTION 7 [Scenario - Testing TRUNCATE on Parent & Child Tables]:
/*
Scenario: Testing table wiping behavior on relational tables.
Task:
1. Execute 'TRUNCATE TABLE EmpChild' on the child table (Record result: Success).
2. Execute 'TRUNCATE TABLE DeptParent' on the parent table (Record error: FK reference error).
3. Explain why TRUNCATE fails on parent tables even when child table row count is 0.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 8 [Scenario - Multi-Tier Cascading Schema Teardown]:
/*
Scenario: Designing a 3-Tier E-commerce schema (Customers -> Orders -> OrderItems).
Task:
1. Create Customer table 'Cust_Tier1' (CustID INT PRIMARY KEY).
2. Create Orders table 'Ord_Tier2' (OrderID INT PRIMARY KEY, CustID INT FOREIGN KEY REFERENCES Cust_Tier1(CustID)).
3. Create OrderItems table 'Items_Tier3' (ItemID INT PRIMARY KEY, OrderID INT FOREIGN KEY REFERENCES Ord_Tier2(OrderID), Price INT CHECK (Price > 0)).
4. Write out the exact 3-step sequence required to DROP all 3 tables without disabling constraints.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Orphan Record Prevention]:
/*
Task:
1. What is an 'Orphan Record' in database terminology?
2. How do Foreign Key constraints prevent orphan records from being created?
*/

-- Write your explanation in comments below:




-- QUESTION 10 [Debugging - Teardown Order Violation Errors]:
/*
Task: Explain why executing the teardown script below fails and rewrite it in the correct order:
-- Buggy Teardown:
DROP TABLE Cust_Tier1;
DROP TABLE Ord_Tier2;
DROP TABLE Items_Tier3;
*/

-- Write your explanation & corrected script below:




/* ============================================================
                   END OF DAY 11 PRACTICE
   ============================================================ */
