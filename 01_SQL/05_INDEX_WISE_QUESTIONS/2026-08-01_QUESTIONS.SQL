/* ============================================================
               DAY 1 PRACTICE QUESTIONS (1 AUGUST 2026)
               TOPICS: SQL THEORY, COMMAND CLASSIFICATION (DDL/DML/DQL),
                       CREATE TABLE, SELECT & INSERT INTO
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - CREATE TABLE Basics]:
/*
Task: Write a DDL query to create a table 'EmployeeBasic' with columns:
- EmpID (INTEGER)
- EmpName (VARCHAR 20)
- Salary (INTEGER)
*/

-- Write your SQL Query below:
CREATE TABLE EmployeeBasic (
    EmpID INTEGER,
    EmpName VARCHAR(20),
    Salary INTEGER
);


-- QUESTION 2 [Syntax Drill - SELECT Projection Variants]:
/*
Task:
1. Write a query to select ALL columns from 'EmployeeBasic'.
2. Write a query to select ONLY 'EmpName' and 'Salary' from 'EmployeeBasic'.
3. Write a query selecting 'EmpName' as 'Employee_Name' using a column alias.
*/

-- Write your SQL Queries below:
SELECT * FROM EmployeeBasic;

SELECT EmpName, Salary FROM EmployeeBasic;

SELECT EmpName AS Employee_Name FROM EmployeeBasic;


-- QUESTION 3 [Syntax Drill - INSERT INTO Full vs Column List]:
/*
Task:
1. Write an INSERT query providing values for ALL columns matching column sequence: (101, 'Rahul', 25000).
2. Write an INSERT query specifying explicit column list for (EmpID, EmpName) with values: (102, 'Priya').
3. Write a multi-row INSERT query adding 2 employees in a single statement.
*/

-- Write your SQL Queries below:
INSERT INTO EmployeeBasic VALUES (101, 'Rahul', 25000);

INSERT INTO EmployeeBasic (EmpID, EmpName) VALUES (102, 'Priya');

INSERT INTO EmployeeBasic (EmpID, EmpName, Salary) 
VALUES (103, 'Amit', 30000), 
       (104, 'Sneha', 32000);


-- QUESTION 4 [Theory Drill - SQL Command Categories]:
/*
Task: Classify each of the following SQL statements into their correct category (DDL, DML, DQL, DCL, TCL):
1. CREATE TABLE StudentMaster (...)
2. INSERT INTO StudentMaster VALUES (...)
3. SELECT * FROM StudentMaster
4. ALTER TABLE StudentMaster ADD City VARCHAR(20)
5. DROP TABLE StudentMaster
*/

-- Write your answers in comments below:
-- 1. CREATE TABLE : DDL (Data Definition Language)
-- 2. INSERT INTO  : DML (Data Manipulation Language)
-- 3. SELECT       : DQL (Data Query Language)
-- 4. ALTER TABLE  : DDL (Data Definition Language)
-- 5. DROP TABLE   : DDL (Data Definition Language)


-- ============================================================
-- SECTION 2: DML & INSERTION PATTERNS
-- ============================================================

-- QUESTION 5 [Insertion Pattern - Column Sequence Independence]:
/*
Task: Write an INSERT statement inserting data into 'EmployeeBasic' specifying columns in reverse order: (Salary, EmpName, EmpID).
*/

-- Write your SQL Query below:
INSERT INTO EmployeeBasic (Salary, EmpName, EmpID) 
VALUES (40000, 'Karan', 105);


-- QUESTION 6 [Insertion Pattern - Selective Omitted Columns]:
/*
Task: Write an INSERT statement providing only Salary and EmpID for a new employee. Observe what value is assigned to EmpName.
*/

-- Write your SQL Query below:
INSERT INTO EmployeeBasic (Salary, EmpID) 
VALUES (45000, 106);
-- Observation: Since EmpName is omitted, it will be assigned a NULL value automatically.


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Healthcare Patient Records Schema]:
/*
Scenario: A hospital requires a database table to log patient admissions.
Task:
1. Create table 'PatientRecords' with: PatientID (INT), FullName (VARCHAR 50), Age (INT), MedicalHistory (VARCHAR 200), ContactNumber (VARCHAR 15), AdmissionDate (VARCHAR 20).
2. Insert 3 complete patient records.
3. Retrieve all patient records.
*/

-- Write your SQL Queries below:
CREATE TABLE PatientRecords (
    PatientID INT,
    FullName VARCHAR(50),
    Age INT,
    MedicalHistory VARCHAR(200),
    ContactNumber VARCHAR(15),
    AdmissionDate VARCHAR(20)
);

INSERT INTO PatientRecords (PatientID, FullName, Age, MedicalHistory, ContactNumber, AdmissionDate)
VALUES (1, 'Ramesh Kumar', 45, 'Hypertension', '9876543210', '2026-08-01'),
       (2, 'Sunita Sharma', 32, 'None', '9876543211', '2026-08-01'),
       (3, 'Vikram Singh', 58, 'Diabetes Type 2', '9876543212', '2026-08-01');

SELECT * FROM PatientRecords;


