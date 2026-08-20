/*================================================================
   SQL CLASS NOTES - 7 AUGUST 2026 (DAY 4)
   TOPICS: GROUP BY, HAVING, ORDER BY
==================================================================*/

/*================================================================
1. BASIC GROUP BY
==================================================================*/
-- Note: Execution order is FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

SELECT dept, SUM(salary) AS total_salary
FROM emp
GROUP BY dept;

/*================================================================
2. GROUP BY WITH WHERE
==================================================================*/
SELECT dept, SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL AND empname LIKE '%a%'
GROUP BY dept;

/*================================================================
3. IN-CLASS TASK: student_dumy
==================================================================*/
IF OBJECT_ID('student_dumy', 'U') IS NOT NULL DROP TABLE student_dumy;
CREATE TABLE student_dumy (id INT, name VARCHAR(10), city VARCHAR(10), age INT);
INSERT INTO student_dumy VALUES (1, 'arpit', 'nagpur', 22), (2, 'rahul', 'pune', 24);

SELECT city, COUNT(id) AS student_count, AVG(age) AS age_avg
FROM student_dumy
WHERE city IS NOT NULL AND age BETWEEN 18 AND 30
GROUP BY city;

/*================================================================
4. HAVING (FILTERING AGGREGATES)
==================================================================*/
/* Theory: WHERE filters rows before grouping. HAVING filters aggregates after grouping. */

SELECT dept, SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL AND empname LIKE '%a%'
GROUP BY dept
HAVING SUM(salary) > 2000;

-- ALIAS WITH HAVING: Fails because SELECT runs after HAVING
-- SELECT dept, SUM(salary) AS total_salary FROM emp GROUP BY dept HAVING total_salary > 2000; -- ERROR

/*================================================================
5. IN-CLASS TASK: student_dumy2 (MULTIPLE CONDITIONS)
==================================================================*/
IF OBJECT_ID('student_dumy2', 'U') IS NOT NULL DROP TABLE student_dumy2;
CREATE TABLE student_dumy2 (id INT, name VARCHAR(10), sub VARCHAR(10), marks INT, age INT);
INSERT INTO student_dumy2 VALUES 
(1, 'arpit', 'Maths', 40, 22), (2, 'rahul', 'Maths', 42, 21), (3, 'rohit', 'Maths', 45, 23),
(4, 'ravi', 'Maths', 48, 22), (5, 'raj', 'Maths', 44, 24), (6, 'rakesh', 'Maths', 46, 21);

SELECT sub, AVG(marks) AS avg_marks, COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35 AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50 AND COUNT(id) > 5;

/*================================================================
6. ORDER BY (SORTING)
==================================================================*/
SELECT * FROM emp ORDER BY salary ASC;  -- Default
SELECT * FROM emp ORDER BY salary DESC;

-- Can order by columns not in SELECT
SELECT empname FROM emp ORDER BY salary DESC;

-- Alias with ORDER BY works because ORDER BY runs AFTER SELECT
SELECT sub, AVG(marks) AS avg_marks, COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35 AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50 AND COUNT(id) > 5
ORDER BY avg_marks;

/* 
   Theory Scenarios:
   1. `SELECT MAX(salary) FROM emp;` -> 0 clauses needed.
   2. `SELECT dept FROM emp WHERE id = 2 ORDER BY id;` -> ERROR if 'id' not in table.
*/

/*================================================================
7. FACULTY HOMEWORK (SUMEDHA MA'AM)
==================================================================*/
/*
   Faculty Homework: See 04_CLASS_TASKS/2026-08-07_CLASS_TASK.SQL
   (9 scenario-based questions assigned for home practice)
*/
