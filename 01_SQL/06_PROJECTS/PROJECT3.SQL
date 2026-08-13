/* ============================================================
               DATA ENGINEERING PROJECT 3 (PROJECT3.SQL)
               TITLE: BANKING TRANSACTION AUDIT & FRAUD DETECTION PIPELINE
               TOPICS COVERED: DAYS 1 - 8
               (SQL Clause Execution Sequence FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY,
                WHERE vs HAVING, Multi-Column Grouping, Alias Scoping, Complex Business Scenarios)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
A Commercial Bank's Fraud & Risk Analytics Division requires an SQL 
audit module to screen high-risk monetary transfers, monitor branch-wise
cash flows, identify suspicious high-volume accounts, and build automated
compliance reports following strict SQL clause execution rules.
=============================================================== */

-- ============================================================
-- 2. SCHEMA CREATION & INGESTION
-- ============================================================

-- Task 1: Create 'BankAccounts' table
CREATE TABLE BankAccounts
(
    AccountNo    INT,
    AccountHolder VARCHAR(35),
    BranchCity   VARCHAR(20),
    AccountType  VARCHAR(15),
    AccountAgeYears INT,
    CurrentBalance INT
);

-- Task 2: Create 'BankTransactions' table
CREATE TABLE BankTransactions
(
    TxnID         INT,
    AccountNo     INT,
    TxnType       VARCHAR(15),
    TxnAmount     INT,
    TxnChannel    VARCHAR(15),
    TxnStatus     VARCHAR(15),
    TxnYear       INT
);

-- Populate Accounts
INSERT INTO BankAccounts VALUES (7001, 'Arpit Bangre', 'Mumbai', 'Savings', 6, 250000);
INSERT INTO BankAccounts VALUES (7002, 'Rahul Patil', 'Pune', 'Current', 4, 180000);
INSERT INTO BankAccounts VALUES (7003, 'Sneha Joshi', 'Mumbai', 'Savings', 8, 550000);
INSERT INTO BankAccounts VALUES (7004, 'Priya Sharma', 'Nagpur', 'Savings', 2, 45000);
INSERT INTO BankAccounts VALUES (7005, 'Amit Verma', 'Delhi', 'Current', 12, 920000);
INSERT INTO BankAccounts VALUES (7006, 'Rohit Singh', 'Pune', 'Savings', 5, 310000);
INSERT INTO BankAccounts VALUES (7007, 'Neha Kale', 'Nagpur', 'Current', 3, 120000);

-- Populate Transactions
INSERT INTO BankTransactions VALUES (901, 7001, 'Withdrawal', 65000, 'UPI', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (902, 7003, 'Deposit', 120000, 'Branch', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (903, 7005, 'Withdrawal', 250000, 'Credit Card', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (904, 7002, 'Withdrawal', 45000, 'UPI', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (905, 7001, 'Withdrawal', 80000, 'Credit Card', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (906, 7003, 'Withdrawal', 150000, 'UPI', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (907, 7005, 'Deposit', 300000, 'Branch', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (908, 7006, 'Withdrawal', 55000, 'UPI', 'Completed', 2023);
INSERT INTO BankTransactions VALUES (909, 7001, 'Withdrawal', 75000, 'Credit Card', 'Completed', 2023);


-- ============================================================
-- 3. AUDIT & FRAUD RISK SCREENING TASKS
-- ============================================================

-- Task 3 [Complete 6-Clause Integration]:
-- Find branch-wise total account balance for accounts with AccountAgeYears >= 3, returning only branches where total balance exceeds 4,00,000. Sort output by total balance descending.
-- (Must use FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY).
-- Write your SQL Query below:




-- Task 4 [High Risk Withdrawal Screening]:
-- From BankTransactions, find total withdrawal amounts per AccountNo for completed transactions in 2023 made via 'UPI' or 'Credit Card' where single TxnAmount > 40,000.
-- Display only accounts with total withdrawals > 1,00,000, sorted by total withdrawal DESCENDING.
-- Write your SQL Query below:




-- Task 5 [Multi-Column Grouping & Sorting]:
-- Group BankAccounts by BranchCity AND AccountType.
-- Display BranchCity, AccountType, COUNT(AccountNo) AS TotalAccounts, AVG(CurrentBalance) AS AvgBalance.
-- Filter out accounts with CurrentBalance < 50000 in WHERE clause.
-- Display only groups with AvgBalance > 100000 in HAVING clause.
-- Sort by AvgBalance DESCENDING, BranchCity ASCENDING.
-- Write your SQL Query below:




-- Task 6 [WHERE vs HAVING Scoping Fix]:
-- Identify the error in the buggy query below and write the fully corrected SQL query:
/*
-- Buggy Query:
SELECT BranchCity, AVG(CurrentBalance) AS AvgBal
FROM BankAccounts
WHERE AVG(CurrentBalance) > 200000
GROUP BY BranchCity
ORDER BY Average Balance DESC;
*/
-- Write your corrected SQL Query below:




-- Task 7 [Account Frequency Audit]:
-- Find accounts that executed at least 3 withdrawal transactions in 2023.
-- Display AccountNo and TotalTxnCount.
-- Write your SQL Query below:




/* ============================================================
                    END OF PROJECT 3
   ============================================================ */
