# 🏆 DAY 01 TO DAY 22: MASTER SQL REVISION & SYNTAX PLAYBOOK
### *The Ultimate Easy-Language Guide to Master Enterprise Relational Architecture & Query Engines*
**Architect & Co-Pilot:** Pippo 🐥 | **Candidate:** Captain Arpit Manoj Bangre (Cap) | **Target CTC:** ₹25.0 to ₹48.0+ LPA  
**Coverage:** 100% of Topics from `01_COMBINED_INDEX_ALL_TOPICS.SQL` (Days 1 to 22)

---

## 🧭 HOW TO USE THIS MASTER PLAYBOOK

This playbook is designed for **fast, crystal-clear revision** and **unbreakable muscle memory**.
Every section follows a simple 4-part structure:
1. **The Core Idea in Simple English** (with a real-life analogy).
2. **The Exact Syntax Formula** (UPPERCASE keywords, ready to run).
3. **Double the Code Examples** (real-world business cases).
4. **The Top Interview Trap & Fix** (what recruiters use to trick you).

---

# 📦 PART 1: DATABASE ENGINE, DDL/DML & STORAGE MECHANICS (DAYS 1 TO 5)

---

## 🔹 1.1 SQL Taxonomy: DDL vs DML vs DQL vs TCL vs DCL (Day 1)

### 💡 The Core Idea:
* **DDL (Data Definition Language):** Building and changing the *physical house* (Tables, Columns). Keywords: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
* **DML (Data Manipulation Language):** Adding, modifying, or removing the *furniture inside the house* (Rows/Data). Keywords: `INSERT`, `UPDATE`, `DELETE`.
* **DQL (Data Query Language):** *Looking* at the furniture without touching it. Keyword: `SELECT`.
* **TCL (Transaction Control Language):** The *Save & Undo buttons*. Keywords: `COMMIT`, `ROLLBACK`, `SAVEPOINT`.

### ⚙️ Syntax & Practical Code:
```sql
-- DDL: Create a clean table
CREATE TABLE Employees
(
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    Salary      DECIMAL(10,2) NOT NULL,
    JoiningDate DATE NOT NULL
);

-- DML: Insert rows (3 main patterns)
INSERT INTO Employees (EmpID, EmpName, Salary, JoiningDate) VALUES 
(101, 'Aarav Sharma', 85000.00, '2024-03-15'),
(102, 'Priya Patel',  92000.00, '2024-06-01');

-- DQL: Query rows
SELECT EmpID, EmpName, Salary FROM Employees;
```

---

## 🔹 1.2 Filtering Operators & Pattern Matching (Days 2 & 3)

### 💡 The Core Idea:
Filtering is like using a sieve. You only let the rows pass that satisfy your exact conditions.
* **`LIKE` Wildcards:**
  - `%` = Zero or more characters (e.g. `'A%'` = starts with A).
  - `_` = Exactly one character (e.g. `'A____n'` = starts with A, ends with n, exactly 6 letters total).
  - `[A-Z]` = Any single character in the range.
  - `[^A-Z]` = Any single character NOT in the range.

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Range filtering with BETWEEN
SELECT * FROM Employees 
WHERE Salary BETWEEN 50000 AND 100000;

-- 2. Multi-value list check with IN
SELECT * FROM Employees 
WHERE EmpID IN (101, 103, 105);

-- 3. Pattern Matching: Names starting with A and ending with n (6 letters)
SELECT * FROM Employees 
WHERE EmpName LIKE 'A____n';

-- 4. Vowel search: Names starting with a vowel
SELECT * FROM Employees 
WHERE EmpName LIKE '[AEIOU]%';
```

---

## 🔹 1.3 Arithmetic & DML Updates (Day 4)

### 💡 The Core Idea:
Computed columns allow you to perform on-the-fly math without modifying physical disk storage. `UPDATE` changes specific column values for rows matching `WHERE`.

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Computed arithmetic column (Monthly to Annual CTC)
SELECT 
    EmpName, 
    Salary AS MonthlySalary,
    Salary * 12 AS AnnualCTC,
    (Salary * 1.15) AS SalaryWith15PctHike
FROM Employees;

-- 2. Conditional UPDATE (Always use WHERE!)
UPDATE Employees
SET Salary = Salary * 1.10
WHERE EmpID = 101;
```

---

## 🔹 1.4 The Big Deletion Battle: DELETE vs TRUNCATE vs DROP (Day 5)

