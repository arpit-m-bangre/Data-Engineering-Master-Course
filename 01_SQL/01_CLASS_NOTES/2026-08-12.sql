-- ============================================================
-- SQL CLASS NOTES - 12 AUGUST 2026
-- PARENT & CHILD TABLE RELATIONSHIPS (FOREIGN KEY BEHAVIOR)
-- ============================================================

-- Parent table and child table rules:
-- • Parent table cannot be destroyed (if referenced)
-- • Child table can be destroyed (TRUNCATE, DROP, DELETE)

SELECT * FROM q1;
SELECT * FROM q9;


-- ------------------------------------------------------------
-- DELETE EXAMPLES
-- ------------------------------------------------------------

DELETE FROM q1 WHERE pkid = 3;
-- Record has no reference in child table, so successfully deleted.


DELETE FROM q1 WHERE pkid = 1;
-- Error:
-- The DELETE statement conflicted with the REFERENCE constraint "FK__Q9__Custid__7C4F7684".
-- The conflict occurred in database "Online_New", table "dbo.Q9", column 'Custid'.

-- Note:
-- We can delete records from the parent table ONLY if they are not currently referenced in the child table.


-- ------------------------------------------------------------
-- TRUNCATE EXAMPLE
-- ------------------------------------------------------------

TRUNCATE TABLE q1;
-- Error:
-- Cannot truncate table 'q1' because it is being referenced by a FOREIGN KEY constraint.


-- ------------------------------------------------------------
-- DROP EXAMPLE
-- ------------------------------------------------------------

DROP TABLE q1;
-- Error:
-- Could not drop object 'q1' because it is referenced by a FOREIGN KEY constraint.
