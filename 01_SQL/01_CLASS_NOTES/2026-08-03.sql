-- ============================================================
-- CLASS TASK - SQL FILTERING PRACTICE
-- ============================================================

/*
1. Retrieve employees whose salary is not between 40,000 and 70,000,
   but whose department is either 'HR' or 'IT'.
*/
SELECT *
FROM Employee1
WHERE Salary NOT BETWEEN 40000 AND 70000
  AND dept IN ('HR', 'IT');


/*
2. Find employees whose name starts with 'A',
   ends with 'n', and has exactly 6 characters.
*/
SELECT *
FROM Employee1
WHERE EmpName LIKE 'A____n';
-- A + 4 characters + n = Total 6 characters


/*
3. Display students whose email does not contain 'gmail'.
*/
SELECT *
FROM StudentInfo
WHERE Email_ID NOT LIKE '%gmail%';


/*
4. Display employee names that contain vowels.
*/
SELECT *
FROM Employee1
WHERE EmpName LIKE '%A%'
   OR EmpName LIKE '%E%'
   OR EmpName LIKE '%I%'
   OR EmpName LIKE '%O%'
   OR EmpName LIKE '%U%'
   OR EmpName LIKE '%a%'
   OR EmpName LIKE '%e%'
   OR EmpName LIKE '%i%'
   OR EmpName LIKE '%o%'
   OR EmpName LIKE '%u%';


/*
5. Display names that contain both letters and numbers.
*/
SELECT *
FROM Employee1
WHERE EmpName LIKE '%[A-Za-z]%'
  AND EmpName LIKE '%[0-9]%';


/*
6. Display students whose marks are between 50 and 80
   without using BETWEEN or LIKE.
*/
SELECT *
FROM StudentInfo
WHERE Marks >= 50
  AND Marks <= 80;