### 💡 The Vivid Analogy (Cleaning a Classroom):
* **`DELETE` (DML):** A teacher walking to specific student desks with an eraser, wiping names one by one. Slow, logs every erased row, and can be filtered with `WHERE`.
* **`TRUNCATE` (DDL):** Taking a bulldozer to sweep all desks clean in one second. Super fast, resets the identity counter, deallocates storage pages, but keeps the empty classroom structure.
* **`DROP` (DDL):** Demolishing the entire building to the ground. The desks, students, and classroom structure are completely gone.

### 📊 Structural Comparison Table:

| Feature | `DELETE` | `TRUNCATE` | `DROP` |
| :--- | :--- | :--- | :--- |
| **Command Type** | DML | DDL | DDL |
| **`WHERE` Clause Support** | ✅ Yes | ❌ No (all rows wiped) | ❌ No |
| **Speed / Overhead** | Slow (row-by-row logging) | Ultra Fast (page deallocation) | Instant |
| **IDENTITY Reset** | ❌ No (preserves seed) | ✅ Yes (resets seed to start) | ❌ Table destroyed |
| **Rollback in Transaction**| ✅ Yes | ✅ Yes (in SQL Server!) | ✅ Yes (in SQL Server!) |

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Delete specific row
DELETE FROM Employees WHERE EmpID = 102;

-- 2. Truncate table (clean slate, fast)
TRUNCATE TABLE Employees;

-- 3. Drop table completely
DROP TABLE Employees;

-- 4. ALTER operations: Add and change column
ALTER TABLE Employees ADD Department VARCHAR(50) NULL;
ALTER TABLE Employees ALTER COLUMN Department VARCHAR(100) NOT NULL;
```

---

# 📊 PART 2: AGGREGATIONS, 6-STAGE EXECUTION ORDER & SCOPING (DAYS 6 TO 8)

---

## 🔹 2.1 Aggregate Functions & NULL Behavior (Day 6)

### 💡 The Core Idea:
Aggregates collapse multiple rows into **one summary calculation** per group.
* `COUNT(*)` counts physical rows (including rows with NULLs).
* `COUNT(Column)` counts only non-NULL values.
* `AVG(Column)` calculates `SUM(Column) / COUNT(Column)` — it silently ignores NULLs and does NOT divide by total rows!

### ⚙️ Practical Code Blueprints:
```sql
SELECT 
    COUNT(*) AS TotalPhysicalRows,
    COUNT(Salary) AS EmployeesWithSalary,
    COUNT(DISTINCT Department) AS UniqueDepartmentsCount,
    SUM(Salary) AS TotalMonthlyPayroll,
    AVG(Salary) AS AverageSalary,
    MIN(Salary) AS MinimumSalary,
    MAX(Salary) AS MaximumSalary
FROM Employees;
```

---

## 🔹 2.2 The 6-Stage SQL Execution Flow (Day 7) 🔴 CRITICAL

### 💡 The Core Idea:
SQL is **not executed in the order it is written**. SQL executes from the data source outwards!

```text
========================================================================================
                          THE 6-STAGE PHYSICAL EXECUTION PIPELINE
========================================================================================
  STAGE 1: FROM + JOIN    ──► Identify source tables & join conditions
  STAGE 2: WHERE          ──► Filter raw rows BEFORE grouping
  STAGE 3: GROUP BY       ──► Collapse rows into summary groups
  STAGE 4: HAVING         ──► Filter aggregated groups AFTER grouping
  STAGE 5: SELECT         ──► Project columns, compute aliases, evaluate Window & CASE
  STAGE 6: ORDER BY       ──► Sort final output (can see SELECT aliases)
========================================================================================
```

### 🥊 The Scoping Trap:
* **Why can't you use a SELECT alias in `WHERE`?** Because `WHERE` (Stage 2) runs **before** `SELECT` (Stage 5)! The computer doesn't know what your alias means yet.
* **`WHERE` vs `HAVING` Rule:**
  - `WHERE` filters **individual rows** before grouping.
  - `HAVING` filters **aggregated group values** after `GROUP BY`.

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    Department,
    AVG(Salary) AS AvgDeptSalary,
    COUNT(*) AS TotalStaff
FROM Employees
WHERE JoiningDate >= '2024-01-01'  -- Stage 2: Filter individual rows first
GROUP BY Department                -- Stage 3: Group remaining rows
HAVING AVG(Salary) >= 75000        -- Stage 4: Filter aggregated groups
ORDER BY AvgDeptSalary DESC;       -- Stage 6: Sort by alias (visible here!)
```

