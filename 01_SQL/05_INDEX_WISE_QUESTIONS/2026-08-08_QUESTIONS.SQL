/*============================================================
        DAY 8 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: COMPLEX GROUP BY, SCENARIO DRILLS & DEBUGGING
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day8', 'U') IS NOT NULL DROP TABLE practice_day8;
CREATE TABLE practice_day8 (
    empid INT,
    dept VARCHAR(15),
    salary INT,
    exp INT,
    city VARCHAR(15),
    age INT
);

INSERT INTO practice_day8 (empid, dept, salary, exp, city, age) VALUES 
(101, 'Finance', 45000, 5, 'Nagpur', 28),
(102, 'IT', 65000, 8, 'Pune', 30),
(103, 'Finance', 78000, 12, 'Nagpur', 35),
(104, 'HR', 35000, 3, 'Mumbai', 24);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Find dept and employee count
--     where dept has >= 3 employees.
-- Write your SQL Query below:




-- Q2. Show dept average experience
--     sorted by experience descending.
-- Write your SQL Query below:




-- Q3. Show city maximum salary
--     excluding NULL cities.
-- Write your SQL Query below:




-- Q4. Group by dept and show
--     employee count, sorted ascending.
-- Write your SQL Query below:




-- Q5. Find department-wise
--     minimum salary.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Select employees earning > 5000,
--     group by dept, show average.
-- Write your SQL Query below:




-- Q7. Show minimum salary per city
--     for employees aged >= 25.
-- Write your SQL Query below:




-- Q8. Find depts where max salary
--     > 80000 and count >= 5.
-- Write your SQL Query below:




-- Q9. Show average salary of
--     employees earning > 3000.
-- Write your SQL Query below:




-- Q10. Explain what is wrong with
--      filtering aggregate in WHERE.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. HR Finance: Earnings > 40000.
--      Depts with count >= 6, avg > 75000,
--      max experience > 10, sorted avg desc.
-- Write your SQL Query below:




-- Q12. HR City: Ignore age < 25.
--      Cities with count >= 8, min > 30000,
--      avg experience > 5, sorted count desc.
-- Write your SQL Query below:




-- Q13. Sales: Find salespersons with
--      total > 1,00,000 in 'Q3' sales,
--      sorted descending.
-- Write your SQL Query below:




-- Q14. Bookings: Hotel group bookings
--      for > 2 nights (minimum price < 1500),
--      sorted price ascending.
-- Write your SQL Query below:




-- Q15. Transactions: Total UPI/Card
--      transactions > 10,000 per cust,
--      sorted customer ID ascending.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug query for HR City Audit:
--      SELECT city, COUNT(empid), MIN(salary), AVG(exp) FROM emp
--      WHERE age < 25 HAVING COUNT(empid) >= 8 AND MIN(salary) > 30000
--      ORDER BY COUNT(empid) DESC;
-- Write your corrected Query below:




-- Q17. Explain why GROUP BY list
--      must match un-aggregated SELECT.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT dept, AVG(salary) FROM emp
--      WHERE salary > 3000
--      ORDER BY AVG(salary)
--      GROUP BY dept;
-- Write your corrected Query below:




-- Q19. Why does grouping by a unique
--      ID defeat the purpose of GROUP BY?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT dept, COUNT(*) FROM emp
--      HAVING COUNT(*) > 5;
-- Write your corrected Query below:\n