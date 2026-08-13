/* ============================================================
               DAY 1 PRACTICE QUESTIONS & SOLUTIONS (1 AUGUST 2026)
               TOPICS: SQL THEORY, COMMAND CLASSIFICATION (DDL/DML/DQL),
                       CREATE TABLE, SELECT & INSERT INTO
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - CREATE TABLE]:
/*
Task: Write a DDL query to create a table 'EmployeeBasic' with columns:
- EmpID (INTEGER)
- EmpName (VARCHAR 20)
- Salary (INTEGER)
*/

-- Solution:
CREATE TABLE EmployeeBasic
(
    EmpID   INT,
    EmpName VARCHAR(20),
    Salary  INT
);


-- QUESTION 2 [Basic Syntax - SELECT Projections]:
/*
Task:
1. Write a query to select ALL columns from 'EmployeeBasic'.
2. Write a query to select ONLY 'EmpName' and 'Salary' from 'EmployeeBasic'.
*/

-- Solution:
-- 1. Select ALL columns
SELECT * FROM EmployeeBasic;

-- 2. Select specific columns
SELECT EmpName, Salary FROM EmployeeBasic;


-- ============================================================
-- SECTION 2: DML & INSERTION PATTERNS
-- ============================================================

-- QUESTION 3 [Basic Syntax - INSERT INTO Statements]:
/*
Task:
1. Write an INSERT query providing values for ALL columns matching column sequence: (101, 'Rahul', 25000).
2. Write an INSERT query specifying explicit column list for (EmpID, EmpName) with values: (102, 'Priya').
*/

-- Solution:
-- 1. Full row insertion
INSERT INTO EmployeeBasic VALUES (101, 'Rahul', 25000);

-- 2. Selective column list insertion
INSERT INTO EmployeeBasic (EmpID, EmpName) VALUES (102, 'Priya');


-- QUESTION 4 [Theory - SQL Command Classification]:
/*
Task: Classify each of the following SQL statements into their correct category (DDL, DML, DQL, DCL, TCL):
1. CREATE TABLE StudentMaster (...)
2. INSERT INTO StudentMaster VALUES (...)
3. SELECT * FROM StudentMaster
4. ALTER TABLE StudentMaster ADD City VARCHAR(20)
5. DROP TABLE StudentMaster
*/

-- Solution:
/*
CLASSIFICATION SUMMARY:
1. CREATE TABLE -> DDL (Data Definition Language)
2. INSERT INTO   -> DML (Data Manipulation Language)
3. SELECT        -> DQL (Data Query Language)
4. ALTER TABLE   -> DDL (Data Definition Language)
5. DROP TABLE    -> DDL (Data Definition Language)
*/


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Healthcare Patient Records Schema]:
/*
Scenario: A hospital requires a database table to log patient admissions.
Task:
1. Create table 'PatientRecords' with: PatientID (INT), FullName (VARCHAR 50), Age (INT), MedicalHistory (VARCHAR 200), ContactNumber (VARCHAR 15), AdmissionDate (VARCHAR 20).
2. Insert 3 complete patient records.
3. Retrieve all patient records from Nagpur city.
*/

-- Solution:
CREATE TABLE PatientRecords
(
    PatientID      INT,
    FullName       VARCHAR(50),
    Age            INT,
    MedicalHistory VARCHAR(200),
    ContactNumber  VARCHAR(15),
    AdmissionDate  VARCHAR(20)
);

INSERT INTO PatientRecords VALUES (1, 'Rajesh Kumar', 45, 'Hypertension, Diabetes Type 2', '9876543210', '2026-08-01');
INSERT INTO PatientRecords VALUES (2, 'Sunita Sharma', 32, 'Acute Appendicitis', '8765432109', '2026-08-01');
INSERT INTO PatientRecords VALUES (3, 'Amit Verma', 60, 'Routine Cardiology Assessment', '7654321098', '2026-08-01');

SELECT * FROM PatientRecords;


