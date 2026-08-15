/*============================================================
        DAY 3 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: COMPLEX WHERE FILTERS, MULTIPLE CONDITIONS
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day3', 'U') IS NOT NULL DROP TABLE practice_day3;
CREATE TABLE practice_day3 (
    roll_no INT,
    name VARCHAR(30),
    city VARCHAR(30),
    subject VARCHAR(15),
    marks INT,
    age INT,
    email_id VARCHAR(40)
);

INSERT INTO practice_day3 (roll_no, name, city, subject, marks, age, email_id) VALUES 
(101, 'Arpit', 'Nagpur', 'Stat', 65, 22, 'arpit.m.bangre@gmail.com'),
(102, 'Rahul', 'Pune', 'Maths', 72, 21, NULL),
(103, 'Sneha', 'Mumbai', 'Maths', 88, 20, 'sneha.joshi@gmail.com'),
(104, 'Aman', 'Delhi', 'Delhi', 69, 23, 'aman.verma@gmail.com');


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Select students not
--     living in 'Pune' or 'Mumbai'.
-- Write your SQL Query below:




-- Q2. Select students whose
--     marks are < 60 or NULL.
-- Write your SQL Query below:




-- Q3. Select students whose
--     names end with 'a' or 'i'.
-- Write your SQL Query below:




-- Q4. Select students whose
--     roll_no ends with 2.
-- Write your SQL Query below:




-- Q5. Select students whose
--     age is strictly > 21.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Select RollNo and Name
--     where subject is 'Stat'.
-- Write your SQL Query below:




-- Q7. Select students whose
--     subject starts with 'M'
--     and marks are > 70.
-- Write your SQL Query below:




-- Q8. Find students whose age
--     is NOT NULL and city is
--     'Nagpur' or 'Indore'.
-- Write your SQL Query below:




-- Q9. Select all students whose
--     email is not NULL.
-- Write your SQL Query below:




-- Q10. Explain what '_m%'
--      wildcard pattern matches.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Find student emails ending
--      with '.com' but missing '@'.
-- Write your SQL Query below:




-- Q12. Find students with marks
--      50-80, and city starts
--      with 'N' or 'A'.
-- Write your SQL Query below:




-- Q13. Retrieve students whose
--      names start with 'A' to 'M'.
-- Write your SQL Query below:




-- Q14. Find students where city is
--      not 'Nagpur' and subject
--      is not 'Maths'.
-- Write your SQL Query below:




-- Q15. Retrieve students whose
--      marks are NULL or 0.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the query:
--      SELECT * FROM StudentInfo
--      WHERE city = 'Nagpur' OR
--      city = 'Pune' AND marks > 80;
--      Force city filter first.
-- Write your corrected Query below:




-- Q17. Explain why 'IS NULL' is
--      used instead of '= NULL'.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT * FROM StudentInfo
--      WHERE Name LIKE 'A%' AND 'B%';
-- Write your corrected Query below:




-- Q19. Why does 'LIKE '%'' not
--      return rows with NULL values?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT Name FROM StudentInfo
--      WHERE Marks BETWEEN 80, 90;
-- Write your corrected Query below:\n