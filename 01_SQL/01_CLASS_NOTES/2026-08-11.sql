/*================================================================
   SQL CLASS NOTES - 11 AUGUST 2026 (DAY 10)
   TOPICS: DEFAULT CONSTRAINT, INSERT TYPES, IDENTITY PROPERTY, FOREIGN KEYS
==================================================================*/


/*================================================================
1. DEFAULT CONSTRAINT (Fills column automatically if omitted)
==================================================================*/

CREATE TABLE Q5
(
    id   INT,
    city VARCHAR(10) DEFAULT 'Pune'
);


INSERT INTO Q5 (id) VALUES (1);

SELECT * FROM Q5;


INSERT INTO Q5 (id, city) VALUES (2, 'Mumbai');

SELECT * FROM Q5;


/*================================================================
2. INSERT METHODS
==================================================================*/

-- Method A: Full Row Insert (Values order must match columns)
INSERT INTO Q5 VALUES (1, 'Pune');

-- Method B: Explicit Column list (Best practice for production!)
INSERT INTO Q5 (id) VALUES (1);
INSERT INTO Q5 (id, city) VALUES (2, 'Mumbai');

-- Method C: Multiple rows insert
INSERT INTO Q5 (id, city) VALUES (3, 'Pune'), (4, 'Mumbai'), (5, 'Nagpur');
INSERT INTO Q5 (id) VALUES (6), (7), (8);

-- Method D: Explicit DEFAULT keyword usage
INSERT INTO Q5 (id, city) VALUES (10, DEFAULT);

-- Method E: Explicit NULL insertion
INSERT INTO Q5 (id, city) VALUES (11, NULL);


/*================================================================
3. DEFAULT + CHECK COMBINED
==================================================================*/

CREATE TABLE Q5_
(
    id    INT,
    marks INT DEFAULT 5,
    CHECK (marks > 4)
);


INSERT INTO Q5_ (id) VALUES (1);


INSERT INTO Q5_ (id, marks) VALUES (2, 2);
/*----------------------------------------------------------------
Error:
❌ Fails: marks = 2 violates CHECK constraint (> 4).
------------------------------------------------------------------*/

SELECT * FROM Q5_;


/*================================================================
4. IDENTITY (Auto-increment column property)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Analogy: A ticket dispenser at a bank. Dispenses numbers in order automatically.
Rule: Only for whole number (numeric) columns. Max 1 IDENTITY per table.
------------------------------------------------------------------*/

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


/*================================================================
5. FOREIGN KEY (FK) (Inter-table connectivity)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Analogy: A child holding a parent's hand. The Custid must exist in Parent's PKID.
Rule: Referenced parent column must be a PRIMARY KEY or UNIQUE.
------------------------------------------------------------------*/

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


-- INSERT INTO Q9 VALUES (7, 103, 'Phone', 90000);
/*----------------------------------------------------------------
Error:
❌ Fails: Custid 7 does not exist in Parent Q1 table (FOREIGN KEY violation).
------------------------------------------------------------------*/

SELECT * FROM Q9;


/*================================================================
6. PARENT & CHILD RELATIONSHIP RULES
==================================================================*/

-- Rule 1: Child Table can be deleted, truncated, or dropped freely.
DELETE FROM Q9;
TRUNCATE TABLE Q9;
DROP TABLE Q9;


-- Rule 2: Parent Table CANNOT be dropped or truncated while active Foreign Key references exist.
-- DROP TABLE Q1;
/*----------------------------------------------------------------
Error:
❌ Fails (referenced by FK constraint).
------------------------------------------------------------------*/

-- TRUNCATE TABLE Q1;
/*----------------------------------------------------------------
Error:
❌ Fails (referenced by FK constraint).
------------------------------------------------------------------*/


-- Rule 3: Parent Table rows CANNOT be deleted if a Child row points to it.
-- DELETE FROM Q1 WHERE PKID = 1;
/*----------------------------------------------------------------
Error:
❌ Fails if Custid 1 has matching rows in Child Q9 table.
------------------------------------------------------------------*/\n