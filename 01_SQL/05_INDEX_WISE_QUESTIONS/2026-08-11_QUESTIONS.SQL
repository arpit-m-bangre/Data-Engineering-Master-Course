/*============================================================
       DAY 10 PRACTICE QUESTIONS - 11 AUGUST 2026
       TOPICS: DEFAULT CONSTRAINT, INSERT TYPES, IDENTITY PROPERTY, FOREIGN KEYS
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Create a table 'Offices' with: OfficeID (INT PRIMARY KEY) and City (VARCHAR(20) DEFAULT 'Pune').
-- Write your SQL Query below:




-- Q2. Create a table 'AssetLog' with: LogID (INT IDENTITY) and AssetName (VARCHAR(20)).
-- Write your SQL Query below:




-- Q3. Create a child table 'Employees_FK' with: EmpID (INT PRIMARY KEY) and OfficeID (INT FOREIGN KEY REFERENCES Offices(OfficeID)).
-- Write your SQL Query below:




-- Q4. Insert a row into 'Offices' using the DEFAULT keyword to populate the City column.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Insert a row into 'AssetLog' specifying only the 'AssetName'. What ID is generated automatically?
-- Write your SQL Query below:




-- Q6. Create a table 'Q5_Check' with: ID (INT), Marks (INT DEFAULT 5 CHECK (Marks > 4)).
-- Write your SQL Query below:




-- Q7. Try inserting a row into 'Employees_FK' with an OfficeID that does not exist in the 'Offices' table.
-- Write your SQL Query and explanation below:




-- Q8. Explain what happens to the IDENTITY sequence seed if an INSERT statement fails due to a constraint violation.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR Parent-Child setup: Create 'Departments_PK' (DeptID INT PRIMARY KEY, DeptName VARCHAR(15)) and
--     'Staff_FK' (StaffID INT PRIMARY KEY, Name VARCHAR(30), DeptID INT FOREIGN KEY REFERENCES Departments_PK(DeptID)).
-- Write your SQL Query below:




-- Q10. Insert 3 departments and 3 employees referencing those departments.
-- Write your SQL Queries below:




-- Q11. Try running 'DROP TABLE Departments_PK' while the child table 'Staff_FK' exists. What error is produced?
-- Write your SQL Query and explanation below:




-- Q12. Delete a department from 'Departments_PK' that has active employees referencing it in 'Staff_FK'.
-- Write your SQL Query and explanation below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the error: The developer wants to reset the identity column to start from 100,
--      so they wrote:
--      CREATE TABLE Test (ID INT IDENTITY, Name VARCHAR(10));
--      INSERT INTO Test VALUES (100, 'Arpit');
--      How do you define a custom seed and increment in IDENTITY?
-- Write your corrected SQL Query below:




-- Q14. Explain why the FOREIGN KEY constraint enforces referential integrity, and compare it to the PRIMARY KEY.
-- Write your explanation below:\n