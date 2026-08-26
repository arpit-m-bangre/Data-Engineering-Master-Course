/* ====================================================================
   SQL CLASS NOTES — 2026-08-25 (DAY 21)
   TOPIC: Value Window Functions (LEAD, LAG) & Aggregate Window Functions
          (Stock Delta Pipelines, Period-over-Period Reporting)
   FACULTY: Online Batch 15 | Enterprise SQL Engineering
   ==================================================================== */

-- ⚙️ SECTION 1: ENVIRONMENT SETUP & SEED DATA
IF OBJECT_ID('Stock', 'U') IS NOT NULL DROP TABLE Stock;
IF OBJECT_ID('StudentInfo', 'U') IS NOT NULL DROP TABLE StudentInfo;

CREATE TABLE StudentInfo
(
    StudentID   INT IDENTITY(1,1) PRIMARY KEY,
    RollNo      INT NOT NULL,
    StudentName VARCHAR(50) NOT NULL,
    Subject     VARCHAR(50) NOT NULL,
    Marks       INT NOT NULL
);

INSERT INTO StudentInfo (RollNo, StudentName, Subject, Marks) VALUES
(1, 'Aarav Kumar', 'Maths', 92),
(2, 'Diya Sharma', 'Science', 85),
(3, 'Rohan Joshi', 'Maths', 78),
(4, 'Isha Kapoor', 'English', 95),
(5, 'Ananya Sen', 'Science', 88),
(6, 'Kabir Mehta', 'Maths', 65),
(7, 'Pooja Nair', 'Science', 90);

CREATE TABLE Stock
(
    PName VARCHAR(20) NOT NULL,
    DateT DATE NOT NULL,
    Stock INT NOT NULL
);

INSERT INTO Stock (PName, DateT, Stock) VALUES
('Laptop', '2026-10-10', 70),
('Laptop', '2026-10-11', 100),
('Laptop', '2026-10-12', 140),
('Mobile', '2026-10-10', 300),
('Mobile', '2026-10-11', 40),
('Mobile', '2026-10-12', 100);

-- --------------------------------------------------------------------
-- 🧠 SECTION 2: FUNDAMENTALS OF VALUE WINDOW FUNCTIONS (LEAD & LAG)
-- --------------------------------------------------------------------

-- Theory: LEAD() looks ahead to next rows; LAG() looks back to previous rows.
-- Syntax: LEAD(column, [offset], [default]) OVER (PARTITION BY ... ORDER BY ...)

-- Query 1: Basic LEAD without partition
SELECT Marks,
       LEAD(Marks) OVER (ORDER BY StudentID) AS NextMarks
FROM StudentInfo;

-- Query 2: Basic LAG without partition
SELECT Marks,
       LAG(Marks) OVER (ORDER BY StudentID) AS PrevMarks
FROM StudentInfo;

-- Query 3: LAG partitioned by Subject
SELECT Subject,
       Marks,
       LAG(Marks) OVER (PARTITION BY Subject ORDER BY StudentID) AS PrevSubjectMarks
FROM StudentInfo;

-- --------------------------------------------------------------------
-- 📊 SECTION 3: REAL-WORLD STOCK INVENTORY DELTA PIPELINE
-- --------------------------------------------------------------------

-- Query 4: Raw stock sequence with lookahead
SELECT PName,
       DateT,
       Stock,
       LEAD(Stock) OVER (PARTITION BY PName ORDER BY DateT) AS NextDayStock
FROM Stock;

-- Query 5: CTE calculating inventory shift / daily restock delta
WITH StockCTE AS
(
    SELECT PName,
           DateT,
           Stock,
           LEAD(Stock) OVER (PARTITION BY PName ORDER BY DateT) AS NextStock
    FROM Stock
)
SELECT PName,
       DateT,
       Stock,
       NextStock,
       (Stock - NextStock) AS StockChange
FROM StockCTE;

-- --------------------------------------------------------------------
-- 📈 SECTION 4: AGGREGATE WINDOW FUNCTIONS (RUNNING TOTAL & MIN)
-- --------------------------------------------------------------------

-- Query 6: Running Minimum per Subject
SELECT StudentID,
       StudentName,
       Subject,
       Marks,
       MIN(Marks) OVER (PARTITION BY Subject ORDER BY Marks) AS RunningMinMarks
FROM StudentInfo;

-- Query 7: Running Cumulative Sum per Subject
SELECT StudentID,
       StudentName,
       Subject,
       Marks,
       SUM(Marks) OVER (PARTITION BY Subject ORDER BY Marks) AS RunningTotalMarks
FROM StudentInfo;

-- --------------------------------------------------------------------
-- 🎯 SECTION 5: SALARY BOUNDARY SCAN (PREVIOUS < CURRENT < NEXT)
-- --------------------------------------------------------------------

/*
Pattern: Find employees whose salary is strictly greater than previous employee
and strictly less than next employee in sequence.
*/
WITH SalarySequence AS
(
    SELECT StudentID,
           StudentName,
           Marks,
           LAG(Marks, 1, 0) OVER (ORDER BY StudentID) AS PrevMarks,
           LEAD(Marks, 1, 999999) OVER (ORDER BY StudentID) AS NextMarks
    FROM StudentInfo
)
SELECT StudentID,
       StudentName,
       Marks,
       PrevMarks,
       NextMarks
FROM SalarySequence
WHERE Marks > PrevMarks AND Marks < NextMarks;

/* Faculty Homework & 5 Enterprise Scenarios: see 04_CLASS_TASKS/2026-08-25_CLASS_TASK.SQL */