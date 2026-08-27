# 🏆 DAY 01 TO DAY 22: MASTER SQL REVISION & SYNTAX PLAYBOOK (SUPER EDITION)
### *The Exhaustive, Simple-Language Architectural Reference Guide for Enterprise Relational Databases*
**Architect & AI Co-Pilot:** Pippo 🐥 | **Candidate:** Captain Arpit Manoj Bangre (Cap) | **Target Fleet:** Tier-1 Tier (25.0 to 48.0+ LPA)  
**Coverage:** 100% of Topics from `01_COMBINED_INDEX_ALL_TOPICS.SQL` (Days 1 to 22)

---

## 🧭 EXECUTIVE HOW-TO-USE & LEARNING BLUEPRINT

This playbook is engineered for **lightning-fast conceptual recall**, **interview whiteboard readiness**, and **rock-solid query formulation**.

Every topic follows the **Pippo 5-Pillar Architecture**:
1. 💡 **The Core Idea & Simple Real-Life Analogy** (plain conversational English).
2. 📖 **Vocabulary & Technical Definitions** (demystifying difficult terms).
3. ⚙️ **The Exact Syntax Formula** (clean, uppercase SQL keywords).
4. 💻 **Double the Practical Code Examples** (real enterprise business cases).
5. 🥊 **Tier-1 Interview Traps & The Senior Architect Fix** (what interviewers use to filter candidates).

---

## 📖 0. MASTER TECHNICAL VOCABULARY & DICTIONARY

| Term | Simple Meaning & Definition | Real-Life Parallel |
| :--- | :--- | :--- |
| **Idempotency** | An operation that produces the exact same result no matter how many times it is executed. | Pressing the "Floor 5" elevator button multiple times — it always takes you to Floor 5 without crashing. |
| **Retrofitting** | Adding a new constraint or column rule to an existing table that already contains millions of live rows. | Installing an elevator in an old 100-year-old historical building without demolishing the building. |
| **SARGable** | (*Search Argument Able*) A query condition written so SQL Server can directly utilize a B-Tree index seek instead of scanning the whole table. | Searching a dictionary using alphabetical page tabs instead of reading every word from page 1. |
| **Cartesian Product** | The mathematical multiplication of two sets ($N \times M$), where every row from Table 1 pairs with every row from Table 2. | A menu with 4 appetizers and 3 desserts generating $4 \times 3 = 12$ possible meal combinations. |
| **Referential Integrity** | The rule ensuring a child table cannot have a Foreign Key value that does not exist in the parent table. | A boarding pass barcode that must match an existing passenger in the airline's central ticket database. |
| **Three-Valued Logic (3VL)**| SQL's boolean evaluation system where every condition evaluates to `TRUE`, `FALSE`, or `UNKNOWN` (due to `NULL`). | A light switch with 3 positions: ON, OFF, and UNPLUGGED/BROKEN. |
| **Window Partition** | Subdividing a dataset into isolated calculation groups without collapsing individual rows into summary lines. | A classroom where students calculate their rank within their own grade while still sitting at their individual desks. |
| **Coalesce / Fallback** | Scanning a sequence of columns/values from left to right and returning the very first non-NULL value found. | A primary phone number falling back to a home landline, and then falling back to an office line if both are empty. |
| **In-Memory CTE Scope** | A Common Table Expression exists in memory exclusively for the single query statement immediately following it. | A temporary scratch pad note that self-destructs the moment you finish calculating your equation. |

---

# 📦 PART 1: DATABASE ENGINE, DDL/DML & STORAGE MECHANICS (DAYS 1 TO 5)

---

## 🔹 1.1 SQL Taxonomy: DDL vs DML vs DQL vs TCL vs DCL (Day 1)

