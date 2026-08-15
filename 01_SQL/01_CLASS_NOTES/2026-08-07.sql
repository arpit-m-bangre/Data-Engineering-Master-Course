/* ================================================================================
   SQL CLASS NOTES - 07 AUGUST 2026 (DAY 7)
   TOPICS: GROUP BY WITH WHERE/HAVING, CLAUSE EXECUTION SEQUENCE, ORDER BY, ALIASING
   ================================================================================ */

-- ------------------------------------------------------------
-- SEQUENCE OF EXECUTION (How SQL Server actually runs queries)
-- ------------------------------------------------------------
-- Real Execution Order:
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--
-- Why it matters: 
-- You cannot filter an alias in WHERE or HAVING because SELECT (which defines the alias) runs AFTER them!
-- You CAN use aliases in ORDER BY because ORDER BY runs last.

SELECT * FROM emp;

-- Rename org_id to dept (Metadata adjustment)
-- EXEC sp_rename 'emp.org_id', 'dept';

-- 1. BASIC GROUP BY
SELECT dept, SUM(salary) AS total_salary
FROM emp
GROUP BY dept;

-- 2. GROUP BY WITH WHERE (Filter individual rows BEFORE grouping)
SELECT dept, SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL
GROUP BY dept;

SELECT dept, SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL AND empname LIKE '%a%'
GROUP BY dept;

-- 3. IN-CLASS TASK (City-wise student count)
CREATE TABLE student_dumy
(
    id   INT,
    name VARCHAR(10),
    city VARCHAR(10),
    age  INT
);

INSERT INTO student_dumy VALUES 
(1, 'arpit', 'nagpur', 22),
(1, 'arpit', 'nagpur', 22);

SELECT city, COUNT(id) AS student_count
FROM student_dumy
WHERE city IS NOT NULL AND age BETWEEN 18 AND 30
GROUP BY city;

-- GROUP BY with multiple aggregates
SELECT city, COUNT(id) AS student_count, AVG(age) AS age_avg
FROM student_dumy
WHERE city IS NOT NULL AND age BETWEEN 18 AND 30
GROUP BY city;

-- 4. HAVING CLAUSE (The Group Filter)
-- Analogy: WHERE is the bouncer filtering individual guests. HAVING is the manager filtering entire tables.
-- Rule: Use HAVING to filter on aggregated columns (like SUM, AVG, COUNT). Use WHERE to filter normal columns.

SELECT dept, SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL AND empname LIKE '%a%'
GROUP BY dept
HAVING SUM(salary) > 2000;

-- ⚠️ ALIAS LIMITATION:
-- The query below fails because HAVING runs BEFORE SELECT defines 'total_salary'!
-- SELECT dept, SUM(salary) AS total_salary FROM emp GROUP BY dept HAVING total_salary > 2000;

-- 5. IN-CLASS DRILL (Subject-wise analysis)
CREATE TABLE student_dumy2
(
    id    INT,
    name  VARCHAR(10),
    sub   VARCHAR(10),
    marks INT,
    age   INT
);

