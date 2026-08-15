/*============================================================
        DAY 7 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: GROUP BY, HAVING, ORDER BY, EXECUTION SEQUENCE
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Group 'emp' by department
--      and show total salary.
-- Write your SQL Query below:




-- Q1.2. Show dept average salary
--      where avg salary is > 3000.
-- Write your SQL Query below:




-- Q1.3. Sort all employees by
--      salary descending.
-- Write your SQL Query below:




-- Q1.4. Group by dept and show avg
--      salary, sorted by avg ascending.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Group by dept and show
--      employee count.
-- Write your SQL Query below:




-- Q2.2. Show dept and employee count
--      excluding NULL depts.
-- Write your SQL Query below:




-- Q2.3. Find max salary per dept,
--      sorted by dept name.
-- Write your SQL Query below:




-- Q2.4. Find count of students per
--      city where count is >= 2.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Show logical execution
--      order of SQL clauses.
-- Write your answer below:




-- Q3.2. Explain why HAVING requires
--      GROUP BY to function.
-- Write your explanation below:




-- Q3.3. Filter students aged 18-30
--      and show city count.
-- Write your SQL Query below:




-- Q3.4. Show subject-wise average
--      marks for marks > 40.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. Sumedha Ma'am Q1: Total salary
--      per dept for employees joining
--      after 2020 (sum > 3,00,000),
--      sorted descending.
-- Write your SQL Query below:




-- Q4.2. Salesperson sales > 50,000
--      for products priced > 500,
--      sorted alphabetically.
-- Write your SQL Query below:




-- Q4.3. 2023 orders per customer where
--      amount > 1000 (at least 5 orders),
--      sorted descending by count.
-- Write your SQL Query below:




-- Q4.4. Group expenses by type where
--      amount is 500-5000 (average > 1000),
--      sorted average descending.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Average product category price
--      with stock > 50 (avg > 2000),
--      category name sorted.
-- Write your SQL Query below:




-- Q5.2. Total UPI/Card transactions
--      amount > 10,000 per customer,
--      sorted customer ID ascending.
-- Write your SQL Query below:




-- Q5.3. Min hotel price for bookings
--      > 2 nights (min price < 1500),
--      sorted price ascending.
-- Write your SQL Query below:




-- Q5.4. Plan users in India/Nepal
--      with count >= 200, sorted
--      by subscriber count.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Correct the syntax error:
--      SELECT dept, SUM(salary) AS total
--      FROM emp GROUP BY dept
--      HAVING total > 5000;
-- Write your corrected Query below:




-- Q6.2. Explain why you cannot use
--      aliases in WHERE/HAVING.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      SELECT dept, salary FROM emp
--      GROUP BY dept;
-- Write your corrected Query below:




-- Q6.4. Why does ORDER BY allow
--      column aliases?
-- Write your explanation below:\n