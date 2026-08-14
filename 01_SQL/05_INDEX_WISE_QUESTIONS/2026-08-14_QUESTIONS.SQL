-- ==============================================================================
-- 14-QUESTION PRACTICE DRILLS: DAY 13 (SET OPERATORS)
-- ==============================================================================
-- INSTRUCTIONS:
-- Write your answers in the blank space below each question.
-- Do NOT look at the answers. Test your logic!
-- ==============================================================================

-- ==============================================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ==============================================================================

-- Q1: You have two tables: `Managers` (ManagerID, Name) and `Employees` (EmpID, Name).
-- Write a query to get a single combined list of ALL names, without any duplicates.
-- Write your SQL Query below:



-- Q2: Modify the query from Q1 so that it runs faster and keeps every single 
-- duplicate name in the final output.
-- Write your SQL Query below:



-- Q3: Write a query to find only the names of people who are BOTH a Manager 
-- and an Employee (i.e., their name appears in both tables).
-- Write your SQL Query below:



-- Q4: Write a query to find the names of Managers who are NOT in the Employees table.
-- Write your SQL Query below:



-- ==============================================================================
-- SECTION 2: SPACED CUMULATIVE REVISION DRILLS
-- ==============================================================================

-- Q5: Write a query to find the top 5 highest-paid employees from `Employees` 
-- UNIONed with the top 5 highest-paid contractors from `Contractors`.
-- Write your SQL Query below:



-- Q6: Find the names of employees in `TableA` that start with the letter 'S' 
-- INTERSECT with the names of employees in `TableB` that end with the letter 'A'.
-- Write your SQL Query below:



-- ==============================================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ==============================================================================

-- Q7: SCENARIO: Two hospitals (CityCare and MetroHealth) have merged.
-- Write a query to merge the `PatientID` and `BloodGroup` columns from both 
-- hospital tables into one massive, deduped Master Patient List.
-- Write your SQL Query below:



-- Q8: SCENARIO: You are auditing e-commerce sales. 
-- Find all `ProductID`s that were in the `Catalog` table but are completely missing 
-- (EXCEPT) from the `Orders` table this year.
-- Write your SQL Query below:



-- Q9: SCENARIO: A retail company wants a master transaction log.
-- Write a query to combine `TxnID`, `Amount`, and `Date` from both the `OnlineSales` 
-- and `InStoreSales` tables. Keep all duplicates because every transaction matters.
-- Write your SQL Query below:



-- Q10: SCENARIO: The Marketing team wants to reward loyal customers.
-- Write a query to find the `Email` of customers who bought something during the 
-- Black Friday Sale (Table: BlackFriday) AND also bought something during the 
-- Christmas Sale (Table: ChristmasSale).
-- Write your SQL Query below:



-- ==============================================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ==============================================================================

-- Q11: DEBUGGING: Why will this query fail? Fix it.
-- SELECT EmpName, Salary FROM Branch1
-- UNION
-- SELECT EmpName FROM Branch2;
-- Write your SQL Query below:



-- Q12: DEBUGGING: Will this query fail? If yes, why? If no, what happens?
-- SELECT EmpID FROM IT_Dept (Data type: INT)
-- UNION
-- SELECT EmpName FROM HR_Dept (Data type: VARCHAR)
-- Write your SQL Query below:



-- Q13: LOGIC: If Table A has 50 unique rows, and Table B has 50 completely different 
-- unique rows, how many rows will `A INTERSECT B` return?
-- Write your SQL Query below:



-- Q14: LOGIC: You run `SELECT * FROM T1 EXCEPT SELECT * FROM T2` and it returns 
-- 0 rows. What does this mathematically tell you about the data in T1 compared to T2?
-- Write your SQL Query below:


