/* ============================================================
               DAY 9 PRACTICE QUESTIONS (10 AUGUST 2026)
               TOPICS: SQL CONSTRAINTS (PRIMARY KEY, UNIQUE,
                       NOT NULL, CHECK), DATA VALIDATION & ERRORS
               REVISION: DAYS 1 - 8 (GROUP BY, HAVING, UPDATE, ALTER)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Constraint Declarations]:
/*
Task: Write simple DDL statements for table creation with constraints:
1. Create table 'Test_PK' with: ID INT PRIMARY KEY, Name VARCHAR(20).
2. Create table 'Test_UQ' with: Email VARCHAR(30) UNIQUE.
3. Create table 'Test_NN' with: Phone VARCHAR(15) NOT NULL.
4. Create table 'Test_CK' with: Age INT CHECK (Age >= 18).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - Adding Constraints via ALTER TABLE]:
/*
Task:
1. Create table 'Student_Validation' (StudentID INT, StudentName VARCHAR 30, Score INT).
2. Add CHECK constraint requiring StudentName NOT LIKE 'A%' via ALTER TABLE.
3. Add CHECK constraint requiring Score BETWEEN 0 AND 100 via ALTER TABLE.
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - CHECK Constraints with IN & NOT BETWEEN]:
/*
Task: Write DDL for table 'EmployeeRules' with:
- EmpID INT PRIMARY KEY
- Department VARCHAR(20) CHECK (Department IN ('IT', 'HR', 'Finance'))
- BaseSalary INT CHECK (BaseSalary > 0 AND BaseSalary NOT BETWEEN 1000000 AND 2000000)
*/

-- Write your SQL Query below:




-- QUESTION 4 [Syntax Drill - Combining UNIQUE & NOT NULL]:
/*
Task: Write DDL for table 'UserCredentials' with UserID INT PRIMARY KEY, Email VARCHAR(40) NOT NULL UNIQUE.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 2: DAYS 1 - 8 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-8 Revision - Aggregations & ALTER TABLE]:
/*
Task:
1. Create table 'BankCustomers' with: CustomerID (INT), CustomerName (VARCHAR 30), City (VARCHAR 20), AccountBalance (INT), AccountType (VARCHAR 15).
2. Insert 6 records.
3. Alter 'BankCustomers' to ADD column 'CreditScore' (INT) and update CreditScore = 750 WHERE AccountBalance > 50000.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-8 Revision - GROUP BY & HAVING Filter]:
/*
Task: Write a GROUP BY query on 'BankCustomers' returning City-wise average AccountBalance for cities where average balance > 30000.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - PRIMARY KEY Uniqueness & NULL Prevention]:
/*
Scenario: User Registration system requiring unique identification.
Task:
1. Create table 'Users_PK' (UserID INT PRIMARY KEY, Username VARCHAR 20).
2. Insert valid row (1, 'Alice').
3. Write an INSERT attempting duplicate UserID (1, 'Bob') and explain the resulting error message.
4. Write an INSERT attempting (NULL, 'Charlie') and explain why PK prohibits NULLs.
*/

-- Write your SQL Queries & explanations below:




-- QUESTION 8 [Scenario - UNIQUE Constraint & Single NULL Exception]:
/*
Scenario: Email uniqueness validation.
Task:
1. Create table 'Users_UQ' (UserID INT, UserEmail VARCHAR 40 UNIQUE).
2. Insert (101, 'user1@test.com') and (102, NULL).
3. Attempt a second NULL email (103, NULL) and explain why UNIQUE permits NULL only once in SQL Server.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 9 [Scenario - NOT NULL & Composite Candidate Keys]:
/*
Scenario: Building secondary unique keys without using PRIMARY KEY.
Task:
1. Create table 'Users_Composite' (UserID INT PRIMARY KEY, FirstName VARCHAR 20 NOT NULL, GovernmentID INT NOT NULL UNIQUE).
2. Demonstrate valid insertion.
3. Test duplicate GovernmentID and record error.
4. Test NULL FirstName and record error.
5. Explain how NOT NULL + UNIQUE acts as an alternative primary key.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 10 [Scenario - CHECK Constraints & Business Rule Rules]:
/*
Scenario: HR onboarding system enforcing policy checks.
Task:
1. Create table 'Staff_Check' (EmpID INT PRIMARY KEY, Age INT CHECK (Age >= 18), Department VARCHAR 20 CHECK (Department IN ('HR', 'IT', 'Finance')), Salary INT CHECK (Salary > 0 AND Salary NOT BETWEEN 1000000 AND 2000000)).
2. Insert valid row.
3. Test Age = 16 and record CHECK error message.
4. Test Department = 'Marketing' and record error message.
*/

-- Write your SQL Queries & explanations below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Constraint Enforcement Rules]:
/*
Task:
1. How many Primary Keys can exist in a single SQL table?
2. What happens if you attempt to alter an existing column to PRIMARY KEY when that column contains duplicate or NULL values?
*/

-- Write your answers in comments below:




-- QUESTION 12 [Logic Builder - SSMS Object Explorer Inspection]:
/*
Task: Where in SSMS Object Explorer can you visually inspect a table's Primary Key, Unique, and Check constraints?
*/

-- Write your answer in comments below:




-- QUESTION 13 [Debugging - Constraint Violation Tracing]:
/*
Task: Identify which constraint is violated by each of the following queries:
1. INSERT INTO Users_PK VALUES (1, 'Duplicate'); -> Violation of ?
2. INSERT INTO Users_UQ VALUES (104, NULL); (after 102 NULL already inserted) -> Violation of ?
3. INSERT INTO Staff_Check VALUES (2, 15, 'IT', 50000); -> Violation of ?
*/

-- Write your answers in comments below:




-- QUESTION 14 [Debugging - Multi-Constraint Conflict Errors]:
/*
Task: Identify why 'CREATE TABLE Test (ID INT PRIMARY KEY, ID2 INT PRIMARY KEY);' fails in SQL Server.
*/

-- Write your explanation in comments below:




/* ============================================================
                   END OF DAY 9 PRACTICE
   ============================================================ */
