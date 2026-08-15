/*============================================================
        DAY 10 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: DEFAULT, IDENTITY, FOREIGN KEYS
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Create table 'Offices' with:
--      OfficeID (INT PRIMARY KEY),
--      City (VARCHAR(20) DEFAULT 'Pune').
-- Write your SQL Query below:




-- Q1.2. Create table 'AssetLog' with:
--      LogID (INT IDENTITY),
--      AssetName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q1.3. Create table 'Employees_FK' with:
--      EmpID (INT PRIMARY KEY),
--      OfficeID (INT FOREIGN KEY REFERENCES Offices(OfficeID)).
-- Write your SQL Query below:




-- Q1.4. Insert a row into 'Offices'
--      using DEFAULT keyword for City.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Insert into 'AssetLog' omitting
--      LogID. What ID is generated?
-- Write your SQL Query below:




-- Q2.2. Create table 'Q5_Check' with:
--      ID (INT),
--      Marks (INT DEFAULT 5 CHECK (Marks > 4)).
-- Write your SQL Query below:




-- Q2.3. Try inserting OfficeID = 99
--      into 'Employees_FK'. Show error.
-- Write your SQL Query and explanation:




-- Q2.4. Insert 2 rows into 'Offices'
--      specifying custom cities.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Explain identity seed gap
--      after an insert statement fails.
-- Write your explanation below:




-- Q3.2. Find all offices where city
--      is NOT the default 'Pune'.
-- Write your SQL Query below:




-- Q3.3. Drop the DEFAULT constraint
--      on 'Offices' table.
-- Write your SQL Query below:




-- Q3.4. Show the column structure of
--      the 'Employees_FK' table.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. Create 'Departments_PK'
--      (DeptID INT PRIMARY KEY) and
--      'Staff_FK' (StaffID INT PK,
--      DeptID INT REFERENCES parent).
-- Write your SQL Query below:




-- Q4.2. Insert 3 departments and
--      3 staff records.
-- Write your SQL Queries below:




-- Q4.3. Try dropping parent table
--      Departments_PK. Show error.
-- Write your SQL Query and explanation:




-- Q4.4. Delete a department having
--      active staff references.
-- Write your SQL Query and explanation:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Create parent table 'Store'
--      with StoreID INT PRIMARY KEY.
-- Write your SQL Query below:




-- Q5.2. Create child table 'Sales'
--      referencing 'Store(StoreID)'.
-- Write your SQL Query below:




-- Q5.3. Insert matching rows in
--      Store and Sales tables.
-- Write your SQL Queries below:




-- Q5.4. Truncate child table 'Sales'.
--      Does it succeed?
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug the IDENTITY config:
--      CREATE TABLE Test (ID INT IDENTITY, Name VARCHAR(10));
--      Make identity start at 1000.
-- Write your corrected Query below:




-- Q6.2. Explain why FOREIGN KEY
--      enforces referential integrity.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      CREATE TABLE child (
--      id INT REFERENCES parent(id) FK
--      );
-- Write your corrected Query below:




-- Q6.4. Why does SQL Server prevent
--      truncating a referenced parent?
-- Write your explanation below:\n