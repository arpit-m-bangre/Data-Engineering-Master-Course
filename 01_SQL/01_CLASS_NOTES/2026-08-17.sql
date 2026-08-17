-- ============================================================================
-- 📅 DATE & DATETIME FUNCTIONS IN SQL SERVER (T-SQL)
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engineering
-- 📆 CLASS DATE: 17 AUGUST 2026 (Day 14)
-- 🎯 TOPIC: Temporal Data Types, GETDATE, DATEDIFF, DATEPART, DATEADD, EOMONTH
-- ============================================================================

-- ============================================================================
-- 1. INTRODUCTION: TEMPORAL DATA TYPES IN REAL-WORLD ENTERPRISE DATABASES
-- ============================================================================

/*
   Why do DATE and DATETIME data types matter in enterprise databases?
   -----------------------------------------------------------------------------
   In real production company databases, almost EVERY transaction table contains
   temporal columns (e.g., OrderDate, CreatedAt, ShippedDate, PolicyMaturityDate).
   In interview rounds, interviewers heavily test candidates on temporal functions
   because time-series data slicing, SLAs, churn analysis, and aging calculations
   are foundational to Data Engineering.

   Analogy:
   Think of DATE like a wall calendar that only shows the day (2026-08-17),
   and DATETIME like a wall clock + calendar combined down to the millisecond tick
   (2026-08-17 21:17:20.133).
*/

-- Supported Datepart Interval Codes Table:
-- -----------------------------------------------------------------------------
-- Year         -> YY / YYYY (e.g., 26 / 2026)
-- Quarter      -> Q / QQ    (1 to 4)
-- Month        -> M / MM    (1 to 12)
-- Day of Year  -> DY        (1 to 366)
-- Day of Month -> D / DD    (1 to 31)
-- Week         -> WK / WW   (1 to 53)
-- Weekday      -> WEEKDAY / DW (1 = Sunday, 2 = Monday, ... 7 = Saturday)
-- Hour         -> HH / H    (0 to 23)
-- Minute       -> MI / N    (0 to 59)
-- Second       -> S / SS    (0 to 59)
-- Millisecond  -> MS        (0 to 999)

-- Standard Valid Date Literal Formats in SQL Server:
-- Format 1: MM/DD/YYYY  (e.g., '08/17/2026') - US Standard
-- Format 2: YYYY-MM-DD  (e.g., '2026-08-17') - ISO Standard (Recommended)
-- Format 3: YYYY/MM/DD  (e.g., '2026/08/17')


-- ============================================================================
-- 2. GETDATE() — CAPTURING SYSTEM CLOCK TIMESTAMP
-- ============================================================================

SELECT GETDATE() AS CurrentServerDateTime;
-- Result: Returns current server date and time down to milliseconds.
-- Example output: 2026-08-17 21:17:20.133


-- ============================================================================
-- 3. DATEDIFF() — CALCULATING TIME DIFFERENCE BETWEEN TWO DATES
-- ============================================================================

/*
   Syntax:
   DATEDIFF(datepart_interval, start_date, end_date)

   Core Mechanics:
   - DATEDIFF counts the number of DATEPART BOUNDARY CROSSINGS between start_date
     and end_date.
   - If end_date > start_date, the result is POSITIVE.
   - If start_date > end_date, the result is NEGATIVE.
   - Returns an INT data type.
*/

-- 3.1 Difference in Months:
SELECT DATEDIFF(MM, '10/02/2008', GETDATE()) AS diff_in_month;
-- Valid format: MM/DD/YYYY

-- 3.2 Difference in Weeks:
SELECT DATEDIFF(WK, '10/02/2008', GETDATE()) AS diff_in_week;

-- 3.3 Negative Result Example (When start_date is in the future relative to end_date):
SELECT DATEDIFF(DY, GETDATE(), '10/02/2008') AS diff_in_days_negative;
-- Output: Negative integer value because end_date is in the past.

-- 3.4 Invalid Date String Format Trap (DD/MM/YYYY causing character conversion error):
-- SELECT DATEDIFF(MM, '24/02/2008', GETDATE()) AS diff_in_months;
-- Msg 241, Level 16, State 1:
-- Conversion failed when converting date and/or time from character string.
-- Reason: SQL Server expects MM/DD/YYYY by default; month '24' does not exist.

-- 3.5 Malformed Date Literal Trap:
-- SELECT DATEDIFF(MM, '24/02/2008', '24/02/20081');
-- Msg 241, Level 16, State 1:
-- Conversion failed when converting date and/or time from character string.

-- 3.6 Difference in Minutes:
SELECT DATEDIFF(N, '08/16/2026', GETDATE()) AS diff_in_minutes;
-- Example Output: ~2730 minutes

-- 3.7 Difference in Milliseconds (Short Interval - Successful):
SELECT DATEDIFF(MS, '08/16/2026', GETDATE()) AS diff_in_milliseconds;
-- Example Output: 163854093

-- 3.8 Integer Overflow Trap in DATEDIFF with High Precision (MS across months):
-- SELECT DATEDIFF(MS, '07/16/2026', GETDATE()) AS diff_in_milliseconds;
-- Msg 535, Level 16, State 1:
-- The datediff function resulted in an overflow. The number of dateparts 
-- separating two date/time instances is too large. Try to use datediff 
-- with a less precise datepart or use DATEDIFF_BIG().
-- Reason: Milliseconds over ~24.8 days exceed the 2,147,483,647 limit of INT (4 bytes).

