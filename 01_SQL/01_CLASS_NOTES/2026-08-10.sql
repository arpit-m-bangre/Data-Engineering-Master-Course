/*================================================================
   SQL CLASS NOTES - 10 AUGUST 2026 (DAY 9)
   TOPICS: SQL CONSTRAINTS, PRIMARY KEY, UNIQUE, NOT NULL, CHECK CONSTRAINTS
==================================================================*/


/*================================================================
1. PRIMARY KEY (PK)
==================================================================*/

/*----------------------------------------------------------------
Theory:
Constraints are input rules put on columns to keep data clean.
PRIMARY KEY: Unique values only + Cannot be NULL + Maximum 1 Primary Key per table.
------------------------------------------------------------------*/

CREATE TABLE Q1
(
    id   INT PRIMARY KEY,
    name VARCHAR(10)
);


INSERT INTO Q1 VALUES (1, 'a');


INSERT INTO Q1 VALUES (1, 'a');
/*----------------------------------------------------------------
Error:
❌ Fails: Violation of PRIMARY KEY constraint (Duplicate ID value 1).
------------------------------------------------------------------*/


INSERT INTO Q1 VALUES (NULL, 'a');
/*----------------------------------------------------------------
Error:
❌ Fails: Cannot insert the value NULL into PK column 'id'.
------------------------------------------------------------------*/


INSERT INTO Q1 VALUES (2, 'a'); -- (Valid: Name can duplicate because it has no constraint)

SELECT * FROM Q1;


/*================================================================
2. UNIQUE CONSTRAINT
==================================================================*/

/*----------------------------------------------------------------
Theory:
UNIQUE: Unique values only + Allows exactly ONE NULL value (in SQL Server).
------------------------------------------------------------------*/

CREATE TABLE Q2
(
    id   INT UNIQUE,
    city VARCHAR(10)
);


INSERT INTO Q2 VALUES (1, 'pune');


INSERT INTO Q2 VALUES (1, 'pune');
/*----------------------------------------------------------------
Error:
❌ Fails: Violation of UNIQUE KEY constraint (Duplicate ID value 1).
------------------------------------------------------------------*/


INSERT INTO Q2 VALUES (NULL, 'mumbai');


INSERT INTO Q2 VALUES (NULL, 'mumbai');
/*----------------------------------------------------------------
Error:
❌ Fails: Violation of UNIQUE KEY constraint (Duplicate key value NULL is not allowed twice!).
------------------------------------------------------------------*/

SELECT * FROM Q2;


/*================================================================
3. NOT NULL CONSTRAINT
==================================================================*/

/*----------------------------------------------------------------
Theory:
NOT NULL: Must contain a value + Duplicates are allowed.
Tip: NOT NULL + UNIQUE combined acts exactly like a secondary Primary Key!
------------------------------------------------------------------*/

CREATE TABLE Q3
(
    id     INT PRIMARY KEY,
    f_name VARCHAR(10) NOT NULL,
    custid INT NOT NULL UNIQUE
);


INSERT INTO Q3 VALUES (1, 'a', 101);


INSERT INTO Q3 VALUES (2, 'a', 101);
/*----------------------------------------------------------------
Error:
❌ Fails: Violation of UNIQUE KEY constraint (Duplicate custid 101).
------------------------------------------------------------------*/


INSERT INTO Q3 VALUES (1, 'a', 102);
/*----------------------------------------------------------------
Error:
❌ Fails: Violation of PRIMARY KEY constraint (Duplicate id 1).
------------------------------------------------------------------*/


INSERT INTO Q3 VALUES (3, NULL, 103);
/*----------------------------------------------------------------
Error:
❌ Fails: Cannot insert the value NULL into column 'f_name'.
------------------------------------------------------------------*/


/*================================================================
4. CHECK CONSTRAINT
==================================================================*/

CREATE TABLE Q4
(
    id  INT,
    age INT CHECK (age > 18)
);


INSERT INTO Q4 VALUES (1, 23);


INSERT INTO Q4 VALUES (1, 18);
/*----------------------------------------------------------------
Error:
❌ Fails: Conflicted with the CHECK constraint (age must be > 18!).
------------------------------------------------------------------*/

SELECT * FROM Q4;


-- Adding column with custom CHECK constraints
ALTER TABLE Q4 ADD city VARCHAR(10);

ALTER TABLE Q4 ADD name VARCHAR(10) CHECK (name NOT LIKE 'a%');


INSERT INTO Q4 VALUES (2, 19, 'nag', 'arpit');
/*----------------------------------------------------------------
Error:
❌ Fails: name starts with 'a' which violates CHECK constraint!
------------------------------------------------------------------*/


-- Adding CHECK constraint with multiple conditions
ALTER TABLE Q4 ADD marks INT CHECK (marks NOT LIKE '9%' AND marks <> 99234235);


INSERT INTO Q4 VALUES (2, 19, 'pune', 'rman', 99234235);
/*----------------------------------------------------------------
Error:
❌ Fails: marks value 99234235 is explicitly blocked by CHECK constraint!
------------------------------------------------------------------*/


-- Adding CHECK constraint with IN list
ALTER TABLE Q4 ADD grade VARCHAR(10) CHECK (grade IN ('A', 'B', 'C'));


INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, 'c'); -- (Valid: 'c' matches 'C' case-insensitively)


INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, 'y');
/*----------------------------------------------------------------
Error:
❌ Fails: Grade Y is not in the allowed CHECK list ('A', 'B', 'C').
------------------------------------------------------------------*/


INSERT INTO Q4 VALUES (3, 45, 'hyd', 'hrushi', 85, NULL);
/*----------------------------------------------------------------
Note:
CHECK constraints allow NULL unless NOT NULL is also specified!
------------------------------------------------------------------*/\n