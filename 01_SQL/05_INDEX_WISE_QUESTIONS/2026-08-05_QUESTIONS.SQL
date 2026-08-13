/* ============================================================
               DAY 5 PRACTICE QUESTIONS (5 AUGUST 2026)
               TOPICS: DELETE vs TRUNCATE vs DROP, ALTER TABLE
                       (ADD, DROP, ALTER COLUMN), RENAME (sp_rename)
               REVISION: DAYS 1 - 4 (DML UPDATE/DELETE, WHERE, ALIASES)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - ALTER TABLE ADD Column Variants]:
/*
Task: Write DDL queries on table 'ProductCatalog(ProdID INT, ProdName VARCHAR 20)':
1. Add column 'Category' (VARCHAR 15).
2. Add multiple columns in a single statement: 'Brand' (VARCHAR 20), 'WarrantyMonths' (INT).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - ALTER TABLE DROP Column Variants]:
/*
Task: Write DDL queries on 'ProductCatalog':
1. Drop column 'Category'.
2. Drop multiple columns in a single statement: 'Brand', 'WarrantyMonths'.
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - ALTER COLUMN Data Type & Length]:
/*
Task: Write DDL queries on 'ProductCatalog':
1. Alter column 'ProdName' data type length to VARCHAR(50).
2. Alter column 'ProdID' data type to BIGINT.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - sp_rename Procedure Variations]:
/*
Task:
1. Write the query to rename table 'ProductCatalog' to 'CatalogMaster' using sp_rename.
2. Write the query to rename column 'ProdName' to 'ItemName' in table 'ProductCatalog' using sp_rename.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 - 4 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1-4 Revision - Schema & Inventory Setup]:
/*
Task:
1. Create table 'WarehouseInventory' with: ItemID (INT), ItemName (VARCHAR 30), Category (VARCHAR 20), StockQuantity (INT), UnitPrice (INT).
2. Insert 5 sample records including 1 row with StockQuantity = 0 and 1 row with Category IS NULL.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1-4 Revision - UPDATE, DELETE & Projections]:
/*
Task:
1. Update StockQuantity = StockQuantity + 50 for items where UnitPrice < 500.
2. Delete items where StockQuantity = 0 OR Category IS NULL.
3. Select all items with computed column TotalStockValue = StockQuantity * UnitPrice.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Deletion Command Comparison]:
/*
Scenario: Performance evaluation of table wiping commands.
Task: Write out the exact syntax and explain the behavioral differences between:
1. DELETE FROM WarehouseInventory;
2. TRUNCATE TABLE WarehouseInventory;
3. DROP TABLE WarehouseInventory;
*/

-- Write your explanation and SQL Queries below:




-- QUESTION 8 [Scenario - Schema Evolution (ALTER TABLE ADD & UPDATE)]:
/*
Scenario: Pipeline expansion adding new supplier metrics.
Task:
1. Alter 'WarehouseInventory' to ADD columns: SupplierCity (VARCHAR 20), SupplierRating (INT), ReorderLevel (INT).
2. Update SupplierCity = 'Pune', SupplierRating = 4, ReorderLevel = 100 for all items.
*/

-- Write your SQL Queries below:




-- QUESTION 9 [Scenario - Dropping Unused Attributes]:
/*
Scenario: Removing redundant metadata fields.
Task: Alter 'WarehouseInventory' to DROP columns 'SupplierCity' and 'ReorderLevel'.
*/

-- Write your SQL Query below:




-- QUESTION 10 [Scenario - Column Size Expansion vs Truncation Errors]:
/*
Scenario: Expanding description limits vs decreasing limits below data size.
Task:
1. Alter 'WarehouseInventory' to expand ItemName to VARCHAR(60).
2. Explain what happens if you attempt to decrease ItemName to VARCHAR(3) when existing row values contain 10 characters.
*/

-- Write your SQL Query & explanation below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & METADATA DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Table & Column Renaming Rules]:
/*
Task:
1. Write the exact syntax to rename table 'WarehouseInventory' to 'InvMaster'.
2. Write the exact syntax to rename column 'Category' to 'ItemCategory' in table 'WarehouseInventory'.
3. Why must column renaming include the table name prefix ('TableName.OldColumn')?
*/

-- Write your SQL Queries & explanation below:




-- QUESTION 12 [Logic Builder - DDL vs DML Transaction Logging]:
/*
Task: Explain why TRUNCATE TABLE is faster than DELETE FROM table on a table with 1,000,000 rows.
*/

-- Write your answer in comments below:




-- QUESTION 13 [Debugging - Identify TRUNCATE & Renaming Syntax Errors]:
/*
Task: Identify the error in the following 2 queries:
1. TRUNCATE TABLE WarehouseInventory WHERE StockQuantity = 0;
2. EXEC sp_rename 'Category', 'ItemCategory';
*/

-- Write your explanations & corrected queries below:




-- QUESTION 14 [Debugging - ALTER TABLE Syntax Errors]:
/*
Task: Identify why 'ALTER TABLE WarehouseInventory ADD COLUMN Brand VARCHAR(20);' fails in SQL Server and write the corrected version.
*/

-- Write your explanation & corrected query below:




/* ============================================================
                   END OF DAY 5 PRACTICE
   ============================================================ */
