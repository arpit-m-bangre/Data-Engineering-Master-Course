/* ====================================================================
   SQL CLASS NOTES — 2026-08-24 (DAY 20)
   TOPIC: Common Table Expressions (CTEs), CTE with Window Functions,
          Nth Max Rank Filtering & Deduplication Architecture (DELETE)
   FACULTY: Online Batch 15 | Enterprise SQL Engineering
   ==================================================================== */

-- ⚙️ SECTION 1: ENVIRONMENT SETUP & SEED DATA
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;
IF OBJECT_ID('Emp', 'U') IS NOT NULL DROP TABLE Emp;

CREATE TABLE Emp
(
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary     INT NOT NULL
);

INSERT INTO Emp (EmpID, EmpName, Department, Salary) VALUES
(101, 'Rahul Sharma', 'IT', 95000),
(102, 'Pooja Verma', 'HR', 65000),
(103, 'Amit Patel', 'IT', 120000),
(104, 'Sneha Rao', 'Finance', 85000),
(105, 'Vikas Gupta', 'IT', 110000),
(106, 'Neha Singh', 'HR', 72000);

CREATE TABLE StudentInfo
(
    StudentID   INT IDENTITY(1,1) PRIMARY KEY,
    RollNo      INT NOT NULL,
    StudentName VARCHAR(50) NOT NULL,
    Subject     VARCHAR(50) NOT NULL,
    Marks       INT NOT NULL,
    EmailID     VARCHAR(100) NOT NULL,
    City        VARCHAR(50) NOT NULL,
    MobileNo    VARCHAR(15) NOT NULL
);

-- Note: Seed data with intentional duplicate rows for deduplication labs
INSERT INTO StudentInfo (RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo) VALUES
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'),
(2, 'Diya Sharma', 'Science', 85, 'diya@test.com', 'Mumbai', '9876543211'),
(3, 'Rohan Joshi', 'Maths', 78, 'rohan@test.com', 'Pune', '9876543212'),
(4, 'Isha Kapoor', 'English', 95, 'isha@test.com', 'Delhi', '9876543213'),
(5, 'Ananya Sen', 'Science', 88, 'ananya@test.com', 'Kolkata', '9876543214'),
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'), -- Duplicate 1
(1, 'Aarav Kumar', 'Maths', 92, 'aarav@test.com', 'Pune', '9876543210'), -- Duplicate 2
(3, 'Rohan Joshi', 'Maths', 78, 'rohan@test.com', 'Pune', '9876543212'); -- Duplicate 3

-- --------------------------------------------------------------------
-- 🧠 SECTION 2: WHY CTE? OVERCOMING MSG 4108 WHERE CLAUSE RESTRICTIONS
-- --------------------------------------------------------------------

-- ❌ Error: Msg 4108 - Window functions cannot be placed directly in WHERE clause
/*
SELECT EmpID, EmpName, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Emp
WHERE ROW_NUMBER() OVER (ORDER BY Salary DESC) = 1;
*/

-- ✅ Solution: CTE (Common Table Expression) creates an in-memory named result set
WITH RankedEmpCTE AS
(
    SELECT EmpID, EmpName, Department, Salary,
           ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
    FROM Emp
)
SELECT EmpID, EmpName, Department, Salary, RowNum
FROM RankedEmpCTE
WHERE RowNum = 1; -- Returns top 1 highest earner

-- --------------------------------------------------------------------
-- 🎯 SECTION 3: NTH MAXIMUM VALUE FILTERING (DENSE_RANK VS RANK)
-- --------------------------------------------------------------------

-- Finding 3rd Highest Marks using DENSE_RANK()
WITH RankedMarksCTE AS
(
    SELECT RollNo, StudentName, Subject, Marks,
           DENSE_RANK() OVER (ORDER BY Marks DESC) AS DenseRankNum
    FROM StudentInfo
)
SELECT RollNo, StudentName, Subject, Marks, DenseRankNum
FROM RankedMarksCTE
WHERE DenseRankNum = 3;

-- Department-Wise 2nd Highest Salary using PARTITION BY
WITH DeptSalaryRankCTE AS
(
    SELECT EmpID, EmpName, Department, Salary,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Emp
)
SELECT EmpID, EmpName, Department, Salary, DeptRank
FROM DeptSalaryRankCTE
WHERE DeptRank = 2;

-- --------------------------------------------------------------------
-- 🔍 SECTION 4: DUPLICATE RECORD IDENTIFICATION (COLUMN VS ENTIRE ROW)
-- --------------------------------------------------------------------

-- Method 1: Column-level duplicate check via GROUP BY + HAVING
SELECT RollNo, COUNT(RollNo) AS OccurrenceCount
FROM StudentInfo
GROUP BY RollNo
HAVING COUNT(RollNo) > 1;

-- Method 2: Full-Row Duplicate Identification via CTE + ROW_NUMBER()
WITH DuplicateFinderCTE AS
(
    SELECT StudentID, RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo,
           ROW_NUMBER() OVER 
           (
               PARTITION BY RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo 
               ORDER BY StudentID
           ) AS RowOccurrence
    FROM StudentInfo
)
SELECT StudentID, RollNo, StudentName, Subject, Marks, RowOccurrence
FROM DuplicateFinderCTE
WHERE RowOccurrence > 1; -- Flags all redundant duplicate copies

-- --------------------------------------------------------------------
-- 🗑️ SECTION 5: ZERO-DATA-LOSS ROW DEDUPLICATION VIA CTE DELETE
-- --------------------------------------------------------------------

-- Deleting duplicates directly from base table through CTE alias
WITH DuplicateDeleterCTE AS
(
    SELECT StudentID, RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo,
           ROW_NUMBER() OVER 
           (
               PARTITION BY RollNo, StudentName, Subject, Marks, EmailID, City, MobileNo 
               ORDER BY StudentID
           ) AS RowOccurrence
    FROM StudentInfo
)
DELETE FROM DuplicateDeleterCTE
WHERE RowOccurrence > 1;

-- Verification: Confirm table contains strictly unique records
SELECT * FROM StudentInfo;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-24_CLASS_TASK.SQL */