/*============================================================
        DAY 11 PRACTICE QUESTIONS
        STRUCTURE: 6 QUESTIONS / 24 SUBQUESTIONS
        TOPICS: PARENT-CHILD DESTRUCTION RULES
============================================================*/

-- ============================================================
-- QUESTION 1: BASIC SYNTAX DRILLS
-- ============================================================

-- Q1.1. Drop child table 'Staff_FK'.
-- Write your SQL Query below:




-- Q1.2. Drop parent table
--      'Departments_PK' afterwards.
-- Write your SQL Query below:




-- Q1.3. Create parent table 'Branch'
--      with BranchID (INT PRIMARY KEY).
-- Write your SQL Query below:




-- Q1.4. Create child table 'Member'
--      with MemberID (INT PRIMARY KEY),
--      BranchID (INT FK REFERENCES Branch).
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 2: OPERATOR & FILTERING CHECKS
-- ============================================================

-- Q2.1. Insert 3 branches and 3
--      members into database tables.
-- Write your SQL Queries below:




-- Q2.2. Delete member from child table.
--      Does this succeed?
-- Write your SQL Query and explanation:




-- Q2.3. Try to TRUNCATE parent 'Branch'.
--      Does it fail or succeed?
-- Write your SQL Query and explanation:




-- Q2.4. Drop the 'Member' child table.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 3: CUMULATIVE REVISION
-- ============================================================

-- Q3.1. Display metadata for all
--      active foreign key constraints.
-- Write your SQL Query below:




-- Q3.2. Explain why dropping child
--      unlocks parent drop block.
-- Write your explanation below:




-- Q3.3. Verify if a primary key
--      can be dropped while referenced.
-- Write your explanation below:




-- Q3.4. Show the count of active tables
--      in the user database schema.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 4: ENTERPRISE SCENARIO CHALLENGE A
-- ============================================================

-- Q4.1. HR Cleanup: Clear 'Member'
--      rows and then delete a branch.
-- Write your SQL Queries below:




-- Q4.2. Select all remaining rows
--      from member and branch tables.
-- Write your SQL Queries below:




-- Q4.3. Empty child table. Try to
--      TRUNCATE the parent 'Branch'.
-- Write your SQL Query and explanation:




-- Q4.4. Show all tables in the current
--      database catalog.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 5: ENTERPRISE SCENARIO CHALLENGE B
-- ============================================================

-- Q5.1. Create child table 'SalesLog'
--      referencing branch table.
-- Write your SQL Query below:




-- Q5.2. Insert branch records and
--      matching sales log rows.
-- Write your SQL Queries below:




-- Q5.3. Drop the foreign key constraint
--      between branch and sales log.
-- Write your SQL Query below:




-- Q5.4. Truncate parent branch table
--      after constraint is dropped.
-- Write your SQL Query below:





-- ============================================================
-- QUESTION 6: LOGIC BUILDER & DEBUGGING
-- ============================================================

-- Q6.1. Debug parent truncation block:
--      DELETE FROM Member;
--      TRUNCATE TABLE Branch;
--      Why does truncate fail?
-- Write your explanation and fix below:




-- Q6.2. Explain why DELETE is allowed
--      on parent (if no child links)
--      but TRUNCATE is blocked.
-- Write your explanation below:




-- Q6.3. Correct the syntax error:
--      DROP parent_table CASCADE;
-- Write your corrected Query below:




-- Q6.4. Why does SQL Server check
--      for constraint existence
--      rather than row counts?
-- Write your explanation below:\n