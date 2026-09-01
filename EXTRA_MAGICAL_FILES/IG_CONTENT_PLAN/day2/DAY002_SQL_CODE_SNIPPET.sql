/* ====================================================================
   210-DAY CREATOR ENGINE — DAY 002 REEL ASSET
   TOPIC: The 50% Order Drop Trap: Why LEAD() Needs an Anchor
   TARGET: Dark Mode Screen Recording (SSMS / VS Code)
==================================================================== */

-- 1. SETUP SAMPLE DATA
CREATE TABLE #CustomerOrders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO #CustomerOrders VALUES 
(1, 101, '2026-01-10', 200.00), -- 1st Order ($200)
(2, 101, '2026-01-15',  80.00), -- 2nd Order ($80) -> Dropped > 50%!
(3, 101, '2026-01-20',  90.00),
(4, 102, '2026-01-12', 150.00), -- 1st Order ($150)
(5, 102, '2026-01-18', 140.00); -- 2nd Order ($140) -> Did not drop 50%

-- 2. THE SENIOR DATA ENGINEER SOLUTION (ANCHORED WITH ROW_NUMBER)
WITH EvaluatedOrders AS (
    SELECT 
        CustomerID,
        OrderDate,
        Amount AS FirstOrderAmount,
        LEAD(Amount, 1) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS SecondOrderAmount,
        ROW_NUMBER()    OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderSequence
    FROM #CustomerOrders
)
SELECT 
    CustomerID,
    FirstOrderAmount,
    SecondOrderAmount,
    ROUND(((FirstOrderAmount - SecondOrderAmount) / FirstOrderAmount) * 100, 2) AS DropPercentage
FROM EvaluatedOrders
WHERE OrderSequence = 1 
  AND SecondOrderAmount <= (FirstOrderAmount * 0.50);

-- CLEANUP
DROP TABLE #CustomerOrders;
