/* ============================================================
               DAY 4 PRACTICE QUESTIONS (4 AUGUST 2026)
               TOPICS: ARITHMETIC OPERATIONS, COMPUTED COLUMNS,
                       DML (UPDATE, DELETE), DDL (DROP), DBA PERMISSIONS
               REVISION: DAYS 1 - 3 (TABLE CREATION, WHERE, LIKE, IN)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Arithmetic Operators in Projections]:
/*
Task: Write queries on table 'Accounts(AccID INT, AccName VARCHAR 30, Balance INT)':
1. Select AccName and (Balance + 1000) AS NewBalance.
2. Select AccName and (Balance - 500) AS DeductedBalance.
3. Select AccName and (Balance * 1.10) AS BonusBalance.
4. Select AccName and (Balance / 2) AS HalfBalance.
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - Column Aliasing Variations]:
/*
Task: Write 2 different syntax styles to alias (Balance * 0.90) as 'DiscountedBalance' (using AS vs using '=').
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - UPDATE Statement Syntax]:
/*
Task: Write queries on 'Accounts':
1. Update Accounts SET Balance = Balance + 500 WHERE AccID = 101.
2. Update Accounts SET AccName = 'Arpit', Balance = 50000 WHERE AccID = 102.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - DELETE & DROP Syntax]:
/*
Task: Write queries on 'Accounts':
1. Delete from Accounts WHERE Balance = 0.
2. Write the syntax to DROP table Accounts.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 3 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-3 Revision - Table Setup & Complex Filtering]:
/*
Task:
1. Create a table 'LoanAccounts' with: LoanID (INT), CustomerName (VARCHAR 35), LoanType (VARCHAR 20), PrincipalAmount (INT), InterestRate (FLOAT), BranchCity (VARCHAR 25), AccountStatus (VARCHAR 15).
2. Insert 5 sample records.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-3 Revision - Range Exclusions & LIKE Matching]:
/*
Task: Select accounts from 'LoanAccounts' where PrincipalAmount NOT BETWEEN 100000 AND 500000 AND BranchCity IN ('Pune', 'Nagpur') AND CustomerName LIKE '%a%'.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Financial Computed Projections]:
/*
Scenario: Bank loan processing engine calculating total interest & repayment.
Task: Select all columns from 'LoanAccounts' along with computed columns:
1. NewPrincipalAmount = PrincipalAmount * 1.15
2. DiscountedAmount = PrincipalAmount * 0.90
3. TotalRepaymentProjected = PrincipalAmount + (PrincipalAmount * InterestRate / 100.0)
4. MonthlyInstallment = TotalRepaymentProjected / 12.0
*/

-- Write your SQL Query below:




-- QUESTION 8 [Scenario - Target Row Deletions]:
/*
Scenario: Cleansing closed or targeted customer accounts.
Task:
1. Delete loan account with LoanID = 104.
2. Delete loan accounts where CustomerName = 'Pushpak' OR AccountStatus = 'Closed'.
*/

-- Write your SQL Queries below:




-- QUESTION 9 [Scenario - Single & Multi-Column UPDATE Operations]:
/*
Scenario: Mass updates based on customer criteria.
Task:
1. Update LoanType = 'Home Loan' for accounts where CustomerName LIKE '%i%'.
2. Update LoanType = 'Auto Loan', InterestRate = 8.5, and AccountStatus = 'Active' for LoanID = 102.
3. Increase PrincipalAmount by 10% (PrincipalAmount * 1.10) for accounts where CustomerName contains 'Arpit'.
*/

-- Write your SQL Queries below:




-- QUESTION 10 [Scenario - Handling NULLs & Empty Strings in UPDATE]:
/*
Scenario: Replacing missing data fields.
Task:
1. Update BranchCity = 'Nashik' for accounts where BranchCity IS NULL.
2. Update BranchCity = NULL for accounts where BranchCity = 'Nashik'.
3. Update CustomerName = '' (empty string) for accounts where CustomerName contains 'Rahul'.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & SECURITY DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - DML Scoping Safety Check]:
/*
Task:
1. What happens if you execute 'UPDATE LoanAccounts SET AccountStatus = 'Active'' without a WHERE clause?
2. Explain the best practice steps before running an UPDATE or DELETE command in production.
*/

-- Write your explanation in comments below:




-- QUESTION 12 [Logic Builder - Empty String vs 0 in Numeric Columns]:
/*
Task: Explain why assigning '' (empty string) to an INT column either converts to 0 or throws a data conversion error.
*/

-- Write your explanation in comments below:




-- QUESTION 13 [Security - DBA Permission Hierarchies]:
/*
Task:
1. Why do Database Administrators (DBAs) restrict DELETE and DROP permissions for standard users?
2. List the 4 permission levels in relational databases (Database, Table, Column, Row).
*/

-- Write your answers in comments below:




-- QUESTION 14 [Debugging - Fix UPDATE & Arithmetic Syntax Errors]:
/*
Task: Identify and fix errors in the following 2 queries:
1. UPDATE LoanAccounts SET PrincipalAmount + 5000 WHERE LoanID = 101;
2. SELECT CustomerName, PrincipalAmount * 1.10 AS New Principal FROM LoanAccounts;
*/

-- Write your corrected SQL Queries below:




/* ============================================================
                   END OF DAY 4 PRACTICE
   ============================================================ */
