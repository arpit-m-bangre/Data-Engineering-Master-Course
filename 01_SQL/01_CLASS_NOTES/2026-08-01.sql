/* ================================================================================
   SQL CLASS NOTES - 01 AUGUST 2026 (DAY 1)
   TOPICS: DATABASE FUNDAMENTALS, COMMAND CATEGORIES, CREATE TABLE, INSERT & SELECT
   ================================================================================ */

-- 1. DATA: Raw facts (e.g. 'Manoj', 20, 25000).
-- 2. DATABASE: An organized collection of related data (e.g. College DB).
-- 3. DBMS: Software to manage databases. (Analogy: A digital file cabinet).
-- 4. RDBMS: DB software storing data in connected tables. (Analogy: Excel workbook with linked tabs).
-- 5. SQL: Language used to talk to the RDBMS.
-- 6. SSMS: GUI tool to work with SQL Server. (Analogy: SQL Server = Engine; SSMS = Steering Wheel).

-- ------------------------------------------------------------
-- THE 5 SQL TOOLBOXES
-- ------------------------------------------------------------
-- 1. DDL (Data Definition): The Architect (CREATE, ALTER, DROP, TRUNCATE). Alters structure.
-- 2. DML (Data Manipulation): The Mover (INSERT, UPDATE, DELETE). Alters data rows.
-- 3. DQL (Data Query): The Detective (SELECT). Reads data.
-- 4. DCL (Data Control): The Guard (GRANT, REVOKE). Controls permissions.
-- 5. TCL (Transaction Control): Video Game Save (COMMIT, ROLLBACK). Manages transactions.

-- ------------------------------------------------------------
-- CRITICAL RULES FOR DDL & DML
-- ------------------------------------------------------------
-- DDL commands always require the keyword "TABLE" (e.g., CREATE TABLE).
-- DML commands never use the "TABLE" keyword, only the table name (e.g., INSERT INTO employee).
-- SQL Server is case-insensitive, but we keep SQL keywords in UPPERCASE.

-------------------------------------------------------------------------------

-- ❌ BAD TABLE CREATION: VARCHAR without size defaults to 1 character (fails on inserts!).
CREATE TABLE employee
(
    empid   INT,
    empname VARCHAR,
    dept    VARCHAR,
    salary  INT
);

-- SELECT: Extracts data from the table (* means all columns)
SELECT * FROM employee;
SELECT dept, salary FROM employee;

-- Test insert (fails due to VARCHAR size truncation error)
INSERT INTO employee VALUES (101, 'Amit', 'HR', 2000);

-------------------------------------------------------------------------------

-- ✔️ GOOD TABLE CREATION: Explicit sizes set for VARCHAR
CREATE TABLE employee1
(
    empid   INT,
    empname VARCHAR(20),
    dept    VARCHAR(20),
    salary  INT
);

SELECT * FROM employee1;
SELECT dept, salary FROM employee1;

-- ------------------------------------------------------------
-- DATA INSERTION PATTERNS
-- ------------------------------------------------------------

-- Pattern A: Full row insert (Must match columns sequence exactly)
INSERT INTO employee1 VALUES (101, 'Amit', 'HR', 2000);
INSERT INTO employee1 VALUES (102, 'Puja', 'Entc', 3000);
INSERT INTO employee1 VALUES (103, 'Arpit', 'Stat', 4000);
INSERT INTO employee1 VALUES (104, 'Sidhant', 'Electronics', 5000);
INSERT INTO employee1 VALUES (105, 'Mohit', 'MS', 6000);
INSERT INTO employee1 VALUES (106, 'Shreyash', 'BCA', 7000);

-- Pattern B: Empty value vs NULL
-- Note: Empty string ('') or 0 is an actual value. Always use NULL for missing data!
INSERT INTO employee1 VALUES (111, 'Arjun', '', ''); 
INSERT INTO employee1 VALUES (107, NULL, NULL, NULL);

-- Pattern C: Selective column insertion (Automation approach)
-- Unspecified columns are automatically filled with NULL.
INSERT INTO employee1 (empid, empname) VALUES (108, 'Pushpak');
INSERT INTO employee1 (empid, empname) VALUES (109, 'Yash');
INSERT INTO employee1 (empid, empname) VALUES (110, 'Rahul');
INSERT INTO employee1 (dept, salary) VALUES ('Mech', 8000);

-- Test truncation (Fails because name length exceeds VARCHAR(20))
INSERT INTO employee1 VALUES (NULL, 'arpitmanojbangrearpitmanojbangrearpitmanojbangre', NULL, NULL);

-------------------------------------------------------------------------------
-- TASK: STUDENT INFO TABLE
-------------------------------------------------------------------------------
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

SELECT * FROM StudentInfo;
