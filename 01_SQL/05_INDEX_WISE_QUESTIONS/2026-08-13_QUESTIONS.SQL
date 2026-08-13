/* ============================================================
               DAY 12 PRACTICE QUESTIONS (13 AUGUST 2026)
               TOPICS: RETROFITTING CONSTRAINTS VIA ALTER TABLE,
                       COLUMN PROPERTIES (NOT NULL, IDENTITY) VS CONSTRAINTS,
                       METADATA AUDITING & TRANSACTIONAL SAFETY
               REVISION: DAYS 1 - 11 (DDL, DML, CLAUSES, FK DESTRUCTION RULES)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Retrofitting UNIQUE Constraint]:
/*
Task: Write DDL query to retrofit a UNIQUE constraint named 'uq_employee_email' 
on the column 'email' for an existing table 'EmployeeRegistry'.
*/

-- Write your SQL Query below:




-- QUESTION 2 [Syntax Drill - Retrofitting CHECK Constraint]:
/*
Task: Write DDL query to retrofit a CHECK constraint named 'chk_salary_positive' 
ensuring 'salary > 0' on an existing table 'PayrollMaster'.
*/

-- Write your SQL Query below:




-- QUESTION 3 [Syntax Drill - Retrofitting DEFAULT Constraint]:
/*
Task: Write DDL query to retrofit a DEFAULT constraint named 'df_country_india' 
setting default value 'India' for column 'country' on table 'CustomerProfiles'.
*/

-- Write your SQL Query below:




-- QUESTION 4 [Syntax Drill - Retrofitting FOREIGN KEY Constraint]:
/*
Task: Write DDL query to retrofit a FOREIGN KEY constraint named 'fk_orders_customer' 
on column 'customer_id' in table 'OrdersLog' referencing 'CustomersMaster(customer_id)'.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 2: DAYS 1 - 11 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-11 Revision - Pre-Cleaning Data before Retrofitting Constraints]:
/*
Task:
You have an unconstrained legacy table 'VendorData' containing columns (vendor_id INT, vendor_name VARCHAR(50), tax_code VARCHAR(20)).
1. Write a DML query to delete all rows where vendor_id IS NULL or vendor_name IS NULL.
2. Write DDL query to convert 'vendor_id' column property to NOT NULL using ALTER COLUMN.
3. Write DDL query to retrofit PRIMARY KEY constraint 'pk_vendor' on 'vendor_id'.
4. Write DDL query to retrofit UNIQUE constraint 'uq_vendor_name' on 'vendor_name'.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-11 Revision - SQL Clause Execution & Scoping Rules]:
/*
Task: Write a single SELECT query on 'PayrollMaster' returning department-wise metrics where:
1. Only consider active employees (status = 'Active').
2. Salary must be greater than 40,000.
3. Group by department and calculate Total Salary (total_sal) and Average Salary (avg_sal).
4. Include only departments having at least 3 qualifying employees and average salary >= 60,000.
5. Sort by total_sal descending using column alias.
*/

-- Write your SQL Query below:




-- ============================================================
-- SECTION 3: REAL-WORLD DATA ENGINEERING SCENARIO CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Enterprise Staging Layer Data Cleansing Pipeline]:
/*
Scenario: Raw IoT sensor readings are ingested into unconstrained staging table 'STG_SensorData' 
with columns (sensor_id INT, reading_val DECIMAL(10,2), status_code VARCHAR(10), reading_time DATETIME).
Task:
1. Delete duplicate sensor readings or invalid NULL sensor IDs.
2. Convert 'sensor_id' column to NOT NULL via ALTER COLUMN.
3. Retrofit PRIMARY KEY 'pk_sensor_data' on 'sensor_id'.
4. Retrofit CHECK constraint 'chk_sensor_val' ensuring reading_val is between -50.00 and 150.00.
5. Retrofit DEFAULT constraint 'df_status_ok' defaulting status_code to 'OK'.
*/

-- Write your SQL Queries below:




-- QUESTION 8 [Scenario - Banking Transaction Ledger Retrofit Architecture]:
/*
Scenario: A core banking migration requires attaching Foreign Key constraints onto 
existing staging transactions table 'STG_Transactions' referencing 'Dim_Accounts(account_id)'.
Task:
1. Write a SELECT query to identify any orphaned records in 'STG_Transactions' where account_id does NOT exist in 'Dim_Accounts'.
2. Write a DELETE statement to purge those orphan transaction rows.
3. Retrofit FOREIGN KEY constraint 'fk_tx_account' on 'STG_Transactions(account_id)' referencing 'Dim_Accounts(account_id)'.
*/

-- Write your SQL Queries below:




-- QUESTION 9 [Scenario - Live Table Auto-Increment Identity Enrichment]:
/*
Scenario: A production audit table 'AuditLog' has 500,000 records but lacks a surrogate primary key.
Task:
1. Can you directly alter an existing column 'log_id' to IDENTITY(1,1)? Explain why or why not.
2. Write the DDL query to safely add a NEW surrogate primary key column 'surrogate_key' with IDENTITY(1,1) to 'AuditLog'.
3. Write DDL query to retrofit PRIMARY KEY constraint 'pk_audit_surrogate' on 'surrogate_key'.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 10 [Scenario - Transactional TRUNCATE Rollback Verification]:
/*
Scenario: An ETL developer accidentally executes TRUNCATE TABLE on a critical dimension table 
during a database deployment script.
Task:
1. Write an explicit transaction script that starts a transaction, truncates table 'Dim_Products', and then rolls back the change.
2. Write a verification SELECT query to confirm that 100% of rows were restored.
3. Explain why TRUNCATE can be rolled back inside an explicit transaction in SQL Server.
*/

-- Write your SQL Queries & explanation below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & DEBUGGING DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Column Property vs Table Constraint Matrix]:
/*
Task: Complete the comparison table in comments:
Feature / Constraint | Modification Syntax (ALTER COLUMN / ADD CONSTRAINT) | Custom Key Name Allowed? (Yes/No)
---------------------------------------------------------------------------------------------------------
NOT NULL             | ?                                                    | ?
PRIMARY KEY          | ?                                                    | ?
UNIQUE               | ?                                                    | ?
CHECK                | ?                                                    | ?
DEFAULT              | ?                                                    | ?
IDENTITY             | ?                                                    | ?
*/

-- Write your answer in comments below:




-- QUESTION 12 [Debugging Drill - Error Msg 1750 Duplicate Key Analysis]:
/*
Task: You execute:
ALTER TABLE Employees ADD CONSTRAINT uq_emp_code UNIQUE (emp_code);
SQL Server returns: "Msg 1750: The CREATE UNIQUE INDEX statement terminated because a duplicate key was found..."
1. What caused this error?
2. Write the SQL query to find all duplicate 'emp_code' values causing the failure.
3. Write the resolution steps to fix the data and successfully re-run the ALTER TABLE statement.
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 13 [Debugging Drill - Information Schema Constraint Audit Query]:
/*
Task: Write an INFORMATION_SCHEMA query that lists all constraints on table 'PayrollMaster' 
displaying: TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE.
Filter out default system constraints to show user-defined constraints.
*/

-- Write your SQL Query below:




-- QUESTION 14 [Debugging Drill - FK Destruction Behavior Audit]:
/*
Task: Explain why 'TRUNCATE TABLE ParentTable' fails in SQL Server even if the child table 'ChildTable' has 0 rows.
Contrast this behavior with 'DELETE FROM ParentTable'.
*/

-- Write your explanation in comments below:




/* ============================================================
                   END OF DAY 12 PRACTICE
   ============================================================ */
