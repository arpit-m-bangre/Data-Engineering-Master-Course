/*================================================================
   SQL CLASS NOTES - 01 AUGUST 2026 (DAY 1)
   TOPICS: DATABASE FUNDAMENTALS, DDL & DML, CREATE TABLE, INSERT & SELECT
==================================================================*/


/*================================================================
1. DATABASE FUNDAMENTALS
==================================================================*/

-- 1. DATA: Raw facts (e.g. 'Manoj', 20, 25000).
-- 2. DATABASE: Organized digital file cabinet.
-- 3. DBMS: Software that runs the file cabinet (e.g. SQL Server).
-- 4. RDBMS: DBMS that links tables together (like connected Excel sheets).
-- 5. SQL: Language we use to talk to the database.
-- 6. SSMS: Steering wheel to control the database engine.


/*----------------------------------------------------------------
The 5 SQL Toolboxes
------------------------------------------------------------------

1. DDL (Definition): The Architect (CREATE, ALTER, DROP, TRUNCATE).
   * Alters structure. Always uses the "TABLE" keyword.
2. DML (Manipulation): The Mover (INSERT, UPDATE, DELETE).
   * Alters data rows. Never uses the "TABLE" keyword.
3. DQL (Query): The Detective (SELECT). Reads data.
4. DCL (Control): The Guard (GRANT, REVOKE). Controls permissions.
5. TCL (Transaction): Video Game Save (COMMIT, ROLLBACK). Manages undo/saves.

Note: SQL is case-insensitive, but we write keywords in UPPERCASE.
*/


/*================================================================
2. TABLE CREATION
==================================================================*/

CREATE TABLE employee
(
    empid   INT,
    empname VARCHAR,
    dept    VARCHAR,
    salary  INT
);


/*----------------------------------------------------------------
WARNING

VARCHAR without size defaults to 1 character!
This causes insert statements to fail with truncation errors.
------------------------------------------------------------------*/

SELECT * FROM employee;

SELECT dept, salary FROM employee;


INSERT INTO employee VALUES (101, 'Amit', 'HR', 2000);

/*----------------------------------------------------------------
Error:
❌ Fails: Truncation error because VARCHAR size is not set.
------------------------------------------------------------------*/


CREATE TABLE employee1
(
    empid   INT,
    empname VARCHAR(20),
    dept    VARCHAR(20),
    salary  INT
);


/*----------------------------------------------------------------
Note:
✔️ Correct: Explicit sizes are set for VARCHAR columns.
------------------------------------------------------------------*/

SELECT * FROM employee1;

SELECT dept, salary FROM employee1;


/*================================================================
3. DATA INSERTION PATTERNS
==================================================================*/

-- Pattern A: Full row insert (Values order must match columns sequence)
INSERT INTO employee1 VALUES (101, 'Amit', 'HR', 2000);
INSERT INTO employee1 VALUES (102, 'Puja', 'Entc', 3000);
INSERT INTO employee1 VALUES (103, 'Arpit', 'Stat', 4000);
INSERT INTO employee1 VALUES (104, 'Sidhant', 'Electronics', 5000);
INSERT INTO employee1 VALUES (105, 'Mohit', 'MS', 6000);
INSERT INTO employee1 VALUES (106, 'Shreyash', 'BCA', 7000);


-- Pattern B: Empty value vs NULL
-- Note: Empty string ('') or 0 are actual values.
-- Always use NULL for unknown/missing data!
INSERT INTO employee1 VALUES (111, 'Arjun', '', ''); 
INSERT INTO employee1 VALUES (107, NULL, NULL, NULL);


-- Pattern C: Selective column insertion (Missing columns default to NULL)
INSERT INTO employee1 (empid, empname) VALUES (108, 'Pushpak');
INSERT INTO employee1 (empid, empname) VALUES (109, 'Yash');
INSERT INTO employee1 (empid, empname) VALUES (110, 'Rahul');
INSERT INTO employee1 (dept, salary) VALUES ('Mech', 8000);


INSERT INTO employee1 VALUES (NULL, 'arpitmanojbangrearpitmanojbangre', NULL, NULL);

/*----------------------------------------------------------------
Error:
❌ Fails: name exceeds the VARCHAR(20) limit of employee1.
------------------------------------------------------------------*/


/*================================================================
4. IN-CLASS TASK: STUDENT INFO TABLE
==================================================================*/

CREATE TABLE StudentInfo
(
    roll_no   INT,
    name      VARCHAR(30),
    city      VARCHAR(30),
    subject   VARCHAR(15),
    marks     INT,
    age       INT,
    email_id  VARCHAR(40),
    mobile_no INT
);

SELECT * FROM StudentInfo;\n