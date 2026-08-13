/* ================================================================================
   SQL CLASS NOTES - 13 AUGUST 2026 (DAY 12)
   TOPICS: PARENT/CHILD DESTRUCTION RULES RECAP, RETROFITTING CONSTRAINTS VIA ALTER TABLE,
           DATA CLEANING PRE-CONDITIONS, COLUMN PROPERTIES (NOT NULL, IDENTITY) VS TABLE CONSTRAINTS,
           INFORMATION_SCHEMA METADATA AUDITING, 18 MCQ TEST REVIEW & ERROR ANALYSIS
   FACULTY: DE COURSE INSTRUCTOR | STUDENT: ARPIT MANOJ BANGRE (BATCH 15)
   ================================================================================ */

-- ================================================================================
-- SECTION 1: PRIMARY KEY (PK) & FOREIGN KEY (FK) DESTRUCTION RULES RECAP
-- ================================================================================

-- Inspecting Parent (PK) and Child (FK) tables
SELECT * FROM q1; -- Parent Table (contains Primary Key)
SELECT * FROM q9; -- Child Table (contains Foreign Key referencing q1)

-- RULE 1: The Parent table containing Primary Key CANNOT be DELETED, TRUNCATED, or DROPPED 
-- while active Foreign Key references exist in Child table.
DELETE FROM q1;    -- FAILS if referenced child rows exist
TRUNCATE TABLE q1; -- FAILS always if referenced by Foreign Key constraint
DROP TABLE q1;     -- FAILS always if referenced by Foreign Key constraint

-- RULE 2: The Child table containing Foreign Key CAN be DELETED, TRUNCATED, and DROPPED freely.
DELETE FROM q9;    -- SUCCEEDS (Removes child rows)
TRUNCATE TABLE q9; -- SUCCEEDS (Resets child table identity & clears data)
DROP TABLE q9;     -- SUCCEEDS (Removes child table structure)

/*
   Visual Mapping of PK vs FK Validation:
   --------------------------------------
   PRIMARY KEY (q1)    FOREIGN KEY (q9)
   ----------------    ----------------
   1                   
   2                   2 (VALID - exists in PK)
   3                   3 (VALID - exists in PK)
   4                   5 (INVALID - fails FK validation because 5 does not exist in PK q1)
*/

-- CONCEPTUAL DEEP DIVE: Why is TRUNCATE classified as DDL even though it does not remove table structure?
-- Explanation: TRUNCATE TABLE is Data Definition Language (DDL) because it operates on table metadata 
-- and data pages directly rather than logging individual row deletions. It deallocates data pages, 
-- resets IDENTITY seeds to initial seed values, and requires ALTER TABLE permissions. However, it 
-- preserves the table schema definition (columns, types, constraints).


-- ================================================================================
-- SECTION 2: METADATA EXPLORATION & SCHEMA INSPECTION
-- ================================================================================

-- Querying system metadata views to inspect database tables
SELECT * 
FROM INFORMATION_SCHEMA.TABLES;


-- ================================================================================
-- SECTION 3: RETROFITTING CONSTRAINTS ON EXISTING TABLES VIA ALTER TABLE
-- ================================================================================

-- Inspecting existing Employee table
SELECT * FROM emp;

--------------------------------------------------------------------------------
-- 3.1 RETROFITTING UNIQUE CONSTRAINT
--------------------------------------------------------------------------------
-- Pre-condition: Existing data in the column MUST be unique and eligible for constraint enforcement.
-- Navigation Path in SSMS: Object Explorer -> Database -> Tables -> dbo.emp -> Keys / Constraints

-- Pre-cleaning: Remove NULL or duplicate values before applying UNIQUE constraint
DELETE FROM emp 
WHERE empid IS NULL;

-- Adding UNIQUE constraint to empid column
ALTER TABLE emp 
ADD CONSTRAINT u01 UNIQUE (empid);
-- Result: Command(s) completed successfully.

-- Testing UNIQUE constraint violation on existing duplicates (e.g., column 'age')
ALTER TABLE emp 
ADD CONSTRAINT u02 UNIQUE (age);
/*
   ERROR TRACE:
   Msg 1750, Level 16, State 1, Line 50
   The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object 
   name 'dbo.emp' and the index name 'u02'. The duplicate key value is (30).
   Could not create constraint or index. See previous errors.
*/

