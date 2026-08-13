/* ============================================================
                    SQL - 11 AUGUST 2026
                         CONSTRAINTS
   ============================================================ */


/* ------------------------------------------------------------
1. DEFAULT CONSTRAINT
---------------------------------------------------------------

-- DEFAULT is used to automatically enter a value
-- when no value is provided for that column.

-- Example:
-- If city is not entered, 'Pune' will be entered automatically.
-- Since at the time or create or alter we made pune as default value for city column
*/

CREATE TABLE Q5
(
    id   INT,
    city VARCHAR(10) DEFAULT 'Pune'
);


INSERT INTO Q5 (id)
VALUES (1);


SELECT * FROM Q5;

/*
-- So here Pune is default and entered automatically.

-- At a time one DEFAULT for one column.

-- We can enter different values if we want to.
*/


INSERT INTO Q5 (id, city)
VALUES (2, 'Mumbai');


SELECT * FROM Q5;


/*
-- Example:
-- UI side default will be N/A / None or anything like that
-- or can be any value.
*/

/* 
-- extra note about insert operation 

/* ============================================================
                    WAYS TO INSERT DATA IN SQL
   ============================================================ */


/* ------------------------------------------------------------
1. INSERT VALUES INTO ALL COLUMNS
---------------------------------------------------------------*/

-- Column names are not specified.
-- Values must be given in the same order as table columns.

INSERT INTO Q5
VALUES (1, 'Pune');


/* ------------------------------------------------------------
2. INSERT VALUES USING COLUMN LIST
---------------------------------------------------------------*/

-- Also called:
-- Explicit Column List Insertion
-- Column-Specified INSERT

-- Only the required column is specified.
-- Other columns can use DEFAULT values or NULL
-- depending on the table definition.

INSERT INTO Q5 (id)
VALUES (1);


/* ------------------------------------------------------------
3. INSERT VALUES INTO MULTIPLE SPECIFIC COLUMNS
---------------------------------------------------------------*/

INSERT INTO Q5 (id, city)
VALUES (2, 'Mumbai');


/* ------------------------------------------------------------
4. INSERT MULTIPLE ROWS AT ONCE
---------------------------------------------------------------*/

INSERT INTO Q5 (id, city)
VALUES
(3, 'Pune'),
(4, 'Mumbai'),
(5, 'Nagpur');


/* ------------------------------------------------------------
5. INSERT MULTIPLE ROWS USING ONLY SPECIFIC COLUMNS
---------------------------------------------------------------*/

INSERT INTO Q5 (id)
VALUES
(6),
(7),
(8);


/* ------------------------------------------------------------
6. INSERT USING DEFAULT VALUE
---------------------------------------------------------------*/

-- If city has a DEFAULT value, we can omit city.

INSERT INTO Q5 (id)
VALUES (9);


/* ------------------------------------------------------------
7. EXPLICITLY USE DEFAULT KEYWORD
---------------------------------------------------------------*/

-- DEFAULT tells SQL Server to use the column's
-- defined DEFAULT value.

INSERT INTO Q5 (id, city)
VALUES (10, DEFAULT);


/* ------------------------------------------------------------
8. INSERT NULL EXPLICITLY
---------------------------------------------------------------*/

-- NULL can be inserted only if the column allows NULL.

INSERT INTO Q5 (id, city)
VALUES (11, NULL);


/* ------------------------------------------------------------
9. INSERT DATA FROM ANOTHER TABLE
---------------------------------------------------------------*/

-- INSERT INTO ... SELECT
-- Used to copy/select data from another table.

INSERT INTO Q5 (id, city)
SELECT id, city
FROM Q4;


/* ------------------------------------------------------------
10. INSERT SELECTED DATA FROM ANOTHER TABLE
---------------------------------------------------------------*/

-- We can also apply WHERE while inserting.

INSERT INTO Q5 (id, city)
SELECT id, city
FROM Q4
WHERE id > 5;


