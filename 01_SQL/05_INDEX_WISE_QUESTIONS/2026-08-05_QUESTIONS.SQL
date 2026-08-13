/* ============================================================
               DAY 5 PRACTICE QUESTIONS & SOLUTIONS (5 AUGUST 2026)
               TOPICS: DELETE vs TRUNCATE vs DROP, ALTER TABLE
                       (ADD, DROP, ALTER COLUMN), RENAME (sp_rename)
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - ALTER TABLE Operations]:
/*
Task: Write DDL queries on table 'ProductCatalog(ProdID INT, ProdName VARCHAR 20)':
1. Add column 'Category' (VARCHAR 15).
2. Drop column 'Category'.
3. Alter column 'ProdName' data type length to VARCHAR(50).
*/

-- Solution:
ALTER TABLE ProductCatalog ADD Category VARCHAR(15);
ALTER TABLE ProductCatalog DROP COLUMN Category;
ALTER TABLE ProductCatalog ALTER COLUMN ProdName VARCHAR(50);


-- QUESTION 2 [Basic Syntax - sp_rename Procedure]:
/*
Task:
1. Write the query to rename table 'ProductCatalog' to 'CatalogMaster' using sp_rename.
2. Write the query to rename column 'ProdName' to 'ItemName' in table 'ProductCatalog' using sp_rename.
*/

-- Solution:
EXECUTE sp_rename 'ProductCatalog', 'CatalogMaster';
EXECUTE sp_rename 'ProductCatalog.ProdName', 'ItemName';


-- ============================================================
-- SECTION 2: DAYS 1 - 4 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1-4 Revision - Schema & Inventory Setup]:
/*
Task:
1. Create table 'WarehouseInventory' with: ItemID (INT), ItemName (VARCHAR 30), Category (VARCHAR 20), StockQuantity (INT), UnitPrice (INT).
2. Insert 5 sample records including 1 row with StockQuantity = 0 and 1 row with Category IS NULL.
*/

-- Solution:
CREATE TABLE WarehouseInventory
(
    ItemID        INT,
    ItemName      VARCHAR(30),
    Category      VARCHAR(20),
    StockQuantity INT,
    UnitPrice     INT
);

INSERT INTO WarehouseInventory VALUES (101, 'Dell Monitor 27', 'Electronics', 150, 18000);
INSERT INTO WarehouseInventory VALUES (102, 'Logitech Mouse', 'Electronics', 0, 450);
INSERT INTO WarehouseInventory VALUES (103, 'Office Chair', 'Furniture', 45, 6500);
INSERT INTO WarehouseInventory VALUES (104, 'USB Cable', NULL, 200, 250);
INSERT INTO WarehouseInventory VALUES (105, 'Keyboard', 'Electronics', 80, 1200);


-- QUESTION 4 [Days 1-4 Revision - UPDATE, DELETE & Projections]:
/*
Task:
1. Update StockQuantity = StockQuantity + 50 for items where UnitPrice < 500.
2. Delete items where StockQuantity = 0 OR Category IS NULL.
3. Select all items with computed column TotalStockValue = StockQuantity * UnitPrice.
*/

-- Solution:
UPDATE WarehouseInventory SET StockQuantity = StockQuantity + 50 WHERE UnitPrice < 500;
DELETE FROM WarehouseInventory WHERE StockQuantity = 0 OR Category IS NULL;
SELECT *, TotalStockValue = StockQuantity * UnitPrice FROM WarehouseInventory;


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Deletion Command Comparison]:
/*
Scenario: Performance evaluation of table wiping commands.
Task: Write out the exact syntax and explain the behavioral differences between:
1. DELETE FROM WarehouseInventory;
2. TRUNCATE TABLE WarehouseInventory;
3. DROP TABLE WarehouseInventory;
*/

-- Solution:
DELETE FROM WarehouseInventory;    -- DML: Removes rows, supports WHERE, structure remains
TRUNCATE TABLE WarehouseInventory; -- DDL: Fast deallocation of data pages, no WHERE, structure remains
DROP TABLE WarehouseInventory;     -- DDL: Deletes data AND schema structure permanently


-- QUESTION 6 [Scenario - Schema Evolution (ALTER TABLE ADD & UPDATE)]:
/*
Scenario: Pipeline expansion adding new supplier metrics.
Task:
1. Alter 'WarehouseInventory' to ADD columns: SupplierCity (VARCHAR 20), SupplierRating (INT), ReorderLevel (INT).
2. Update SupplierCity = 'Pune', SupplierRating = 4, ReorderLevel = 100 for all items.
*/

-- Solution:
ALTER TABLE WarehouseInventory ADD SupplierCity VARCHAR(20), SupplierRating INT, ReorderLevel INT;
UPDATE WarehouseInventory SET SupplierCity = 'Pune', SupplierRating = 4, ReorderLevel = 100;


-- QUESTION 7 [Scenario - Dropping Unused Attributes]:
/*
Scenario: Removing redundant metadata fields.
Task: Alter 'WarehouseInventory' to DROP columns 'SupplierCity' and 'ReorderLevel'.
*/

-- Solution:
ALTER TABLE WarehouseInventory DROP COLUMN SupplierCity, ReorderLevel;


-- QUESTION 8 [Scenario - Column Size Expansion vs Truncation Errors]:
/*
Scenario: Expanding description limits vs decreasing limits below data size.
Task:
1. Alter 'WarehouseInventory' to expand ItemName to VARCHAR(60).
2. Explain what happens if you attempt to decrease ItemName to VARCHAR(3) when existing row values contain 10 characters.
*/

-- Solution:
ALTER TABLE WarehouseInventory ALTER COLUMN ItemName VARCHAR(60);
/*
EXPLANATION: Decreasing column size below stored character length throws error: "String or binary data would be truncated".
*/


-- ============================================================
-- SECTION 4: LOGIC BUILDER & METADATA DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Table & Column Renaming Rules]:
/*
Task:
1. Write the exact syntax to rename table 'WarehouseInventory' to 'InvMaster'.
2. Write the exact syntax to rename column 'Category' to 'ItemCategory' in table 'WarehouseInventory'.
3. Why must column renaming include the table name prefix ('TableName.OldColumn')?
*/

-- Solution:
EXECUTE sp_rename 'WarehouseInventory', 'InvMaster';
EXECUTE sp_rename 'WarehouseInventory.Category', 'ItemCategory';
/*
EXPLANATION: Including table prefix tells sp_rename which table's column to target, avoiding ambiguity across the database catalog.
*/


-- QUESTION 10 [Debugging - Identify TRUNCATE & Renaming Syntax Errors]:
/*
Task: Identify the error in the following 2 queries:
1. TRUNCATE TABLE WarehouseInventory WHERE StockQuantity = 0;
2. EXEC sp_rename 'Category', 'ItemCategory';
*/

-- Solution:
-- 1. Fix: TRUNCATE does NOT allow a WHERE clause; use DELETE.
DELETE FROM WarehouseInventory WHERE StockQuantity = 0;

-- 2. Fix: Column renaming requires table name prefix.
EXEC sp_rename 'WarehouseInventory.Category', 'ItemCategory';


/* ============================================================
                   END OF DAY 5 PRACTICE & SOLUTIONS
   ============================================================ */
