/*============================================================
       DAY 3 PRACTICE QUESTIONS - 3 AUGUST 2026
       TOPICS: COMPLEX WHERE FILTERS, MULTIPLE CONDITIONS, WILDCARD PATTERNS
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Select all students from 'StudentInfo' who do not live in 'Pune' or 'Mumbai'.
-- Write your SQL Query below:




-- Q2. Write a query to find all students whose marks are less than 60 or are NULL.
-- Write your SQL Query below:




-- Q3. Write a query to find all students whose names end with the letter 'a' or 'i'.
-- Write your SQL Query below:




-- Q4. Select all students whose mobile number ends with the digit 5.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select RollNo and Name from 'StudentInfo' where the subject is 'Stat' and age is 22.
-- Write your SQL Query below:




-- Q6. Write a query to find all students whose subject starts with 'M' and marks are greater than 70.
-- Write your SQL Query below:




-- Q7. Find all students whose age is not NULL and city is either 'Nagpur' or 'Indore'.
-- Write your SQL Query below:




-- Q8. Explain what the wildcard pattern '_m%' matches when used in a LIKE clause.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. HR needs to audit student emails. Select all students whose email ends with '.com'
--     but does not contain the '@' symbol.
-- Write your SQL Query below:




-- Q10. Sales audit: Find students whose marks are between 50 and 80, and their city starts with 'N' or 'A'.
-- Write your SQL Query below:




-- Q11. Retrieve students whose names start with letters from 'A' to 'M' (inclusive).
-- Write your SQL Query below:




-- Q12. Find all students whose city is NOT 'Nagpur' and their subject is not 'Maharashtra'.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Debug the following query which conflicts logical operators:
--      SELECT * FROM StudentInfo WHERE city = 'Nagpur' OR city = 'Pune' AND marks > 80;
--      Ensure that the city filter is evaluated as a combined group before checking marks.
-- Write your corrected SQL Query below:




-- Q14. Explain why 'WHERE email_id = NULL' returns 0 rows even if there are rows with NULL emails.
-- Write your explanation below:\n