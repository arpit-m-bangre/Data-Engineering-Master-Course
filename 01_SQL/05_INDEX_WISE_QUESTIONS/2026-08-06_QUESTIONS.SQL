/*============================================================
        DAY 6 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: AGGREGATE FUNCTIONS, DISTINCT, TOP
============================================================*/

-- ============================================================
-- ⚙️ PHASE 0: ENVIRONMENT SETUP & SEED DATA (RUN IN SSMS FIRST)
-- ============================================================

-- Table 1: practice_day6 (Employees Master)
IF OBJECT_ID('practice_day6', 'U') IS NOT NULL DROP TABLE practice_day6;
CREATE TABLE practice_day6 (
    empid INT PRIMARY KEY,
    empname VARCHAR(50) NOT NULL,
    org_id VARCHAR(20),  -- 'HR', 'IT', 'Entc', 'Stat', NULL
    salary INT NOT NULL,
    status VARCHAR(20)   -- 'Active', 'On Leave', 'Contract'
);

INSERT INTO practice_day6 (empid, empname, org_id, salary, status) VALUES 
(101, 'Amit Sharma',      'HR',   2000, 'Active'),
(102, 'Puja Patel',       'Entc', 3000, 'Active'),
(103, 'Arpit Bangre',     'Stat', 4000, 'On Leave'),
(104, 'Sidhant Deshmukh', 'HR',   5000, 'Active'),
(105, 'Mohit Verma',      NULL,   6000, 'Contract'),
(106, 'Sneha Rao',        'IT',   7500, 'Active'),
(107, 'Rahul Mehra',      'IT',   8200, 'Active'),
(108, 'Ananya Sen',       'Stat', 4500, 'Contract'),
(109, 'Vikas Roy',        'Entc', 3200, 'On Leave'),
(110, 'Pooja Nair',       'HR',   5500, 'Active');

-- Table 2: students (Academic Records Master)
IF OBJECT_ID('students', 'U') IS NOT NULL DROP TABLE students;
CREATE TABLE students (
    RollNo INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    marks INT NOT NULL,
    city VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    subject VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

INSERT INTO students (RollNo, name, marks, city, email, subject, age) VALUES 
(1, 'Aarav Gupta',    92, 'Nagpur',    'aarav@gmail.com',  'Stat', 21),
(2, 'Diya Sen',       85, 'Pune',      'diya@yahoo.com',   'Maths', 22),
(3, 'Kabir Mehta',    78, 'Nagpur',    NULL,               'Stat', 20),
(4, 'Ishita Sharma',  95, 'Mumbai',    'ishita@gmail.com', 'Stat', 23),
(5, 'Rohan Joshi',    64, 'Nagpur',    NULL,               'Physics', 21),
(6, 'Tanvi Kulkarni', 88, 'Pune',      'tanvi@gmail.com',  'Stat', 22),
(7, 'Yash Patil',     72, 'Bengaluru', 'yash@live.com',    'Maths', 20),
(8, 'Ananya Roy',     81, 'Nagpur',    'ananya@gmail.com', 'Stat', 21),
(9, 'Karan Malhotra', 59, 'Hyderabad', NULL,               'Physics', 24),
(10,'Simran Kaur',    90, 'Delhi',     'simran@gmail.com', 'Stat', 22);

-- Verify Seed Tables
SELECT * FROM practice_day6;
SELECT * FROM students;


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Display minimum, maximum,
--     and average salary together.
-- Write your SQL Query below:

select 
    min(salary) as minimum_salary ,
    max(salary) as maximum_salary,
    avg(salary) as avg_salary
from practice_day6


-- Q2. Find the total number of
--     rows using COUNT(*).
-- Write your SQL Query below:

select count(*) from practice_day6

-- Q3. Find unique departments
--     using DISTINCT.
-- Write your SQL Query below:

select distinct org_id from practice_day6

-- Q4. Select the TOP 3 highest
--     salaries from 'emp'.
-- Write your SQL Query below:

select top 3 salary from practice_day6


-- Q5. Find sum of all salaries.
-- Write your SQL Query below:


select sum(salary) as sum_of_all_salaries from practice_day6


-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Display RollNo and marks
--     for TOP 5 students.
-- Write your SQL Query below:

select * from practice_day6


-- Q7. Find average marks of
--     students living in 'Nagpur'.
-- Write your SQL Query below:




-- Q8. Find count of students
--     without an email ID.
-- Write your SQL Query below:




-- Q9. Select unique city values.
-- Write your SQL Query below:




-- Q10. Explain COUNT(col) vs
--      COUNT(*) with NULLs.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. HR Payroll Summaries:
--      Q11.1. Calculate total budget (SUM)
--             for 'IT' department.
--      Q11.2. Calculate average salary (AVG)
--             for 'HR' department.
-- Write your SQL Queries below:




-- Q12. Alphabetical Extreme Limits:
--      Q12.1. Find alphabetical minimum
--             employee name in database.
--      Q12.2. Find alphabetical maximum
--             employee name in database.
-- Write your SQL Queries below:




-- Q13. Unicity Verification Checks:
--      Q13.1. Select unique statuses
--             using DISTINCT.
--      Q13.2. Count unique statuses.
-- Write your SQL Queries below:




-- Q14. Null Data Analysis:
--      Q14.1. Count unique departments
--             that are NOT NULL.
--      Q14.2. Count unique departments
--             including NULLs (via COUNT(*)).
-- Write your SQL Queries below:




-- Q15. High-Value Boundary Audits:
--      Q15.1. Find total students who
--             scored > 80 in subject 'Stat'.
--      Q15.2. Find average age of
--             students in 'Nagpur'.
-- Write your SQL Queries below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Correct the syntax error:
--      SELECT dept, AVG(salary)
--      FROM emp;
-- Write your corrected Query below:




-- Q17. Explain why SQL Server
--      lacks a BOTTOM keyword.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT DISTINCT(empname),
--      DISTINCT(org_id) FROM emp;
-- Write your corrected Query below:




-- Q19. Why does 'SELECT *, SUM(sal)'
--      fail in a query?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT COUNT(DISTINCT *) FROM emp;
-- Write your corrected Query below:\n