---

# 🛡️ PART 3: CONSTRAINTS, REFERENTIAL INTEGRITY & RETROFITTING (DAYS 9 TO 12)

---

## 🔹 3.1 The 6 Core Constraints & Real-Life Models (Days 9 & 10)

### 💡 Real-Life Models:
1. **`PRIMARY KEY` (Uniqueness + NOT NULL):** Like an Aadhaar / Social Security Number. Exactly 1 per table.
2. **`UNIQUE` (Uniqueness + allows 1 NULL):** Like an email address. No two people have the same, but one person might not have an email.
3. **`NOT NULL` (Mandatory Value):** Like your legal First Name. You cannot leave it blank.
4. **`CHECK` (Custom Rule Bouncer):** Like an age bouncer at a club (`CHECK (Age >= 18)`).
5. **`DEFAULT` (Automatic Fallback):** Like default currency set to `'INR'` if the user doesn't pick one.
6. **`FOREIGN KEY` (Referential Integrity):** Like a student ID card that MUST match an existing student in the principal's master register.

---

## 🔹 3.2 Parent vs Child Table Destruction Rules (Day 11)

### 💡 The Protection Law:
* **Child Table** has the `FOREIGN KEY` pointing to the **Parent Table**.
* You **cannot delete/truncate a Parent record** if a Child record is actively referencing it!
* `TRUNCATE TABLE Parent` will **always fail** if referenced by a Foreign Key, even if the child table is completely empty! (Because `TRUNCATE` checks metadata constraints, not row counts).

### ⚙️ Practical Code Blueprint:
```sql
-- Parent Table: Departments
CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- Child Table: Staff with FK
CREATE TABLE Staff
(
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(50) NOT NULL,
    DeptID INT NOT NULL FOREIGN KEY REFERENCES Departments(DeptID),
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Status VARCHAR(20) DEFAULT 'Active'
);
```

---

## 🔹 3.3 Retrofitting Constraints on Live Dirty Tables (Day 12)

### 💡 The Real-World Engineering Challenge:
In production, tables already have millions of dirty records. You cannot simply add a constraint if invalid data exists!

```text
The 3-Step Retrofitting Pipeline:
[Step 1: Audit Data] ──► [Step 2: Cleanse / Fix Violations] ──► [Step 3: Add Constraint via ALTER]
```

### ⚙️ Practical Code Blueprint:
```sql
-- Step 1: Find duplicates before adding UNIQUE constraint
SELECT Email, COUNT(*) FROM Users GROUP BY Email HAVING COUNT(*) > 1;

-- Step 2: Add UNIQUE constraint on clean data
ALTER TABLE Users 
ADD CONSTRAINT UQ_Users_Email UNIQUE (Email);

-- Step 3: Add CHECK constraint
ALTER TABLE Users 
ADD CONSTRAINT CHK_Users_Age CHECK (Age >= 18);

-- Step 4: Add FOREIGN KEY constraint
ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_Dept FOREIGN KEY (DeptID) REFERENCES Departments(DeptID);
```

---

# 🔗 PART 4: SET OPERATORS & TEMPORAL FUNCTIONS (DAYS 13 & 14)

---

## 🔹 4.1 Set Operators: Vertical Stacking (Day 13)

### 💡 The Core Idea:
Set operators combine result sets **vertically** (stacking rows). Both queries must have the **exact same number of columns and compatible data types**.
* **`UNION`:** Combines rows and runs an in-memory sort to remove duplicates (Slower).
* **`UNION ALL`:** Combines rows and directly appends them with zero sorting (Ultra Fast!).
* **`INTERSECT`:** Returns only rows present in **both** result sets.
* **`EXCEPT`:** Subtracts query 2 from query 1 (Mathematical $A - B$).

### ⚙️ Practical Code Blueprint:
```sql
-- 1. UNION vs UNION ALL
SELECT City FROM Customers
UNION ALL -- Fast append, keeps duplicates
SELECT City FROM Suppliers;

-- 2. INTERSECT: Cities where we have both Customers AND Suppliers
SELECT City FROM Customers
INTERSECT
SELECT City FROM Suppliers;

-- 3. EXCEPT: Cities where we have Customers but NO Suppliers
SELECT City FROM Customers
EXCEPT
SELECT City FROM Suppliers;
```

---

## 🔹 4.2 Temporal Date Math & Interval Functions (Day 14)

