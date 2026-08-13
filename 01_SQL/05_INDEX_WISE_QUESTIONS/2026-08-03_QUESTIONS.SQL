/* ============================================================
               DAY 3 PRACTICE QUESTIONS & SOLUTIONS (3 AUGUST 2026)
               TOPICS: PATTERN MATCHING, RANGE EXCLUSIONS,
                       VOWEL FILTERING, ALPHANUMERIC CHECKS
               STATUS: COMPLETED IN LEARNING DIARY
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Basic Syntax - Range & Substring Exclusions]:
/*
Task: Write queries on table 'Items(ItemID INT, ItemName VARCHAR 30, Price INT)':
1. Select items where Price NOT BETWEEN 100 AND 500.
2. Select items where ItemName NOT LIKE '%test%'.
*/

-- Solution:
SELECT * FROM Items WHERE Price NOT BETWEEN 100 AND 500;
SELECT * FROM Items WHERE ItemName NOT LIKE '%test%';


-- QUESTION 2 [Basic Syntax - Exact Character Length & Boundaries]:
/*
Task: Write queries on table 'Items':
1. Select items where ItemName starts with 'B', ends with 'y', and has EXACTLY 6 characters ('B____y').
2. Select items where Price >= 200 AND Price <= 800 without using BETWEEN.
*/

-- Solution:
SELECT * FROM Items WHERE ItemName LIKE 'B____y';
SELECT * FROM Items WHERE Price >= 200 AND Price <= 800;


-- ============================================================
-- SECTION 2: DAYS 1 & 2 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 3 [Days 1 & 2 Revision - Schema Setup]:
/*
Task:
1. Create table 'ShipmentLog' with: TrackingID (INT), SenderName (VARCHAR 30), DestinationCity (VARCHAR 30), ShippingCost (INT), SenderEmail (VARCHAR 40), TransportMode (VARCHAR 15).
2. Insert 6 sample records including 'Air', 'Sea', and 'Road' modes across 'Mumbai', 'Delhi', 'Pune', 'Nagpur'.
*/

-- Solution:
CREATE TABLE ShipmentLog
(
    TrackingID      INT,
    SenderName      VARCHAR(30),
    DestinationCity VARCHAR(30),
    ShippingCost    INT,
    SenderEmail     VARCHAR(40),
    TransportMode   VARCHAR(15)
);

INSERT INTO ShipmentLog VALUES (1001, 'Arjun Singh', 'Mumbai', 45000, 'arjun@gmail.com', 'Air');
INSERT INTO ShipmentLog VALUES (1002, 'Aditya Rao', 'Delhi', 75000, 'aditya@company.org', 'Sea');
INSERT INTO ShipmentLog VALUES (1003, 'Aman101', 'Nagpur', 25000, 'aman.v@gmail.com', 'Road');
INSERT INTO ShipmentLog VALUES (1004, 'Rohan Verma', 'Mumbai', 85000, 'rohan@yahoo.com', 'Air');
INSERT INTO ShipmentLog VALUES (1005, 'Anishn', 'Delhi', 35000, 'anishn@outlook.com', 'Sea');
INSERT INTO ShipmentLog VALUES (1006, 'Priya Nair', 'Pune', 18000, 'priya@gmail.com', 'Road');


-- QUESTION 4 [Days 1 & 2 Revision - Combined Filtering]:
/*
Task:
1. Select shipments where ShippingCost BETWEEN 20000 AND 60000 AND TransportMode IN ('Air', 'Sea').
2. Select shipments where SenderEmail IS NOT NULL AND DestinationCity = 'Mumbai'.
*/

-- Solution:
SELECT * FROM ShipmentLog WHERE ShippingCost BETWEEN 20000 AND 60000 AND TransportMode IN ('Air', 'Sea');
SELECT * FROM ShipmentLog WHERE SenderEmail IS NOT NULL AND DestinationCity = 'Mumbai';


-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 5 [Scenario - Logistics Exclusions & Cost Filters]:
/*
Scenario: Auditing freight shipping logs.
Task: Select shipments where ShippingCost NOT BETWEEN 30000 AND 70000 AND DestinationCity IN ('Mumbai', 'Delhi').
*/

-- Solution:
SELECT * FROM ShipmentLog WHERE ShippingCost NOT BETWEEN 30000 AND 70000 AND DestinationCity IN ('Mumbai', 'Delhi');


-- QUESTION 6 [Scenario - Exact String Length Pattern Matching]:
/*
Scenario: Searching logistics sender handles.
Task: Select shipments where SenderName starts with 'A', ends with 'n', and has EXACTLY 6 characters ('A____n').
*/

-- Solution:
SELECT * FROM ShipmentLog WHERE SenderName LIKE 'A____n';


-- QUESTION 7 [Scenario - Domain Exclusion Filtering]:
/*
Scenario: Quality check filtering non-commercial emails.
Task: Select shipments where SenderEmail does NOT contain 'gmail' (NOT LIKE '%gmail%').
*/

-- Solution:
SELECT * FROM ShipmentLog WHERE SenderEmail NOT LIKE '%gmail%';


-- QUESTION 8 [Scenario - Vowel & Alphanumeric String Detection]:
/*
Scenario: Data cleansing user input strings.
Task:
1. Select shipments where SenderName contains any vowels (A, E, I, O, U).
2. Select shipments where SenderName contains BOTH letters AND numeric digits ('%[A-Za-z]%' AND '%[0-9]%').
*/

-- Solution:
-- 1. Vowels query
SELECT * FROM ShipmentLog 
WHERE SenderName LIKE '%A%' OR SenderName LIKE '%E%' OR SenderName LIKE '%I%' 
   OR SenderName LIKE '%O%' OR SenderName LIKE '%U%'
   OR SenderName LIKE '%a%' OR SenderName LIKE '%e%' OR SenderName LIKE '%i%' 
   OR SenderName LIKE '%o%' OR SenderName LIKE '%u%';

-- 2. Alphanumeric query
SELECT * FROM ShipmentLog 
WHERE SenderName LIKE '%[A-Za-z]%' AND SenderName LIKE '%[0-9]%';


-- ============================================================
-- SECTION 4: LOGIC BUILDER & BOUNDARY DRILLS
-- ============================================================

-- QUESTION 9 [Logic Builder - Simulating BETWEEN without BETWEEN]:
/*
Task: Write a query selecting shipments where ShippingCost is between 25000 and 75000 using only relational operators (>= and <=), without using BETWEEN or LIKE.
*/

-- Solution:
SELECT * FROM ShipmentLog WHERE ShippingCost >= 25000 AND ShippingCost <= 75000;


-- QUESTION 10 [Debugging - Correct AND vs OR Logic Errors]:
/*
Task: Identify the error in the query below and write the corrected version:
-- Buggy Query: Select * from ShipmentLog where SenderName LIKE '%[A-Za-z]%' OR SenderName LIKE '%[0-9]%'
(Goal: Must contain BOTH letters AND numbers).
*/

-- Solution:
/*
EXPLANATION: OR condition checks if the string contains letters OR numbers. To require BOTH letters and numbers simultaneously, AND must be used.
*/

-- Fix:
SELECT * FROM ShipmentLog WHERE SenderName LIKE '%[A-Za-z]%' AND SenderName LIKE '%[0-9]%';


/* ============================================================
                   END OF DAY 3 PRACTICE & SOLUTIONS
   ============================================================ */
