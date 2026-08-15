/*============================================================
       DAY 8 PRACTICE QUESTIONS - 8 AUGUST 2026
       TOPICS: COMPLEX SCENARIO-BASED SQL CHALLENGES, QUERY MISTAKE ANALYSIS & DEBUGGING
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query to find the department and count of employees where the department has at least 3 employees.
-- Write your SQL Query below:




-- Q2. Write a query to show department-wise average experience (Exp) sorted by average experience descending.
-- Write your SQL Query below:




-- Q3. Write a query to show city-wise maximum salary, excluding cities that are NULL.
-- Write your SQL Query below:




-- Q4. Group 'emp' by department and show the count of employees, sorted by count ascending.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select all employees who earn more than 5000 and group by department, showing average salary.
-- Write your SQL Query below:




-- Q6. Write a query to show the minimum salary per city for employees aged 25 or older.
-- Write your SQL Query below:




-- Q7. Find departments whose maximum salary is greater than 80000 and count of employees is at least 5.
-- Write your SQL Query below:




-- Q8. Explain what is wrong with: 'SELECT city, AVG(salary) FROM emp WHERE AVG(salary) > 30000 GROUP BY city;'
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR Finance: Consider employees earning > 40000. Find departments having: employee count >= 6,
--     average salary > 75000, and maximum experience > 10 years, sorted by avg salary descending.
-- Write your SQL Query below:




-- Q10. HR City Audit: Ignore employees aged below 25. Find cities where: employee count >= 8,
--      minimum salary > 30000, and average experience > 5 years, sorted by employee count descending.
-- Write your SQL Query below:




-- Q11. Sales Performance: In the Sales table, find salespersons with total sales > 1,00,000 for sales
--      made in 'Q3' only, sorted by total sales descending.
-- Write your SQL Query below:




-- Q12. Room Bookings: Group bookings by hotel where bookings were made for > 2 nights, displaying
--      hotels where the minimum room price booked is < 1500, sorted by price ascending.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the logic errors in this query written for Q10 (HR City Audit):
--      SELECT city, COUNT(empid), MIN(salary), AVG(exp) FROM emp
--      WHERE age < 25 HAVING COUNT(empid) >= 8 AND MIN(salary) > 30000 AND AVG(exp) > 5
--      ORDER BY COUNT(empid) DESC;
-- Write your corrected SQL Query below:




-- Q14. Explain why you cannot use 'GROUP BY city' without specifying 'city' in the SELECT list,
--      and vice-versa (selecting 'city' without grouping by it).
-- Write your explanation below:\n