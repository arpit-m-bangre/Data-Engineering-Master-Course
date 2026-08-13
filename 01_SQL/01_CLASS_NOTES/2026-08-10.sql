/* ============================================================
                    SQL - 10 AUGUST 2026
                         SQL CONSTRAINTS
   ============================================================ */


/* ------------------------------------------------------------
INTRODUCTION
---------------------------------------------------------------
-- Creating restriction for entering the values
-- Like creating rules for insertion
-- Example: Form restriction - only age 18+ can fill the form

-- SQL Constraints
*/


/* ------------------------------------------------------------
1. PRIMARY KEY
---------------------------------------------------------------

Characteristics:
-- No duplicates
-- No NULL
-- Per table only one PK will be there
-- Example: username

Syntax:
-- CREATE TABLE table_name
-- (
--     col_name datatype constraint
-- );

-- All constraints can be used many times in a column except PK

Example:
*/

CREATE TABLE Q1
(
    id   INT PRIMARY KEY,
    name VARCHAR(10)
);


INSERT INTO Q1 VALUES (1, 'a');

INSERT INTO Q1 VALUES (1, 'a');

/*
Violation of PRIMARY KEY constraint 'PK__Q1__3213E83FB7D1018F'.
Cannot insert duplicate key in object 'dbo.Q1'.
The duplicate key value is (1).

-- constraint 'PK__Q1__3213E83FB7D1018F'
-- It is important and unique for all.
-- It will be used to remove it.

-- Go to:
-- Object Explorer
--     → Database
--         → Table
--             → Keys folder
*/


INSERT INTO Q1 VALUES (2, 'a');

/*
-- Name can be same since it does not have any constraints.
*/


INSERT INTO Q1 VALUES (NULL, 'a');

/*
Cannot insert the value NULL into column 'id',
table 'Online_New.dbo.Q1';
column does not allow nulls. INSERT fails.
*/


SELECT * FROM Q1;


/*
-- We can add PK in an existing column,
-- but the column should not have duplicates and NULL.
-- At that time only we can alter PK.

-- Data validation vs constraints in SQL?
-- Data validation means checking whether the data is correct and follows certain rules.
-- Constraints are built-in SQL rules used to enforce data validation.
-- Example: PRIMARY KEY, UNIQUE, NOT NULL, and CHECK are constraints.
-- In short: Constraints are a way to perform data validation in SQL.
*/


/* ------------------------------------------------------------
2. UNIQUE
---------------------------------------------------------------

-- No duplicates
-- NULL is allowed single time only once

-- In real scenario it is not used since it supports NULL once,
-- which is not good practice.

-- Can be used in multiple columns in table unlike PK.

-- DISTINCT vs UNIQUE:
-- DISTINCT is showing duplicates once.
-- UNIQUE only accepts unique values.

Example:
*/

CREATE TABLE Q2
(
    id   INT UNIQUE,
    city VARCHAR(10)
);


INSERT INTO Q2 VALUES (1, 'pune');

INSERT INTO Q2 VALUES (1, 'pune');

/*
Violation of UNIQUE KEY constraint 'UQ__Q2__3213E83E6DEA3D9D'.
Cannot insert duplicate key in object 'dbo.Q2'.
The duplicate key value is (1).
*/


INSERT INTO Q2 VALUES (NULL, 'mumbai');

INSERT INTO Q2 VALUES (NULL, 'mumbai');

/*
Violation of UNIQUE KEY constraint 'UQ__Q2__3213E83E6DEA3D9D'.
Cannot insert duplicate key in object 'dbo.Q2'.
The duplicate key value is ().
The statement has been terminated.
*/


SELECT * FROM Q2;


/*
-- [UQ__Q2__3213E83E6DEA3D9D]
-- Key for unique table Q2
*/


/* ------------------------------------------------------------
3. NOT NULL
---------------------------------------------------------------

-- No NULL
-- Duplicates allowed
-- Example?

-- Note:
-- To get alternative of PK in another column,
-- then we can use NOT NULL and UNIQUE together.
*/

CREATE TABLE Q3
(
    id     INT PRIMARY KEY,
    f_name VARCHAR(10) NOT NULL,
    custid INT NOT NULL UNIQUE
);