### 💡 The Core Idea:
Dates in enterprise databases power churn analysis, SLAs, and YoY deltas.
* `GETDATE()`: Current system timestamp.
* `DATEDIFF(interval, start_date, end_date)`: Calculates boundaries crossed ($end - start$).
* `DATEADD(interval, number, date)`: Adds/subtracts time horizons.
* `DATEPART(interval, date)`: Extracts parts (Year `yy`, Quarter `qq`, Month `mm`, Day `dd`).
* `EOMONTH(date)`: Returns the exact last date of that month (auto-handles leap years!).

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    OrderDate,
    GETDATE() AS CurrentTimestamp,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysElapsed,
    DATEADD(DAY, 30, OrderDate) AS ReturnWindowExpiryDate,
    DATEPART(QUARTER, OrderDate) AS OrderQuarter,
    EOMONTH(OrderDate) AS MonthEndDate
FROM Orders;
```

---

# 🤝 PART 5: RELATIONAL JOINS, CARTESIAN MATH & HIERARCHIES (DAYS 15 TO 18)

---

## 🔹 5.1 The Fundamental Join Equation & 3VL (Day 15)

### 💡 The Mathematical Law:
`JOIN = (Cartesian Cross Product N x M) + (Filter Predicate)`

* **Three-Valued Logic (3VL):** In SQL, boolean expressions evaluate to `TRUE`, `FALSE`, or `UNKNOWN`.
* **NULL Behavior in Joins:** `NULL = NULL` evaluates to `UNKNOWN`. Therefore, rows with `NULL` keys will **never match** in an `INNER JOIN`!
* **Cartesian Matching Matrix:** If Table 1 has 4 rows with key `1`, and Table 2 has 3 rows with key `1`, the `INNER JOIN` produces **4 x 3 = 12 rows**!

---

## 🔹 5.2 ANSI Relational Joins & Anti-Join Pattern (Day 16)

### 💡 The Visual Taxonomy:
* **`INNER JOIN`:** Returns only rows with matching keys in **both** tables.
* **`LEFT JOIN`:** Returns **all** rows from Left table + matching rows from Right (NULLs if no match).
* **`RIGHT JOIN`:** Returns **all** rows from Right table + matching rows from Left.
* **`FULL OUTER JOIN`:** Returns **all** rows from both tables.
* **The Anti-Join Pattern:** Finding unmatched rows (e.g. Customers who placed zero orders):
  `LEFT JOIN Orders ON c.ID = o.ID WHERE o.ID IS NULL`.

### ⚙️ Practical Code Blueprint:
```sql
-- 1. Standard ANSI Multi-Table Join with Aggregations
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrdersCount,
    ISNULL(SUM(o.OrderAmount), 0) AS TotalSpend
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

-- 2. Anti-Join: Customers with ZERO orders
SELECT c.CustomerID, c.CustomerName
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
```

---

## 🔹 5.3 Multi-Table Joins & CROSS JOIN Matrices (Day 17)

### 💡 The Core Idea:
Chaining 3+ tables connects master entities to transactions and reference catalogs.
`CROSS JOIN` produces an unconditional Cartesian multiplication ($N \times M$). Used for tournament pairing, date-spine matrices, and test data generation.

### ⚙️ Practical Code Blueprint:
```sql
-- 1. 3-Table Relational Chain
SELECT 
    c.CustomerName,
    o.OrderID,
    p.ProductName,
    p.Price
FROM Customers AS c
INNER JOIN Orders AS o 
    ON c.CustomerID = o.CustomerID
INNER JOIN Products AS p 
    ON o.ProductID = p.ProductID;

-- 2. CROSS JOIN for Tournament Match Pairings
SELECT 
    T1.TeamName AS HomeTeam,
    T2.TeamName AS AwayTeam
