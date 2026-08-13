/* ============================================================
               DAY 4 PRACTICE QUESTIONS & SOLUTIONS (4 AUGUST 2026)
               TOPICS: ARITHMETIC OPERATIONS, COMPUTED COLUMNS,
                       DML (UPDATE, DELETE), DDL (DROP), DBA PERMISSIONS
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - Arithmetic & Projection Aliases]:
/*
Task: Write queries on a table 'Accounts(AccID INT, AccName VARCHAR 30, Balance INT)':
1. Select AccName and (Balance + 1000) AS NewBalance.
2. Select AccName and (Balance * 1.10) AS BonusBalance.
*/

-- Solution:
SELECT AccName, (Balance + 1000) AS NewBalance FROM Accounts;
SELECT AccName, (Balance * 1.10) AS BonusBalance FROM Accounts;


-- QUESTION 2 [Basic Syntax - UPDATE & DELETE Drills]:
/*
Task: Write queries on 'Accounts':
1. Update Accounts SET Balance = Balance + 500 WHERE AccID = 101.
2. Delete from Accounts WHERE Balance = 0.
3. Write the syntax to DROP table Accounts.
*/

-- Solution:
UPDATE Accounts SET Balance = Balance + 500 WHERE AccID = 101;
DELETE FROM Accounts WHERE Balance = 0;
DROP TABLE Accounts;


-- ============================================================
-- SECTION 2: DAYS 1 - 3 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-3 Revision - Table Setup & Complex Filtering]:
/*
Task:
1. Create a table 'LoanAccounts' with: LoanID (INT), CustomerName (VARCHAR 35), LoanType (VARCHAR 20), PrincipalAmount (INT), InterestRate (FLOAT), BranchCity (VARCHAR 25), AccountStatus (VARCHAR 15).
2. Insert 5 sample records.
*/

-- Solution:
CREATE TABLE LoanAccounts
(
    LoanID          INT,
    CustomerName    VARCHAR(35),
    LoanType        VARCHAR(20),
    PrincipalAmount INT,
    InterestRate    FLOAT,
    BranchCity      VARCHAR(25),
    AccountStatus   VARCHAR(15)
);

INSERT INTO LoanAccounts VALUES (101, 'Arpit Bangre', 'Home Loan', 450000, 8.5, 'Pune', 'Active');
INSERT INTO LoanAccounts VALUES (102, 'Rahul Patil', 'Personal', 150000, 11.2, 'Nagpur', 'Active');
INSERT INTO LoanAccounts VALUES (103, 'Sneha Joshi', 'Car Loan', 650000, 9.0, 'Pune', 'Active');
INSERT INTO LoanAccounts VALUES (104, 'Pushpak Kale', 'Home Loan', 250000, 8.5, 'Mumbai', 'Closed');
INSERT INTO LoanAccounts VALUES (105, 'Nehal Sharma', 'Personal', 80000, 12.0, NULL, 'Active');


-- QUESTION 4 [Days 1-3 Revision - Range Exclusions & LIKE Matching]:
/*
Task: Select accounts from 'LoanAccounts' where PrincipalAmount NOT BETWEEN 100000 AND 500000 AND BranchCity IN ('Pune', 'Nagpur') AND CustomerName LIKE '%a%'.
*/

-- Solution:
SELECT * FROM LoanAccounts 
WHERE PrincipalAmount NOT BETWEEN 100000 AND 500000 
  AND BranchCity IN ('Pune', 'Nagpur') 
  AND CustomerName LIKE '%a%';


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Financial Computed Projections]:
/*
Scenario: Bank loan processing engine calculating total interest & repayment.
Task: Select all columns from 'LoanAccounts' along with computed columns:
1. NewPrincipalAmount = PrincipalAmount * 1.15
2. DiscountedAmount = PrincipalAmount * 0.90
3. TotalRepaymentProjected = PrincipalAmount + (PrincipalAmount * InterestRate / 100.0)
4. MonthlyInstallment = TotalRepaymentProjected / 12.0
*/

