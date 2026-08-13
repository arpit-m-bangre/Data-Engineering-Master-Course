/* ============================================================
          SQL SERVER - BASIC THEORY (SHORT NOTES)
   ============================================================ */

-- ------------------------------------------------------------
-- 1) WHAT IS DATA?
-- ------------------------------------------------------------
-- Data = Raw facts or information.
-- Example:
--   Name   = Manoj
--   Age    = 20
--   Salary = 25000


-- ------------------------------------------------------------
-- 2) WHAT IS DATABASE?
-- ------------------------------------------------------------
-- A Database is a collection of related data stored in an organized way.
-- Example: A College Database stores:
--   - Students
--   - Teachers
--   - Courses
--   - Marks


-- ------------------------------------------------------------
-- 3) WHAT IS DBMS?
-- ------------------------------------------------------------
-- DBMS = Database Management System
-- Software used to create, store, update and manage databases.
--
-- Examples:
--   - Microsoft Access
--   - MySQL
--   - Oracle
--   - SQL Server
--
-- Features:
--   - Store data
--   - Retrieve data
--   - Update data
--   - Delete data


-- ------------------------------------------------------------
-- 4) WHAT IS RDBMS?
-- ------------------------------------------------------------
-- RDBMS = Relational Database Management System
-- Data is stored in Tables (Rows & Columns).
-- Tables are related using Primary Key and Foreign Key.
--
-- Examples:
--   - Microsoft SQL Server
--   - MySQL
--   - Oracle
--   - PostgreSQL


-- ------------------------------------------------------------
-- 5) WHAT IS SQL?
-- ------------------------------------------------------------
-- SQL = Structured Query Language
-- The language used to communicate with databases.
--
-- Using SQL we can:
--   - Create Database
--   - Create Tables
--   - Insert Data
--   - Update Data
--   - Delete Data
--   - Retrieve Data


-- ------------------------------------------------------------
-- 6) TYPES OF SQL COMMANDS
-- ------------------------------------------------------------

-- 6.1) DDL (Data Definition Language)
--      Used to define database structure.
--      Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME
--      Example: CREATE TABLE Student(...);

-- 6.2) DML (Data Manipulation Language)
--      Used to insert or modify data.
--      Commands: INSERT, UPDATE, DELETE
--      Example: INSERT INTO Student VALUES(...);

-- 6.3) DQL (Data Query Language)
--      Used to retrieve data.
--      Command: SELECT
--      Example: SELECT * FROM Student;

-- 6.4) DCL (Data Control Language)
--      Used to control user permissions.
--      Commands: GRANT, REVOKE

-- 6.5) TCL (Transaction Control Language)
--      Used to manage transactions.
--      Commands: COMMIT, ROLLBACK, SAVEPOINT
--        COMMIT    -> Save changes permanently.
--        ROLLBACK  -> Undo changes.
--        SAVEPOINT -> Create a checkpoint.


-- ------------------------------------------------------------
-- 7) WHAT IS MICROSOFT SQL SERVER?
-- ------------------------------------------------------------
-- Microsoft SQL Server is an RDBMS developed by Microsoft.
-- It stores and manages data using SQL.
--
-- Used in:
--   - Banks
--   - Hospitals
--   - Schools
--   - Companies
--   - E-commerce Websites


-- ------------------------------------------------------------
-- 8) WHAT IS SSMS?
-- ------------------------------------------------------------
-- SSMS = SQL Server Management Studio
-- A graphical tool used to work with SQL Server.
--
-- Using SSMS we can:
--   - Connect to SQL Server
--   - Write SQL Queries
--   - Create Databases
--   - Create Tables
--   - Execute Queries
--   - Backup & Restore Databases
--
-- Think of it like:
--   SQL Server = Engine (Stores Data)
--   SSMS       = Dashboard (Controls the Engine)


