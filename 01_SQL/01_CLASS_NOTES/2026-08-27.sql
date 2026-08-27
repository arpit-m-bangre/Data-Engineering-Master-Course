/* === SQL CLASS NOTES - 2026-08-27 (DAY 23) | SURPRISE TEST: ADVANCED SQL & PRACTICAL SCENARIO LAB === */

-- 1. SETUP SCHEMA & SEED DATASETS FOR SURPRISE TEST LAB
IF OBJECT_ID('OrderItems', 'U') IS NOT NULL DROP TABLE OrderItems;
IF OBJECT_ID('SalesTransactions', 'U') IS NOT NULL DROP TABLE SalesTransactions;
IF OBJECT_ID('Sales', 'U') IS NOT NULL DROP TABLE Sales;
IF OBJECT_ID('BankTransactions', 'U') IS NOT NULL DROP TABLE BankTransactions;
IF OBJECT_ID('UserAccounts', 'U') IS NOT NULL DROP TABLE UserAccounts;
IF OBJECT_ID('ProductPriceHistory', 'U') IS NOT NULL DROP TABLE ProductPriceHistory;
IF OBJECT_ID('EmployeeSalaries', 'U') IS NOT NULL DROP TABLE EmployeeSalaries;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;

CREATE TABLE EmployeeSalaries (EmpID INT, Salary DECIMAL(10,2), SalaryDate DATE);
CREATE TABLE ProductPriceHistory (ProductID INT, ProductName VARCHAR(50), Price DECIMAL(10,2), PriceDate DATE);
CREATE TABLE Customers (CustomerID INT PRIMARY KEY, CustomerName VARCHAR(50));
CREATE TABLE Orders (OrderID INT PRIMARY KEY, CustomerID INT, OrderDate DATE, Amount DECIMAL(10,2));
CREATE TABLE Products (ProductID INT PRIMARY KEY, CategoryID INT, ProductName VARCHAR(50), Price DECIMAL(10,2));
CREATE TABLE OrderItems (OrderID INT, ProductID INT, Quantity INT, Price DECIMAL(10,2));
CREATE TABLE Employees (EmpID INT PRIMARY KEY, EmpName VARCHAR(50));
CREATE TABLE Sales (SaleID INT PRIMARY KEY, EmpID INT, SaleDate DATE, Amount DECIMAL(10,2));
CREATE TABLE SalesTransactions (OrderID INT PRIMARY KEY, OrderTime TIME, Amount DECIMAL(10,2));
CREATE TABLE UserAccounts (UserID INT PRIMARY KEY, UserName VARCHAR(50), Email VARCHAR(100));
CREATE TABLE BankTransactions (TxnID INT PRIMARY KEY, CustomerID INT, City VARCHAR(50), TxnTime DATETIME, Amount DECIMAL(10,2));

-- 2. SCENARIO 1: SALARY INCREASED BY > 30% OVER PREVIOUS SALARY (LAG VALUE FUNCTION)
/* Theory: LAG retrieves the immediately preceding row within partition to calculate progression. */
WITH SalaryProgressionCTE AS
(
    SELECT 
        EmpID,
        Salary,
        SalaryDate,
        LAG(Salary) OVER (PARTITION BY EmpID ORDER BY SalaryDate) AS PrevSalary
    FROM EmployeeSalaries
)
SELECT 
    EmpID,
    Salary AS LatestSalary,
    PrevSalary,
    SalaryDate
FROM SalaryProgressionCTE
WHERE PrevSalary IS NOT NULL AND Salary > PrevSalary * 1.30;

-- 3. SCENARIO 2: PRODUCT PRICE CHANGED MORE THAN TWICE IN 90 DAYS (LAG + AGGREGATION)
/* Theory: Compare current price against lagged price to count true price changes within date window. */
WITH PriceVarianceCTE AS
(
    SELECT 
        ProductID,
        ProductName,
        Price,
        PriceDate,
        LAG(Price) OVER (PARTITION BY ProductID ORDER BY PriceDate) AS PrevPrice
    FROM ProductPriceHistory
)
SELECT 
    ProductID,
    ProductName,
    COUNT(*) AS PriceChangeCount
FROM PriceVarianceCTE
WHERE Price <> PrevPrice 
  AND PriceDate >= DATEADD(DAY, -90, CAST('2026-08-27' AS DATE))
GROUP BY ProductID, ProductName
HAVING COUNT(*) > 2;

