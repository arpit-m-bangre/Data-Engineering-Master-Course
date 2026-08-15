/*============================================================
        DAY 13 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: SET OPERATORS (UNION, ALL, INTERSECT, EXCEPT)
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Write UNION to combine 'id'
--      from Newset1 & Newset2.
-- Write your SQL Query below:




-- Q1.2. Write UNION ALL to combine
--      'id' from Newset1 & Newset2.
-- Write your SQL Query below:




-- Q1.3. Write INTERSECT to find
--      common IDs between tables.
-- Write your SQL Query below:




-- Q1.4. Write EXCEPT to find IDs in
--      Newset1 not in Newset2.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Select RollNo from StudentInfo
--      UNION select empid from emp.
-- Write your SQL Query below:




-- Q2.2. Combine student & emp names,
--      removing duplicate rows.
-- Write your SQL Query below:




-- Q2.3. Explain rules for columns
--      and types in Set Operators.
-- Write your explanation below:




-- Q2.4. Explain speed difference
--      between UNION and UNION ALL.
-- Write your explanation below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Show INTERSECT output when
--      one table has NULL values.
-- Write your SQL Query below:




-- Q3.2. Combine names keeping all
--      duplicate records.
-- Write your SQL Query below:




-- Q3.3. Verify if UNION combines
--      columns with different names.
-- Write your explanation below:




-- Q3.4. Show count of output rows in
--      UNION vs UNION ALL.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. Branch Merger: Combine
--      BranchA (id, name) and
--      BranchB (custid, name)
--      using UNION.
-- Write your SQL Query below:




-- Q4.2. Logs audit: Combine UPI & Card
--      payments keeping all duplicates.
-- Write your SQL Query below:




-- Q4.3. Churn: Customer IDs from
--      Customers EXCEPT those in Orders.
-- Write your SQL Query below:




-- Q4.4. Common clients: Find names
--      in prospects & active tables.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Combine distinct city logs
--      from two branch offices.
-- Write your SQL Query below:




-- Q5.2. Select all employee IDs
--      INTERSECT student IDs.
-- Write your SQL Query below:




-- Q5.3. Show transaction amounts
--      from prospects EXCEPT active.
-- Write your SQL Query below:




-- Q5.4. Combine branch logs and
--      sort output by branch name.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug the UNION query error:
--      SELECT id, name FROM Newset1
--      UNION
--      SELECT custid FROM Newset2;
--      Make schemas match.
-- Write your corrected Query below:




-- Q6.2. Explain why Set Operators
--      evaluate column order sequence
--      rather than column names.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      SELECT name FROM Newset1
--      INTERSECT SELECT dept
--      ORDER BY Newset1.name;
-- Write your corrected Query below:




-- Q6.4. Why does EXCEPT ignore duplicate
--      records in the output?
-- Write your explanation below:\n