-- 3.9 Understanding Starting Point / Boundary Counting:
SELECT DATEDIFF(DY, '08/16/2026', GETDATE()) AS diff_in_day;
-- Output: 1 (Crossed midnight boundary)

SELECT DATEDIFF(HH, '08/16/2026', GETDATE()) AS diff_in_hour;
-- Output: ~45 hours (Calculated from 12:00:00 AM of start date to current hour)


-- ============================================================================
-- 4. DATEPART() — EXTRACTING INDIVIDUAL DATE/TIME COMPONENTS
-- ============================================================================

/*
   Syntax:
   DATEPART(datepart_interval, target_date)

   Core Mechanics:
   - Returns an INTEGER representing the requested component of the date.
*/

-- 4.1 Extract Quarter:
SELECT DATEPART(Q, GETDATE()) AS CurrentQuarter;
-- Output: 3 (August falls in Q3: July, August, September)

-- 4.2 Extract Month:
SELECT DATEPART(M, GETDATE()) AS CurrentMonth;
-- Output: 8 (August)

-- 4.3 Extract Day of Month:
SELECT DATEPART(DD, GETDATE()) AS CurrentDayOfMonth;
-- Output: 17

-- 4.4 Extract Day of Year:
SELECT DATEPART(DY, GETDATE()) AS CurrentDayOfYear;
-- Output: 229 (17th August is the 229th day of 2026)

-- 4.5 Extract Hour:
SELECT DATEPART(HH, GETDATE()) AS CurrentHourOfDay;
-- Output: 21 (9 PM in 24-hour format)

-- 4.6 Extract Day of Week (WEEKDAY):
SELECT DATEPART(WEEKDAY, GETDATE()) AS CurrentDayOfWeek;
-- Output: 2 (Sunday = 1, Monday = 2, Tuesday = 3, ..., Saturday = 7)

-- 4.7 Extract Year:
SELECT DATEPART(YEAR, GETDATE()) AS CurrentYear;
-- Output: 2026

-- 4.8 Extract Quarter from a specific date literal:
SELECT DATEPART(QQ, '08/15/2026') AS IndependenceDayQuarter;
-- Output: 3

-- 4.9 Week boundaries and calendar offset calculations:
SELECT DATEPART(WK, GETDATE()) AS CurrentWeekOfYear;
SELECT DATEPART(WK, GETDATE() - 2) AS WeekOfYearTwoDaysAgo;


-- ============================================================================
-- 5. DATEADD() — ADDING OR SUBTRACTING TIME INTERVALS
-- ============================================================================

/*
   Syntax:
   DATEADD(datepart_interval, number_to_add, target_date)

   Use Case Example:
   Calculating future insurance premium due dates (e.g., today + 6 months),
   subscription renewal deadlines, or trailing history (e.g., today - 30 days).
*/

-- 5.1 Adding 52 Weeks to Current Date:
SELECT DATEADD(WK, 52, GETDATE()) AS OneYearLaterByWeeks;

-- 5.2 Adding 6 Months to Current Date (Policy Renewal):
SELECT DATEADD(MM, 6, GETDATE()) AS SixMonthsFromNow;

-- 5.3 Subtracting 6 Months from Current Date:
SELECT DATEADD(MM, -6, GETDATE()) AS SixMonthsAgo;

-- 5.4 Adding 2 Quarters:
SELECT DATEADD(QQ, 2, GETDATE()) AS TwoQuartersLater;

-- 5.5 Adding 52 Weeks to a Specific Date Literal:
SELECT DATEADD(WK, 52, '08/08/2026') AS CalculatedDate;

-- Note: WEEKDAY is not a valid interval for DATEADD; use DAY (DD) instead.


-- ============================================================================
-- 6. EOMONTH() — FINDING THE END-OF-MONTH DATE
-- ============================================================================

/*
   Syntax:
   EOMONTH(start_date [, month_to_add])

   Use Case Example:
   Generating month-end financial closing reports, billing cycle ends,
   and payroll processing cutoffs.
*/

-- 6.1 End of Current Month:
SELECT EOMONTH(GETDATE()) AS CurrentMonthEndDate;
-- Output: 2026-08-31

-- 6.2 End of February in a Leap Year (2024):
SELECT EOMONTH('02/12/2024') AS LeapYearFebEnd;
-- Output: 2024-02-29 (Correctly identifies 29 days in leap year)


-- ============================================================================
-- 7. IN-CLASS FACULTY DEMO & PRACTICAL TABLE SCENARIOS
-- ============================================================================

-- Setup Demo Table:
IF OBJECT_ID('Newdate', 'U') IS NOT NULL DROP TABLE Newdate;

CREATE TABLE Newdate
(
    id          INT PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    joiningdate DATE NOT NULL
);

INSERT INTO Newdate (id, name, joiningdate)
VALUES
(1, 'a', '02/13/2025'),
(2, 'b', '04/23/2024'),
(3, 'c', '11/20/2026');

-- 7.1 Filter Records Joined More Than 5 Months Ago:
SELECT 
    id,
    name,
    joiningdate,
    DATEDIFF(MM, joiningdate, GETDATE()) AS MonthsSinceJoining
FROM Newdate
WHERE DATEDIFF(MM, joiningdate, GETDATE()) > 5;


-- ============================================================================
-- 8. FACULTY CHALLENGE QUESTIONS (FOR INDEPENDENT PRACTICE)
-- ============================================================================

/*
   FACULTY ASSIGNED IN-CLASS TASKS:
   1. Display employees who joined strictly on weekends (Saturday or Sunday).
   2. Calculate month-wise average sales from transaction records.
   3. Identify customers who have NOT purchased anything in the last 90 days.
*/