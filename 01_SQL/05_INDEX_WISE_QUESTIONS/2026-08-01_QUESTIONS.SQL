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




-- QUESTION 2 [Syntax Drill - SELECT Projection Variants]:
/*
Task:
1. Write a query to select ALL columns from 'EmployeeBasic'.
2. Write a query to select ONLY 'EmpName' and 'Salary' from 'EmployeeBasic'.
3. Write a query selecting 'EmpName' as 'Employee_Name' using a column alias.
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - INSERT INTO Full vs Column List]:
/*
Task:
1. Write an INSERT query providing values for ALL columns matching column sequence: (101, 'Rahul', 25000).
2. Write an INSERT query specifying explicit column list for (EmpID, EmpName) with values: (102, 'Priya').
3. Write a multi-row INSERT query adding 2 employees in a single statement.
*/

-- Write your SQL Queries below:




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




-- ============================================================
-- SECTION 2: DML & INSERTION PATTERNS
-- ============================================================

-- QUESTION 5 [Insertion Pattern - Column Sequence Independence]:
/*
Task: Write an INSERT statement inserting data into 'EmployeeBasic' specifying columns in reverse order: (Salary, EmpName, EmpID).
*/

-- Write your SQL Query below:




-- QUESTION 6 [Insertion Pattern - Selective Omitted Columns]:
/*
Task: Write an INSERT statement providing only Salary and EmpID for a new employee. Observe what value is assigned to EmpName.
*/

-- Write your SQL Query below:




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




-- QUESTION 8 [Scenario - E-Commerce Product Catalog]:
/*
Scenario: An online store needs to store product inventory details.
Task:
1. Create table 'ProductCatalog' with: ProductID (INT), ProductName (VARCHAR 30), Category (VARCHAR 20), Price (INT), StockQuantity (INT).
2. Insert 2 records with full column values.
3. Insert 1 record omitting 'StockQuantity'.
*/

-- Write your SQL Queries below:




-- QUESTION 9 [Scenario - String Truncation Error Demonstration]:
/*
Scenario: Testing system limits on VARCHAR columns.
Task:
1. Create table 'CourseEnrollment' with: EnrollmentID (INT), StudentName (VARCHAR 15).
2. Write an INSERT statement attempting to insert 'Alexander Bartholomew' (21 chars) into StudentName and explain the resulting error message.
*/

-- Write your SQL Query and explanation below:




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




-- QUESTION 12 [Logic Builder - Case Insensitivity in SQL Server]:
/*
Task: Test whether 'select * from userdata' produces the exact same result as 'SELECT * FROM UserData' in SQL Server and explain why.
*/

-- Write your answer in comments below:




-- QUESTION 13 [Debugging - Fix Broken DDL & DML Queries]:
/*
Task: Identify and fix errors in the following 2 queries:
1. CREATE StudentInfo (RollNo INT, Name VARCHAR(20));
2. INSERT INTO StudentInfo (RollNo) VALUES ('101', 'Arpit');
*/

-- Write your corrected SQL Queries below:




-- QUESTION 14 [Debugging - Column Count Mismatch Error]:
/*
Task: Identify why the query 'INSERT INTO EmployeeBasic VALUES (105, 'Anjali');' fails and write the corrected version.
*/

-- Write your explanation & corrected query below:




/* ============================================================
                   END OF DAY 1 PRACTICE
   ============================================================ */