/* ------------------------------------------------------------
IMPORTANT NOTES
---------------------------------------------------------------

-- 1. When column names are NOT specified:
--    Values must follow the table's column order.

-- 2. When column names ARE specified:
--    Values must follow the specified column order.

-- 3. We do NOT have to provide every column when using
--    an explicit column list.

-- 4. Missing columns may receive:
--    DEFAULT value, NULL, or cause an error depending
--    on the column definition.

-- 5. Number of columns and number of values must match.

-- 6. For multiple-row INSERT, every row must contain
--    the same number of values.

-- 7. IDENTITY columns normally do not need to be included
--    because SQL Server generates their values automatically.

===============================================================
                    MAIN INSERT PATTERNS
===============================================================

-- Pattern 1:
INSERT INTO table_name
VALUES (value1, value2, value3);


-- Pattern 2:
INSERT INTO table_name (column1, column2)
VALUES (value1, value2);


-- Pattern 3:
INSERT INTO table_name (column1, column2)
VALUES
(value1, value2),
(value3, value4);


-- Pattern 4:
INSERT INTO table_name (column1)
VALUES (value1);


-- Pattern 5:
INSERT INTO table_name (column1, column2)
SELECT column1, column2
FROM another_table;


===============================================================
                    MOST IMPORTANT
===============================================================

-- Prefer this style when inserting data:

INSERT INTO Q5 (id, city)
VALUES (1, 'Pune');

-- Because the columns are clearly specified,
-- making the query easier to understand and safer
-- when the table structure changes.
===============================================================
*/ 

/* ------------------------------------------------------------
DEFAULT + CHECK CONSTRAINT
---------------------------------------------------------------
*/

CREATE TABLE Q5_
(
    id    INT,
    marks INT DEFAULT 5,
    CHECK (marks > 4)
);


SELECT * FROM Q5_;


INSERT INTO Q5_ (id)
VALUES (1);

/*
-- Valid.
-- Default marks value is used.
*/


INSERT INTO Q5_ (id, marks)
VALUES (2, 2);

/*
-- Invalid.
-- CHECK constraint does not allow marks = 2.

The INSERT statement conflicted with the CHECK constraint "CK__q5___marks__74AE54BC".
The conflict occurred in database "Online_New", table "dbo.q5_", column 'marks'.
*/


/* ------------------------------------------------------------
2. AUTO INCREMENT
---------------------------------------------------------------

-- Keyword: IDENTITY

-- Auto increment and NOT NULL are column properties.

-- Example:
-- Automatic entry like:
-- Seat numbers
-- Bank account number
-- It will fill automatically in backend system generated.

-- Same like PK, we can use it once.
-- Features are same like:
-- NOT NULL
-- No duplicates
-- Per table one auto increment and one PK

-- But PK value does not automatically increment.
*/


CREATE TABLE Q6
(
    id   INT IDENTITY,
    name VARCHAR(10)
);


SELECT * FROM Q6;


INSERT INTO Q6
VALUES
    ('a'),
    ('b'),
    ('c'),
    ('d'),
    ('e'),
    ('f');


/*
-- No column mismatch error since this is not available on UI.
-- It is completely backend, that's why
-- no need to specify column name before VALUES like table Q5.
*/


/* ------------------------------------------------------------
IDENTITY(start, increment)
---------------------------------------------------------------

-- We can specify auto increment value like:
-- IDENTITY(start, increment)
*/


CREATE TABLE Q7
(
    id   INT IDENTITY(1000, 1),
    name VARCHAR(10)
);


INSERT INTO Q7
VALUES
    ('a'),
    ('b'),
    ('c'),
    ('d'),
    ('e'),
    ('f');


SELECT * FROM Q7;


/*
-- IDENTITY / auto increment is only used with
-- numeric data type.
-- No other data type other than numeric data types.
-- That also means whole numbers.

-- We can alter the identity size.
-- Suppose we used INT and entries are bigger than INT,
-- we can alter the data type to BIGINT.
*/


/* ------------------------------------------------------------
3. FOREIGN KEY
---------------------------------------------------------------

-- IMPORTANT

-- ETL: 80% weight on PK and FK.

-- One table affects another.
-- That happens with the help of keys:
-- PK and FK.

-- To use FK, we need PK compulsory.
*/


SELECT * FROM Q1;


/*
-- Here id is PK.
*/


DROP TABLE Q1;

/*
-- It will drop since it is an independent table.
*/


/* ------------------------------------------------------------
INDEPENDENT TABLE WITH PRIMARY KEY
---------------------------------------------------------------
*/

CREATE TABLE Q1
(
    PKID INT PRIMARY KEY,
    Name VARCHAR(10)
);


INSERT INTO Q1
VALUES
    (1, 'A'),
    (2, 'B'),
    (3, 'C'),
    (4, 'D'),
    (5, 'E');


/*
-- Above table is independent with PK.
*/


/* ------------------------------------------------------------
TABLE WITH FOREIGN KEY
---------------------------------------------------------------
*/

CREATE TABLE Q9
(
    Custid INT FOREIGN KEY REFERENCES Q1(PKID),
    Pid    INT,
    Pname  VARCHAR(10),
    Amount INT
);


