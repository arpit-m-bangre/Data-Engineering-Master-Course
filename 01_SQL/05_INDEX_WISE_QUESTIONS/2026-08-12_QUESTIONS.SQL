/*============================================================
        DAY 11 PRACTICE QUESTIONS
        STRUCTURE: 20 QUESTIONS / HYBRID LAYOUT
        TOPICS: PARENT-CHILD DESTRUCTION RULES
============================================================*/

-- ============================================================
-- 0. ENVIRONMENT SETUP (RUN THIS IN SSMS FIRST)
-- ============================================================

IF OBJECT_ID('practice_day11', 'U') IS NOT NULL DROP TABLE practice_day11;
CREATE TABLE practice_day11 (
    id INT
);


-- ============================================================
-- PHASE 1: BASIC SYNTAX DRILLS (Q1 - Q5)
-- ============================================================

-- Q1. Drop child table 'Staff_FK'.
-- Write your SQL Query below:




-- Q2. Drop parent table
--     'Departments_PK' afterwards.
-- Write your SQL Query below:




-- Q3. Create parent table 'Branch'
--     with BranchID (INT PRIMARY KEY).
-- Write your SQL Query below:




-- Q4. Create child table 'Member'
--     with MemberID (INT PRIMARY KEY),
--     BranchID (INT FK REFERENCES Branch).
-- Write your SQL Query below:




-- Q5. Display metadata for all
--     active foreign key constraints.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 2: CUMULATIVE REVISION (Q6 - Q10)
-- ============================================================

-- Q6. Insert 3 branches and 3
--     members into database tables.
-- Write your SQL Queries below:




-- Q7. Delete member from child table.
--     Does this succeed?
-- Write your SQL Query and explanation:




-- Q8. Try to TRUNCATE parent 'Branch'.
--     Does it fail or succeed?
-- Write your SQL Query and explanation:




-- Q9. Drop the 'Member' child table.
-- Write your SQL Query below:




-- Q10. Explain why dropping child
--      unlocks parent drop block.
-- Write your explanation below:





-- ============================================================
-- PHASE 3: ENTERPRISE SCENARIOS (Q11 - Q15)
-- ============================================================

-- Q11. Database Auditing & Resets:
--      Q11.1. Delete all rows from child 'BranchStaff'.
--      Q11.2. Delete branch ID 10 from parent 'CompanyBranch'.
-- Write your SQL Queries below:




-- Q12. Record Validation Audits:
--      Q12.1. Select remaining rows from child.
--      Q12.2. Select remaining rows from parent.
-- Write your SQL Queries below:




-- Q13. Empty Table Truncations:
--      Q13.1. Try to TRUNCATE parent when child has 0 rows.
--             Does it fail or succeed?
--      Q13.2. Drop foreign key constraint first and truncate.
-- Write your SQL Query and explanation:




-- Q14. Show all tables in the current
--      database catalog.
-- Write your SQL Query below:




-- Q15. Create child table 'SalesLog'
--      referencing branch table.
-- Write your SQL Query below:





-- ============================================================
-- PHASE 4: LOGIC & DEBUGGING (Q16 - Q20)
-- ============================================================

-- Q16. Debug parent truncation block:
--      DELETE FROM Member;
--      TRUNCATE TABLE Branch;
--      Why does truncate fail?
-- Write your explanation and fix below:




-- Q17. Explain why DELETE is allowed
--      on parent (if no child links)
--      but TRUNCATE is blocked.
-- Write your explanation below:




-- Q18. Correct the syntax error:
--      DROP parent_table CASCADE;
-- Write your corrected Query below:




-- Q19. Why does SQL Server check
--      for constraint existence
--      rather than row counts?
-- Write your explanation below:




-- Q20. Correct the query:
--      TRUNCATE child_table REFERENCES parent;
-- Write your corrected Query below:\n