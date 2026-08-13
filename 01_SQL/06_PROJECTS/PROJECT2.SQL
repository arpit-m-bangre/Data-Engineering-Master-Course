/* ============================================================
               DATA ENGINEERING PROJECT 2 (PROJECT2.SQL)
               TITLE: HEALTHCARE HOSPITAL ADMISSIONS & BILLING PIPELINE
               TOPICS COVERED: DAYS 1 - 6
               (Schema Alterations ALTER TABLE, sp_rename, DELETE vs TRUNCATE,
                Aggregates MIN/MAX/SUM/AVG/COUNT, NULL Handling, DISTINCT, TOP N)
   ============================================================ */

/* ============================================================
1. PROJECT OVERVIEW & BUSINESS SCENARIO
===============================================================
A Multi-specialty Healthcare Network is upgrading its Patient Data
Warehouse. The data engineering team must handle schema modifications,
normalize medical code fields, compute hospital-wide billing KPIs,
identify top revenue-generating wards, and cleanse incomplete patient files.
=============================================================== */

-- ============================================================
-- 2. BASE SCHEMA CREATION & EVOLUTION
-- ============================================================

-- Task 1: Create base table 'PatientAdmissions'
CREATE TABLE PatientAdmissions
(
    PatientID     INT,
    PatientName   VARCHAR(30),
    WardType      VARCHAR(20),
    RoomCharges   INT,
    TreatmentCost INT,
    DoctorID      INT
);

-- Task 2: Schema Evolution - Alter table to ADD new columns
ALTER TABLE PatientAdmissions
ADD AdmissionCity VARCHAR(20), DischargeStatus VARCHAR(15), StayDurationDays INT;

-- Task 3: Schema Evolution - Alter column data type length
ALTER TABLE PatientAdmissions
ALTER COLUMN PatientName VARCHAR(50);

-- Task 4: Rename column 'DoctorID' to 'AttendingDoctorID' using sp_rename
EXECUTE sp_rename 'PatientAdmissions.DoctorID', 'AttendingDoctorID';


-- ============================================================
-- 3. DATA POPULATION (INGESTION)
-- ============================================================

INSERT INTO PatientAdmissions VALUES (1001, 'Rajesh Kumar', 'General', 1500, 12000, 501, 'Nagpur', 'Discharged', 5);
INSERT INTO PatientAdmissions VALUES (1002, 'Sunita Sharma', 'ICU', 8000, 45000, 502, 'Pune', 'Admitted', 3);
INSERT INTO PatientAdmissions VALUES (1003, 'Amit Verma', 'Private', 4500, 28000, 501, 'Mumbai', 'Discharged', 7);
INSERT INTO PatientAdmissions VALUES (1004, 'Priya Nair', 'ICU', 8000, 62000, 503, 'Nagpur', 'Discharged', 8);
INSERT INTO PatientAdmissions VALUES (1005, 'Rohit Singh', 'General', 1500, NULL, 502, 'Delhi', 'Admitted', 2);
INSERT INTO PatientAdmissions VALUES (1006, 'Neha Kale', 'Private', 4500, 18000, 501, NULL, 'Discharged', 4);
INSERT INTO PatientAdmissions VALUES (1007, 'Vikas Meena', 'General', 1500, 9500, 504, 'Pune', 'Discharged', 3);
INSERT INTO PatientAdmissions VALUES (1008, 'Anjali Singh', 'ICU', 8000, 85000, 503, 'Mumbai', 'Discharged', 10);


-- ============================================================
-- 4. ANALYTICS & EXECUTIVE REPORTING TASKS
-- ============================================================

-- Task 5: Compute total hospital billing KPIs:
-- Total Treatment Cost (SUM), Average Treatment Cost (AVG), Minimum Treatment Cost (MIN), Maximum Treatment Cost (MAX).
-- Write your SQL Query below:




-- Task 6: Count total patient admissions (COUNT(*)) vs patients with non-NULL TreatmentCosts (COUNT(TreatmentCost)) vs unique attending doctors (COUNT(DISTINCT AttendingDoctorID)).
-- Write your SQL Query below:




-- Task 7: Retrieve TOP 3 highest total bill patients where total bill = (RoomCharges * StayDurationDays) + TreatmentCost.
-- Write your SQL Query below:




-- Task 8: Calculate average treatment cost grouped by WardType.
-- Write your SQL Query below:




-- Task 9: Retrieve unique admission cities from PatientAdmissions excluding NULL values.
-- Write your SQL Query below:




-- Task 10: Demonstrate fast full-table cleanup vs structure deletion:
-- Write comments explaining why TRUNCATE TABLE is preferred over DELETE for clearing staging patient logs, and why DROP TABLE destroys the schema structure.
-- Write your explanation / query below:




/* ============================================================
                    END OF PROJECT 2
   ============================================================ */