INSERT INTO Q3 VALUES (1, 'a', 101);

/*
-- Valid
*/


INSERT INTO Q3 VALUES (2, 'a', 101);

/*
-- Invalid

-- custid NOT NULL and UNIQUE,
-- so it will use UNIQUE constraint.

Violation of UNIQUE KEY constraint 'UQ__Q3__973AFEFF50B368E8'.
Cannot insert duplicate key in object 'dbo.Q3'.
The duplicate key value is (101).
*/


INSERT INTO Q3 VALUES (1, 'a', 102);

/*
-- Invalid

-- The PRIMARY KEY constraint is in use.

Violation of PRIMARY KEY constraint 'PK__Q3__3213E83FAC127C05'.
Cannot insert duplicate key in object 'dbo.Q3'.
The duplicate key value is (1).
The statement has been terminated.
*/


INSERT INTO Q3 VALUES (3, NULL, 103);

/*
-- Valid

-- Cannot insert the value NULL into column 'f_name',
-- table 'Online_New.dbo.Q3';
-- column does not allow nulls. INSERT fails.
*/


INSERT INTO Q3 VALUES (4, NULL, 104);

/*
-- Invalid

-- Cannot insert the value NULL into column 'f_name',
-- table 'Online_New.dbo.Q3';
-- column does not allow nulls. INSERT fails.
*/


/*
-- If we have a table and column has NULL and is not unique,
-- then we can't alter it to PK.
*/


/* ------------------------------------------------------------
REMAINING CONSTRAINTS
---------------------------------------------------------------

-- The remaining constraints are for specific values.

-- Example:
-- age > 18
*/


/* ------------------------------------------------------------
4. CHECK
---------------------------------------------------------------
*/

CREATE TABLE Q4
(
    id  INT,
    age INT CHECK (age > 18)
);


INSERT INTO Q4 VALUES (1, 23);

INSERT INTO Q4 VALUES (1, 18);

/*
-- CHECK constraint does not allow 18.

The INSERT statement conflicted with the CHECK constraint "CK__Q4__age__6D0D32F4".
The conflict occurred in database "Online_New", table "dbo.q4", column 'age'.
*/


SELECT * FROM Q4;


/*
-- I can use any operators in CHECK constraint.
*/


ALTER TABLE Q4
ADD city VARCHAR(10);


ALTER TABLE Q4
ADD name VARCHAR(10)
CHECK (name NOT LIKE 'a%');


INSERT INTO Q4
VALUES (2, 19, 'nag', 'arpit');

/*
-- Invalid.
-- CHECK says name should not start with 'a'.

The INSERT statement conflicted with the CHECK constraint "CK__Q4__name__6E01572D".
The conflict occurred in database "Online_New", table "dbo.q4", column 'name'.
*/


ALTER TABLE Q4
ADD marks INT
CHECK (marks NOT LIKE '9%' AND marks <> 99234235);


/*
-- This will not accept:
-- marks starting from 9
-- and 99234235
*/


INSERT INTO Q4
VALUES (2, 19, 'pune', 'rman', 99234235);

/*
-- The INSERT statement conflicted with the CHECK constraint "CK__Q4__marks__6EF57B66".
The conflict occurred in database "Online_New", table "dbo.q4", column 'marks'.
*/


ALTER TABLE Q4
ADD grade VARCHAR(10)
CHECK (grade IN ('A', 'B', 'C'));


INSERT INTO Q4
VALUES (3, 45, 'hyd', 'hrushi', 85, 'c');

/*
-- Valid.
-- Grade is C.
*/


INSERT INTO Q4
VALUES (3, 45, 'hyd', 'hrushi', 85, 'y');

/*
-- Invalid.
-- Grade Y is not allowed.
*/


INSERT INTO Q4
VALUES (3, 45, 'hyd', 'hrushi', 85, NULL);

/*
-- So we have to add constraint for NOT NULL as well.
*/


/* ------------------------------------------------------------
EXPLORATION
---------------------------------------------------------------

-- Explore constraints and keys in Object Explorer.

===============================================================
                         END OF NOTES
=============================================================== */