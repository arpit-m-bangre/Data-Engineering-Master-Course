/*============================================================
       DAY 13 PRACTICE QUESTIONS - 14 AUGUST 2026
       TOPICS: SET OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT), VALIDATION RULES
============================================================*/

-- SECTION 1: BASIC SYNTAX DRILLS (Q1 - Q4)
-- ------------------------------------------------------------

-- Q1. Write a query using UNION to combine 'id' from 'Newset1' and 'custid' from 'Newset2'.
-- Write your SQL Query below:




-- Q2. Write a query using UNION ALL to combine 'id' from 'Newset1' and 'custid' from 'Newset2'.
-- Write your SQL Query below:




-- Q3. Write a query using INTERSECT to find common values between 'id' in 'Newset1' and 'custid' in 'Newset2'.
-- Write your SQL Query below:




-- Q4. Write a query using EXCEPT to find IDs in 'Newset1' that are not present in 'Newset2'.
-- Write your SQL Query below:





-- SECTION 2: CUMULATIVE REVISION (Q5 - Q8)
-- ------------------------------------------------------------

-- Q5. Select RollNo from 'StudentInfo' INTERSECT select empid from 'emp'.
-- Write your SQL Query below:




-- Q6. Write a query to combine names from two tables, removing duplicate rows.
-- Write your SQL Query below:




-- Q7. Explain the validation rules regarding the number of columns and data types in Set Operators.
-- Write your explanation below:




-- Q8. Explain the difference in execution speed between UNION and UNION ALL.
-- Write your explanation below:





-- SECTION 3: ENTERPRISE SCENARIO CHALLENGES (Q9 - Q12)
-- ------------------------------------------------------------

-- Q9. Bank Branch Merger: You have customer tables from BranchA (id, name, city) and BranchB (custid, name, city).
--     Write a query to combine them into a single unique customer database using UNION.
-- Write your SQL Query below:




-- Q10. Transaction logs audit: Combine transaction logs from UPI payments and Card payments tables
--      retaining all duplicate logs (keep all records).
-- Write your SQL Query below:




-- Q11. Customer Churn analysis: Select all customer IDs from the 'Customers' table EXCEPT customer IDs
--      who placed orders in the 'Orders' table.
-- Write your SQL Query below:




-- Q12. Retain common clients: Find the names of clients who are present in both the 'Prospects' and 'ActiveClients' tables.
-- Write your SQL Query below:





-- SECTION 4: LOGIC BUILDER & DEBUGGING (Q13 - Q14)
-- ------------------------------------------------------------

-- Q13. Identify and fix the syntax error: The developer wants to union two tables but wrote:
--      SELECT id, name FROM Newset1
--      UNION
--      SELECT custid FROM Newset2;
--      Why does this fail, and how do you fix it?
-- Write your corrected SQL Query and explanation below:




-- Q14. Explain why Set Operators evaluate columns by their sequence order rather than their column names.
-- Write your explanation below:\n