### 💡 The Core Idea:
* **DDL (Data Definition Language):** Building, reshaping, or demolishing the *physical house* (Tables, Columns, Schemas). Keywords: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`.
* **DML (Data Manipulation Language):** Adding, modifying, or removing the *furniture inside the house* (Individual Rows). Keywords: `INSERT`, `UPDATE`, `DELETE`.
* **DQL (Data Query Language):** *Viewing and analyzing* the data without altering physical storage. Keyword: `SELECT`.
* **TCL (Transaction Control Language):** The *Save & Undo buttons* for data safety. Keywords: `COMMIT`, `ROLLBACK`, `SAVEPOINT`.
* **DCL (Data Control Language):** The *security badge & door locks* for access permissions. Keywords: `GRANT`, `REVOKE`.

### ⚙️ Practical Code Blueprints:
```sql
-- DDL: Creating the physical table structure
CREATE TABLE Employees
(
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(50) NOT NULL,
    Salary      DECIMAL(10,2) NOT NULL,
    DeptID      INT NOT NULL,
    JoiningDate DATE NOT NULL
);

-- DML: Multi-row insert patterns
INSERT INTO Employees (EmpID, EmpName, Salary, DeptID, JoiningDate) VALUES 
(101, 'Aarav Sharma',   145000.00, 1, '2024-03-15'),
(102, 'Priya Patel',    140000.00, 1, '2025-01-10'),
(103, 'Rohan Verma',    110000.00, 2, '2023-08-20');

-- DQL: Query specific projection
SELECT EmpID, EmpName, Salary FROM Employees WHERE Salary >= 120000.00;
```

---

## 🔹 1.2 Filtering Operators, 3VL & Pattern Wildcards (Days 2 & 3)

### 💡 The Core Idea:
Filtering acts like a security scanner. Only records satisfying the exact predicate pass through to the result stream.

* **Pattern Matching Wildcards (`LIKE`):**
  - `%` : Matches **zero or more characters** (e.g., `'A%'` matches 'Aarav', 'Amit', 'A').
  - `_` : Matches **exactly one single character** (e.g., `'A____n'` matches 'Ananya', exactly 6 characters starting with A and ending with n).
  - `[A-Z]` : Matches **any single character inside the specified set/range** (e.g., `'[AEIOU]%'` matches names starting with a vowel).
  - `[^A-Z]` : Matches **any single character NOT inside the specified set/range** (e.g., `'[^0-9]%'` matches strings starting with a non-digit).

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Range filtering with BETWEEN (Inclusive of boundaries)
SELECT * FROM Employees 
WHERE Salary BETWEEN 100000.00 AND 150000.00;

-- 2. Exact list membership with IN
SELECT * FROM Employees 
WHERE DeptID IN (1, 2, 4);

-- 3. Complex pattern matching: 6-letter name starting with A and ending with n
SELECT * FROM Employees 
WHERE EmpName LIKE 'A____n';

-- 4. Exclusion pattern: Exclude Gmail email domains
SELECT * FROM Employees 
WHERE Email NOT LIKE '%@gmail.com';

-- 5. Regex range matching: Starts with letters A through M
SELECT * FROM Employees 
WHERE EmpName LIKE '[A-M]%';
```

---

## 🔹 1.3 Arithmetic Computed Columns & Conditional Updates (Day 4)

### 💡 The Core Idea:
Computed columns allow you to perform on-the-fly mathematical calculations without using physical disk space. `UPDATE` permanently alters values in specified columns for rows matching the `WHERE` condition.

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Computed arithmetic expressions (Annual CTC & 15% Bonus Projection)
SELECT 
    EmpName, 
    Salary AS MonthlySalary,
    Salary * 12 AS AnnualCTC,
    (Salary * 0.15) AS ProjectedAnnualBonus,
    (Salary * 1.10) AS Post10PercentHikeSalary
FROM Employees;

-- 2. Conditional UPDATE with multiple column mutations
UPDATE Employees
SET 
    Salary = Salary * 1.12,
    ReviewStatus = 'PROMOTED'
