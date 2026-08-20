/*================================================================
   SQL CLASS NOTES - 17 AUGUST 2026 (DAY 14)
   TOPICS: DATETIME FUNCTIONS (GETDATE, DATEDIFF, DATEPART, DATEADD)
==================================================================*/

/* Theory: DATE stores YYYY-MM-DD. DATETIME stores YYYY-MM-DD HH:MM:SS.MMM */

-- 1. GETDATE() — System Clock Timestamp
SELECT GETDATE() AS CurrentServerDateTime;

-- ============================================================================
-- 2. DATEDIFF() — TIME DIFFERENCE
-- Syntax: DATEDIFF(datepart, start_date, end_date)
-- ============================================================================

-- Difference in Months
SELECT DATEDIFF(MM, '2016-08-18', GETDATE()) AS diff_in_month;
SELECT DATEDIFF(MM, '2016/08/18', GETDATE()) AS diff_in_month;
SELECT DATEDIFF(MM, '08-18-2016', GETDATE()) AS diff_in_month;

-- Difference in Weeks & Days
SELECT DATEDIFF(WK, '10/02/2008', GETDATE()) AS diff_in_week;
SELECT DATEDIFF(DY, GETDATE(), '10/02/2008') AS diff_in_days_negative;

/* Error: Conversion failed. Ambiguous format DD/MM/YYYY vs MM/DD/YYYY */
-- SELECT DATEDIFF(MM, '24/02/2008', GETDATE()); 

-- Correct ISO Format (YYYY-MM-DD):
SELECT DATEDIFF(MM, '2008-02-24', '2081-02-24');

-- Difference in Minutes & Milliseconds
SELECT DATEDIFF(N, '08/16/2026', GETDATE()) AS diff_in_minutes;
SELECT DATEDIFF(MS, '08/16/2026', GETDATE()) AS diff_in_milliseconds;

/* Error: Integer Overflow for high precision across months */
-- SELECT DATEDIFF(MS, '07/16/2026', GETDATE());

-- Boundary Check
SELECT DATEDIFF(DY, '08/16/2026', GETDATE()) AS diff_in_day;
SELECT DATEDIFF(HH, '08/16/2026', GETDATE()) AS diff_in_hour;


-- ============================================================================
-- 3. DATEPART() — EXTRACT COMPONENTS
-- Syntax: DATEPART(datepart, target_date)
-- ============================================================================

SELECT DATEPART(Q, GETDATE()) AS CurrentQuarter;
SELECT DATEPART(M, GETDATE()) AS CurrentMonth;
SELECT DATEPART(DD, GETDATE()) AS CurrentDayOfMonth;
SELECT DATEPART(DY, GETDATE()) AS CurrentDayOfYear;
SELECT DATEPART(HH, GETDATE()) AS CurrentHourOfDay;
SELECT DATEPART(WEEKDAY, GETDATE()) AS CurrentDayOfWeek;
SELECT DATEPART(YEAR, GETDATE()) AS CurrentYear;
SELECT DATEPART(QQ, '08/15/2026') AS IndDayQuarter;
SELECT DATEPART(WK, GETDATE()) AS CurrentWeekOfYear;


-- ============================================================================
-- 4. DATEADD() — ADD / SUBTRACT INTERVALS
-- Syntax: DATEADD(datepart, number, target_date)
-- ============================================================================

SELECT DATEADD(WK, 52, GETDATE()) AS OneYearLaterByWeeks;
SELECT DATEADD(MM, 6, GETDATE()) AS SixMonthsFromNow;
SELECT DATEADD(MM, -6, GETDATE()) AS SixMonthsAgo;
SELECT DATEADD(QQ, 2, GETDATE()) AS TwoQuartersLater;
SELECT DATEADD(WK, 52, '08/08/2026') AS CalculatedDate;


-- ============================================================================
-- 5. EOMONTH() — END OF MONTH
-- ============================================================================

SELECT EOMONTH(GETDATE()) AS CurrentMonthEndDate;
SELECT EOMONTH('02/12/2024') AS LeapYearFebEnd; -- Returns 2024-02-29


-- ============================================================================
-- 6. FACULTY DEMO
-- ============================================================================

IF OBJECT_ID('Newdate', 'U') IS NOT NULL DROP TABLE Newdate;

CREATE TABLE Newdate
(
    id          INT PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    joiningdate DATE NOT NULL
);

INSERT INTO Newdate (id, name, joiningdate) VALUES
(1, 'a', '02/13/2025'),
(2, 'b', '04/23/2024'),
(3, 'c', '11/20/2026');

-- Filter records joined more than 5 months ago
SELECT 
    id, name, joiningdate,
    DATEDIFF(MM, joiningdate, GETDATE()) AS MonthsSinceJoining
FROM Newdate
WHERE DATEDIFF(MM, joiningdate, GETDATE()) > 5;