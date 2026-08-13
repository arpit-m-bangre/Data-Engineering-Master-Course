/* ============================================================
               CLASS TASK - 13 AUGUST 2026 (2026-08-13_CLASS_TASK.SQL)
               TOPICS: RETROFITTING CONSTRAINTS & COLUMN PROPERTIES VIA ALTER TABLE
               FACULTY IN-CLASS EXERCISES & HANDS-ON SOLUTIONS
               STATUS: COMPLETED BY STUDENT
   ============================================================ */

-- ============================================================
-- ENVIRONMENT SETUP FOR CLASS TASK
-- ============================================================

-- Create base parent table for Foreign Key reference
IF OBJECT_ID('DepartmentMaster', 'U') IS NOT NULL DROP TABLE DepartmentMaster;
CREATE TABLE DepartmentMaster (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);

INSERT INTO DepartmentMaster (dept_id, dept_name) VALUES 
(10, 'Data Engineering'),
(20, 'Cloud Infrastructure'),
(30, 'Analytics');

-- Create base unconstrained employee table
IF OBJECT_ID('emp', 'U') IS NOT NULL DROP TABLE emp;
CREATE TABLE emp (
    empid INT,
    emp_name VARCHAR(30),
    age INT,
    salary INT,
    city VARCHAR(30),
    dept_id INT
);

-- Insert sample unconstrained / uncleaned data
INSERT INTO emp (empid, emp_name, age, salary, city, dept_id) VALUES 
(101, 'Arpit', 28, 35000, 'Nagpur', 10),
(102, 'Rohan', 30, 38000, NULL, 20),
(103, 'Priya', 25, 39000, 'Mumbai', 10),
(NULL, 'Invalid_Record', 40, NULL, 'Delhi', 99);


-- ============================================================
-- FACULTY IN-CLASS TASK EXERCISES & EXECUTABLE SOLUTIONS
-- ============================================================

-- ------------------------------------------------------------
-- TASK 1 [Data Sanitization & Retrofitting UNIQUE Constraint]:
-- ------------------------------------------------------------
/*
Task: 
1. Clean table 'emp' by deleting rows where empid IS NULL.
2. Retrofit UNIQUE constraint 'u01' on column 'empid'.
*/

-- Step 1: Data Pre-Cleaning
DELETE FROM emp 
WHERE empid IS NULL;

-- Step 2: Retrofit UNIQUE constraint
ALTER TABLE emp 
ADD CONSTRAINT u01 UNIQUE (empid);


-- ------------------------------------------------------------
-- TASK 2 [Data Sanitization & Retrofitting CHECK Constraint]:
-- ------------------------------------------------------------
/*
Task: 
1. Clean table 'emp' by deleting rows where salary IS NULL or salary > 40,000.
2. Retrofit CHECK constraint 'ch01' enforcing salary <= 40000.
*/

-- Step 1: Data Pre-Cleaning
DELETE FROM emp 
WHERE salary IS NULL OR salary > 40000;

-- Step 2: Retrofit CHECK constraint
ALTER TABLE emp 
ADD CONSTRAINT ch01 CHECK (salary <= 40000);


-- ------------------------------------------------------------
-- TASK 3 [Faculty In-Class Practice - Retrofitting DEFAULT Constraint]:
-- ------------------------------------------------------------
/*
Task: Add default constraint 'df01' setting default city as 'pune' for column 'city' in table 'emp'.
*/

ALTER TABLE emp 
ADD CONSTRAINT df01 DEFAULT 'pune' FOR city;


-- ------------------------------------------------------------
-- TASK 4 [Faculty In-Class Practice - Retrofitting FOREIGN KEY Constraint]:
-- ------------------------------------------------------------
/*
Task: Add foreign key constraint 'fk01' on column 'dept_id' in table 'emp' referencing 'DepartmentMaster(dept_id)'.
*/

ALTER TABLE emp 
ADD CONSTRAINT fk01 FOREIGN KEY (dept_id) REFERENCES DepartmentMaster(dept_id);


-- ------------------------------------------------------------
-- TASK 5 [Retrofitting PRIMARY KEY via Column Property NOT NULL]:
-- ------------------------------------------------------------
/*
Task:
1. Create table 'q10' with nullable column (id INT, name VARCHAR(10)).
2. Convert column property 'id' to NOT NULL using ALTER COLUMN.
3. Retrofit PRIMARY KEY constraint 'pk011' on column 'id'.
*/

-- Step 1: Create table
IF OBJECT_ID('q10', 'U') IS NOT NULL DROP TABLE q10;
CREATE TABLE q10 (
    id INT,
    name VARCHAR(10)
);

-- Step 2: Convert column property to NOT NULL
ALTER TABLE q10 
ALTER COLUMN id INT NOT NULL;

-- Step 3: Retrofit PRIMARY KEY constraint
ALTER TABLE q10 
ADD CONSTRAINT pk011 PRIMARY KEY (id);


-- ------------------------------------------------------------
-- TASK 6 [Adding AUTO INCREMENT IDENTITY Column to Populated Table]:
-- ------------------------------------------------------------
/*
Task: Add new auto-incrementing identity column 'adharno' to table 'emp'.
*/

ALTER TABLE emp 
ADD adharno INT IDENTITY(1, 1);


-- ============================================================
-- VERIFICATION & METADATA INSPECTION
-- ============================================================

-- Inspect clean table structure and data
SELECT * FROM emp;

-- Inspect applied table constraints
SELECT 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE, 
    TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE TABLE_NAME IN ('emp', 'q10');

/* ============================================================
                   END OF CLASS TASK (13 AUG 2026)
   ============================================================ */