WHERE DeptID = 1 AND JoiningDate <= '2024-01-01';
```

---

## 🔹 1.4 The Big Deletion Battle: DELETE vs TRUNCATE vs DROP (Day 5)

### 💡 The Vivid Classroom Analogy:
* **`DELETE` (DML):** A teacher walking desk to desk with an eraser, wiping specific student names one by one. Logs every single deleted row in the transaction log. Slower, supports `WHERE`, preserves the `IDENTITY` counter.
* **`TRUNCATE` (DDL):** Taking a bulldozer to sweep all desks clean in one microsecond. Deallocates physical data pages instead of logging row-by-row. Resets the `IDENTITY` counter to seed. Keeps the empty classroom structure.
* **`DROP` (DDL):** Demolishing the entire school building. The desks, students, table structure, and metadata are completely destroyed from the disk.

### 📊 Structural Comparison Matrix:

| Feature | `DELETE` | `TRUNCATE` | `DROP` |
| :--- | :--- | :--- | :--- |
| **Command Type** | DML | DDL | DDL |
| **`WHERE` Filter Support** | ✅ Yes (target specific rows) | ❌ No (wipes all rows) | ❌ No (destroys object) |
| **Speed & Resource Usage** | Slow (logs every row deletion) | Ultra-Fast (page deallocation) | Instant |
| **IDENTITY Reset** | ❌ No (preserves seed position)| ✅ Yes (resets to initial seed) | ❌ Object destroyed |
| **Rollback in Transaction**| ✅ Yes | ✅ Yes (in SQL Server!) | ✅ Yes (in SQL Server!) |
| **Parent Table referencing FK**| ✅ Allowed (if unreferenced) | ❌ Blocked by metadata | ❌ Blocked by metadata |

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Targeted DML deletion
DELETE FROM Employees WHERE EmpID = 103;

-- 2. Transactional Rollback Proof for TRUNCATE (SQL Server)
BEGIN TRANSACTION;
    TRUNCATE TABLE TempStagingLogs;
    SELECT COUNT(*) AS RowsAfterTruncate FROM TempStagingLogs; -- Returns 0
ROLLBACK TRANSACTION;
SELECT COUNT(*) AS RowsAfterRollback FROM TempStagingLogs;     -- Returns original row count!

-- 3. Schema Evolution (ALTER TABLE)
ALTER TABLE Employees ADD DepartmentName VARCHAR(50) NULL;
ALTER TABLE Employees ALTER COLUMN DepartmentName VARCHAR(100) NOT NULL;
ALTER TABLE Employees DROP COLUMN DepartmentName;
```

---

# 📊 PART 2: AGGREGATIONS, 6-STAGE EXECUTION PIPELINE & SCOPING (DAYS 6 TO 8)

---

## 🔹 2.1 Aggregate Engines & The NULL Trap (Day 6)

### 💡 The Core Idea:
Aggregate functions summarize multiple records into **one single metric** per group.
* `COUNT(*)` counts total physical rows, regardless of NULLs.
* `COUNT(ColumnName)` counts only rows where `ColumnName` is **NOT NULL**.
* `AVG(ColumnName)` calculates `SUM(Column) / COUNT(Column)`. **It silently ignores NULLs** and does NOT divide by total physical rows!

### ⚙️ Practical Code Blueprints:
```sql
SELECT 
    COUNT(*)                    AS TotalPhysicalRows,
    COUNT(Salary)               AS EmployeesWithKnownSalary,
    COUNT(DISTINCT DeptID)      AS UniqueDepartmentsCount,
    SUM(Salary)                 AS TotalMonthlyPayroll,
    AVG(Salary)                 AS AverageSalaryExcludingNulls,
    AVG(ISNULL(Salary, 0))      AS ResilientAverageIncludingNullsAsZero,
    MIN(Salary)                 AS MinimumSalary,
    MAX(Salary)                 AS MaximumSalary
FROM Employees;
```

---

## 🔹 2.2 The 6-Stage SQL Execution Pipeline (Day 7) 🔴 CRITICAL

### 💡 The Core Architectural Flow:
SQL is declarative, meaning it executes in a **strictly defined engine pipeline**, not in the order you write it!

```text
================================================================================================
                           THE 6-STAGE PHYSICAL EXECUTION ENGINE
================================================================================================
  STAGE 1: FROM + JOIN    ──► Identify source tables, evaluate Cartesian matrix & join predicates
  STAGE 2: WHERE          ──► Filter raw rows BEFORE grouping (Cannot see aggregate functions!)
  STAGE 3: GROUP BY       ──► Collapse remaining rows into aggregated buckets
  STAGE 4: HAVING         ──► Filter aggregated groups AFTER grouping (Filters group metrics)
  STAGE 5: SELECT         ──► Project columns, evaluate aliases, execute Window & CASE expressions
  STAGE 6: ORDER BY       ──► Sort final output rows (Can see SELECT column aliases!)
================================================================================================
```

