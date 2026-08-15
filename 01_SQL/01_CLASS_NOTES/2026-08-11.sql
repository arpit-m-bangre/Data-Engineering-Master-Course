/* ================================================================================
   SQL CLASS NOTES - 11 AUGUST 2026 (DAY 10)
   TOPICS: DEFAULT CONSTRAINT, INSERT TYPES, IDENTITY PROPERTY, FOREIGN KEYS, parent/child rules
   ================================================================================ */

-- 1. DEFAULT CONSTRAINT (Fills column automatically if omitted)
CREATE TABLE Q5
(
    id   INT,
    city VARCHAR(10) DEFAULT 'Pune'
);

-- Insert omitting 'city' triggers default
INSERT INTO Q5 (id) VALUES (1);
SELECT * FROM Q5;

-- Custom value overrides default
INSERT INTO Q5 (id, city) VALUES (2, 'Mumbai');
SELECT * FROM Q5;

-- ------------------------------------------------------------
-- SQL INSERT METHODS
-- ------------------------------------------------------------
-- Method A: Full Row Insert (Values order must match table columns order exactly)
INSERT INTO Q5 VALUES (1, 'Pune');

-- Method B: Explicit Column list (Best practice for production - safety when tables alter!)
INSERT INTO Q5 (id) VALUES (1);
INSERT INTO Q5 (id, city) VALUES (2, 'Mumbai');

-- Method C: Multiple rows insert
INSERT INTO Q5 (id, city) VALUES (3, 'Pune'), (4, 'Mumbai'), (5, 'Nagpur');
INSERT INTO Q5 (id) VALUES (6), (7), (8);

-- Method D: Explicit DEFAULT keyword usage
INSERT INTO Q5 (id, city) VALUES (10, DEFAULT);

-- Method E: Explicit NULL insertion (Allowed only if column is nullable)
INSERT INTO Q5 (id, city) VALUES (11, NULL);

-- Method F: Ingestion from another table
-- INSERT INTO Q5 (id, city) SELECT id, city FROM Q4;
-- INSERT INTO Q5 (id, city) SELECT id, city FROM Q4 WHERE id > 5;

-- 2. DEFAULT + CHECK COMBINED
CREATE TABLE Q5_
(
    id    INT,
    marks INT DEFAULT 5,
    CHECK (marks > 4)
);

INSERT INTO Q5_ (id) VALUES (1); -- (Valid: uses default 5 which is > 4)
-- ❌ Test constraint failure
-- INSERT INTO Q5_ (id, marks) VALUES (2, 2); -- (Fails: marks must be > 4!)

SELECT * FROM Q5_;

-- 3. IDENTITY (Auto-increment column property)
-- Analogy: A ticket dispenser at a bank. Dispenses numbers in order automatically.
-- Rule: Only for whole number (numeric) columns. Max 1 IDENTITY per table.
CREATE TABLE Q6
(
    id   INT IDENTITY,
    name VARCHAR(10)
);

INSERT INTO Q6 VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('f');
SELECT * FROM Q6;

-- Custom start and step value: IDENTITY(seed, increment)
CREATE TABLE Q7
(
    id   INT IDENTITY(1000, 1),
    name VARCHAR(10)
);

INSERT INTO Q7 VALUES ('a'), ('b'), ('c'), ('d'), ('e'), ('f');
SELECT * FROM Q7;

-- 4. FOREIGN KEY (FK) (Inter-table connectivity)
-- Analogy: A child holds the hand of their parent. The child's Custid MUST exist in Parent's PKID.
-- Rule: To establish a Foreign Key, the referenced parent column must be a PRIMARY KEY or UNIQUE.

-- Drop test table Q1
DROP TABLE Q1;

-- Independent Parent Table
CREATE TABLE Q1
(
    PKID INT PRIMARY KEY,
    Name VARCHAR(10)
);

INSERT INTO Q1 VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D'), (5, 'E');

-- Dependent Child Table referencing Parent
CREATE TABLE Q9
(
    Custid INT FOREIGN KEY REFERENCES Q1(PKID),
    Pid    INT,
    Pname  VARCHAR(10),
    Amount INT
);

INSERT INTO Q9 VALUES (1, 101, 'Mobile', 70000);
INSERT INTO Q9 VALUES (5, 102, 'Phone', 80000);

-- ❌ Test invalid Foreign Key insert (Fails because Custid 7 does not exist in Parent Q1)
-- INSERT INTO Q9 VALUES (7, 103, 'Phone', 90000);

SELECT * FROM Q9;

-- ------------------------------------------------------------
-- PARENT & CHILD RELATIONSHIP RULES
-- ------------------------------------------------------------
-- Parent Table = Table with Primary Key (q1)
-- Child Table  = Table with Foreign Key (q9)

-- Rule 1: Child Table can be deleted, truncated, or dropped freely.
DELETE FROM Q9;
TRUNCATE TABLE Q9;
DROP TABLE Q9;

-- Rule 2: Parent Table CANNOT be dropped or truncated while active Foreign Key references exist.
-- DROP TABLE Q1;     -- (Fails: referenced by FK constraint!)
-- TRUNCATE TABLE Q1; -- (Fails: referenced by FK constraint!)

-- Rule 3: Parent Table rows CANNOT be deleted if a Child row points to it.
-- (Re-create child table first)
-- CREATE TABLE Q9 ( Custid INT FOREIGN KEY REFERENCES Q1(PKID), Pid INT, Pname VARCHAR(10), Amount INT );
-- INSERT INTO Q9 VALUES (1, 101, 'Mobile', 70000);
-- DELETE FROM Q1 WHERE PKID = 1; -- (Fails: Custid 1 is currently shopping!)
DELETE FROM Q1 WHERE PKID = 3; -- (Succeeds: Custid 3 is not referenced in Child Q9!)