FROM Teams AS T1
CROSS JOIN Teams AS T2
WHERE T1.TeamName <> T2.TeamName;
```

---

## 🔹 5.4 Self Joins, Hierarchies & Fraud Detection (Day 18)

### 💡 The Core Idea:
A **Self Join** joins a table to itself using memory aliasing (`T1` vs `T2`).
* **Hierarchy:** Employee $\rightarrow$ Manager (`e.ManagerID = m.EmpID`).
* **Symmetric Deduplication:** Match pairs without duplicates using `s1.ID < s2.ID`.
* **Geo-Temporal Fraud Detection:** Finding transactions on the same card in different cities within a 5-minute window!

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Employee-Manager Hierarchy (Use LEFT JOIN so CEO with NULL manager is not lost!)
SELECT 
    e.EmpName AS Employee,
    ISNULL(m.EmpName, 'Top Boss (CEO)') AS Manager
FROM Employees AS e
LEFT JOIN Employees AS m
    ON e.ManagerID = m.EmpID;

-- 2. High-Velocity Fraud Detection (Diff cities in <= 5 mins)
SELECT 
    t1.CardNo,
    t1.City AS City1,
    t2.City AS City2,
    t1.TxTime AS Time1,
    t2.TxTime AS Time2,
    DATEDIFF(MINUTE, t1.TxTime, t2.TxTime) AS MinutesDiff
FROM Transactions AS t1
INNER JOIN Transactions AS t2
    ON t1.CardNo = t2.CardNo
   AND t1.TxID < t2.TxID           -- Prevents matching self & mirror duplicates
   AND t1.City <> t2.City          -- Different physical cities
   AND DATEDIFF(MINUTE, t1.TxTime, t2.TxTime) BETWEEN 0 AND 5;
```

---

# 🚀 PART 6: ANALYTICAL SQL, WINDOW FUNCTIONS, CTES & CASE (DAYS 19 TO 22)

---

## 🔹 6.1 Window Ranking Functions: ROW_NUMBER vs DENSE_RANK vs RANK (Day 19)

### 💡 The Core Idea:
Window functions calculate rankings and aggregations across a group of rows **without collapsing rows** into a single output like `GROUP BY` does!
* `ROW_NUMBER()`: Strict sequential numbering: `1, 2, 3, 4`. (No ties, no gaps).
* `DENSE_RANK()`: Tied values share the same rank, next rank is consecutive: `1, 2, 2, 3`. (Zero gaps!).
* `RANK()`: Tied values share the same rank, next rank skips by number of ties: `1, 2, 2, 4`. (Leaves gaps!).

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    DeptID,
    EmpName,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS RowNum,
    DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS DenseRnk,
    RANK()       OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS PositionalRnk
FROM Employees;
```

---

## 🔹 6.2 Common Table Expressions (CTEs) & In-Place Deduplication (Day 20) 🔴

### 💡 The Core Idea:
A CTE (`WITH CTE AS (...)`) is a temporary in-memory named result set.
* **Why use CTEs?** To bypass the Msg 4108 error (window functions cannot appear in `WHERE`).
* **The In-Place Deduplication Engine:** Delete duplicate records directly from the underlying base table in 1 step!

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Finding 2nd Highest Salary per Department using CTE
WITH RankedSalaries AS
(
    SELECT 
        DeptID,
        EmpName,
        Salary,
        DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS rnk
    FROM Employees
)
SELECT DeptID, EmpName, Salary
FROM RankedSalaries
WHERE rnk = 2;

-- 2. In-Place Table Deduplication Engine (Tier-1 Interview Favorite)
WITH DuplicateRemoverCTE AS
(
    SELECT 
        CustomerID,
        Email,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY CreatedDate ASC) AS RowOccurrence
    FROM Customers
)
DELETE FROM DuplicateRemoverCTE 
WHERE RowOccurrence > 1; -- Safely deletes duplicate rows from base table!
```

---

## 🔹 6.3 Value Window Functions: LEAD & LAG (Day 21)

### 💡 The Core Idea:
`LEAD()` looks **forward** to upcoming rows. `LAG()` looks **backward** to previous rows.
Essential for Month-over-Month (MoM) revenue growth, inventory consumption variance, and customer gap analysis.

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    AccountID,
    TxDate,
    Balance,
    LAG(Balance, 1, 0) OVER (PARTITION BY AccountID ORDER BY TxDate) AS PrevBalance,
    Balance - LAG(Balance, 1, Balance) OVER (PARTITION BY AccountID ORDER BY TxDate) AS BalanceChangeDelta,
    LEAD(Balance, 1, NULL) OVER (PARTITION BY AccountID ORDER BY TxDate) AS NextBalance