-- Solution:
SELECT *,
       NewPrincipalAmount      = PrincipalAmount * 1.15,
       DiscountedAmount        = PrincipalAmount * 0.90,
       TotalRepaymentProjected = PrincipalAmount + (PrincipalAmount * InterestRate / 100.0),
       MonthlyInstallment      = (PrincipalAmount + (PrincipalAmount * InterestRate / 100.0)) / 12.0
FROM LoanAccounts;


-- QUESTION 6 [Scenario - Target Row Deletions]:
/*
Scenario: Cleansing closed or targeted customer accounts.
Task:
1. Delete loan account with LoanID = 104.
2. Delete loan accounts where CustomerName = 'Pushpak' OR AccountStatus = 'Closed'.
*/

-- Solution:
DELETE FROM LoanAccounts WHERE LoanID = 104;
DELETE FROM LoanAccounts WHERE CustomerName = 'Pushpak' OR AccountStatus = 'Closed';


-- QUESTION 7 [Scenario - Single & Multi-Column UPDATE Operations]:
/*
Scenario: Mass updates based on customer criteria.
Task:
1. Update LoanType = 'Home Loan' for accounts where CustomerName LIKE '%i%'.
2. Update LoanType = 'Auto Loan', InterestRate = 8.5, and AccountStatus = 'Active' for LoanID = 102.
3. Increase PrincipalAmount by 10% (PrincipalAmount * 1.10) for accounts where CustomerName contains 'Arpit'.
*/

-- Solution:
UPDATE LoanAccounts SET LoanType = 'Home Loan' WHERE CustomerName LIKE '%i%';
UPDATE LoanAccounts SET LoanType = 'Auto Loan', InterestRate = 8.5, AccountStatus = 'Active' WHERE LoanID = 102;
UPDATE LoanAccounts SET PrincipalAmount = PrincipalAmount * 1.10 WHERE CustomerName LIKE '%Arpit%';


-- QUESTION 8 [Scenario - Handling NULLs & Empty Strings in UPDATE]:
/*
Scenario: Replacing missing data fields.
Task:
1. Update BranchCity = 'Nashik' for accounts where BranchCity IS NULL.
2. Update BranchCity = NULL for accounts where BranchCity = 'Nashik'.
3. Update CustomerName = '' (empty string) for accounts where CustomerName contains 'Rahul'.
*/

-- Solution:
UPDATE LoanAccounts SET BranchCity = 'Nashik' WHERE BranchCity IS NULL;
UPDATE LoanAccounts SET BranchCity = NULL WHERE BranchCity = 'Nashik';
UPDATE LoanAccounts SET CustomerName = '' WHERE CustomerName LIKE '%Rahul%';


-- ============================================================
-- SECTION 4: LOGIC BUILDER & SECURITY DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - DML Scoping Safety Check]:
/*
Task:
1. What happens if you execute 'UPDATE LoanAccounts SET AccountStatus = 'Active'' without a WHERE clause?
2. Explain the best practice steps before running an UPDATE or DELETE command in production.
*/

-- Solution:
/*
1. EXPLANATION: Omitting WHERE updates EVERY row in the entire table.
2. BEST PRACTICE: Always test your WHERE clause using a SELECT query first before converting it to UPDATE or DELETE.
*/


-- QUESTION 10 [Security - DBA Permission Hierarchies]:
/*
Task:
1. Why do Database Administrators (DBAs) restrict DELETE and DROP permissions for standard users?
2. List the 4 permission levels in relational databases (Database, Table, Column, Row).
*/

-- Solution:
/*
1. EXPLANATION: To prevent accidental structural destruction (DROP) or irreversible data loss (DELETE).
2. PERMISSION LEVELS:
   - Database Level
   - Table Level
   - Column Level
   - Row Level
*/


/* ============================================================
                   END OF DAY 4 PRACTICE & SOLUTIONS
   ============================================================ */
