/* ============================================================
               DAY 11 PRACTICE QUESTIONS (12 AUGUST 2026)
               TOPICS: RELATIONAL DATABASE DESIGN, FOREIGN KEYS,
                       PARENT VS CHILD TABLES, DESTRUCTION RULES
               REVISION: DAYS 1 - 10 (PRIMARY KEY, IDENTITY, DEFAULT, CHECK)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Basic Parent-Child Foreign Key Syntax]:
/*
Task: Write DDL queries:
1. Create Parent table 'Depts' (DeptID INT PRIMARY KEY, DeptName VARCHAR 20).
2. Create Child table 'Staff' (StaffID INT PRIMARY KEY, StaffName VARCHAR 20, DeptID INT FOREIGN KEY REFERENCES Depts(DeptID)).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - 3-Tier Foreign Key Syntax]:
/*
Task: Write DDL queries:
1. Create Tier 1 Parent 'Companies' (CompID INT PRIMARY KEY, CompName VARCHAR 30).
2. Create Tier 2 Relational 'Branches' (BranchID INT PRIMARY KEY, BranchName VARCHAR 30, CompID INT FOREIGN KEY REFERENCES Companies(CompID)).
3. Create Tier 3 Child 'Employees_Tier3' (EmpID INT PRIMARY KEY, EmpName VARCHAR 30, BranchID INT FOREIGN KEY REFERENCES Branches(BranchID)).
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - Valid Foreign Key Row Insertions]:
/*
Task:
1. Insert 2 rows into Parent table 'Depts' (10, 'IT') and (20, 'HR').
2. Insert 2 valid rows into Child table 'Staff' referencing DeptID = 10 and DeptID = 20.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - Invalid Orphan Foreign Key Insertion]:
/*
Task: Write an INSERT statement into Child table 'Staff' attempting to reference DeptID = 99 (non-existent in Depts) and explain the resulting error message.
*/

-- Write your SQL Query & explanation below:




-- ============================================================
-- SECTION 2: DAYS 1 - 10 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-10 Revision - Parent Schema with Constraints]:
/*
Task:
1. Create Parent table 'DepartmentMaster' with: DeptID INT PRIMARY KEY IDENTITY(10, 10), DeptName VARCHAR(20) NOT NULL UNIQUE, Location VARCHAR(20) DEFAULT 'Pune'.
2. Create Child table 'EmployeeRegistry' with: EmpID INT PRIMARY KEY IDENTITY(100, 1), EmpName VARCHAR(30) NOT NULL, Salary INT CHECK (Salary > 0), DeptID INT FOREIGN KEY REFERENCES DepartmentMaster(DeptID).
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-10 Revision - Data Population & Join Preview]:
/*
Task: Insert 3 departments into 'DepartmentMaster' and 5 employees into 'EmployeeRegistry' verifying identity auto-generation and foreign key validation.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 3: PARENT VS CHILD INTEGRITY & DESTRUCTION RULES
-- ============================================================

-- QUESTION 7 [Scenario - Parent Row Deletion & Reference Protection]:
/*
Scenario: Auditing parent row deletion behavior.
Task:
1. Write a DELETE statement attempting to remove a parent department from 'DepartmentMaster' that has active child employees in 'EmployeeRegistry'.
2. Record and explain the resulting Foreign Key reference error message.
3. Write the correct 2-step procedure to safely delete that department (Child deletion first, then Parent deletion).
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 8 [Scenario - Truncation Protection on Parent Tables]:
/*
Scenario: Administrative table wiping attempt.
Task:
1. Write a TRUNCATE statement attempting to wipe Parent table 'DepartmentMaster'.
2. Record and explain why TRUNCATE fails on Parent tables referenced by a Foreign Key, even if the Child table is empty.
*/

-- Write your SQL Query & explanation below:




-- QUESTION 9 [Scenario - Drop Protection & Bottom-Up Teardown Script]:
/*
Scenario: Database schema teardown automation.
Task:
1. Write a DROP statement attempting to drop Parent table 'DepartmentMaster' while Child table 'EmployeeRegistry' exists, and record the error message.
2. Write the correct Bottom-Up Schema Teardown Script (Drop Child table first, then Drop Parent table).
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 10 [Scenario - Multi-Tier Supply Chain Referential Integrity]:
/*
Scenario: Auditing a 3-Tier Enterprise Supply Chain (Suppliers -> Products -> LineItems).
Task:
1. Create Tier 1 Parent 'SuppliersMaster' (SupplierID INT PRIMARY KEY IDENTITY(100,1), SupplierName VARCHAR 40).
2. Create Tier 2 Relational 'ProductsMaster' (ProductID INT PRIMARY KEY IDENTITY(500,1), ProductName VARCHAR 40, SupplierID INT FOREIGN KEY REFERENCES SuppliersMaster(SupplierID)).
3. Create Tier 3 Child 'LineItemsLog' (ItemID INT PRIMARY KEY IDENTITY(1,1), ProductID INT FOREIGN KEY REFERENCES ProductsMaster(ProductID), Quantity INT).
4. Populate 2 rows per table.
5. Write out the exact safe deletion/teardown order for removing Tier 1 Supplier 100.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & ARCHITECTURE DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - NULL Foreign Key Behavior]:
/*
Task:
1. Does a Foreign Key column allow NULL values by default if NOT NULL is omitted?
2. What is an orphan row, and how does a Foreign Key constraint prevent orphans?
*/

-- Write your answers in comments below:




-- QUESTION 12 [Logic Builder - Parent vs Child Destruction Rules Table]:
/*
Task: Complete the destruction rules summary table in comments:
Command   | Can execute on Parent with Child FK? | Reason
-----------------------------------------------------------
DELETE    | ?                                    | ?
TRUNCATE  | ?                                    | ?
DROP      | ?                                    | ?
*/

-- Write your answer in comments below:




-- QUESTION 13 [Debugging - Foreign Key References Non-PK Column]:
/*
Task: Explain why 'CREATE TABLE Child (ID INT, ParentCode VARCHAR(20) REFERENCES ParentTable(NonKeyCol));' fails if NonKeyCol is not a PRIMARY KEY or UNIQUE constraint in ParentTable.
*/

-- Write your explanation in comments below:




-- QUESTION 14 [Debugging - Circular Dependency Foreign Keys]:
/*
Task: Explain how circular foreign keys (Table A referencing Table B, and Table B referencing Table A) create drop/teardown issues, and how to resolve them.
*/

-- Write your explanation in comments below:




/* ============================================================
                   END OF DAY 11 PRACTICE
   ============================================================ */