-- Testing UNIQUE constraint enforcement on INSERT
INSERT INTO emp (empid) 
VALUES (101);
/*
   ERROR TRACE:
   Violation of UNIQUE KEY constraint 'u01'. Cannot insert duplicate key in object 'dbo.emp'. 
   The duplicate key value is (101).
*/

-- Syntax Pattern for Dropping Constraints:
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;


--------------------------------------------------------------------------------
-- 3.2 RETROFITTING CHECK CONSTRAINT
--------------------------------------------------------------------------------
SELECT * FROM emp;

-- Attempting CHECK constraint when non-compliant data exists
ALTER TABLE emp 
ADD CONSTRAINT ch01 CHECK (salary > 4000);
/*
   ERROR TRACE:
   The ALTER TABLE statement conflicted with the CHECK constraint "ch01". 
   The conflict occurred in database "Online_New", table "dbo.emp", column 'salary'.
*/

-- Pre-cleaning: Remove non-compliant or NULL values
DELETE FROM emp 
WHERE salary IS NULL;

-- Retrofitting valid CHECK constraint
ALTER TABLE emp 
ADD CONSTRAINT ch01 CHECK (salary <= 40000);
-- Result: Command(s) completed successfully.

-- Testing CHECK constraint enforcement
INSERT INTO emp (salary) VALUES (41000); -- INVALID: Violates CHECK constraint ch01 (salary <= 40000)
INSERT INTO emp (salary) VALUES (39000); -- VALID: Satisfies CHECK constraint


--------------------------------------------------------------------------------
-- 3.3 METADATA AUDITING FOR APPLIED CONSTRAINTS
--------------------------------------------------------------------------------
-- Inspect all active constraints in the current database
SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;


--------------------------------------------------------------------------------
-- 3.4 IN-CLASS TASK: RETROFITTING FOREIGN KEY & DEFAULT CONSTRAINTS
--------------------------------------------------------------------------------

-- Task 1: Add Foreign Key Constraint to an existing table
ALTER TABLE emp 
ADD CONSTRAINT fk01 FOREIGN KEY (col) REFERENCES pk_table(pk_col);

-- Task 2: Add Default Constraint to an existing column
ALTER TABLE emp 
ADD CONSTRAINT df01 DEFAULT 'pune' FOR city;


--------------------------------------------------------------------------------
-- 3.5 HANDLING ACCIDENTAL OR INCORRECT CONSTRAINT CONFIGURATIONS
--------------------------------------------------------------------------------
-- Scenario: If an incorrect constraint logic was applied under a constraint name, 
-- drop the constraint or apply the corrected rule using a new unique constraint name.

ALTER TABLE emp ADD CONSTRAINT ch01 CHECK (salary <= 40000); -- Accidentally applied rule
ALTER TABLE emp ADD CONSTRAINT ch02 CHECK (salary <= 30000); -- Applied corrected rule under new key name


-- ================================================================================
-- SECTION 4: COLUMN PROPERTIES VS TABLE CONSTRAINTS (NOT NULL & IDENTITY)
-- ================================================================================

--------------------------------------------------------------------------------
-- 4.1 RETROFITTING PRIMARY KEY & MANDATORY NOT NULL COLUMN PROPERTY
--------------------------------------------------------------------------------
-- Step 1: Create sample table without explicit NOT NULL constraint
CREATE TABLE q10 (
    id INT,
    name VARCHAR(10)
);

-- Attempting PRIMARY KEY creation on nullable column
ALTER TABLE q10 
ADD CONSTRAINT pk011 PRIMARY KEY (id);
/*
   ERROR TRACE:
   Cannot define PRIMARY KEY constraint on nullable column in table 'q10'.
   Reason: By default, columns created without NOT NULL are NULLABLE in SQL Server.
*/

-- ARCHITECTURAL DISTINCTION:
-- NOT NULL is a COLUMN PROPERTY (structural attribute of column), NOT a table constraint!
-- Therefore, we do NOT use 'ADD CONSTRAINT' for NOT NULL. We use 'ALTER COLUMN'!

-- Step 2: Convert column property to NOT NULL
ALTER TABLE q10 
ALTER COLUMN id INT NOT NULL;

