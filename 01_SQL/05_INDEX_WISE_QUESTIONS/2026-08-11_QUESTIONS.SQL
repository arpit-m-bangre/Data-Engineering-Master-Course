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

-- Q11. Department Registrations:
--      Q11.1. Create parent 'Departments_PK' with
--             DeptID (INT PRIMARY KEY).
--      Q11.2. Create child 'Staff_FK' referencing
--             parent DeptID.
-- Write your SQL Queries below:




-- Q12. Parent-Child Seed Insertion:
--      Q12.1. Insert 3 departments into parent table.
--      Q12.2. Insert 3 staff records referencing
--             valid department IDs.
-- Write your SQL Queries below:




-- Q13. Referential Integrity Block:
--      Q13.1. Try dropping Departments_PK.
--             Show error trace.
--      Q13.2. Try truncating Departments_PK.
-- Write your SQL Query and explanation:




-- Q14. Record Deletion Constraints:
--      Q14.1. Delete a department that has active
--             employees in the child table.
--      Q14.2. Delete child rows first and then
--             delete the department.
-- Write your SQL Queries below:




-- Q15. Multi-Table Setup Checks:
--      Q15.1. Create parent 'Store' with StoreID.
--      Q15.2. Create child 'Sales' referencing 'Store'.
-- Write your SQL Queries below:





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