/* ================================================================================
   SQL CLASS NOTES - 13 AUGUST 2026 (DAY 12)
   TOPICS: RETROFITTING CONSTRAINTS, COLUMN PROPERTIES VS TABLE CONSTRAINTS, 18 MCQ REVIEW
   ================================================================================ */

-- ------------------------------------------------------------
-- DDL VS DML DEEP DIVE (TRUNCATE)
-- ------------------------------------------------------------
-- 📖 THE NOTEBOOK ANALOGY:
-- Imagine your table is a spiral notebook. 
-- The cardboard cover and empty lines represent the Structure (Schema).
-- The handwritten text you write on the lines represents the Data (Rows).
--
-- 1. DELETE (DML): Eraser method. You erase text line-by-line. You are modifying data.
-- 2. TRUNCATE (DDL): Page-ripping method. You rip out all pages and throw them in the trash.
--    You leave only the empty cardboard cover (structure is kept). You are modifying the physical storage pages.
--
-- WHY IS IT DDL?
-- * It deallocates entire storage data pages on disk rather than deleting individual rows.
-- * It resets the IDENTITY seed (auto-increment) back to 1 (modifying a column definition property).
-- * It requires ALTER TABLE permissions (a DDL permission) rather than simple DELETE permissions.

SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- ------------------------------------------------------------
-- RETROFITTING CONSTRAINTS (Hiring bouncers on existing tables)
-- ------------------------------------------------------------
-- Pre-condition: Existing data in the column must comply with the constraint BEFORE you add it!
-- If you have dirty data, clean it up (using DELETE or UPDATE) before applying the constraint.

SELECT * FROM emp;

-- 1. Adding UNIQUE constraint
DELETE FROM emp WHERE empid IS NULL; -- Clean dirty data first
ALTER TABLE emp ADD CONSTRAINT u01 UNIQUE (empid);

-- Attempting UNIQUE constraint on duplicate column (Fails because age has duplicate 30s!)
-- ALTER TABLE emp ADD CONSTRAINT u02 UNIQUE (age);

-- 2. Adding CHECK constraint
-- Attempting CHECK on non-compliant data (Fails if salary has values <= 4000)
-- ALTER TABLE emp ADD CONSTRAINT ch01 CHECK (salary > 4000);

DELETE FROM emp WHERE salary IS NULL; -- Clean NULLs first
ALTER TABLE emp ADD CONSTRAINT ch01 CHECK (salary <= 40000); -- (Succeeds)

-- Test CHECK enforcement
INSERT INTO emp (salary) VALUES (39000); -- Valid
-- INSERT INTO emp (salary) VALUES (41000); -- Invalid (Salary must be <= 40000)

-- Dropping Constraints
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- Metadata check for active constraints
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS;

-- 3. Adding FOREIGN KEY & DEFAULT constraints
-- ALTER TABLE emp ADD CONSTRAINT fk01 FOREIGN KEY (col) REFERENCES pk_table(pk_col);
-- ALTER TABLE emp ADD CONSTRAINT df01 DEFAULT 'pune' FOR city;

-- ------------------------------------------------------------
-- COLUMN PROPERTIES VS TABLE CONSTRAINTS
-- ------------------------------------------------------------
-- * Column Properties (NOT NULL, IDENTITY): Structural properties of a column.
--   Rule: Modify them using 'ALTER COLUMN'. You cannot use 'ADD CONSTRAINT'.
-- * Table Constraints (PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT, UNIQUE): Validation rules.
--   Rule: Add them using 'ADD CONSTRAINT'.

CREATE TABLE q10 (
    id INT,
    name VARCHAR(10)
);

-- ❌ Fails: Can't make a nullable column the Primary Key!
-- ALTER TABLE q10 ADD CONSTRAINT pk011 PRIMARY KEY (id);

-- ✔️ Step 1: Change column property to NOT NULL
ALTER TABLE q10 ALTER COLUMN id INT NOT NULL;

-- ✔️ Step 2: Add Primary Key table constraint
ALTER TABLE q10 ADD CONSTRAINT pk011 PRIMARY KEY (id);

-- IDENTITY limits on existing tables:
-- You cannot change an existing column to IDENTITY. You must add a brand new column!
-- SQL Server will automatically populate IDENTITY values for existing rows.
ALTER TABLE emp ADD sr_no INT; -- Adding normal column
ALTER TABLE emp ADD adharno INT IDENTITY(1,1); -- Adding IDENTITY column (Succeeds)

-- ------------------------------------------------------------
-- 18 MCQ TEST REVIEW & ANALYSIS (Score: 13/18)
-- ------------------------------------------------------------
-- Q1: Parent table referenced by active FK cannot be TRUNCATED (even if child is empty).
-- Q2: Dropping a FK constraint removes the check rule, but leaves actual data untouched.
-- Q3: TRUNCATE is metadata-only (deallocates pages) and is much faster than row-by-row DELETE.
-- Q4: ORDER BY can use aliases; GROUP BY cannot (due to logical execution order).
-- Q5: WHERE filters rows first, then GROUP BY groups them.
-- Q6: Mandatory field is enforced by NOT NULL constraint (Incorrect selection: CHECK).
-- Q7: Referential integrity (Order belongs to Customer) is enforced by FOREIGN KEY.
-- Q8: Pre-filtering rows via WHERE is much faster than filtering groups via HAVING (Incorrect selection: HAVING).
-- Q9: Filtering group thresholds (departments with > 5 employees) requires HAVING.
-- Q10: PRIMARY KEY automatically enforces UNIQUE and NOT NULL.
-- Q11: Execution Order: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY.
-- Q12: TRUNCATE can be rolled back in SQL Server if wrapped in a transaction (Incorrect selection: cannot be undone).
-- Q13: TRUNCATE removes all rows but preserves the table structure schema.
-- Q14: ALTER TABLE DROP COLUMN removes data and column definition permanently.
-- Q15: Referenced Primary Key constraint cannot be dropped while active Foreign Key points to it.
-- Q16: Retrofitting a constraint fails if existing data violates it.
-- Q17: DELETE without WHERE deletes all rows; deleting a specific value requires a WHERE clause (Incorrect selection: cannot delete multiple).
-- Q18: Parent PK table cannot be deleted/dropped if child FK table references it.
