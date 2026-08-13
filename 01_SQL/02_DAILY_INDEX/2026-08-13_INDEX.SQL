============================================================
               DAY 12 (AUGUST 13) - INDEX
============================================================

1. Parent & Child Table Relational Destruction Rules Recap
   1.1 Primary Key (PK) Table Destruction Rules (DELETE / TRUNCATE / DROP Restrictions)
   1.2 Foreign Key (FK) Child Table Destruction Freedom
   1.3 FK Row Insertion Validation Logic & FK/PK Value Matching Rules
   1.4 Conceptual Deep Dive: Why TRUNCATE is DDL (Page Deallocation & Metadata Operations)

2. System Metadata Exploration & Schema Auditing
   2.1 Querying INFORMATION_SCHEMA.TABLES
   2.2 Querying INFORMATION_SCHEMA.TABLE_CONSTRAINTS

3. Retrofitting Constraints on Existing Tables via ALTER TABLE
   3.1 Pre-condition Rules for Existing Data Eligibility
   3.2 SSMS Object Explorer Navigation Path (DB -> Tables -> Table -> Keys)
   3.3 Data Pre-Cleaning Strategy (DELETE ... WHERE col IS NULL / non-compliant)
   3.4 Retrofitting UNIQUE Constraint (ALTER TABLE ... ADD CONSTRAINT ... UNIQUE)
   3.5 Retrofitting CHECK Constraint (ALTER TABLE ... ADD CONSTRAINT ... CHECK)
   3.6 Retrofitting FOREIGN KEY Constraint (ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY ... REFERENCES)
   3.7 Retrofitting DEFAULT Constraint (ALTER TABLE ... ADD CONSTRAINT ... DEFAULT ... FOR col)
   3.8 Dropping Table Constraints Syntax (ALTER TABLE ... DROP CONSTRAINT ...)
   3.9 Handling Accidental / Incorrect Constraint Configurations

4. Structural Column Properties vs Named Table Constraints
   4.1 Conceptual Distinction: Column Properties (NOT NULL, IDENTITY) vs Table Constraints (PK, FK, UNIQUE, CHECK, DEFAULT)
   4.2 Retrofitting PRIMARY KEY Requirement: Mandatory Conversion of Column Property via ALTER COLUMN NOT NULL
   4.3 Syntax Summary: ALTER COLUMN (Properties) vs ADD CONSTRAINT (Table Constraints)
   4.4 IDENTITY Property Limitations on Populated Tables
   4.5 Adding Auto-Increment IDENTITY to Live Populated Tables (ALTER TABLE ... ADD col INT IDENTITY(1,1))
   4.6 Data Pre-Validation Error Tracing on ALTER COLUMN NOT NULL

5. Offline SQL Test 1 Breakdown & Technical Interview Audit (18 MCQs)
   5.1 Score Audit (13/18 Points) & Error Analysis
   5.2 Foreign Key Destruction Behavior (Q1)
   5.3 Foreign Key Dropping Effect on Data (Q2)
   5.4 Storage Deallocation & TRUNCATE Speed (Q3)
   5.5 Column Alias Scoping in SQL Clauses (Q4)
   5.6 Logical Query Execution Flow: WHERE vs GROUP BY vs HAVING (Q5, Q8, Q9, Q11)
   5.7 Mandatory & Referential Integrity Constraints: NOT NULL vs FOREIGN KEY vs PRIMARY KEY (Q6, Q7, Q10, Q15, Q16)
   5.8 TRUNCATE Transactional Rollback Behavior inside Explicit Transactions (Q12)
   5.9 DDL Schema Modifications: Column Deletion Behavior (Q14)
   5.10 Comparative Deletion Analysis: DELETE vs TRUNCATE vs DROP (Q13, Q17, Q18)

============================================================