-- QUESTION 6 [Scenario - E-Commerce Product Catalog]:
/*
Scenario: An online store needs to store product inventory details.
Task:
1. Create table 'ProductCatalog' with: ProductID (INT), ProductName (VARCHAR 30), Category (VARCHAR 20), Price (INT), StockQuantity (INT).
2. Insert 2 records with full column values.
3. Insert 1 record omitting 'StockQuantity'.
*/

-- Solution:
CREATE TABLE ProductCatalog
(
    ProductID     INT,
    ProductName   VARCHAR(30),
    Category      VARCHAR(20),
    Price         INT,
    StockQuantity INT
);

INSERT INTO ProductCatalog VALUES (101, 'Wireless Mouse', 'Electronics', 1200, 50);
INSERT INTO ProductCatalog VALUES (102, 'Mechanical Keyboard', 'Electronics', 4500, 25);
INSERT INTO ProductCatalog (ProductID, ProductName, Category, Price) VALUES (103, 'USB-C Cable', 'Electronics', 450);


-- QUESTION 7 [Scenario - String Truncation Error Demonstration]:
/*
Scenario: Testing system limits on VARCHAR columns.
Task:
1. Create table 'CourseEnrollment' with: EnrollmentID (INT), StudentName (VARCHAR 15).
2. Write an INSERT statement attempting to insert 'Alexander Bartholomew' (21 chars) into StudentName and explain the resulting error message.
*/

-- Solution:
CREATE TABLE CourseEnrollment
(
    EnrollmentID INT,
    StudentName  VARCHAR(15)
);

/*
INSERT INTO CourseEnrollment VALUES (101, 'Alexander Bartholomew');
-- ERROR: String or binary data would be truncated in table 'CourseEnrollment', column 'StudentName'.
-- REASON: StudentName is defined as VARCHAR(15), but 'Alexander Bartholomew' is 21 characters long.
*/

-- Valid Insertion:
INSERT INTO CourseEnrollment VALUES (101, 'Alex Bart');


-- QUESTION 8 [Scenario - NULL vs Empty String Handling]:
/*
Scenario: Differentiating between unknown data (NULL) and zero-length strings ('').
Task:
1. Create table 'UserData' (UserID INT, UserName VARCHAR 20, UserBio VARCHAR 50).
2. Insert a row where UserBio is an empty string ('').
3. Insert a row where UserBio is NULL.
4. Write a SELECT statement querying both rows.
*/

-- Solution:
CREATE TABLE UserData
(
    UserID   INT,
    UserName VARCHAR(20),
    UserBio  VARCHAR(50)
);

-- Row with empty string
INSERT INTO UserData VALUES (1, 'UserA', '');

-- Row with NULL
INSERT INTO UserData VALUES (2, 'UserB', NULL);

SELECT UserID, UserName, UserBio, DATALENGTH(UserBio) AS BioByteLength FROM UserData;


-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Table Schema Modifications & Memory Rules]:
/*
Task:
1. What error occurs if single quotes are omitted around string values in an INSERT query?
2. Write a valid query demonstrating proper single-quote usage for inserting string values.
*/

-- Solution:
/*
1. EXPLANATION: Omitting single quotes around string literals causes SQL Server to treat the text as an invalid column name, resulting in error "Invalid column name 'Value'".
*/

-- 2. Valid Query:
INSERT INTO UserData VALUES (3, 'UserC', 'Data Engineer');


-- QUESTION 10 [Debugging - Fix Broken DDL & DML Queries]:
/*
Task: Identify and fix errors in the following 2 queries:
1. CREATE StudentInfo (RollNo INT, Name VARCHAR(20));
2. INSERT INTO StudentInfo (RollNo) VALUES ('101', 'Arpit');
*/

-- Solution:
-- 1. Fix: Add mandatory TABLE keyword
CREATE TABLE StudentInfo (RollNo INT, Name VARCHAR(20));

-- 2. Fix: Match column list with value count
INSERT INTO StudentInfo (RollNo, Name) VALUES (101, 'Arpit');


/* ============================================================
                   END OF DAY 1 PRACTICE & SOLUTIONS
   ============================================================ */
