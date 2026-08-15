/*============================================================
       DAY 4 PRACTICE QUESTIONS - 4 AUGUST 2026
       TOPICS: ARITHMETIC OPERATORS, UPDATE & DELETE (DML), DROP TABLE (DDL)
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query to project 'marks' and a calculated column 'IncMarks' showing marks increased by 5.
-- Write your SQL Query below:




-- Q2. Write an UPDATE query to change the subject of all students with RollNo = 101 to 'Data Engineering'.
-- Write your SQL Query below:




-- Q3. Write a DELETE query to remove a student whose RollNo is 105.
-- Write your SQL Query below:




-- Q4. Write a query to drop the table 'student_dumy'.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select all students whose marks are strictly greater than 80 after adding a 10-mark grace.
-- Write your SQL Query below:




-- Q6. Write a query to set the marks to NULL for all students who scored below 40.
-- Write your SQL Query below:




-- Q7. Select all students whose name contains 'a' and subject is 'Data Engineering'.
-- Write your SQL Query below:




-- Q8. Explain the difference between DELETE and DROP TABLE in SQL.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR needs to adjust employee salaries. Write a query projecting employee name, current salary,
--     and a new salary column showing a 15% increment.
-- Write your SQL Query below:




-- Q10. HR wants to write these changes to disk. Update 'employee1' table setting salary to salary + 15%
--      for employees whose department is 'HR'.
-- Write your SQL Query below:




-- Q11. A student changed their city. Update 'StudentInfo' setting city to 'Pune' and age to 23
--      for RollNo = 104.
-- Write your SQL Query below:




-- Q12. Perform data cleaning: Delete all students from 'StudentInfo' who do not have a mobile number
--      and whose marks are NULL.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the logic error in this update query:
--      UPDATE StudentInfo SET city = 'Nagpur' WHERE city = NULL;
-- Write your corrected SQL Query below:




-- Q14. Explain why running 'SELECT RollNo, marks / 2 AS HalfMarks FROM StudentInfo' does not alter
--      the actual marks on disk.
-- Write your explanation below:\n