-- ------------------------------------------------------------
-- 9) DATABASE OBJECTS
-- ------------------------------------------------------------
-- Database
--    |
--    |-- Tables
--    |-- Views
--    |-- Stored Procedures
--    |-- Functions
--    |-- Triggers
--    |-- Indexes


-- ------------------------------------------------------------
-- 10) TABLE
-- ------------------------------------------------------------
-- A Table stores data in Rows and Columns.
--
-- +----+--------+-----+
-- |ID  | Name   | Age |
-- +----+--------+-----+
-- |1   | Manoj  | 20  |
-- |2   | Rahul  | 22  |
-- +----+--------+-----+
--
-- Rows    = Records
-- Columns = Fields


-- ------------------------------------------------------------
-- 11) PRIMARY KEY
-- ------------------------------------------------------------
-- A Primary Key uniquely identifies each record.
--
-- Rules:
--   - Unique
--   - Cannot be NULL
--
-- Example: StudentID


-- ------------------------------------------------------------
-- 12) FOREIGN KEY
-- ------------------------------------------------------------
-- A Foreign Key connects one table to another.
-- Used to create relationships.
--
-- Example:
--   Student(StudentID)
--   Fees(StudentID)


-- ------------------------------------------------------------
-- 13) SIMPLE FLOW
-- ------------------------------------------------------------
-- Data
--   ↓
-- Database
--   ↓
-- DBMS / RDBMS
--   ↓
-- SQL Language
--   ↓
-- SQL Server (Stores Data)
--   ↓
-- SSMS (Used to Write SQL Queries)

/* ============================================================
                END OF BASIC SQL THEORY
   ============================================================ */


-- ============================================================
-- DEMO DAY 3
-- ============================================================

-- SQL SERVER IS CASE INSENSITIVE
-- EACH DATABASE CAN HAVE A UNIQUE TABLE NAME ONLY; THAT SAME TABLE NAME CAN EXIST
--   IN ANOTHER DATABASE BUT NOT IN THE SAME ONE
-- COLUMN NAMES SHOULD BE UNIQUE SINCE THEY ARE FIELDS IN THE FRONTEND
-- UNDERSTAND THE COLOR COMBINATION IN SSMS; ALSO EXPLORE SSMS IN DETAIL,
--   INCLUDING KEYBOARD SHORTCUTS
--   BASIC QUERY - BLACK , KEYWORDS - BLUE , FUNCTIONS - PINK , COMMENTS - GREEN

-------------------------------------------------------------------------------

-- SQL STATEMENTS BETWEEN FRONTEND AND BACKEND
-- 1. DDL - DATA DEFINITION LANGUAGE: WORKS ON THE STRUCTURE OF THE TABLE
--          EXAMPLE: CREATE, ALTER, RENAME, DROP, TRUNCATE
-- 2. DML - DATA MANIPULATION LANGUAGE: WORKS ON THE DATA OF THE TABLE ONLY
--          EXAMPLE: INSERT, UPDATE, DELETE
-- 3. DQL - DATA QUERY LANGUAGE: USED TO READ THE TABLE, ONLY ONE STATEMENT USED - SELECT
-- 4. DCL - DATA CONTROL LANGUAGE: STATEMENTS USED TO KEEP CONTROL ON DATA,
--          HANDLED BY DATA ADMIN, EXAMPLE: GRANT AND REVOKE
-- 5. TCL - TRANSACTION CONTROL: USED TO COMMIT AND ROLLBACK OPERATIONS
--          LIKE PERMANENT SAVE AND UNDO

-- NOTE: DDL, DML, DQL ARE MOST IMPORTANT AS DE; DCL IS HANDLED BY OTHER TEAM
-- SQL IS NEEDED FOR ETL - EXTRACT, TRANSFORM, LOAD DATA FROM SOURCE TO TARGET

