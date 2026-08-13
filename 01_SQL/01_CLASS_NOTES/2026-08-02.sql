SELECT * FROM employee1;

-- To delete or update a specific value or row, we have to know filters first.

-- ============================================================
-- FILTERS IN SQL (used daily in company)
-- ============================================================

-- SQL CLAUSES
/*
1. WHERE
2. GROUP BY
3. HAVING
4. ORDER BY

-- In interviews they will ask how to use all clauses together.
*/


-- ------------------------------------------------------------
-- 1) WHERE CLAUSE (used to filter data)
-- ------------------------------------------------------------

-- 1.1) Comparison operators
--      Used to filter: Single column, Single value
--      = , <> , < , <= , > , >=   -> six operators available for comparison

-- Syntax: SELECT * FROM table_name WHERE COL_NAME = value;

SELECT * FROM employee1 WHERE dept = 'HR';
SELECT * FROM employee1 WHERE dept <> 'HR';
/*
102	Puja	    Entc	     3000
103	Arpit	    Stat	     4000
104	Sidhant	    Electronics  5000
105	Mohit	    MS	         6000
106	Shreyash    BCA	         7000
111	Arjun		             0
NULL	NULL	Mech	     8000

Note: the <> operator does not consider NULL;
      for that we have to use a different operator (IS NULL / IS NOT NULL)
*/

SELECT * FROM employee1 WHERE dept < 'HR';
SELECT * FROM employee1 WHERE dept > 'HR';
SELECT * FROM employee1 WHERE dept <= 'HR';
SELECT * FROM employee1 WHERE dept >= 'HR';

-- For characters, comparison follows ASCII code / alphabetical order.


-- 1.2) IN operator
--      Single column, Multiple values

SELECT * FROM employee1 WHERE dept IN ('HR', 'Entc');        -- include
SELECT * FROM employee1 WHERE dept NOT IN ('HR', 'Entc');    -- exclude


-- 1.3) IS NULL operator

SELECT * FROM employee1 WHERE dept IS NULL;       -- show all NULLs
SELECT * FROM employee1 WHERE dept IS NOT NULL;   -- show all non-NULLs


-- 1.4) Logical operators
--      AND / OR
--      Used to filter multiple columns

SELECT * FROM employee1 WHERE dept = 'hr' AND salary = 2000;  -- both conditions true: ANDing
SELECT * FROM employee1 WHERE dept = 'hr' AND salary = 3000;  -- both conditions not true: ANDing
SELECT * FROM employee1 WHERE dept = 'hr' OR salary = 3000;   -- one condition true: ORing


-- 1.5) BETWEEN operator
--      Used to filter a range

SELECT * FROM employee1 WHERE salary BETWEEN 2000 AND 6000;   -- 'AND' here is part of BETWEEN syntax
SELECT * FROM employee1 WHERE empname BETWEEN 'A' AND 'M';    -- A to M
SELECT * FROM employee1 WHERE empname NOT BETWEEN 'A' AND 'M';


-- 1.6) LIKE operator
--      Not an exact value — only a description/pattern is known
--      Used frequently in company work

-- Scenario: when you know the first character
SELECT * FROM employee1 WHERE empname LIKE 'A%';

-- last character
SELECT * FROM employee1 WHERE empname LIKE '%h';

-- somewhere in between
SELECT * FROM employee1 WHERE empname LIKE '%A%';

-- first and last character
SELECT * FROM employee1 WHERE empname LIKE 'R%A';

-- NOTE: the above patterns are the ones mostly used in companies;
--       the ones below are less important, just for practice

-- second character
SELECT * FROM employee1 WHERE empname LIKE '_m%';

-- second-last character
SELECT * FROM employee1 WHERE empname LIKE '%m_';

-- second character NOT matching
SELECT * FROM employee1 WHERE empname NOT LIKE '_m%';

-- multiple starting characters
SELECT * FROM employee1 WHERE empname LIKE '[A,M]%';

-- multiple starting characters, in a range
SELECT * FROM employee1 WHERE empname LIKE '[A-Z]%';