-- QUESTION 8 [Scenario - E-Commerce Product Catalog]:
/*
Scenario: An online store needs to store product inventory details.
Task:
1. Create table 'ProductCatalog' with: ProductID (INT), ProductName (VARCHAR 30), Category (VARCHAR 20), Price (INT), StockQuantity (INT).
2. Insert 2 records with full column values.
3. Insert 1 record omitting 'StockQuantity'.
*/

-- Write your SQL Queries below:
CREATE TABLE ProductCatalog (
    ProductID INT,
    ProductName VARCHAR(30),
    Category VARCHAR(20),
    Price INT,
    StockQuantity INT
);

INSERT INTO ProductCatalog (ProductID, ProductName, Category, Price, StockQuantity)
VALUES (1001, 'Wireless Mouse', 'Electronics', 1500, 50),
       (1002, 'Mechanical Keyboard', 'Electronics', 4500, 30);

INSERT INTO ProductCatalog (ProductID, ProductName, Category, Price)
VALUES (1003, 'Mousepad', 'Accessories', 500);


-- QUESTION 9 [Scenario - String Truncation Error Demonstration]:
/*
Scenario: Testing system limits on VARCHAR columns.
Task:
1. Create table 'CourseEnrollment' with: EnrollmentID (INT), StudentName (VARCHAR 15).
2. Write an INSERT statement attempting to insert 'Alexander Bartholomew' (21 chars) into StudentName and explain the resulting error message.
*/

-- Write your SQL Query and explanation below:
CREATE TABLE CourseEnrollment (
    EnrollmentID INT,
    StudentName VARCHAR(15)
);

-- INSERT INTO CourseEnrollment (EnrollmentID, StudentName) VALUES (1, 'Alexander Bartholomew');

-- Explanation: The above INSERT query will fail with a "String or binary data would be truncated" error.
-- This occurs because 'Alexander Bartholomew' is 21 characters long, which exceeds the maximum length of 15 defined for the StudentName column.


-- QUESTION 10 [Scenario - NULL vs Empty String Handling]:
/*
Scenario: Differentiating between unknown data (NULL) and zero-length strings ('').
Task:
1. Create table 'UserData' (UserID INT, UserName VARCHAR 20, UserBio VARCHAR 50).
2. Insert a row where UserBio is an empty string ('').
3. Insert a row where UserBio is NULL.
4. Write a SELECT statement querying both rows.
*/

-- Write your SQL Queries below:
CREATE TABLE UserData (
    UserID INT,
    UserName VARCHAR(20),
    UserBio VARCHAR(50)
);

INSERT INTO UserData (UserID, UserName, UserBio) VALUES (1, 'UserOne', '');

INSERT INTO UserData (UserID, UserName, UserBio) VALUES (2, 'UserTwo', NULL);

SELECT * FROM UserData;


-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Single Quotes Memory Rule]:
/*
Task:
1. What error occurs if single quotes are omitted around string values in an INSERT query?
2. Write a valid query demonstrating proper single-quote usage for inserting string values.
*/

-- Write your SQL Query & answer below:
-- Answer 1: If single quotes are omitted, SQL treats the string as a column name or keyword, resulting in an "Invalid column name" or syntax error.

-- Answer 2: 
INSERT INTO UserData (UserID, UserName, UserBio) VALUES (3, 'ValidString', 'Proper Quotes');


-- QUESTION 12 [Logic Builder - Case Insensitivity in SQL Server]:
/*
Task: Test whether 'select * from userdata' produces the exact same result as 'SELECT * FROM UserData' in SQL Server and explain why.
*/

-- Write your answer in comments below:
-- Explanation: Yes, both queries produce the exact same result. SQL Server keywords (like SELECT, FROM) are completely case-insensitive.
-- Furthermore, object names (like tables and columns) are also case-insensitive by default in SQL Server, meaning 'userdata' and 'UserData' are treated identically.


-- QUESTION 13 [Debugging - Fix Broken DDL & DML Queries]:
/*
Task: Identify and fix errors in the following 2 queries:
1. CREATE StudentInfo (RollNo INT, Name VARCHAR(20));
2. INSERT INTO StudentInfo (RollNo) VALUES ('101', 'Arpit');
*/

-- Write your corrected SQL Queries below:
-- Fix 1: Missing TABLE keyword in CREATE statement.
CREATE TABLE StudentInfo (
    RollNo INT,
    Name VARCHAR(20)
);

-- Fix 2: The number of columns specified (1) does not match the number of values provided (2).
INSERT INTO StudentInfo (RollNo, Name) VALUES (101, 'Arpit');


-- QUESTION 14 [Debugging - Column Count Mismatch Error]:
/*
Task: Identify why the query 'INSERT INTO EmployeeBasic VALUES (105, 'Anjali');' fails and write the corrected version.
*/

-- Write your explanation & corrected query below:
-- Explanation: The EmployeeBasic table has 3 columns (EmpID, EmpName, Salary), but the query provides only 2 values without specifying a column list. 
-- When using INSERT INTO without a column list, values must be provided for ALL columns in the exact order they were defined.

-- Corrected Query (specifying columns):
INSERT INTO EmployeeBasic (EmpID, EmpName) VALUES (105, 'Anjali');

-- Alternatively, passing NULL for the missing column:
-- INSERT INTO EmployeeBasic VALUES (105, 'Anjali', NULL);


/* ============================================================
                   END OF DAY 1 PRACTICE
   ============================================================ */