-- HOW TO CREATE A TABLE
-- NOTE: AFTER EVERY DDL STATEMENT THERE WILL ALWAYS BE THE TABLE KEYWORD;
--       IN DML THERE IS NO TABLE KEYWORD, ONLY THE TABLE NAME IS USED

-- CREATE TABLE table_name ( col1 data_type , col2 data_type , col3 data_type , col4 data_type ......... )
CREATE TABLE employee
(
    empid   INT,
    empname VARCHAR,
    dept    VARCHAR,
    salary  INT
);
-- varchar is used above without a size limit, since varchar is variable-length memory
--   (example: 20 as a data limit means it will use/release memory accordingly)
-- employee table can't take values since varchar data limit is not set

CREATE TABLE employee1
(
    empid   INT,
    empname VARCHAR(20),
    dept    VARCHAR(20),
    salary  INT
);
-- NOTE: varchar is used when entries are small and of a decided/known length;
--       when we want a longer, descriptive entry, we use text instead

-- HOW TO READ/EXTRACT TABLE

SELECT * FROM employee;
SELECT * FROM employee1;

-- * means all columns; if a specific column is needed, it must be entered properly

SELECT dept, salary FROM employee;
SELECT dept, salary FROM employee1;

-- TASK
-- CREATE TABLE StudentInfo
-- roll_no , name , city , subject , marks , age , email_id, mobile_no

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


-- ============================================================
-- DEMO DAY 4
-- ============================================================

-- Insert - DML
SELECT * FROM employee;
SELECT * FROM employee1;

INSERT INTO employee VALUES (101, 'Amit', 'HR', 2000);
-- String or binary data would be truncated in table 'Online_New.dbo.employee', column 'empname'. Truncated value: 'A'.

INSERT INTO employee1 VALUES (101, 'Amit', 'HR', 2000);
-- NOTE: insert in same sequence as the table columns
-- NOTE: use inverted commas for string entries
INSERT INTO employee1 VALUES (102, 'Puja', 'Entc', 3000);
INSERT INTO employee1 VALUES (103, 'Arpit', 'Stat', 4000);
INSERT INTO employee1 VALUES (104, 'Sidhant', 'Electronics', 5000);
INSERT INTO employee1 VALUES (105, 'Mohit', 'MS', 6000);
INSERT INTO employee1 VALUES (106, 'Shreyash', 'BCA', 7000);
INSERT INTO employee1 VALUES (107, NULL, NULL, NULL);
INSERT INTO employee1 (empid, empname) VALUES (108, 'Pushpak');
INSERT INTO employee1 (empid, empname) VALUES (109, 'Yash');
INSERT INTO employee1 (empid, empname) VALUES (110, 'Rahul');
-- NOTE: in a company, no one does manual entry; there will be automation,
--       and automation uses this kind of statement/query

INSERT INTO employee1 VALUES (111, 'Arjun', '', ''); -- 111  Arjun     0
SELECT * FROM employee1;
-- NOTE: an empty entry ('') leaves a blank space for varchar and 0 for integer,
--       but 0 is a value and space is also a value, so this is not good practice
-- NOTE: to overcome this, we use the NULL/null keyword instead

INSERT INTO employee1 VALUES (NULL, NULL, NULL, NULL); -- NULL  NULL  NULL  NULL
-- NOTE: the above null/NULL entries are manual; we want automation instead
-- NOTE: to overcome this, we specify the column names before VALUES,
--       matching the same order of entries after the VALUES keyword

INSERT INTO employee1 (dept, salary) VALUES ('Mech', 8000); -- NULL  NULL  Mech  8000
-- NOTE: this insertion approach only fills the columns mentioned before VALUES;
--       the rest are automatically set to NULL (final automation approach)

INSERT INTO employee1 VALUES (NULL, 'arpitmanojbangrearpitmanojbangrearpitmanojbangre', NULL, NULL);
-- String or binary data would be truncated in table 'Online_New.dbo.employee1', column 'empname'. Truncated value: 'arpitmanojbangrearpi'.