/*
-- Now Q1 and Q9 are connected.
*/


DROP TABLE Q1;

/*
-- Cannot drop because Q1 is referenced by
-- a FOREIGN KEY constraint.

Could not drop object 'q1'
because it is referenced by a FOREIGN KEY constraint.

-- Can't delete.
*/


INSERT INTO Q9
VALUES (1, 101, 'Mobile', 70000);


SELECT * FROM Q9;


INSERT INTO Q9
VALUES (5, 102, 'Phone', 80000);


INSERT INTO Q9
VALUES (7, 103, 'Phone', 90000);

/*
-- Invalid.

The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Q9__Custid__7C4F7684".
The conflict occurred in database "Online_New", table "dbo.Q1", column 'PKID'.
*/


/* ------------------------------------------------------------
PRIMARY KEY AND FOREIGN KEY EXAMPLE
---------------------------------------------------------------

-- Example:
-- PK = Account Number
-- FK table = Entries

-- PK and FK data type should be same.

-- In one table we can use many FK.

Example:
-- CREATE TABLE Q9
-- (
--     Custid INT FOREIGN KEY REFERENCES Q1(PKI),
--     pkid   INT FOREIGN KEY REFERENCES QX(PKID)
--     ......................
-- );

-- Multiple table interconnectivity is possible.

A
│
└── Primary Key: id1

B
│
├── id1 → Foreign Key
└── id2 → Primary Key

C
│
└── Foreign Key: id3
*/


/* ------------------------------------------------------------
IMPORTANT NOTES
---------------------------------------------------------------

-- Explore Foreign Key and Primary Key in detail
-- on YouTube and GPT.

-- We can add constraints to existing columns
-- using ALTER TABLE.

-- Don't complicate things.
-- Keep it simple.
-- Focus on one resource.
*/

/* ============================================================
* CLASS TASK
* ============================================================ */

-- Delete, DROP and TRUNCATE on both tables Q1 and Q9.


/* ============================================================
            DELETE / TRUNCATE / DROP WITH FOREIGN KEY
   ============================================================

-- Parent / Referenced Table
--     ↓
-- PRIMARY KEY
--
-- Child / Referencing Table
--     ↓
-- FOREIGN KEY
*/


/* ------------------------------------------------------------
1. DELETE
---------------------------------------------------------------

-- DELETE removes rows.

-- Child rows can be deleted normally.

-- Parent rows CANNOT be deleted if a child row is
-- currently referencing that parent row.

-- Example:

DELETE FROM Q9;   -- Child table → allowed

DELETE FROM Q1;   -- Parent table → fails if Q9
                  -- has rows referencing Q1
*/


/* ------------------------------------------------------------
2. TRUNCATE
---------------------------------------------------------------

-- TRUNCATE removes ALL rows from a table.

-- A table that is referenced by a FOREIGN KEY
-- cannot be TRUNCATED while that FOREIGN KEY exists.

-- Therefore:

TRUNCATE TABLE Q1;   -- Parent → NOT allowed
                     -- if Q9 has FK referencing Q1

-- Q9 can be truncated because Q9 is the
-- referencing/child table.

TRUNCATE TABLE Q9;   -- Child → allowed
*/


/* ------------------------------------------------------------
3. DROP
---------------------------------------------------------------

-- DROP removes the entire table structure + data.

-- A referenced/parent table cannot normally be DROPPED
-- while a FOREIGN KEY is referencing it.

DROP TABLE Q1;       -- Parent → NOT allowed while FK exists

DROP TABLE Q9;       -- Child → allowed
*/


/* ------------------------------------------------------------
IMPORTANT SUMMARY
---------------------------------------------------------------

-- DELETE:
-- Parent row cannot be deleted if a child row references it.

-- TRUNCATE:
-- Referenced/parent table cannot be truncated while
-- a FOREIGN KEY references it.

-- DROP:
-- Referenced/parent table cannot normally be dropped while
-- a FOREIGN KEY references it.

-- Child table can generally be DELETE / TRUNCATE / DROP
-- without affecting the parent table.
*/


/* ------------------------------------------------------------
REMEMBER
---------------------------------------------------------------

Parent / Referenced Table
        ↓
   PRIMARY KEY
        ↑
   FOREIGN KEY
        ↓
Child / Referencing Table

-- Parent = Referenced table = PK
-- Child  = Referencing table = FK

=============================================================== */

/* ============================================================
                         END OF NOTES
   ============================================================ */