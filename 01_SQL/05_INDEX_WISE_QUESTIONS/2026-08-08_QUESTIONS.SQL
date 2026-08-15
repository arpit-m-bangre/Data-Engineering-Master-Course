/*============================================================
        DAY 8 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: COMPLEX GROUP BY, SCENARIO DRILLS & DEBUGGING
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Find dept and employee count
--      where dept has >= 3 employees.
-- Write your SQL Query below:




-- Q1.2. Show dept average experience
--      sorted by experience descending.
-- Write your SQL Query below:




-- Q1.3. Show city maximum salary
--      excluding NULL cities.
-- Write your SQL Query below:




-- Q1.4. Group by dept and show
--      employee count, sorted ascending.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Find department-wise
--      minimum salary.
-- Write your SQL Query below:




-- Q2.2. Show average salary of
--      employees earning > 3000.
-- Write your SQL Query below:




-- Q2.3. Find depts whose max salary
--      > 80000 and count >= 5.
-- Write your SQL Query below:




-- Q2.4. Show minimum salary per city
--      for employees aged >= 25.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Select employees earning > 5000,
--      group by dept, show average.
-- Write your SQL Query below:




-- Q3.2. Find the count of students
--      who have marks > 60 in 'Stat'.
-- Write your SQL Query below:




-- Q3.3. Explain what is wrong with
--      filtering aggregate in WHERE.
-- Write your explanation below:




-- Q3.4. Show the execution order
--      of HAVING and SELECT.
-- Write your explanation below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. HR Finance: Earnings > 40000.
--      Depts with count >= 6, avg > 75000,
--      max experience > 10, sorted avg desc.
-- Write your SQL Query below:




-- Q4.2. HR City: Ignore age < 25.
--      Cities with count >= 8, min > 30000,
--      avg experience > 5, sorted count desc.
-- Write your SQL Query below:




-- Q4.3. Sales: Find salespersons with
--      total > 1,00,000 in 'Q3' sales,
--      sorted descending.
-- Write your SQL Query below:




-- Q4.4. Bookings: Hotel group bookings
--      for > 2 nights (minimum price < 1500),
--      sorted price ascending.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Transactions: Total UPI/Card
--      transactions > 10,000 per cust,
--      sorted customer ID ascending.
-- Write your SQL Query below:




-- Q5.2. Category Audit: Cat stock > 50
--      and average price > 2000.
-- Write your SQL Query below:




-- Q5.3. Subscriptions: Count plan users
--      in India/Nepal with count >= 200.
-- Write your SQL Query below:




-- Q5.4. Expenses: Expense type average
--      > 1000 for amounts 500-5000.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug query for HR City Audit:
--      SELECT city, COUNT(empid), MIN(salary), AVG(exp) FROM emp
--      WHERE age < 25 HAVING COUNT(empid) >= 8 AND MIN(salary) > 30000
--      ORDER BY COUNT(empid) DESC;
-- Write your corrected Query below:




-- Q6.2. Explain why GROUP BY list
--      must match un-aggregated SELECT.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      SELECT dept, AVG(salary) FROM emp
--      WHERE salary > 3000
--      ORDER BY AVG(salary)
--      GROUP BY dept;
-- Write your corrected Query below:




-- Q6.4. Why does grouping by a unique
--      ID defeat the purpose of GROUP BY?
-- Write your explanation below:\n