-- Step 3: Now apply PRIMARY KEY table constraint
ALTER TABLE q10 
ADD CONSTRAINT pk011 PRIMARY KEY (id);
-- Result: Command(s) completed successfully.

-- SUMMARY OF SYNTAX RULES:
-- 1. Column Property Modification (NOT NULL):
--    ALTER TABLE table_name ALTER COLUMN column_name datatype NOT NULL;
--
-- 2. Table Constraint Modification (PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT, UNIQUE):
--    ALTER TABLE table_name ADD CONSTRAINT constraint_name <KEY_TYPE> (...);


--------------------------------------------------------------------------------
-- 4.2 IDENTITY COLUMN PROPERTY & LIMITATIONS ON EXISTING TABLES
--------------------------------------------------------------------------------
-- IDENTITY is also a COLUMN PROPERTY.
-- LIMITATION: IDENTITY cannot be applied to an existing column that already contains data!

SELECT * FROM emp;

-- Adding new column to existing table
ALTER TABLE emp ADD sr_no INT;
-- Note: sr_no cannot be made PRIMARY KEY or IDENTITY directly because existing rows default to NULL.

-- Correct way to add an IDENTITY column to an existing populated table:
ALTER TABLE emp 
ADD adharno INT IDENTITY(1,1);
-- SQL Server automatically generates auto-incremented seed numbers for existing rows!

-- Attempting to alter column to NOT NULL when NULL values exist in data:
ALTER TABLE emp 
ALTER COLUMN age INT NOT NULL;
/*
   ERROR TRACE:
   Cannot insert the value NULL into column 'age', table 'Online_New.dbo.emp'; column does not allow nulls. UPDATE fails.
*/

-- KEY BRAINSTORMING NOTE ON FOREIGN KEYS:
-- To establish a Foreign Key relationship, the FK values must match the PK values.
-- The order/sequence of rows does not matter; only the value existence in the PK column matters!


