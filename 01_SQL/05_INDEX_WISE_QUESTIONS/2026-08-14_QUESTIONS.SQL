/*============================================================
        DAY 13 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: SET OPERATORS (UNION, ALL, INTERSECT, EXCEPT)
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('Newset1', 'U') IS NOT NULL DROP TABLE Newset1;
CREATE TABLE Newset1 (
    id INT,
    name VARCHAR(10)
);

IF OBJECT_ID('Newset2', 'U') IS NOT NULL DROP TABLE Newset2;
CREATE TABLE Newset2 (
    custid INT,
    dept VARCHAR(10)
);

INSERT INTO Newset1 VALUES (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D');
INSERT INTO Newset2 VALUES (2, 'HR'), (3, 'Entc'), (4, NULL), (5, NULL);


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




-- Q5. Select id from Newset1
--     UNION select custid from Newset2.
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

-- Q11. Database Merging Operations:
--      Q11.1. Select all customer IDs from BranchA.
--      Q11.2. Select all customer IDs from BranchB.
--      Q11.3. Combine them using UNION.
--      Q11.4. Combine them using UNION ALL.
-- Write your SQL Queries below:




-- Q12. Financial Transaction Auditing:
--      Q12.1. Select transaction amounts from UPI payments.
--      Q12.2. Select transaction amounts from Card payments.
--      Q12.3. Combine UPI & Card transaction amounts.
--      Q12.4. Return only common transaction amounts (INTERSECT).
-- Write your SQL Queries below:




-- Q13. Customer Churn Analysis:
--      Q13.1. Select customer IDs from Customers table.
--      Q13.2. Select customer IDs who placed orders in Orders.
--      Q13.3. Retrieve customer IDs who have never ordered (EXCEPT).
--      Q13.4. Retrieve common customer IDs who ordered (INTERSECT).
-- Write your SQL Queries below:




-- Q14. Client Database Consolidation:
--      Q14.1. Select all prospective client names.
--      Q14.2. Select all active client names.
--      Q14.3. Find prospective clients who became active.
--      Q14.4. Find prospective clients who are NOT active.
-- Write your SQL Queries below:




-- Q15. Regional Office Synchronization:
--      Q15.1. Select unique cities from BranchA logs.
--      Q15.2. Select unique cities from BranchB logs.
--      Q15.3. Find cities common to both branches (INTERSECT).
--      Q15.4. Find cities unique to BranchA only (EXCEPT).
-- Write your SQL Queries below:





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