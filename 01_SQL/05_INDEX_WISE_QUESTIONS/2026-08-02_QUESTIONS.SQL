/*============================================================
       DAY 2 PRACTICE QUESTIONS - 2 AUGUST 2026
       TOPICS: WHERE FILTERS, COMPARISON & LOGICAL OPERATORS, LIKE WILDCARDS
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query to select all employees from 'employee1' whose department is 'HR'.
-- Write your SQL Query below:




-- Q2. Select employees from 'employee1' whose salary is strictly greater than 4000.
-- Write your SQL Query below:




-- Q3. Write a query using IN to select employees from 'employee1' in 'HR' or 'Entc' departments.
-- Write your SQL Query below:




-- Q4. Select all employees from 'employee1' whose salary is between 3000 and 6000 (inclusive).
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select all students from 'StudentInfo' whose city is NULL.
-- Write your SQL Query below:




-- Q6. Select all students from 'StudentInfo' whose city is NOT NULL.
-- Write your SQL Query below:




-- Q7. Write a SELECT query to pull the RollNo, Name, and Marks of students who scored between 70 and 90.
-- Write your SQL Query below:




-- Q8. Explain the difference between the '=' operator and the 'IS NULL' operator in SQL filters.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR wants to find all students in 'StudentInfo' whose name starts with the letter 'A'.
-- Write your SQL Query below:




-- Q10. Find all students in 'StudentInfo' whose email ID contains 'gmail.com'.
-- Write your SQL Query below:




-- Q11. Find all students in 'StudentInfo' whose second character in their name is 'a'.
-- Write your SQL Query below:




-- Q12. Find all students in 'StudentInfo' who live in 'Nagpur' and are aged 22 or older.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the logic error: The user wants to exclude 'HR' dept, so they ran:
--      SELECT * FROM employee1 WHERE dept <> 'HR';
--      Why are employees with NULL departments missing, and how do you fix it?
-- Write your corrected SQL Query below:




-- Q14. Explain why the query 'SELECT * FROM employee1 WHERE empname LIKE '[^A-Z]%';' returns no rows
--      when all names start with uppercase English letters.
-- Write your explanation below:\n