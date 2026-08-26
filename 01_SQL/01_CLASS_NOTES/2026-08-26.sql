/* === SQL CLASS NOTES - 2026-08-26 (DAY 22) | CONDITIONAL LOGIC (CASE EXPRESSIONS) & DYNAMIC EVALUATION === */

-- 1. SETUP DEMO SCHEMA & TABLES
IF OBJECT_ID('Student', 'U') IS NOT NULL DROP TABLE Student;
CREATE TABLE Student
(
    StudentID   INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    City        VARCHAR(50) NOT NULL,
    Salary      DECIMAL(10,2) NULL
);

INSERT INTO Student (StudentID, StudentName, City, Salary) VALUES
(1, 'Aarav Sharma',   'Pune',      35000.00),
(2, 'Priya Patel',    'Mumbai',    28000.00),
(3, 'Rohan Verma',    'Bengaluru', 42000.00),
(4, 'Sneha Rao',      'Pune',      25000.00),
(5, 'Vikram Malhotra','Delhi',     50000.00);

-- 2. BASIC SEARCHED CASE EXPRESSION (CONDITIONAL LABELS)
/* Theory: CASE evaluates boolean conditions sequentially from top to bottom; returns the first TRUE match. */
SELECT 
    StudentID,
    StudentName,
    Salary,
    CASE 
        WHEN Salary > 30000 THEN 'High Salary'
        ELSE 'Low Salary'
    END AS SalaryTier
FROM Student;

-- 3. SIMPLE CASE FOR VALUE TRANSFORMATION
SELECT 
    StudentID,
    StudentName,
    City,
    CASE 
        WHEN City = 'Pune' THEN 'Best City'
        ELSE 'Good City'
    END AS CityStatus
FROM Student;

-- 4. CASE WITH ARITHMETIC & CONDITIONAL AGGREGATION
IF OBJECT_ID('Marks', 'U') IS NOT NULL DROP TABLE Marks;
CREATE TABLE Marks
(
    M1 INT NULL,
    M2 INT NULL
);

INSERT INTO Marks (M1, M2) VALUES
(20, 30), (30, 40), (50, 30), (20, 10), (10, 10), (20, 25),
(NULL, 20), (NULL, 25), (NULL, NULL), (30, NULL);

/* Theory: Using CTE with CASE expression to categorize marks sum, then grouping by calculated status. */
WITH MarksCategorizedCTE AS
(
    SELECT 
        M1,
        M2,
        CASE 
            WHEN (M1 + M2) >= 70 THEN 'Best'
            WHEN (M1 + M2) BETWEEN 50 AND 70 THEN 'Average'
            ELSE 'Below Average'
        END AS Status
    FROM Marks
)
SELECT 
    Status,
    COUNT(*) AS StatusCount
FROM MarksCategorizedCTE
GROUP BY Status;

-- 5. NULL RESILIENT ARITHMETIC WITH CASE (SIMULATING COALESCE)
/* Theory: NULL + ANY_NUMBER yields NULL; CASE handles individual NULL operands explicitly. */
SELECT 
    M1,
    M2,
    CASE 
        WHEN M1 IS NULL AND M2 IS NULL THEN 0
        WHEN M1 IS NULL THEN M2 
        WHEN M2 IS NULL THEN M1 
        ELSE M1 + M2 
    END AS AdditionResult
FROM Marks;

-- 6. MULTI-CONDITION TEMPORAL STATUS EVALUATION
IF OBJECT_ID('CustomerOrders', 'U') IS NOT NULL DROP TABLE CustomerOrders;
CREATE TABLE CustomerOrders
(
    CustomerID   INT,
    CustomerName VARCHAR(50),
    ProductID    INT,
    OrderDate    DATE,
    DeliveryDate DATE NULL
);

INSERT INTO CustomerOrders (CustomerID, CustomerName, ProductID, OrderDate, DeliveryDate) VALUES
(1, 'Rajesh Kumar', 501, '2026-08-10', '2026-08-14'),
(2, 'Meera Iyer',   502, '2026-08-15', NULL),          -- > 7 days pending
(3, 'Sunil Chawla', 503, '2026-08-24', NULL);          -- < 7 days in progress

SELECT 
    CustomerName,
    OrderDate,
    DeliveryDate,
    CASE 
        WHEN DeliveryDate IS NOT NULL THEN 'Delivered'
        WHEN DeliveryDate IS NULL AND DATEDIFF(DAY, OrderDate, CAST('2026-08-26' AS DATE)) >= 7 THEN 'Pending'
        WHEN DeliveryDate IS NULL AND DATEDIFF(DAY, OrderDate, CAST('2026-08-26' AS DATE)) < 7 THEN 'In Progress'
        ELSE 'Unknown'
    END AS OrderStatus
FROM CustomerOrders;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-26_CLASS_TASK.SQL */
