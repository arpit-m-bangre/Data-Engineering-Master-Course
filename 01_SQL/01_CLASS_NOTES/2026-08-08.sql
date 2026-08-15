/* ================================================================================
   SQL PRACTICE - 08 AUGUST 2026
   TOPICS: COMPLEX SCENARIO-BASED GROUP BY DRILLS & MISTAKE ANALYSIS
   ================================================================================ */

-- ------------------------------------------------------------
-- QUESTION 1 - FINANCE BONUS ELIGIBILITY
-- ------------------------------------------------------------
-- Consider only employees earning more than ₹40,000.
-- Find departments having: At least 6 employees, Avg salary > ₹75,000, Max experience > 10 years
-- Sort by Average Salary (Highest First).

SELECT
    dept,
    COUNT(empid) AS employee_count,
    AVG(salary)  AS avg_salary,
    MAX(exp)     AS max_experience
FROM emp
WHERE salary > 40000
GROUP BY dept
HAVING COUNT(empid) >= 6
   AND AVG(salary) > 75000
   AND MAX(exp) > 10
ORDER BY avg_salary DESC;
-- ✔️ Logic was correct: WHERE (row filter) -> GROUP BY -> HAVING (group filter) -> ORDER BY.

-- ------------------------------------------------------------
-- QUESTION 2 - CITY PERFORMANCE
-- ------------------------------------------------------------
-- Ignore employees aged below 25.
-- Find cities where: Employee count is at least 8, Min salary > ₹30,000, Avg experience > 5 years
-- Sort by Employee Count descending.

SELECT
    city,
    COUNT(empid) AS employee_count,
    MIN(salary)  AS min_salary,
    AVG(exp)     AS avg_experience
FROM emp
WHERE age >= 25
GROUP BY city
HAVING COUNT(empid) >= 8
   AND MIN(salary) > 30000
   AND AVG(exp) > 5
ORDER BY employee_count DESC;

-- ❌ Mistakes made in your draft query:
-- 1. You wrote: WHERE age < 25 (Should be: WHERE age >= 25 to IGNORE below 25).
-- 2. You forgot: GROUP BY city (Compulsory since city is in SELECT list!).\n