-- multiple starting characters, NOT in a range (using ^)
SELECT * FROM employee1 WHERE empname LIKE '[^A-Z]%';

-- NOTE: % and _ are known as wildcards


-- ============================================================
-- TO KNOW THE TABLE NAMES IN DB
-- ============================================================

SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM StudentInfo;

INSERT INTO StudentInfo VALUES (101, 'Arpit', 'Nagpur', 'Stat', 65, 22, 'arpit.m.bangre@gmail.com', 992342352);
INSERT INTO StudentInfo VALUES (102, 'Rahul', 'Pune', 'Maharashtra', 72, 21, 'rahul.patil@gmail.com', 987654321);
INSERT INTO StudentInfo VALUES (103, 'Sneha', 'Mumbai', 'Maharashtra', 88, 20, 'sneha.joshi@gmail.com', 876543210);
INSERT INTO StudentInfo VALUES (104, 'Aman', 'Delhi', 'Delhi', 69, 23, 'aman.verma@gmail.com', 765432109);
INSERT INTO StudentInfo VALUES (105, 'Priya', 'Nagpur', 'Maharashtra', 91, 22, 'priya.sharma@gmail.com', 654321987);
INSERT INTO StudentInfo VALUES (106, 'Rohit', 'Bhopal', 'Madhya Pradesh', 58, 24, 'rohit.singh@gmail.com', 543219876);
INSERT INTO StudentInfo VALUES (107, 'Neha', 'Indore', 'Madhya Pradesh', NULL, 21, 'neha.kale@gmail.com', 432198765);
INSERT INTO StudentInfo VALUES (108, 'Karan', 'Hyderabad', 'Telangana', 76, NULL, 'karan.reddy@gmail.com', 321987654);
INSERT INTO StudentInfo VALUES (109, 'Pooja', 'Chennai', 'Tamil Nadu', 83, 22, NULL, 219876543);
INSERT INTO StudentInfo VALUES (110, 'Vikas', 'Jaipur', 'Rajasthan', 67, 20, 'vikas.meena@gmail.com', 198765432);
INSERT INTO StudentInfo VALUES (111, 'Anjali', 'Lucknow', 'Uttar Pradesh', 95, 23, 'anjali.singh@gmail.com', 987123456);
INSERT INTO StudentInfo VALUES (112, 'Sahil', 'Surat', 'Gujarat', 74, 21, 'sahil.patel@gmail.com', 876234567);
INSERT INTO StudentInfo VALUES (113, 'Komal', 'Nashik', 'Maharashtra', 81, NULL, 'komal.more@gmail.com', 765345678);
INSERT INTO StudentInfo VALUES (114, 'Yash', 'Aurangabad', 'Maharashtra', 55, 22, 'yash.kadam@gmail.com', 654456789);
INSERT INTO StudentInfo VALUES (115, 'Meena', NULL, 'Maharashtra', 79, 20, 'meena.deshmukh@gmail.com', 543567890);
INSERT INTO StudentInfo VALUES (116, 'Aditya', 'Kolhapur', 'Maharashtra', NULL, 24, NULL, 432678901);
INSERT INTO StudentInfo VALUES (117, 'Riya', 'Amravati', 'Maharashtra', 86, 19, 'riya.pawar@gmail.com', 321789012);
INSERT INTO StudentInfo VALUES (118, 'Nikhil', 'Goa', 'Goa', 71, 22, 'nikhil.naik@gmail.com', 210890123);
INSERT INTO StudentInfo VALUES (119, 'Sakshi', 'Noida', 'Uttar Pradesh', 93, 21, 'sakshi.gupta@gmail.com', 109901234);
INSERT INTO StudentInfo VALUES (120, 'Harsh', 'Bengaluru', 'Karnataka', 64, 23, 'harsh.jain@gmail.com', 998877665);
INSERT INTO StudentInfo VALUES (121, 'Tanvi', 'Ahmedabad', 'Gujarat', 89, NULL, 'tanvi.shah@gmail.com', 887766554);