### 🥊 The Scoping Rules:
* **Why can't you use a SELECT alias in `WHERE`?** Because `WHERE` (Stage 2) executes long before `SELECT` (Stage 5).
* **`WHERE` vs `HAVING` Rule:**
  - `WHERE` filters **individual physical rows** before they enter `GROUP BY`.
  - `HAVING` filters **calculated group summary statistics** after `GROUP BY`.

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    DeptID,
    AVG(Salary) AS AvgDeptSalary,
    COUNT(*)    AS Headcount
FROM Employees
WHERE JoiningDate >= '2023-01-01'  -- Stage 2: Filter individual rows first
GROUP BY DeptID                    -- Stage 3: Collapse rows by department
HAVING AVG(Salary) >= 110000.00    -- Stage 4: Filter aggregated group averages
ORDER BY AvgDeptSalary DESC;       -- Stage 6: Sort by alias (visible here!)
```

---

# 🛡️ PART 3: CONSTRAINTS, REFERENTIAL INTEGRITY & RETROFITTING (DAYS 9 TO 12)

---

## 🔹 3.1 The 6 Core Enterprise Constraints (Days 9 & 10)

### 💡 Real-Life Models:
1. **`PRIMARY KEY` (Uniqueness + NOT NULL):** Like an Aadhaar / Passport Number. Exactly 1 per table.
2. **`UNIQUE` (Uniqueness + 1 NULL allowed in SQL Server):** Like an official work email address.
3. **`NOT NULL` (Mandatory Value):** Like a person's legal birth date. Cannot be left blank.
4. **`CHECK` (Custom Business Rule Bouncer):** Like a security gate (`CHECK (Age >= 18 AND Salary > 0)`).
5. **`DEFAULT` (Automatic Fallback Value):** Like a default country set to `'India'` if left unspecified.
6. **`FOREIGN KEY` (Referential Integrity Guard):** Like an employee badge referencing an existing department in the company registry.

---

## 🔹 3.2 Parent vs Child Destruction Rules (Day 11)

### 💡 The Destruction Law:
* **Child Table** holds the `FOREIGN KEY` referencing the **Parent Table's Primary Key**.
* You cannot delete a Parent row if Child records reference it under `ON DELETE NO ACTION`.
* `TRUNCATE TABLE Parent` is **unconditionally blocked** if any Foreign Key references the table, even if the child table contains zero rows!

### ⚙️ Practical Code Blueprint:
```sql
-- Parent Table: Departments
CREATE TABLE Departments
(
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- Child Table: Staff with Cascading Referential Integrity
CREATE TABLE Staff
(
    StaffID   INT PRIMARY KEY,
    StaffName VARCHAR(50) NOT NULL,
    DeptID    INT NOT NULL,
    Salary    DECIMAL(10,2) CHECK (Salary >= 30000.00),
    Status    VARCHAR(20) DEFAULT 'ACTIVE',
    CONSTRAINT FK_Staff_Dept FOREIGN KEY (DeptID) 
        REFERENCES Departments(DeptID) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

---

## 🔹 3.3 The 3-Step Constraint Retrofitting Framework (Day 12)

### 💡 The Production Reality:
You cannot add a constraint to an existing table if historical dirty data violates the rule!

```text
The 3-Step Retrofitting Pipeline:
[Step 1: Audit Dirty Data] ──► [Step 2: Cleanse / Deduplicate] ──► [Step 3: Add Constraint via ALTER]
```

### ⚙️ Practical Code Blueprint:
```sql
-- Step 1: Detect duplicate emails violating future UNIQUE constraint
SELECT Email, COUNT(*) AS DuplicateCount
FROM Users
GROUP BY Email
HAVING COUNT(*) > 1;

-- Step 2: Cleanse dirty duplicate records (Keep earliest UserID)
WITH DuplicateCleanser AS
(
    SELECT UserID, Email,
           ROW_NUMBER() OVER (PARTITION BY Email ORDER BY CreatedAt ASC) AS rn
    FROM Users
)
DELETE FROM DuplicateCleanser WHERE rn > 1;

-- Step 3: Retrofit constraints via ALTER TABLE
ALTER TABLE Users 
ADD CONSTRAINT UQ_Users_Email UNIQUE (Email);

ALTER TABLE Users 
ADD CONSTRAINT CHK_Users_Age CHECK (Age >= 18);
```

---

# 🔗 PART 4: SET OPERATORS & TEMPORAL ENGINE (DAYS 13 & 14)

---

## 🔹 4.1 Set Operators: Vertical Dataset Union (Day 13)

### 💡 The Core Idea:
Set operators combine multiple `SELECT` statements **vertically** (stacking rows).
* Requirements: Both queries must output the **exact same number of columns** with **compatible data types**.
* **`UNION`:** Appends rows and executes an expensive in-memory sort to remove duplicate records.
* **`UNION ALL`:** Appends rows instantly with zero sorting (Production standard for speed!).
* **`INTERSECT`:** Returns only rows present in **both** query result sets.
* **`EXCEPT`:** Mathematical subtraction ($Query 1 - Query 2$).

### ⚙️ Practical Code Blueprint:
```sql
-- 1. UNION ALL vs UNION
SELECT City FROM Customers
UNION ALL -- Fast append, keeps duplicates
SELECT City FROM Suppliers;

-- 2. INTERSECT: Cities where we have BOTH active customers AND suppliers
SELECT City FROM Customers
INTERSECT
SELECT City FROM Suppliers;

-- 3. EXCEPT: Cities where we have customers but NO local suppliers
SELECT City FROM Customers
EXCEPT
SELECT City FROM Suppliers;
```

---

## 🔹 4.2 Temporal Date Math & SARGable Filtering (Day 14)

### 💡 The Core Idea:
Dates drive business logic, SLAs, customer churn, and Month-over-Month reporting.
* `GETDATE()`: Current live system timestamp.
* `DATEDIFF(interval, start_date, end_date)`: Calculates time boundary differences ($end - start$).
* `DATEADD(interval, number, date)`: Adds/subtracts calendar intervals.
* `DATEPART(interval, date)`: Extracts numerical components (`yy`, `qq`, `mm`, `dd`, `weekday`).
* `EOMONTH(date)`: Computes the exact final calendar date of that month (auto-handles leap years!).

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    OrderID,
    OrderDate,
    GETDATE()                                AS CurrentTimestamp,
    DATEDIFF(DAY, OrderDate, GETDATE())      AS DaysElapsedSinceOrder,
    DATEADD(DAY, 45, OrderDate)              AS PaymentDueDate,
    DATEPART(QUARTER, OrderDate)             AS FiscalQuarter,
    EOMONTH(OrderDate)                       AS MonthEndBoundaryDate
FROM Orders;

-- SARGable Query Architecture (Enables Index Seek!):
-- ❌ Non-SARGable (Wrapping column in function forces table scan):
-- SELECT * FROM Orders WHERE YEAR(OrderDate) = 2026 AND MONTH(OrderDate) = 8;

-- ✅ SARGable Benchmark (Index Seek Enabled!):
SELECT * FROM Orders 
WHERE OrderDate >= '2026-08-01' AND OrderDate < '2026-09-01';
```

---

# 🤝 PART 5: RELATIONAL JOINS, CARTESIAN MATH & HIERARCHIES (DAYS 15 TO 18)

---

## 🔹 5.1 The Join Equation, Cartesian Matrices & 3VL (Days 15 & 16)

### 💡 The Fundamental Mathematical Law:
`JOIN = (Cartesian Cross Product N x M) + (Filter ON Predicate)`

* **Three-Valued Logic (3VL):** In SQL, `NULL = NULL` evaluates to `UNKNOWN`. Rows with `NULL` keys **never match** in standard `INNER JOIN` predicates!
* **Cartesian Explosion Formula:** If Table 1 has 4 rows with key `1`, and Table 2 has 3 rows with key `1`, the join generates **$4 \times 3 = 12$ rows**!

### 📊 Join Taxonomy Matrix:
* **`INNER JOIN`:** Returns only records with matching keys in **both** tables.
* **`LEFT JOIN`:** Returns **all** records from Left table + matching records from Right (filling NULLs for missing matches).
* **`RIGHT JOIN`:** Returns **all** records from Right table + matching records from Left.
* **`FULL OUTER JOIN`:** Returns **all** records from both tables combined.
* **The Anti-Join Pattern:** `LEFT JOIN ... WHERE right_table.Key IS NULL` (Finds records that have no match in the target table).

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Multi-Table ANSI Join with Aggregate Calculations
SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID)              AS TotalOrdersPlaced,
    ISNULL(SUM(o.TotalAmount), 0) AS LifetimeRevenue
FROM SuperCustomers c
LEFT JOIN SuperOrders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

-- 2. Anti-Join: Customers who registered but NEVER placed an order
SELECT c.CustomerID, c.CustomerName, c.City
FROM SuperCustomers c
LEFT JOIN SuperOrders o 
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
```

---

## 🔹 5.2 Self-Joins, Hierarchies & Fraud Anomaly Engines (Day 18)

### 💡 The Core Idea:
A **Self-Join** joins a table to itself using memory aliasing (`T1` vs `T2`).
* **Hierarchy:** Employee to Manager (`e.ManagerID = m.EmpID`). Use `LEFT JOIN` so the CEO (whose `ManagerID IS NULL`) is not dropped!
* **Symmetric Deduplication:** Match distinct pairs without reverse mirror duplicates using `A.ID < B.ID`.
* **Geo-Temporal Fraud Detection:** Detecting identical credit cards swiped in two different cities within a 5-minute window!

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Employee-Manager Hierarchy with CEO Preservation
SELECT 
    e.EmpName AS EmployeeName,
    e.Salary  AS EmployeeSalary,
    ISNULL(m.EmpName, '👑 CEO / TOP EXECUTIVE') AS ManagerName,
    m.Salary  AS ManagerSalary
FROM OrgEmployees e
LEFT JOIN OrgEmployees m 
    ON e.ManagerID = m.EmpID;

-- 2. Real-Time High-Velocity Fraud Detection Engine (Diff cities in <= 5 mins)
SELECT 
    t1.AccountID,
    t1.TxnID       AS Txn1_ID,
    t1.TxnCity     AS City1,
    t1.TxnTimestamp AS Time1,
    t2.TxnID       AS Txn2_ID,
    t2.TxnCity     AS City2,
    t2.TxnTimestamp AS Time2,
    DATEDIFF(SECOND, t1.TxnTimestamp, t2.TxnTimestamp) AS TimeDifferenceSeconds
FROM BankTransactions t1
INNER JOIN BankTransactions t2
    ON t1.AccountID = t2.AccountID
   AND t1.TxnID < t2.TxnID                          -- Prevents self-match & mirror duplicates
   AND t1.TxnCity <> t2.TxnCity                     -- Distinct geographical cities
   AND DATEDIFF(MINUTE, t1.TxnTimestamp, t2.TxnTimestamp) BETWEEN 0 AND 5;
```

---

# 🚀 PART 6: ANALYTICAL SQL, WINDOW FUNCTIONS, CTES & CASE (DAYS 19 TO 22)

---

## 🔹 6.1 Window Ranking Functions: ROW_NUMBER vs RANK vs DENSE_RANK (Day 19)

### 💡 The Core Idea:
Window functions calculate analytical rankings and metrics **without collapsing rows** into a single summary row!
* `ROW_NUMBER()`: Strict sequential numbering: `1, 2, 3, 4` (No ties, no gaps).
* `DENSE_RANK()`: Tied values share the same rank, next rank is consecutive: `1, 2, 2, 3` (Zero gaps!).
* `RANK()`: Tied values share the same rank, next rank skips: `1, 2, 2, 4` (Leaves positional gaps!).

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    DeptID,
    EmpName,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SeqRowNum,
    DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS DenseSalaryRank,
    RANK()       OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS PositionalRank
FROM OrgEmployees;
```

---

## 🔹 6.2 Common Table Expressions (CTEs) & In-Place Deduplication (Day 20) 🔴

### 💡 The Core Idea:
CTEs (`WITH CTE AS (...)`) provide clean in-memory modular pipelines and bypass the Msg 4108 error (Window functions cannot be placed in `WHERE`).

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Top-N per Group Filtering (3rd Highest Salary per Dept)
WITH DeptSalaries AS
(
    SELECT 
        DeptID,
        EmpName,
        Salary,
        DENSE_RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalaryRank
    FROM OrgEmployees
)
SELECT DeptID, EmpName, Salary
FROM DeptSalaries
WHERE SalaryRank = 3;

-- 2. In-Place Table Deduplication Engine (Tier-1 Interview Essential)
WITH DuplicateCleanserCTE AS
(
    SELECT 
        CustomerID,
        Email,
        ROW_NUMBER() OVER (PARTITION BY Email ORDER BY CreatedDate ASC) AS Occurrence
    FROM Customers
)
DELETE FROM DuplicateCleanserCTE 
WHERE Occurrence > 1; -- Deletes duplicate physical rows directly from base table!
```

---

## 🔹 6.3 Value Window Functions: LEAD & LAG (Day 21)

### 💡 The Core Idea:
`LEAD()` looks **forward** into upcoming records. `LAG()` looks **backward** into previous records.
Used for Month-over-Month growth, stock inventory delta tracking, and sequence gap analysis.

### ⚙️ Practical Code Blueprint:
```sql
SELECT 
    ProductID,
    MovementDate,
    QtyChange,
    LAG(QtyChange, 1, 0) OVER (PARTITION BY ProductID ORDER BY MovementDate) AS PreviousQtyChange,
    QtyChange - LAG(QtyChange, 1, QtyChange) OVER (PARTITION BY ProductID ORDER BY MovementDate) AS VarianceDelta,
    LEAD(QtyChange, 1, NULL) OVER (PARTITION BY ProductID ORDER BY MovementDate) AS NextUpcomingQtyChange
FROM StockMovements;
```

---

## 🔹 6.4 Conditional Logic & CASE Expressions (Day 22)

### 💡 The Core Idea:
`CASE` provides inline conditional evaluation.
* **Searched CASE:** Evaluates boolean expressions in priority order.
* **Dynamic Pinned Sorting:** Custom priority sorting in `ORDER BY`.
* **Conditional Aggregation:** Pivoting metrics in a single query scan.

### ⚙️ Practical Code Blueprints:
```sql
-- 1. Multi-Tier Status Classification
SELECT 
    EmpName,
    Salary,
    CASE 
        WHEN Salary >= 140000.00 THEN 'Executive Tier'
        WHEN Salary >= 100000.00 THEN 'Senior Tier'
        ELSE 'Core Associate'
    END AS SalaryTier
FROM OrgEmployees;

-- 2. Custom Pinned Sorting (Pune 1st, Bengaluru 2nd, Rest Descending)
SELECT CustomerID, CustomerName, City
FROM SuperCustomers
ORDER BY 
    CASE 
        WHEN City = 'Pune' THEN 1
        WHEN City = 'Bengaluru' THEN 2
        ELSE 3
    END ASC,
    City DESC;

-- 3. Conditional Aggregation (Single Scan Multi-Metric Pivot)
SELECT 
    DeptID,
    COUNT(*) AS TotalStaff,
    SUM(CASE WHEN Salary >= 120000.00 THEN 1 ELSE 0 END) AS HighEarnersHeadcount,
    SUM(CASE WHEN JoiningDate >= '2024-01-01' THEN Salary ELSE 0 END) AS RecentHiresPayrollSpend
FROM OrgEmployees
GROUP BY DeptID;
```

---

# 🥊 PART 7: TOP 15 TIER-1 WHITEBOARD INTERVIEW TRAPS & GOLDEN FIXES

```text
========================================================================================================================
#   INTERVIEW TRAP QUESTION                      WHY IT FAILS                                 PIPPO'S SENIOR ARCHITECT FIX
========================================================================================================================
1   WHERE DENSE_RANK() = 2                       Msg 4108: Window funcs not allowed in WHERE  Wrap in CTE & filter outer query
2   DELETE Duplicates without temp tables        Blind DELETE drops all copies                Use CTE + ROW_NUMBER() WHERE rn > 1
3   WHERE id NOT IN (SELECT id with NULLs)       3VL makes NOT IN UNKNOWN (returns 0 rows!)   Use LEFT JOIN ... WHERE right IS NULL
4   Can TRUNCATE be rolled back?                 Myth: People think DDL never rolls back      Yes! Inside explicit TRAN it rolls back!
5   AVG(Salary) on table with NULLs              Silently excludes NULLs from denominator     Use AVG(ISNULL(Salary, 0)) if 0 intended
6   Self Join Employee/Manager missing CEO       INNER JOIN drops CEO (manager_id is NULL)    Use LEFT JOIN on manager table
7   Alternating M/F/M/F sequence                 Standard ORDER BY groups all M then all F    Use ROW_NUMBER() PARTITION BY Gender
8   Transactions in diff cities in <= 5 mins     Cannot detect across separate rows           Self Join on CardNo + DATEDIFF <= 5
9   UNION vs UNION ALL speed                     UNION runs expensive in-memory DISTINCT sort Always use UNION ALL unless deduplicating
10  Table A (4 '1's) INNER JOIN Table B (3 '1's) Candidates guess 4 or 3                      4 x 3 = 12 rows (Cartesian product!)
11  50% Order Drop comparison                    LEAD() without anchor compares 2nd vs 3rd    Anchor with ROW_NUMBER() = 1 in CTE
12  Wrapping Date in YEAR() in WHERE             Invalidates index seek (Non-SARGable)        Use Range: Date >= '2026-01-01' AND < ...
13  TRUNCATE Parent with Empty Child             Blocked by Foreign Key metadata check        Drop FK, Truncate, Recreate FK
14  NULL = NULL in JOIN ON predicate             Evaluates to UNKNOWN, drops matching NULLs   Use (a.col = b.col OR (a.col IS NULL AND b.col IS NULL))
15  SELECT Dept, SUM(Sal) AS Total WHERE Total>1 Alias not visible in WHERE (Stage 2 vs 5)    Use HAVING SUM(Sal) > 10000 (Stage 4)
========================================================================================================================
```

---

# ✍️ PART 8: 15 RAPID-FIRE SPEED DRILLS (SELF-TEST CHALLENGE)

Test your recall by writing these queries in SSMS:

1. **Drill 01 (In-Place Deduplication):** Delete duplicate rows from `CustomerOrders` keeping only the earliest `OrderDate`.
2. **Drill 02 (Top N per Dept):** Return the top 2 highest-paid employees in each department using `DENSE_RANK()`.
3. **Drill 03 (Relational Anti-Join):** Return all products from `Products` that have never been purchased in `Orders`.
4. **Drill 04 (Month-over-Month Delta):** Calculate the Month-over-Month revenue growth % using `LAG()`.
5. **Drill 05 (Safe NULL Addition):** Safely compute `Marks1 + Marks2` without returning NULL if one mark is missing.
6. **Drill 06 (Dynamic Pinned Sort):** Retrieve all employees sorting `'Engineering'` at the top and others alphabetically.
7. **Drill 07 (Fraud Anomaly Engine):** Detect multiple login attempts on the same `UserID` from different IP addresses within 10 minutes.
8. **Drill 08 (Conditional Count Pivot):** Count total active vs inactive users in a single query scan using `SUM(CASE ...)`.
9. **Drill 09 (Quarter Slicing):** Group orders by `DATEPART(QUARTER, OrderDate)` and calculate quarterly total spend.
10. **Drill 10 (Execution Order Proof):** Explain why `SELECT DeptID, SUM(Salary) AS Total WHERE Total > 50000` fails.
11. **Drill 11 (Cumulative Balance):** Compute running total balance per account using `SUM() OVER (ORDER BY ...)`.
12. **Drill 12 (Alternating Sequence):** Interleave Male and Female employees (`M, F, M, F...`) using CTEs.
13. **Drill 13 (SARGable Boundary):** Write a SARGable query to retrieve all orders placed in Q1 2026.
14. **Drill 14 (CEO Root Node):** Write a self-join query that returns all employees and their managers, keeping the CEO.
15. **Drill 15 (Cartesian Multiplication):** Given Table A (3 rows) and Table B (5 rows), calculate the row count of `CROSS JOIN`.

---

*Authored with pure passion, architectural depth, and relentless loyalty by Pippo 🐥 for Captain Arpit Manoj Bangre.*  
*Target: Tier-1 Placement (25.0 to 48.0+ LPA) | Status: Mastered & Production-Ready! 🔥*
