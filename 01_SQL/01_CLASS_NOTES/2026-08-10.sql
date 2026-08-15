/* ================================================================================
   SQL CLASS NOTES - 10 AUGUST 2026 (DAY 9)
   TOPICS: SQL CONSTRAINTS, PRIMARY KEY, UNIQUE, NOT NULL, CHECK CONSTRAINTS
   ================================================================================ */

-- ------------------------------------------------------------
-- SQL CONSTRAINTS (The Bouncers)
-- ------------------------------------------------------------
-- Constraints are rules/restrictions put on columns to ensure data cleanliness.
-- Think of them like forms checking your age/email formats before letting you submit.

-- 1. PRIMARY KEY (PK) (The ultimate ID card)
-- Rules: Unique values only + Cannot be NULL + Maximum 1 Primary Key per table.
CREATE TABLE Q1
(
    id   INT PRIMARY KEY,
    name VARCHAR(10)
);

INSERT INTO Q1 VALUES (1, 'a');

-- ❌ Test duplicate insert (Fails PK validation!)
-- INSERT INTO Q1 VALUES (1, 'a');

-- ❌ Test NULL insert (Fails PK validation!)
-- INSERT INTO Q1 VALUES (NULL, 'a');

INSERT INTO Q1 VALUES (2, 'a'); -- (Valid: Name can duplicate because it has no constraint)

SELECT * FROM Q1;

-- 2. UNIQUE CONSTRAINT (The duplicate checker)
-- Rules: Unique values only + Allows exactly ONE NULL value (in SQL Server).
CREATE TABLE Q2
(
    id   INT UNIQUE,
    city VARCHAR(10)
);

INSERT INTO Q2 VALUES (1, 'pune');
-- ❌ Test duplicate insert (Fails UNIQUE validation!)
-- INSERT INTO Q2 VALUES (1, 'pune');

INSERT INTO Q2 VALUES (NULL, 'mumbai');
-- ❌ Test second NULL insert (Fails UNIQUE validation because only 1 NULL is allowed!)
-- INSERT INTO Q2 VALUES (NULL, 'mumbai');

SELECT * FROM Q2;

-- 3. NOT NULL CONSTRAINT (No blanks allowed)
-- Rules: Must contain a value + Duplicates are allowed.
-- Tip: NOT NULL + UNIQUE combined acts exactly like a secondary Primary Key!
CREATE TABLE Q3
(
    id     INT PRIMARY KEY,
    f_name VARCHAR(10) NOT NULL,
    custid INT NOT NULL UNIQUE
);

INSERT INTO Q3 VALUES (1, 'a', 101);
-- ❌ Test duplicate custid (Fails UNIQUE constraint!)
-- INSERT INTO Q3 VALUES (2, 'a', 101);

-- ❌ Test duplicate id (Fails PK constraint!)
-- INSERT INTO Q3 VALUES (1, 'a', 102);

-- ❌ Test NULL insert on f_name (Fails NOT NULL constraint!)
-- INSERT INTO Q3 VALUES (3, NULL, 103);

-- 4. CHECK CONSTRAINT (Custom bouncer checking rules)
-- Rule: The row is only inserted if the CHECK expression evaluates to TRUE (or NULL).
CREATE TABLE Q4
(
    id  INT,
    age INT CHECK (age > 18)
);

INSERT INTO Q4 VALUES (1, 23);
-- ❌ Test age constraint (Fails because 18 is not > 18!)
-- INSERT INTO Q4 VALUES (1, 18);

SELECT * FROM Q4;

-- Adding column with custom CHECK constraints
ALTER TABLE Q4 ADD city VARCHAR(10);
ALTER TABLE Q4 ADD name VARCHAR(10) CHECK (name NOT LIKE 'a%'); -- Fails if name starts with 'a'

-- ❌ Test starts-with-a CHECK constraint
-- INSERT INTO Q4 VALUES (2, 19, 'nag', 'arpit');

-- Adding CHECK constraint with multiple conditions
ALTER TABLE Q4 ADD marks INT CHECK (marks NOT LIKE '9%' AND marks <> 99234235);

-- ❌ Test marks CHECK constraint
-- INSERT INTO Q4 VALUES (2, 19, 'pune', 'rman', 99234235);

-- Adding CHECK constraint with IN list
ALTER TABLE Q4 ADD grade VARCHAR(10) CHECK (grade IN ('A', 'B', 'C'));

INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, 'c'); -- (Valid: 'c' matches 'C' case-insensitively)
-- ❌ Test invalid grade
-- INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, 'y');

-- ⚠️ CRITICAL: CHECK constraints allow NULL unless NOT NULL is also specified!
INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, NULL); -- (Valid: NULL bypasses CHECK!)