INSERT INTO student_dumy2 (id, name, sub, marks, age) VALUES
    (1,  'arpit',       'Maths',    40, 22),
    (2,  'rahul',       'Maths',    42, 21),
    (3,  'rohit',       'Maths',    45, 23),
    (4,  'ravi',        'Maths',    48, 22),
    (5,  'raj',         'Maths',    44, 24),
    (6,  'rakesh',      'Maths',    46, 21),
    (7,  'aman',        'Maths',    50, 22),
    (8,  'priya',       'Maths',    52, 23),
    (9,  'neha',        'Maths',    60, 21),
    (10, 'rohan',       'Science',  38, 22),
    (11, 'rahul',       'Science',  41, 21),
    (12, 'ravi',        'Science',  43, 23),
    (13, 'rohit',       'Science',  47, 22),
    (14, 'raj',         'Science',  45, 24),
    (15, 'rakesh',      'Science',  49, 21),
    (16, 'arpit',       'Science',  55, 22),
    (17, 'aman',        'Science',  65, 23),
    (18, 'neha',        'Science',  70, 21),
    (19, 'rahul',       'English',  36, 22),
    (20, 'rohit',       'English',  39, 21),
    (21, 'ravi',        'English',  42, 23),
    (22, 'raj',         'English',  44, 22),
    (23, 'rakesh',      'English',  46, 24),
    (24, 'rohan',       'English',  48, 21),
    (25, 'arpit',       'English',  72, 22),
    (26, 'aman',        'English',  75, 23),
    (27, 'arpit',       'Computer', 80, 22),
    (28, 'rahul',       'Computer', 82, 21),
    (29, 'rohit',       'Computer', 78, 23),
    (30, 'ravi',        'Computer', 85, 22),
    (31, 'raj',         'Computer', 88, 24),
    (32, 'rakesh',      'Computer', 90, 21),
    (33, 'rohan',       'Computer', 92, 22),
    (34, 'aman',        'Computer', 75, 23),
    (35, 'rahul',       'History',  40, 22),
    (36, 'rohit',       'History',  42, 21),
    (37, 'ravi',        'History',  45, 23),
    (38, 'raj',         'History',  47, 22),
    (39, 'rakesh',      'History',  44, 24),
    (40, 'rohan',       'History',  46, 21),
    (41, 'arpit',       'History',  48, 22),
    (42, 'aman',        'History',  55, 23),
    (43, 'rohit',       'Maths',    30, 22),
    (44, 'rahul',       'Science',  25, 21),
    (45, 'ravi',        'English',  35, 23),
    (46, 'aman',        'Maths',    40, 22),
    (47, 'neha',        'Science',  45, 21),
    (48, 'priya',       'English',  48, 23),
    (49, 'sneha',       'History',  42, 22),
    (50, 'rohan',       'Maths',    95, 22),
    (51, 'rahul',       'Science',  98, 21),
    (52, 'ravi',        'English',  96, 23);

-- Subject-wise average marks and count where marks > 35 and name contains 'r'
SELECT sub, AVG(marks) AS avg_marks, COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35 AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50 AND COUNT(id) > 5;

-- 6. ORDER BY (Sorting results)
-- Sort values in Ascending (ASC - default) or Descending (DESC) order.
SELECT * FROM emp ORDER BY salary ASC;
SELECT * FROM emp ORDER BY salary DESC;
SELECT empname FROM emp ORDER BY salary DESC;

-- 7. INDEPENDENT CLAUSE RULE (WHERE & ORDER BY can sort columns not displayed in SELECT)
SELECT dept FROM emp WHERE salary > 5000 ORDER BY salary DESC;

-- Tricky Question: How many clauses can be added to: SELECT MAX(salary) FROM emp;
-- Answer: Zero! It already returns 1 row for the whole table. No grouping, filtering, or sorting is needed.

-- ORDER BY with GROUP BY & HAVING (ORDER BY runs LAST, so it can use the 'avg_marks' alias!)
SELECT sub, AVG(marks) AS avg_marks, COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35 AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50 AND COUNT(id) > 5
ORDER BY avg_marks;

-- ------------------------------------------------------------
-- ENTERPRISE PRACTICE QUESTIONS (Sumedha Ma'am's Task)
-- ------------------------------------------------------------
-- 1. Total salary per department for employees who joined after 2020 (total salary > 3,00,000, desc order).
-- 2. Total sales by salesperson for products priced > 500 (total sales > 50,000, alphabetically sorted).
-- 3. Count 2023 orders per customer where amount > 1000 (at least 5 orders, order count desc).
-- 4. Average product category price with stock > 50 (avg price > 2000, category name sorted).
-- 5. Total transactions per customer using UPI/Credit Card (total transaction > 10,000, customer id asc).
-- 6. Minimum room price per hotel for bookings > 2 nights (minimum price < 1500, min price asc).
-- 7. Count plan subscribers in India/Nepal (at least 200 subscribers, sorted by subscriber count).
-- 8. Total stock per supplier for non-expired items (stock sum > 1000, supplier name desc).
-- 9. Group expenses by type where expense is between 500 and 5000 (average expense > 1000, average desc).