-- ================================================================================
-- SECTION 5: OFFLINE SQL TEST 1 REVIEW & INTERVIEW ANALYSIS (18 MCQs)
-- ================================================================================
/*
   TEST RESULTS SUMMARY:
   --------------------
   Exam: SQL_Test1_Offline
   Student: ARPIT MANOJ BANGRE
   Batch: ONLINE BATCH 15
   Score: 13 / 18 Points
   Email: arpit.m.bangre@gmail.com

   --------------------------------------------------------------------------------
   DETAILED QUESTION-BY-QUESTION AUDIT & TECHNICAL RATIONALE:
   --------------------------------------------------------------------------------

   Q1 [Foreign Key Destruction Behavior]:
   Question: A FOREIGN KEY exists from Child.ParentId to Parent.Id. Which statement is generally true?
   Student Selection: C. TRUNCATE TABLE Parent may fail while the FK exists. (CORRECT - 1/1)
   Technical Rationale: TRUNCATE TABLE on a Parent table referenced by a Foreign Key constraint 
   will ALWAYS fail in SQL Server, even if the Child table is currently empty.

   Q2 [Foreign Key Dropping Effect]:
   Question: After dropping a FOREIGN KEY constraint, what remains true?
   Student Selection: B. Existing data remains unchanged unless separately modified. (CORRECT - 1/1)
   Technical Rationale: Dropping a constraint removes the validation rule only. Existing rows 
   in parent and child tables remain completely intact.

   Q3 [Execution Speed & Storage Deallocation]:
   Question: Which operation is generally metadata-only and therefore much faster than row-by-row deletion?
   Student Selection: B. TRUNCATE TABLE T (CORRECT - 1/1)
   Technical Rationale: TRUNCATE deallocates data pages directly via metadata updates without logging 
   individual row deletions in the transaction log.

   Q4 [Column Alias Scoping in SQL Clauses]:
   Question: Can ORDER BY or GROUP BY use Column Aliases?
   Student Selection: Order By (CORRECT - 1/1)
   Technical Rationale: Logical execution order evaluates GROUP BY before SELECT (aliases unknown), 
   whereas ORDER BY executes after SELECT (aliases fully available).

   Q5 [SQL Clause Execution Flow & Row Filtering]:
   Question: Table has 100,000 rows.
             SELECT DeptId, COUNT(*) FROM Employee WHERE Salary > 50000 GROUP BY DeptId HAVING COUNT(*) > 10;
             Which statement is correct?
   Student Selection: Rows are filtered before grouping (CORRECT - 1/1)
   Technical Rationale: WHERE clause filters individual rows first before GROUP BY aggregates them into groups.

   Q6 [Mandatory Field Constraint]:
   Question: A customer must not be created without Email ID. Which constraint?
   Student Selection: A. CHECK (INCORRECT - 0/1)
   Correct Answer: C. NOT NULL
   Technical Rationale: NOT NULL guarantees that a column cannot store NULL values, making it mandatory.

   Q7 [Referential Integrity Constraint]:
   Question: Every Order must belong to an existing Customer. Which constraint?
   Student Selection: C. FOREIGN KEY (CORRECT - 1/1)
   Technical Rationale: FOREIGN KEY enforces referential integrity between child table (Orders) and parent (Customers).

   Q8 [Performance Optimization - WHERE vs HAVING]:
   Question: A Sales table contains 1 million records. Generate department-wise sales statistics 
             only for sales greater than ₹50,000.
   Student Selection: Developer A suggests using WHERE (INCORRECT - 0/1)
   Correct Answer: Developer B suggests using HAVING -- Wait, Developer A (WHERE) is more performant!
   Test Key Notes: Pre-filtering rows via WHERE before grouping reduces rows processed by GROUP BY.

   Q9 [Group Level Filtering]:
   Question: Which query returns departments having more than 5 employees?
   Student Selection: SELECT DeptId FROM Employee GROUP BY DeptId HAVING COUNT(*) > 5; (CORRECT - 1/1)
   Technical Rationale: Aggregate functions cannot be evaluated in WHERE; group aggregate thresholds require HAVING.

   Q10 [Primary Key Properties]:
   Question: Which statement about PRIMARY KEY is TRUE?
   Student Selection: C. PRIMARY KEY automatically enforces UNIQUE and NOT NULL (CORRECT - 1/1)
   Technical Rationale: Primary keys combine uniqueness and non-nullability by definition.

   Q11 [Logical Query Processing Order]:
   Question: What is the logical execution order?
   Student Selection: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY (CORRECT - 1/1)

   Q12 [TRUNCATE Transactional Rollback Behavior]:
   Question: A table contains 10,000 rows. You execute: TRUNCATE TABLE Employee; ROLLBACK; What happens?
   Student Selection: Rows remain deleted because TRUNCATE cannot be rolled back (INCORRECT - 0/1)
   Correct Answer: Rows are restored
   Technical Rationale: In SQL Server, TRUNCATE TABLE is a log-header based DDL operation that CAN be rolled 
   back if wrapped inside an explicit transaction (BEGIN TRANSACTION ... ROLLBACK).

   Q13 [Data Deletion Comparison]:
   Question: Which statement is TRUE?
   Student Selection: TRUNCATE removes all rows and keeps structure (CORRECT - 1/1)

   Q14 [DDL Schema Modification]:
   Question: What is the result of ALTER TABLE Employee DROP COLUMN Salary;?
   Student Selection: Data from Salary column removed permanently (CORRECT - 1/1)

   Q15 [Parent Dependency Constraint Rules]:
   Question: Which operation is NOT possible if a FOREIGN KEY depends on a PRIMARY KEY?
   Student Selection: C. Drop Primary Key Constraint (CORRECT - 1/1)
   Technical Rationale: A primary key referenced by an active foreign key cannot be dropped until the foreign key is removed.

   Q16 [Retrofitting Constraint Violation]:
   Question: What happens when executing ALTER TABLE Employee ADD CONSTRAINT CK_Salary CHECK (Salary > 10000) 
             when existing table contains Salary = 500?
   Student Selection: B. Error because existing data violates constraint (CORRECT - 1/1)

   Q17 [Comparative Deletion Analysis - False Statement]:
   Question: Which statement is false?
   Student Selection: Delete can delete multiple data at a time (INCORRECT - 0/1)
   Correct Answer: delete can delete specific value -- DELETE without WHERE deletes all rows; specific row deletion requires WHERE.

   Q18 [Parent-Child Table Destruction True Statement]:
   Question: Which statement is true?
   Student Selection: Parent key table can not be deleted if child is available (CORRECT - 1/1)
*/

/* ================================================================================
   END OF CLASS NOTES - 13 AUGUST 2026
   ================================================================================ */