FROM AccountTransactions;
```

---

## 🔹 6.4 Conditional Logic & CASE Expressions (Day 22)

### 💡 The Core Idea:
`CASE` is an inline scalar `IF...THEN...ELSE` expression.
* **Searched CASE:** Supports multi-column complex conditions.
* **Conditional Aggregations:** Calculates multiple metrics in 1 scan.
* **Dynamic Pinned Sorting:** Pinned custom sort priorities in `ORDER BY`.

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Multi-Tier Status Classification
SELECT 
    EmpName,
    Salary,
    CASE 
        WHEN Salary >= 100000 THEN 'Executive Tier'
        WHEN Salary >= 60000  THEN 'Senior Tier'
        ELSE 'Associate Tier'
    END AS SalaryGrade
FROM Employees;

-- 2. Dynamic Pinned Sorting (Pune First, rest alphabetically)
SELECT CustomerID, CustomerName, City
FROM Customers
ORDER BY 
    CASE 
        WHEN City = 'Pune' THEN 1
        ELSE 2
    END ASC,
    City ASC;

-- 3. Conditional Aggregation (Pivot Metric Simulation)
SELECT 
    DeptID,
    COUNT(*) AS TotalStaff,
    SUM(CASE WHEN Salary >= 100000 THEN 1 ELSE 0 END) AS HighEarnersCount,
    SUM(CASE WHEN JoiningDate >= '2025-01-01' THEN Salary ELSE 0 END) AS NewHiresPayroll
FROM Employees
GROUP BY DeptID;
```

---

# 🥊 PART 7: TOP 10 TIER-1 WHITEBOARD INTERVIEW TRAPS & GOLDEN FIXES

```text
========================================================================================================================
#   INTERVIEW TRAP QUESTION                      WHY IT FAILS                                 PIPPO'S GOLDEN FIX
========================================================================================================================
1   WHERE DENSE_RANK() = 2                       Msg 4108: Window funcs not allowed in WHERE  Wrap in CTE & filter outer query
2   DELETE Duplicates without temp tables        Blind DELETE drops all copies                Use CTE + ROW_NUMBER() WHERE rn > 1
3   WHERE id NOT IN (SELECT id with NULLs)       3VL makes NOT IN UNKNOWN (returns 0 rows!)   Use LEFT JOIN ... WHERE right IS NULL
4   Can TRUNCATE be rolled back?                 Myth: People think DDL never rolls back      Yes! Inside explicit TRAN it rolls back!
5   AVG(Salary) on table with NULLs              Silently excludes NULLs from denominator     Use ISNULL(Salary, 0) if 0 is intended
6   Self Join Employee/Manager missing CEO       INNER JOIN drops CEO (manager_id is NULL)    Use LEFT JOIN on manager table
7   Alternating M/F/M/F sequence                 Standard ORDER BY groups all M then all F    Use ROW_NUMBER() PARTITION BY Gender
8   Transactions in diff cities in <= 5 mins     Cannot detect across separate rows           Self Join on CardNo + DATEDIFF <= 5
9   UNION vs UNION ALL speed                     UNION runs expensive in-memory DISTINCT sort Always use UNION ALL unless deduplicating
10  Table A (4 '1's) INNER JOIN Table B (3 '1's) Candidates guess 4 or 3                      4 x 3 = 12 rows (Cartesian product!)
========================================================================================================================
```

---

# ✍️ PART 8: 10 SYNTAX MASTERY SPEED DRILLS (SELF-TEST)

Try writing these queries from memory in SSMS:

1. **Drill 1 (Deduplication):** Write a query to delete all duplicate records from `CustomerOrders` keeping only the earliest `OrderDate` per customer.
2. **Drill 2 (Top N per Dept):** Write a query to return the top 2 highest-paid employees in each department using `DENSE_RANK()`.
3. **Drill 3 (Anti-Join):** Return all products from `Products` that have never appeared in `SalesTransactions`.
4. **Drill 4 (MoM Growth):** Calculate the Month-over-Month percentage revenue growth using `LAG()`.
5. **Drill 5 (Safe NULL Math):** Safely compute `M1 + M2` without returning NULL if one value is missing.
6. **Drill 6 (Pinned Sort):** Retrieve all employees sorting `'Data Engineering'` department at the very top, and all other departments alphabetically.
7. **Drill 7 (Fraud Anomaly):** Detect multiple login attempts on the same `UserID` from different IP addresses within 10 minutes.
8. **Drill 8 (Conditional Count):** Count total active vs inactive users in a single query using `COUNT(CASE ...)`.
9. **Drill 9 (Quarter Aggregation):** Group orders by `DATEPART(QUARTER, OrderDate)` and return quarterly total revenue.
10. **Drill 10 (Execution Order Proof):** Explain why `SELECT Department, SUM(Salary) AS Total WHERE Total > 10000` throws a syntax error.

---

*Authored with pure passion by Pippo 🐥 for Captain Arpit Manoj Bangre.*  
*Target: Tier-1 Placement (25.0 to 48.0+ LPA) | Status: Mastered & Production-Ready! 🔥*
