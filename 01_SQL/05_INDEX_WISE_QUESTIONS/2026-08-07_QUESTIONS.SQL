/*============================================================
        DAY 7 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: GROUP BY, HAVING, ORDER BY, EXECUTION SEQUENCE
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day7', 'U') IS NOT NULL DROP TABLE practice_day7;
CREATE TABLE practice_day7 (
    id INT,
    name VARCHAR(10),
    dept VARCHAR(10),
    salary INT
);

INSERT INTO practice_day7 (id, name, dept, salary) VALUES 
(1, 'arpit', 'HR', 2000),
(2, 'rahul', 'IT', 3000),
(3, 'rohit', 'IT', 4000),
(4, 'ravi', 'HR', 2500);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Group 'emp' by department
--     and show total salary.
-- Write your SQL Query below:




-- Q2. Show dept average salary
--     where avg salary is > 3000.
-- Write your SQL Query below:




-- Q3. Sort all employees by
--     salary descending.
-- Write your SQL Query below:




-- Q4. Group by dept and show avg
--     salary, sorted by avg ascending.
-- Write your SQL Query below:




-- Q5. Group by dept and show
--     employee count.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Show dept and employee count
--     excluding NULL depts.
-- Write your SQL Query below:




-- Q7. Find max salary per dept,
--     sorted by dept name.
-- Write your SQL Query below:




-- Q8. Find count of students per
--     city where count is >= 2.
-- Write your SQL Query below:




-- Q9. Show logical execution
--     order of SQL clauses.
-- Write your answer below:




-- Q10. Explain why HAVING requires
--      GROUP BY to function.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Sumedha Ma'am Q1: Total salary
--      per dept for employees joining
--      after 2020 (sum > 3,00,000),
--      sorted descending.
-- Write your SQL Query below:




-- Q12. Salesperson sales > 50,000
--      for products priced > 500,
--      sorted alphabetically.
-- Write your SQL Query below:




-- Q13. 2023 orders per customer where
--      amount > 1000 (at least 5 orders),
--      sorted descending by count.
-- Write your SQL Query below:




-- Q14. Group expenses by type where
--      amount is 500-5000 (average > 1000),
--      sorted average descending.
-- Write your SQL Query below:




-- Q15. Average product category price
--      with stock > 50 (avg > 2000),
--      category name sorted.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Correct the syntax error:
--      SELECT dept, SUM(salary) AS total
--      FROM emp GROUP BY dept
--      HAVING total > 5000;
-- Write your corrected Query below:




-- Q17. Explain why you cannot use
--      aliases in WHERE/HAVING.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT dept, salary FROM emp
--      GROUP BY dept;
-- Write your corrected Query below:




-- Q19. Why does ORDER BY allow
--      column aliases?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT dept FROM emp
--      HAVING AVG(salary) > 3000;
-- Write your corrected Query below:\n