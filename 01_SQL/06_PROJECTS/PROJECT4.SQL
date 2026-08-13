/* ============================================================
               DATA ENGINEERING PROJECT 4 (PROJECT4.SQL)
               TITLE: HR ENTERPRISE PAYROLL & DATA VALIDATION ENGINE
               TOPICS COVERED: DAYS 1 - 10
               (SQL Constraints PRIMARY KEY, UNIQUE, NOT NULL, CHECK, DEFAULT,
                AUTO INCREMENT IDENTITY, 10 Insertion Patterns, Constraint Errors)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
A Global Technology Firm is re-architecting its HR Enterprise Systems.
The Data Engineering team must build a constraint-validated database schema
that guarantees zero duplicate records, enforces strict age/salary business
rules, automatically assigns default locations, auto-generates employee IDs,
and tests system error responses under invalid data insertions.
=============================================================== */

-- ============================================================
-- 2. CONSTRAINT-VALIDATED SCHEMA CREATION
-- ============================================================

-- Task 1: Create 'Departments' table
CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(30) NOT NULL UNIQUE
);

-- Task 2: Create 'EmployeesMaster' table with full constraint stack
CREATE TABLE EmployeesMaster
(
    EmpID         INT IDENTITY(10001, 1) PRIMARY KEY, -- Auto Increment starting 10001
    EmpName       VARCHAR(40) NOT NULL,
    NationalID    INT NOT NULL UNIQUE,                 -- Composite Candidate Key
    Age           INT CHECK (Age BETWEEN 18 AND 65),   -- Custom Age Validation
    Department    VARCHAR(30) DEFAULT 'General IT' CHECK (Department IN ('General IT', 'Software', 'HR', 'Finance', 'Data Engineering')),
    BaseSalary    INT DEFAULT 45000 CHECK (BaseSalary > 0 AND BaseSalary NOT BETWEEN 1000000 AND 2000000),
    WorkLocation  VARCHAR(20) DEFAULT 'Pune'
);


-- ============================================================
-- 3. DEMONSTRATING DATA INSERTION PATTERNS
-- ============================================================

-- Task 3: Ingestion Pattern Demonstrations
-- Pattern 1: Insert into explicit column list (Recommended production style)
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary, WorkLocation)
VALUES ('Arpit Bangre', 998801, 28, 'Data Engineering', 85000, 'Nagpur');

-- Pattern 2: Multi-row insertion with default fallbacks (Omitting Department & WorkLocation)
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, BaseSalary)
VALUES 
    ('Rahul Patil', 998802, 32, 60000),
    ('Sneha Joshi', 998803, 26, 70000);

-- Pattern 3: Explicit DEFAULT keyword in VALUES list
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department, BaseSalary, WorkLocation)
VALUES ('Priya Sharma', 998804, 29, DEFAULT, DEFAULT, DEFAULT);


-- ============================================================
-- 4. CONSTRAINT VALIDATION & ERROR TESTING
-- ============================================================

-- Task 4 [PRIMARY KEY & IDENTITY Validation]:
-- Verify auto-generated IDENTITY values.
SELECT EmpID, EmpName, Department, BaseSalary, WorkLocation FROM EmployeesMaster;

-- Task 5 [CHECK Constraint Violation Test 1 - Age Rule]:
-- Write an INSERT attempting to insert Age = 16 (Below 18 limit) and observe the CHECK constraint error.
-- Write your SQL Query below (keep commented after testing):
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age) VALUES ('Test Underage', 998899, 16);
-- Error: The INSERT statement conflicted with the CHECK constraint "CK__EmployeesM__Age__...".
*/


-- Task 6 [CHECK Constraint Violation Test 2 - Invalid Department]:
-- Write an INSERT attempting to insert Department = 'Marketing' (Not in allowed list) and observe error.
-- Write your SQL Query below (keep commented after testing):
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age, Department) VALUES ('Test Dept', 998898, 30, 'Marketing');
-- Error: The INSERT statement conflicted with the CHECK constraint "CK__EmployeesM__Depar...".
*/


-- Task 7 [UNIQUE Constraint Violation Test]:
-- Write an INSERT attempting duplicate NationalID = 998801 and observe UNIQUE error.
-- Write your SQL Query below (keep commented after testing):
/*
INSERT INTO EmployeesMaster (EmpName, NationalID, Age) VALUES ('Duplicate ID', 998801, 35);
-- Error: Violation of UNIQUE KEY constraint. Cannot insert duplicate key value (998801).
*/


-- Task 8 [Executive Payroll Reporting]:
-- Retrieve Department-wise average BaseSalary and total employee count for departments having AVG(BaseSalary) >= 50000.
-- Write your SQL Query below:




/* ============================================================
                    END OF PROJECT 4
   ============================================================ */
