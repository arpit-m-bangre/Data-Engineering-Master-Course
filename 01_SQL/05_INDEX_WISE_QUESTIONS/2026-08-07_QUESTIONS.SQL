/*============================================================
       DAY 7 PRACTICE QUESTIONS - 7 AUGUST 2026
       TOPICS: GROUP BY WITH WHERE/HAVING, CLAUSE EXECUTION SEQUENCE, ORDER BY, ALIASING
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query to group 'emp' by department and show the total salary of each department.
-- Write your SQL Query below:




-- Q2. Write a query to show department-wise average salary where the average salary is greater than 3000.
-- Write your SQL Query below:




-- Q3. Display all employees sorted by salary in DESCENDING order.
-- Write your SQL Query below:




-- Q4. Group 'emp' by department and show average salary, sorted by average salary in ASCENDING order.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select the department and count of employees in each department, excluding NULL departments.
-- Write your SQL Query below:




-- Q6. Find the maximum salary for each department, sorting the result alphabetically by department name.
-- Write your SQL Query below:




-- Q7. Write a query to find the count of students in each city where the student count is at least 2.
-- Write your SQL Query below:




-- Q8. Write down the logical execution sequence of SQL clauses (FROM, SELECT, WHERE, HAVING, GROUP BY, ORDER BY).
-- Write your answer below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. Sumedha Ma'am's Task: From the Employees table, find the total salary per department for employees
--     who joined after 2020, showing departments where the total salary is > 3,00,000, ordered descending.
-- Write your SQL Query below:




-- Q10. From the Sales table, calculate total sales done by each salesperson for products priced > 500,
--      displaying salespersons whose total sales exceed 50,000, sorted alphabetically.
-- Write your SQL Query below:




-- Q11. From the Orders table, count 2023 orders per customer where amount > 1000, showing customers
--      who placed at least 5 orders, sorted by count descending.
-- Write your SQL Query below:




-- Q12. Group expenses by type where expense is between 500 and 5000, displaying expense types
--      whose average expense is above 1000, ordered by average value descending.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the error in the following aggregate filter query:
--      SELECT dept, SUM(salary) AS total_salary FROM emp GROUP BY dept HAVING total_salary > 5000;
-- Write your corrected SQL Query below:




-- Q14. Explain why you cannot use a column alias in the WHERE clause, but you CAN use it in the ORDER BY clause.
-- Write your explanation below:\n