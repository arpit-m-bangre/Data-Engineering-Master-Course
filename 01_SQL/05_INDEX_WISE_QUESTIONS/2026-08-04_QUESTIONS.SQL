/*============================================================
        DAY 4 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: ARITHMETIC, UPDATE, DELETE, DROP
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day4', 'U') IS NOT NULL DROP TABLE practice_day4;
CREATE TABLE practice_day4 (
    roll_no INT,
    name VARCHAR(30),
    subject VARCHAR(15),
    marks INT,
    age INT,
    mobile_no VARCHAR(20)
);

INSERT INTO practice_day4 (roll_no, name, subject, marks, age, mobile_no) VALUES 
(101, 'Arpit', 'Physics', 65, 22, '992342352'),
(102, 'Rahul', 'Maths', 72, 21, '987654321'),
(103, 'Sneha', 'Computer', 88, 20, NULL),
(104, 'Aman', 'Art', 90, 23, '765432109');


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Project marks and a new
--     column 'IncMarks' (marks+5).
-- Write your SQL Query below:




-- Q2. Update the subject of all
--     students with RollNo = 101
--     to 'Data Engineering'.
-- Write your SQL Query below:




-- Q3. Delete student with
--     RollNo = 105.
-- Write your SQL Query below:




-- Q4. Write query to drop
--     table 'student_dumy'.
-- Write your SQL Query below:




-- Q5. Project salary decreased
--     by 20% from 'employee1'.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Select students with marks
--     > 80 after a 10 grace marks.
-- Write your SQL Query below:




-- Q7. Set marks to NULL for
--     students who scored < 40.
-- Write your SQL Query below:




-- Q8. Select students whose name
--     has 'a' and subject is
--     'Data Engineering'.
-- Write your SQL Query below:




-- Q9. Update student marks to
--      marks * 2 where roll is 102.
-- Write your SQL Query below:




-- Q10. Explain the difference
--      between DELETE and DROP.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Project candidate name,
--      salary, and a new salary
--      showing a 15% increment.
-- Write your SQL Query below:




-- Q12. Update salary to salary+15%
--      for all 'HR' employees.
-- Write your SQL Query below:




-- Q13. Update subject to 'Pune' and
--      age to 23 for RollNo = 104.
-- Write your SQL Query below:




-- Q14. Delete all students who
--      have no mobile number
--      and marks are NULL.
-- Write your SQL Query below:




-- Q15. Delete employees whose
--      salary is < 2000.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the query:
--      UPDATE StudentInfo
--      SET city = 'Nagpur'
--      WHERE city = NULL;
-- Write your corrected Query below:




-- Q17. Explain why projecting
--      marks/2 does not change
--      actual marks on disk.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      UPDATE emp SET (salary = 5000)
--      WHERE id = 101;
-- Write your corrected Query below:




-- Q19. Why is transaction rollback
--      possible with DELETE but
--      typically restricted?
-- Write your explanation below:




-- Q20. Correct the syntax error:
--      DELETE * FROM emp;
-- Write your corrected Query below:\n