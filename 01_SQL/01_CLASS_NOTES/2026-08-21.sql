/* ==============================================================================
   SQL CLASS NOTES - 2026-08-21 (DAY 18)
   TOPIC: SELF JOIN MECHANICS, HIERARCHIES & FRAUD ANOMALY DETECTION
   DATABASE: SQL SERVER / T-SQL (SSMS)
============================================================================== */

-- ------------------------------------------------------------------------------
-- 1. SELF JOIN FUNDAMENTALS & ARCHITECTURE
-- ------------------------------------------------------------------------------
/* Theory: A SELF JOIN is a regular join where a table is joined with itself.
   It requires mandatory table aliasing (e.g. A1, A2) to create two virtual instances in memory. */

-- Base Table Schema: Employee with Manager ID (MID)
CREATE TABLE EmployeeSelf (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    MID INT
);

INSERT INTO EmployeeSelf (EmpID, EmpName, MID) VALUES
(1, 'Amit', 3),
(2, 'Rahul', 1),
(3, 'Priya', NULL), -- Top-level manager (MID is NULL)
(4, 'Sneha', 3),
(5, 'Rohan', 2),
(6, 'Neha', 4),
(7, 'Vikas', 5);

SELECT * FROM EmployeeSelf;

-- ------------------------------------------------------------------------------
-- 2. HIERARCHICAL MAPPING: EMPLOYEE TO MANAGER
-- ------------------------------------------------------------------------------
/* Error: ❌ Incorrect join logic (a1.EmpID = a2.MID treats employees as managers incorrectly). */
-- SELECT * FROM EmployeeSelf A1, EmployeeSelf A2 WHERE A1.EmpID = A2.MID;

-- Legacy Comma / Equi Join Syntax
SELECT 
    A1.EmpName AS EmployeeName,
    A2.EmpName AS ManagerName
FROM EmployeeSelf A1, EmployeeSelf A2
WHERE A1.MID = A2.EmpID;

-- ANSI SQL-92 Standard INNER JOIN (Recommended Enterprise Pattern)
SELECT 
    E.EmpName AS EmployeeName,
    M.EmpName AS ManagerName
FROM EmployeeSelf E
INNER JOIN EmployeeSelf M 
    ON E.MID = M.EmpID;

-- ------------------------------------------------------------------------------
-- 3. HIERARCHICAL SALARY COMPARISON (TIER-1 INTERVIEW PATTERN)
-- ------------------------------------------------------------------------------
ALTER TABLE EmployeeSelf ADD Salary INT;

UPDATE EmployeeSelf SET Salary = 20000 WHERE EmpID = 1;
UPDATE EmployeeSelf SET Salary = 30000 WHERE EmpID = 2;
UPDATE EmployeeSelf SET Salary = 50000 WHERE EmpID = 3;
UPDATE EmployeeSelf SET Salary = 25000 WHERE EmpID = 4;
UPDATE EmployeeSelf SET Salary = 35000 WHERE EmpID = 5;
UPDATE EmployeeSelf SET Salary = 22000 WHERE EmpID = 6;
UPDATE EmployeeSelf SET Salary = 40000 WHERE EmpID = 7;

-- Display Employees whose salary is higher than their direct manager
SELECT 
    E.EmpName AS EmployeeName,
    E.Salary AS EmployeeSalary,
    M.EmpName AS ManagerName,
    M.Salary AS ManagerSalary
FROM EmployeeSelf E
INNER JOIN EmployeeSelf M 
    ON E.MID = M.EmpID
WHERE E.Salary > M.Salary;

-- ------------------------------------------------------------------------------
-- 4. SAME-TABLE PAIRING & DUPLICATE PREVENTION
-- ------------------------------------------------------------------------------
/* Theory: When finding pairs within the same table, use A1.ID < A2.ID instead of A1.ID <> A2.ID
   to avoid mirror duplicates (A-B and B-A) and self-matches (A-A). */

CREATE TABLE Student (
    StudID INT PRIMARY KEY,
    City VARCHAR(50)
);

INSERT INTO Student (StudID, City) VALUES
(101, 'Pune'),
(102, 'Mumbai'),
(103, 'Pune'),
(104, 'Delhi'),
(105, 'Mumbai'),
(106, 'Pune'),
(107, 'Chennai');

-- Find unique pairs of students living in the same city
SELECT 
    S1.StudID AS Student1_ID,
    S2.StudID AS Student2_ID,
    S1.City
FROM Student S1
INNER JOIN Student S2 
    ON S1.City = S2.City 
   AND S1.StudID < S2.StudID;

-- ------------------------------------------------------------------------------
-- 5. REAL-WORLD DATA ENGINEERING: BANKING FRAUD ANOMALY ENGINE
-- ------------------------------------------------------------------------------
/* Theory: Detect same customer executing transactions across different cities within 5 minutes.
   This requires Self Join on CustID + City inequality + Time difference window. */

CREATE TABLE BankTransactions (
    TxnID INT PRIMARY KEY,
    CustID INT,
    City VARCHAR(50),
    TxnDate DATETIME
);

INSERT INTO BankTransactions (TxnID, CustID, City, TxnDate) VALUES
(1001, 501, 'Pune', '2026-08-21 10:00:00'),
(1002, 501, 'Mumbai', '2026-08-21 10:03:00'), -- Fraud: 3 min difference in different city
(1003, 502, 'Delhi', '2026-08-21 11:00:00'),
(1004, 501, 'Pune', '2026-08-21 14:00:00');

-- Fraud Anomaly Detection Query
SELECT 
    T1.CustID,
    T1.TxnID AS Txn1_ID,
    T1.City AS City1,
    T1.TxnDate AS Txn1_Time,
    T2.TxnID AS Txn2_ID,
    T2.City AS City2,
    T2.TxnDate AS Txn2_Time,
    DATEDIFF(MINUTE, T1.TxnDate, T2.TxnDate) AS MinutesApart
FROM BankTransactions T1
INNER JOIN BankTransactions T2 
    ON T1.CustID = T2.CustID
   AND T1.City <> T2.City
   AND T1.TxnID < T2.TxnID
   AND DATEDIFF(MINUTE, T1.TxnDate, T2.TxnDate) BETWEEN 0 AND 5;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-21_CLASS_TASK.SQL */
