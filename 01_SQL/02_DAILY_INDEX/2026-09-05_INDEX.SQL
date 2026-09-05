-- ====================================================================================
-- DAY 28 TOPIC INDEX: DATABASE-LEVEL DDL & TABLE-LEVEL DML TRIGGERS
-- Date: 05 September 2026 | Module: 01_SQL
-- ====================================================================================

/*
TOPIC BREAKDOWN:
---------------------------------------------------------------------------------------
1. DDL Triggers Architecture:
   - Database Scope vs Server Scope Triggers
   - Event Types: CREATE_TABLE, ALTER_TABLE, DROP_TABLE
   - Enforcement of Enterprise Schema Immutability & Security Policies
   - Schema Rollback Mechanics: ROLLBACK TRANSACTION inside Triggers

2. DML Triggers Architecture:
   - AFTER / FOR Triggers (Post-operation execution)
   - INSTEAD OF Triggers (Pre-operation interception & view updatability)
   - Magic Tables: INSERTED vs DELETED virtual row caches
   - Column Modification Detection: IF UPDATE(ColumnName)

3. Trigger Lifecycle & Administration:
   - DISABLE TRIGGER ... ON DATABASE / TABLE
   - ENABLE TRIGGER ... ON DATABASE / TABLE
   - DROP TRIGGER ... ON DATABASE / TABLE
   - Querying Trigger Metadata via sys.triggers and sys.server_triggers
---------------------------------------------------------------------------------------
*/
