/* ==============================================================================
   SQL CLASS NOTES - 2026-08-22 (DAY 19)
   TOPIC: WINDOW FUNCTIONS - RANKING FUNCTIONS (ROW_NUMBER, DENSE_RANK, RANK)
   DATABASE: SQL SERVER / T-SQL (SSMS)
============================================================================== */

-- ------------------------------------------------------------------------------
-- 1. WINDOW FUNCTIONS ARCHITECTURE & TAXONOMY
-- ------------------------------------------------------------------------------
/* Theory: Window functions perform calculations across a set of table rows 
   related to the current row without collapsing rows like GROUP BY does.
   3 Main Categories:
   1. Ranking Functions: ROW_NUMBER(), DENSE_RANK(), RANK(), NTILE()
   2. Value / Analytic Functions: LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE()
   3. Aggregate Window Functions: SUM() OVER(), AVG() OVER(), COUNT() OVER() */

-- Base Table Schema: Student Scores
CREATE TABLE StudentInfo (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(50),
    Subject VARCHAR(50),
    Marks INT,
    Department VARCHAR(50)
);

INSERT INTO StudentInfo (StudentName, Subject, Marks, Department) VALUES
('Aarav', 'SQL', 99, 'HR'),
('Aditi', 'SQL', 99, 'ENTC'),
('Rohan', 'SQL', 98, 'MECH'),
('Sneha', 'SQL', 98, 'MECH'),
('Pooja', 'SQL', 98, 'HR'),
('Vikas', 'SQL', 94, 'ENTC'),
('Priya', 'SQL', 90, 'MECH'),
('Karan', 'SQL', 90, 'HR'),
('Ananya', 'SQL', 85, 'ENTC'),
('Nikhil', 'SQL', 85, 'MECH'),
('Varun', 'SQL', 85, 'HR'),
('Meera', 'SQL', 80, 'ENTC'),
('Tanvi', 'SQL', 80, 'HR'),
('Deepak', 'SQL', 70, 'MECH'),
('Rahul', 'SQL', 70, 'ENTC'),
('Arjun', 'SQL', NULL, 'HR');

SELECT * FROM StudentInfo;

-- ------------------------------------------------------------------------------
-- 2. GLOBAL RANKING FUNCTIONS COMPARISON (OVER ORDER BY)
-- ------------------------------------------------------------------------------
/* Theory: 
   - ROW_NUMBER(): Sequential unique integer (1, 2, 3, 4...). No ties, no gaps.
   - DENSE_RANK(): Consecutive ranking with ties (1, 1, 2, 2, 3...). Ties share rank, NO gaps.
   - RANK(): Positional ranking with ties (1, 1, 3, 3, 5...). Ties share rank, LEAVES gaps. */

SELECT 
    StudentID,
    StudentName,
    Marks,
    ROW_NUMBER() OVER (ORDER BY Marks DESC) AS RowNum_Pos,
    DENSE_RANK() OVER (ORDER BY Marks DESC) AS DenseRank_Val,
    RANK() OVER (ORDER BY Marks DESC) AS Rank_Pos
FROM StudentInfo;

-- ------------------------------------------------------------------------------
-- 3. PARTITIONED RANKING (OVER PARTITION BY + ORDER BY)
-- ------------------------------------------------------------------------------
/* Theory: PARTITION BY divides the result set into partitions (groups) and 
   applies the ranking function independently inside each partition. */

-- Base Table Schema: Department Salary Master
CREATE TABLE DeptSalary (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Dept VARCHAR(20),
    Sal INT
);

INSERT INTO DeptSalary (Dept, Sal) VALUES
('HR', 20000), ('ENTC', 30000), ('MECH', 50000),
('HR', 40000), ('HR', 40000), ('MECH', 40000),
('MECH', 40000), ('ENTC', 35000), ('HR', 30000),
('ENTC', 25000), ('MECH', 30000), ('MECH', 25000),
('HR', 30000), ('HR', 20000), ('ENTC', 25000),
('ENTC', 20000), ('MECH', 20000);

-- Department-wise Salary Ranking
SELECT 
    Dept,
    Sal,
    ROW_NUMBER() OVER (PARTITION BY Dept ORDER BY Sal DESC) AS Dept_RowNum,
    DENSE_RANK() OVER (PARTITION BY Dept ORDER BY Sal DESC) AS Dept_DenseRank,
    RANK() OVER (PARTITION BY Dept ORDER BY Sal DESC) AS Dept_Rank
FROM DeptSalary;

-- ------------------------------------------------------------------------------
-- 4. COMBINING PARTITION BY AND MULTIPLE SUBJECTS
-- ------------------------------------------------------------------------------
SELECT 
    StudentID,
    StudentName,
    Subject,
    Department,
    Marks,
    ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Marks DESC) AS Dept_RowNum,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Marks DESC) AS Dept_DenseRank,
    RANK() OVER (PARTITION BY Department ORDER BY Marks DESC) AS Dept_Rank
FROM StudentInfo;

-- ------------------------------------------------------------------------------
-- 5. LOGICAL QUERY EXECUTION ORDER WITH WINDOW FUNCTIONS
-- ------------------------------------------------------------------------------
/* Theory: Execution Order:
   1. FROM & JOIN
   2. WHERE
   3. GROUP BY
   4. HAVING
   5. WINDOW FUNCTIONS (OVER)
   6. SELECT
   7. DISTINCT
   8. ORDER BY */

/* Error: ❌ Window functions CANNOT be used in WHERE or HAVING clauses directly.
   Msg 4108: Windowed functions can only appear in the SELECT or ORDER BY clauses. */
-- SELECT * FROM StudentInfo WHERE ROW_NUMBER() OVER (ORDER BY Marks DESC) <= 3; -- FAILS

-- Solution: Use Derived Table / Subquery / CTE for filtering by rank
SELECT *
FROM (
    SELECT 
        StudentID,
        StudentName,
        Department,
        Marks,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Marks DESC) AS Rnk
    FROM StudentInfo
) AS RankedStudents
WHERE Rnk = 1;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-22_CLASS_TASK.SQL */
