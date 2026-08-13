/* ============================================================
               DAY 3 PRACTICE QUESTIONS (3 AUGUST 2026)
               TOPICS: PATTERN MATCHING, RANGE EXCLUSIONS,
                       VOWEL FILTERING, ALPHANUMERIC CHECKS
               REVISION: DAYS 1 & 2 (TABLE CREATION, WHERE, IN, LIKE)
               ESTIMATED TIME: 1.5 - 2 HOURS | TARGET: 14 QUESTIONS
   ============================================================ */

-- ============================================================
-- SECTION 1: BASIC SYNTAX PRACTICE & QUICK DRILLS
-- ============================================================

-- QUESTION 1 [Syntax Drill - Range & List Exclusions]:
/*
Task: Write queries on table 'Items(ItemID INT, ItemName VARCHAR 30, Price INT)':
1. Select items where Price NOT BETWEEN 100 AND 500.
2. Select items where ItemName NOT LIKE '%test%'.
3. Select items where ItemID NOT IN (1, 3, 5).
*/

-- Write your SQL Queries below:




-- QUESTION 2 [Syntax Drill - Exact Character Length Wildcards]:
/*
Task: Write queries on 'Items':
1. Select items where ItemName starts with 'B', ends with 'y', and has EXACTLY 6 characters ('B____y').
2. Select items where ItemName has EXACTLY 4 characters ('____').
*/

-- Write your SQL Queries below:




-- QUESTION 3 [Syntax Drill - Range Bounds Without BETWEEN]:
/*
Task: Write queries on 'Items':
1. Select items where Price >= 200 AND Price <= 800 without using BETWEEN.
2. Select items where Price < 100 OR Price > 1000 without using NOT BETWEEN.
*/

-- Write your SQL Queries below:




-- QUESTION 4 [Syntax Drill - Specific Letter Bracket Matching]:
/*
Task: Write queries on 'Items':
1. Select items where ItemName starts with any vowel ('[A,E,I,O,U]%').
2. Select items where ItemName does NOT start with a vowel ('[^A,E,I,O,U]%').
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 2: DAYS 1 & 2 CUMULATIVE REVISION DRILLS
-- ============================================================

-- QUESTION 5 [Days 1 & 2 Revision - Schema Setup]:
/*
Task:
1. Create table 'ShipmentLog' with: TrackingID (INT), SenderName (VARCHAR 30), DestinationCity (VARCHAR 30), ShippingCost (INT), SenderEmail (VARCHAR 40), TransportMode (VARCHAR 15).
2. Insert 6 sample records including 'Air', 'Sea', and 'Road' modes across 'Mumbai', 'Delhi', 'Pune', 'Nagpur'.
*/

-- Write your SQL Queries below:




-- QUESTION 6 [Days 1 & 2 Revision - Combined Filtering]:
/*
Task:
1. Select shipments where ShippingCost BETWEEN 20000 AND 60000 AND TransportMode IN ('Air', 'Sea').
2. Select shipments where SenderEmail IS NOT NULL AND DestinationCity = 'Mumbai'.
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 3: REAL-WORLD SCENARIO-BASED CHALLENGES
-- ============================================================

-- QUESTION 7 [Scenario - Logistics Exclusions & Cost Filters]:
/*
Scenario: Auditing freight shipping logs.
Task: Select shipments where ShippingCost NOT BETWEEN 30000 AND 70000 AND DestinationCity IN ('Mumbai', 'Delhi').
*/

-- Write your SQL Query below:




-- QUESTION 8 [Scenario - Exact String Length Pattern Matching]:
/*
Scenario: Searching logistics sender handles.
Task: Select shipments where SenderName starts with 'A', ends with 'n', and has EXACTLY 6 characters ('A____n').
*/

-- Write your SQL Query below:




-- QUESTION 9 [Scenario - Domain Exclusion Filtering]:
/*
Scenario: Quality check filtering non-commercial emails.
Task: Select shipments where SenderEmail does NOT contain 'gmail' (NOT LIKE '%gmail%').
*/

-- Write your SQL Query below:




-- QUESTION 10 [Scenario - Vowel & Alphanumeric String Detection]:
/*
Scenario: Data cleansing user input strings.
Task:
1. Select shipments where SenderName contains any vowels (A, E, I, O, U).
2. Select shipments where SenderName contains BOTH letters AND numeric digits ('%[A-Za-z]%' AND '%[0-9]%').
*/

-- Write your SQL Queries below:




-- ============================================================
-- SECTION 4: LOGIC BUILDER & BOUNDARY DRILLS
-- ============================================================

-- QUESTION 11 [Logic Builder - Simulating BETWEEN without BETWEEN]:
/*
Task: Write a query selecting shipments where ShippingCost is between 25000 and 75000 using only relational operators (>= and <=), without using BETWEEN or LIKE.
*/

-- Write your SQL Query below:




-- QUESTION 12 [Logic Builder - Counting Underscores in LIKE Patterns]:
/*
Task: Explain why 'LIKE 'A__b'' matches a 4-character string while 'LIKE 'A%b'' matches a string of any length.
*/

-- Write your explanation in comments below:




-- QUESTION 13 [Debugging - Correct AND vs OR Logic Errors]:
/*
Task: Identify the error in the query below and write the corrected version:
-- Buggy Query: Select * from ShipmentLog where SenderName LIKE '%[A-Za-z]%' OR SenderName LIKE '%[0-9]%'
(Goal: Must contain BOTH letters AND numbers).
*/

-- Write your explanation and corrected SQL Query below:




-- QUESTION 14 [Debugging - Negated Wildcard Bracket Errors]:
/*
Task: Identify why 'LIKE '^A%'' fails to match names not starting with A, and write the corrected bracket syntax.
*/

-- Write your explanation & corrected query below:




/* ============================================================
                   END OF DAY 3 PRACTICE
   ============================================================ */
