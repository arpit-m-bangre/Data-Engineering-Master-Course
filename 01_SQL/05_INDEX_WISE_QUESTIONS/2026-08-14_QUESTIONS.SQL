/*============================================================
       DAY 13 PRACTICE QUESTIONS
       TOPICS: SET OPERATORS (UNION, ALL, INTERSECT, EXCEPT)
============================================================*/

-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Write UNION to combine 'id'
--     from Newset1 & Newset2.
-- Write your SQL Query below:




-- Q2. Write UNION ALL to combine
--     'id' from Newset1 & Newset2.
-- Write your SQL Query below:




-- Q3. Write INTERSECT to find
--     common IDs between tables.
-- Write your SQL Query below:




-- Q4. Write EXCEPT to find IDs in
--     Newset1 not in Newset2.
-- Write your SQL Query below:




-- Q5. Select RollNo from StudentInfo
--     UNION select empid from emp.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Combine student & emp names,
--     removing duplicate rows.
-- Write your SQL Query below:




-- Q7. Explain rules for columns
--     and types in Set Operators.
-- Write your explanation below:




-- Q8. Explain speed difference
--     between UNION and UNION ALL.
-- Write your explanation below:




-- Q9. Show INTERSECT output when
--     one table has NULL values.
-- Write your SQL Query below:




-- Q10. Combine names keeping all
--      duplicate records.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Branch Merger: Combine
--      BranchA (id, name) and
--      BranchB (custid, name)
--      using UNION.
-- Write your SQL Query below:




-- Q12. Logs audit: Combine UPI & Card
--      payments keeping all duplicates.
-- Write your SQL Query below:




-- Q13. Churn: Customer IDs from
--      Customers EXCEPT those in Orders.
-- Write your SQL Query below:




-- Q14. Common clients: Find names
--      in prospects & active tables.
-- Write your SQL Query below:




-- Q15. Combine distinct city logs
--      from two branch offices.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug the UNION query error:
--      SELECT id, name FROM Newset1
--      UNION
--      SELECT custid FROM Newset2;
--      Make schemas match.
-- Write your corrected Query below:




-- Q17. Explain why Set Operators
--      evaluate column order sequence
--      rather than column names.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      SELECT name FROM Newset1
--      INTERSECT SELECT dept
--      ORDER BY Newset1.name;
-- Write your corrected Query below:




-- Q19. Why does EXCEPT ignore duplicate
--      records in the output?
-- Write your explanation below:




-- Q20. Correct the query:
--      SELECT * FROM Newset1 UNION
--      ALL * FROM Newset2;
-- Write your corrected Query below:\n