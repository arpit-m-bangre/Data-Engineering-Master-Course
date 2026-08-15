/*============================================================
        DAY 10 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: DEFAULT, IDENTITY, FOREIGN KEYS
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day10', 'U') IS NOT NULL DROP TABLE practice_day10;
CREATE TABLE practice_day10 (
    id INT,
    city VARCHAR(10) DEFAULT 'Pune'
);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Create table 'Offices' with:
--     OfficeID (INT PRIMARY KEY),
--     City (VARCHAR(20) DEFAULT 'Pune').
-- Write your SQL Query below:




-- Q2. Create table 'AssetLog' with:
--     LogID (INT IDENTITY),
--     AssetName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q3. Create table 'Employees_FK' with:
--     EmpID (INT PRIMARY KEY),
--     OfficeID (INT FOREIGN KEY REFERENCES Offices(OfficeID)).
-- Write your SQL Query below:




-- Q4. Insert a row into 'Offices'
--     using DEFAULT keyword for City.
-- Write your SQL Query below:




-- Q5. Select all columns from
--     the 'AssetLog' table.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Insert into 'AssetLog' omitting
--     LogID. What ID is generated?
-- Write your SQL Query below:




-- Q7. Create table 'Q5_Check' with:
--     ID (INT),
--     Marks (INT DEFAULT 5 CHECK (Marks > 4)).
-- Write your SQL Query below:




-- Q8. Try inserting OfficeID = 99
--     into 'Employees_FK'. Show error.
-- Write your SQL Query and explanation:




-- Q9. Explain identity seed gap
--     after an insert statement fails.
-- Write your explanation below:




-- Q10. Insert 2 rows into 'Offices'
--      specifying custom cities.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Create 'Departments_PK'
--      (DeptID INT PRIMARY KEY) and
--      'Staff_FK' (StaffID INT PK,
--      DeptID INT REFERENCES parent).
-- Write your SQL Query below:




-- Q12. Insert 3 departments and
--      3 staff records.
-- Write your SQL Queries below:




-- Q13. Try dropping parent table
--      Departments_PK. Show error.
-- Write your SQL Query and explanation:




-- Q14. Delete a department having
--      active staff references.
-- Write your SQL Query and explanation:




-- Q15. Create parent table 'Store'
--      with StoreID INT PRIMARY KEY.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the IDENTITY config:
--      CREATE TABLE Test (ID INT IDENTITY, Name VARCHAR(10));
--      Make identity start at 1000.
-- Write your corrected Query below:




-- Q17. Explain why FOREIGN KEY
--      enforces referential integrity.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      CREATE TABLE child (
--      id INT REFERENCES parent(id) FK
--      );
-- Write your corrected Query below:




-- Q19. Why does SQL Server prevent
--      truncating a referenced parent?
-- Write your explanation below:




-- Q20. Correct the query:
--      INSERT INTO AssetLog VALUES
--      (1, 'Laptop'); -- ID has IDENTITY
-- Write your corrected Query below:\n