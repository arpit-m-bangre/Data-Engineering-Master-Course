-- 14 aug 
-- topics till now are important but not that important for interview the more important is concept
-- the topics from tommorow onward are query perspective or scenario based important 


-- set operator 

-- 1 union 
-- 2 union all 
-- 3 intersect 
-- 4 except 

-- 1 union 
-- combine value but without duplicate 
-- example :
/*
A = {1,2,3,4}
B = {3,4,5,6}
A U B = { 1,2,3,4,5,6} 
So and 3 and 4 are there only once 
*/

-- 2 union all 
-- combine value with duplicates 
-- example:
/*
A = {1,2,3,4}
B = {3,4,5,6}
A U B = { 1,2,3,4,3,4,5,6} 
So and 3 and 4 are there only once 
*/

-- 3 Intersect 
-- common of both table 
/*
A = {1,2,3,4}
B = {3,4,5,6}
A intersect B = {3,4} 
So and 3 and 4 are there only once 
*/

-- 4 except 
-- like minus 
-- example 
-- A - B = { 1,2 }
-- B - A = { 5,6 } 

-------------------
-- Validation rule for set operaton 

-- 1 same column 
-- 2 same data type in same sequence 
-- but this are like very rare to find this validation that's why the set operation use very rare

/*
example 

bank table for all bank table strucutre same mostly 

cust id custname account_no adress mob email balance

so such scenario we can use set operations 
example union of boi xyz brank and boi abc bank union will give me combine customer list 
*/
