/*================================================================
   SQL CLASS NOTES - 02 AUGUST 2026 (DAY 2)
   TOPICS: SQL FILTERS, WHERE CLAUSE, COMPARISON & LOGICAL OPERATORS, LIKE WILDCARDS
==================================================================*/


/*================================================================
1. WHERE CLAUSE (THE BOUNCER)
==================================================================*/

/*----------------------------------------------------------------
Theory:
The WHERE clause acts like a club bouncer.
It checks each row one-by-one.
If the row meets the criteria, it is let in; otherwise, it is kicked out.
------------------------------------------------------------------*/

SELECT * FROM employee1;


/*================================================================
2. COMPARISON OPERATORS
==================================================================*/

-- Filters single column / single value: = , <> , < , <= , > , >=
SELECT * FROM employee1 WHERE dept = 'HR';


SELECT * FROM employee1 WHERE dept <> 'HR';

/*----------------------------------------------------------------
Note:
The <> (not equal) operator ignores NULLs.
To find NULLs, you must use IS NULL.
------------------------------------------------------------------*/


-- Text comparison follows alphabetical (ASCII) order:
SELECT * FROM employee1 WHERE dept < 'HR';
SELECT * FROM employee1 WHERE dept > 'HR';
SELECT * FROM employee1 WHERE dept <= 'HR';
SELECT * FROM employee1 WHERE dept >= 'HR';


/*================================================================
3. IN / NOT IN OPERATORS
==================================================================*/

-- Filters single column / multiple values
SELECT * FROM employee1 WHERE dept IN ('HR', 'Entc');        -- Include only these
SELECT * FROM employee1 WHERE dept NOT IN ('HR', 'Entc');    -- Exclude these


/*================================================================
4. IS NULL / IS NOT NULL
==================================================================*/

-- Filters for missing/blank data
SELECT * FROM employee1 WHERE dept IS NULL;       -- Show only NULLs
SELECT * FROM employee1 WHERE dept IS NOT NULL;   -- Show non-NULLs


/*================================================================
5. LOGICAL OPERATORS (AND / OR)
==================================================================*/

-- AND: Both rules must be true:
SELECT * FROM employee1 WHERE dept = 'HR' AND salary = 2000;


SELECT * FROM employee1 WHERE dept = 'HR' AND salary = 3000;

/*----------------------------------------------------------------
Note:
❌ Fails to return rows because Salary for HR is 2000, not 3000.
------------------------------------------------------------------*/


-- OR: At least one rule must be true:
SELECT * FROM employee1 WHERE dept = 'HR' OR salary = 3000;


/*================================================================
6. BETWEEN / NOT BETWEEN
==================================================================*/

-- Filters ranges (boundaries are inclusive)
SELECT * FROM employee1 WHERE salary BETWEEN 2000 AND 6000;   
SELECT * FROM employee1 WHERE empname BETWEEN 'A' AND 'M';    
SELECT * FROM employee1 WHERE empname NOT BETWEEN 'A' AND 'M';


/*================================================================
7. LIKE PATTERN MATCHING (WILDCARDS)
==================================================================*/

-- Wildcards: % = 0 or more characters, _ = exactly 1 character
SELECT * FROM employee1 WHERE empname LIKE 'A%';     -- Starts with A
SELECT * FROM employee1 WHERE empname LIKE '%h';     -- Ends with h
SELECT * FROM employee1 WHERE empname LIKE '%A%';    -- Contains A anywhere
SELECT * FROM employee1 WHERE empname LIKE 'R%A';    -- Starts with R, ends with A
SELECT * FROM employee1 WHERE empname LIKE '_m%';    -- Second character is m
SELECT * FROM employee1 WHERE empname LIKE '%m_';    -- Second-to-last character is m
SELECT * FROM employee1 WHERE empname NOT LIKE '_m%';-- Second character is NOT m
SELECT * FROM employee1 WHERE empname LIKE '[A,M]%'; -- Starts with A or M
SELECT * FROM employee1 WHERE empname LIKE '[A-Z]%'; -- Starts with A to Z range
SELECT * FROM employee1 WHERE empname LIKE '[^A-Z]%';-- Does NOT start with A-Z


/*================================================================
8. SYSTEM METADATA AUDIT
==================================================================*/

SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES;


/*================================================================
9. SEED DATA: StudentInfo
==================================================================*/

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
INSERT INTO StudentInfo VALUES (121, 'Tanvi', 'Ahmedabad', 'Gujarat', 89, NULL, 'tanvi.shah@gmail.com', 887766554);\n