-- 4. SCENARIO 3: CUSTOMERS WHO ORDERED IN EVERY MONTH (CALENDAR COMPLETENESS)
/* Theory: Distinct month count equals 12 across a full annual reporting cycle. */
SELECT 
    CustomerID,
    COUNT(DISTINCT MONTH(OrderDate)) AS DistinctActiveMonths
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT MONTH(OrderDate)) = 12;

-- 5. SCENARIO 4: PRODUCTS HAVING IDENTICAL SALE AMOUNT (SELF JOIN DE-DUPLICATION)
/* Theory: Self join on matching price using '<' comparison to eliminate mirror duplicate pairs. */
SELECT DISTINCT 
    p1.ProductName AS Product1,
    p2.ProductName AS Product2,
    p1.Price AS MatchingPrice
FROM Products p1
JOIN Products p2 
    ON p1.Price = p2.Price 
   AND p1.ProductID < p2.ProductID;

-- 6. SCENARIO 5: TOP 5 CUSTOMERS BY TOTAL LIFETIME SPEND (DENSE_RANK & CTE)
/* Theory: DENSE_RANK assigns consecutive rank without gaps for equal aggregate spends. */
WITH CustomerSpendRankCTE AS
(
    SELECT 
        c.CustomerName,
        SUM(o.Amount) AS TotalSpent,
        DENSE_RANK() OVER (ORDER BY SUM(o.Amount) DESC) AS SpendRank
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.CustomerName
)
SELECT 
    CustomerName,
    TotalSpent,
    SpendRank
FROM CustomerSpendRankCTE
WHERE SpendRank <= 5;

-- 7. SCENARIO 6: IDENTIFY PEAK SALES HOUR (HOURLY REVENUE SLICING)
/* Theory: Slices timestamp into hour bucket using DATEPART and aggregates revenue. */
SELECT TOP 1 
    DATEPART(HOUR, OrderTime) AS PeakHour,
    SUM(Amount) AS TotalRevenue
FROM SalesTransactions
GROUP BY DATEPART(HOUR, OrderTime)
ORDER BY SUM(Amount) DESC;

-- 8. SCENARIO 7: PRODUCT WITH HIGHEST REVENUE PER CATEGORY (PARTITIONED RANKING)
/* Theory: PARTITION BY isolates ranking calculation per CategoryID. */
WITH CategoryProductRevenueCTE AS
(
    SELECT 
        p.CategoryID,
        p.ProductName,
        SUM(oi.Quantity * oi.Price) AS TotalRevenue,
        DENSE_RANK() OVER (PARTITION BY p.CategoryID ORDER BY SUM(oi.Quantity * oi.Price) DESC) AS CategoryRank
    FROM Products p
    JOIN OrderItems oi ON p.ProductID = oi.ProductID
    GROUP BY p.CategoryID, p.ProductID, p.ProductName
)
SELECT 
    CategoryID,
    ProductName,
    TotalRevenue
FROM CategoryProductRevenueCTE
WHERE CategoryRank = 1;

-- 9. SCENARIO 8: TOP PERFORMING EMPLOYEE PER MONTH (MONTHLY PARTITIONED LEADERBOARD)
WITH MonthlyEmployeeSalesCTE AS
(
    SELECT 
        DATEPART(MONTH, s.SaleDate) AS SaleMonth,
        e.EmpName,
        SUM(s.Amount) AS TotalSales,
        DENSE_RANK() OVER (PARTITION BY DATEPART(MONTH, s.SaleDate) ORDER BY SUM(s.Amount) DESC) AS MonthlyRank
    FROM Sales s
    JOIN Employees e ON s.EmpID = e.EmpID
    GROUP BY DATEPART(MONTH, s.SaleDate), e.EmpID, e.EmpName
)
SELECT 
    SaleMonth,
    EmpName,
    TotalSales
FROM MonthlyEmployeeSalesCTE
WHERE MonthlyRank = 1;

-- 10. SCENARIO 9: FIND DUPLICATE EMAIL IDS (GROUP BY & HAVING)
SELECT 
    Email,
    COUNT(*) AS DuplicateCount
FROM UserAccounts
GROUP BY Email
HAVING COUNT(*) > 1;

-- 11. SCENARIO 10: FRAUD DETECTION - GEO-TEMPORAL COLLISION AT SAME TIME
/* Theory: Self join detects same customer in different cities at identical timestamps. */
SELECT 
    t1.CustomerID,
    t1.City AS City1,
    t2.City AS City2,
    t1.TxnTime
FROM BankTransactions t1
JOIN BankTransactions t2 
    ON t1.CustomerID = t2.CustomerID
   AND t1.TxnID < t2.TxnID
   AND t1.TxnTime = t2.TxnTime
   AND t1.City <> t2.City;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-27_CLASS_TASK.SQL */
