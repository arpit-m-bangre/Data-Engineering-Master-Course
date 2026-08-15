/*================================================================
                        DAY 4 - AUGUST 7
                 BRAINSTORM / CLASS NOTES
==================================================================*/


/*================================================================
1. BASIC GROUP BY
==================================================================*/

SELECT *
FROM emp;


EXEC sp_rename 'emp.org_id', 'dept';


SELECT
    dept,
    SUM(salary) AS sum_salary
FROM emp
GROUP BY dept;


SELECT
    dept,
    SUM(salary) AS total_salary
FROM emp
GROUP BY dept;


/*----------------------------------------------------------------
Sequence of Execution
------------------------------------------------------------------

FROM emp
GROUP BY dept
SELECT dept, SUM(salary)

• GROUP BY dept  -> 1st column is fixed
• SELECT dept, SUM(salary)
  -> 2nd column can be any aggregate column
*/


/*================================================================
2. SEQUENCE OF USING CLAUSES
==================================================================*/

/*
Sequence of clauses:

WHERE
GROUP BY
HAVING
ORDER BY
*/


/*================================================================
3. GROUP BY WITH WHERE
==================================================================*/

SELECT
    dept,
    SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL
GROUP BY dept;


SELECT
    dept,
    SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL
  AND empname LIKE '%a%'
GROUP BY dept;


/*----------------------------------------------------------------
Sequence of Execution
------------------------------------------------------------------

FROM emp
WHERE dept

NOTE:
WHERE clause can be applied on any column which is displaying
and also on a column which is not displaying.

It is an independent clause.

GROUP BY dept
-> 1st column

SELECT dept, SUM(salary)
-> 2nd column / aggregate column
*/


/*================================================================
4. IN-CLASS TASK
==================================================================*/

/*
Table Columns:

id
name
city
age

Question:

Find city-wise student count.

Conditions:
• City should not be NULL
• Age should be between 18 and 30
*/


CREATE TABLE student_dumy
(
    id   INT,
    name VARCHAR(10),
    city VARCHAR(10),
    age  INT
);


INSERT INTO student_dumy
VALUES
    (1, 'arpit', 'nagpur', 22),
    (1, 'arpit', 'nagpur', 22);

-- Add more records


SELECT
    city,
    COUNT(id) AS student_count
FROM student_dumy
WHERE city IS NOT NULL
  AND age BETWEEN 18 AND 30
GROUP BY city;


/*----------------------------------------------------------------
TIP
------------------------------------------------------------------

Write the query in execution order.

Start writing like:

FROM ...
WHERE ...
GROUP BY ...
SELECT ...
*/


/*================================================================
5. MULTIPLE AGGREGATE FUNCTIONS WITH GROUP BY
==================================================================*/

-- We can use multiple aggregate functions
-- in a GROUP BY query.


SELECT
    city,
    COUNT(id) AS student_count,
    AVG(age) AS age_avg
FROM student_dumy
WHERE city IS NOT NULL
  AND age BETWEEN 18 AND 30
GROUP BY city;


/*----------------------------------------------------------------
IMPORTANT NOTE
------------------------------------------------------------------

On an aggregate function, we cannot use WHERE.

For filtering an aggregate function,
we use HAVING.

Example:

AVG(marks) is an aggregate function.

If we want:

AVG(marks) > 75

then we use:

HAVING AVG(marks) > 75
*/


/*================================================================
6. HAVING
==================================================================*/

SELECT
    dept,
    SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL
  AND empname LIKE '%a%'
GROUP BY dept
HAVING SUM(salary) > 2000;


/*----------------------------------------------------------------
IMPORTANT NOTE
------------------------------------------------------------------

If we are using an aggregate function and want to apply
a filter on that aggregate function, we use HAVING.

Example:

AVG(marks) is an aggregate function.

If we want to filter:

AVG(marks) > 75

then we use:

HAVING AVG(marks) > 75
*/


/*----------------------------------------------------------------
Sequence of Execution
------------------------------------------------------------------

FROM emp
WHERE
GROUP BY dept
-> 1st column fixed

HAVING SUM(salary)
-> aggregate filter

SELECT dept, SUM(salary)
-> 2nd column
*/


/*================================================================
7. ALIAS WITH HAVING
==================================================================*/

SELECT
    dept,
    SUM(salary) AS total_salary
FROM emp
WHERE dept IS NOT NULL
  AND empname LIKE '%a%'
GROUP BY dept
HAVING total_salary > 2000;


/*----------------------------------------------------------------
NOTE:

We can't use total_salary here because HAVING does not know
what total_salary is.

HAVING runs before SELECT.

In SELECT, we are creating:

SUM(salary) AS total_salary

Error:

Invalid column name 'total_salary'.
*/


/*================================================================
8. IN-CLASS TASK - HAVING
==================================================================*/

/*
Table Columns:

id
name
sub
marks
age

Question:

• Subject-wise average marks
• Subject-wise student count
• Marks > 35
• Average marks < 50
• Count > 5
• Name should contain 'R'
*/


CREATE TABLE student_dumy2
(
    id    INT,
    name  VARCHAR(10),
    sub   VARCHAR(10),
    marks INT,
    age   INT
);


INSERT INTO student_dumy2 (id, name, sub, marks, age) VALUES
    (1,  'arpit',       'Maths',    40, 22),
    (2,  'rahul',       'Maths',    42, 21),
    (3,  'rohit',       'Maths',    45, 23),
    (4,  'ravi',        'Maths',    48, 22),
    (5,  'raj',         'Maths',    44, 24),
    (6,  'rakesh',      'Maths',    46, 21),
    (7,  'aman',        'Maths',    50, 22),
    (8,  'priya',       'Maths',    52, 23),
    (9,  'neha',        'Maths',    60, 21),
    (10, 'rohan',       'Science',  38, 22),
    (11, 'rahul',       'Science',  41, 21),
    (12, 'ravi',        'Science',  43, 23),
    (13, 'rohit',       'Science',  47, 22),
    (14, 'raj',         'Science',  45, 24),
    (15, 'rakesh',      'Science',  49, 21),
    (16, 'arpit',       'Science',  55, 22),
    (17, 'aman',        'Science',  65, 23),
    (18, 'neha',        'Science',  70, 21),
    (19, 'rahul',       'English',  36, 22),
    (20, 'rohit',       'English',  39, 21),
    (21, 'ravi',        'English',  42, 23),
    (22, 'raj',         'English',  44, 22),
    (23, 'rakesh',      'English',  46, 24),
    (24, 'rohan',       'English',  48, 21),
    (25, 'arpit',       'English',  72, 22),
    (26, 'aman',        'English',  75, 23),
    (27, 'arpit',       'Computer', 80, 22),
    (28, 'rahul',       'Computer', 82, 21),
    (29, 'rohit',       'Computer', 78, 23),
    (30, 'ravi',        'Computer', 85, 22),
    (31, 'raj',         'Computer', 88, 24),
    (32, 'rakesh',      'Computer', 90, 21),
    (33, 'rohan',       'Computer', 92, 22),
    (34, 'aman',        'Computer', 75, 23),
    (35, 'rahul',       'History',  40, 22),
    (36, 'rohit',       'History',  42, 21),
    (37, 'ravi',        'History',  45, 23),
    (38, 'raj',         'History',  47, 22),
    (39, 'rakesh',      'History',  44, 24),
    (40, 'rohan',       'History',  46, 21),
    (41, 'arpit',       'History',  48, 22),
    (42, 'aman',        'History',  55, 23),
    (43, 'rohit',       'Maths',    30, 22),
    (44, 'rahul',       'Science',  25, 21),
    (45, 'ravi',        'English',  35, 23),
    (46, 'aman',        'Maths',    40, 22),
    (47, 'neha',        'Science',  45, 21),
    (48, 'priya',       'English',  48, 23),
    (49, 'sneha',       'History',  42, 22),
    (50, 'rohan',       'Maths',    95, 22),
    (51, 'rahul',       'Science',  98, 21),
    (52, 'ravi',        'English',  96, 23);


SELECT
    sub,
    AVG(marks) AS avg_marks,
    COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35
  AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50
   AND COUNT(id) > 5;


/*----------------------------------------------------------------
NOTE:

Query-writing approach:

See the notebook and brainstorm.

Approach:

Word problem
    ↓
Break it down step by step
    ↓
Write the query
*/


/*================================================================
9. ORDER BY
==================================================================*/

/*
ORDER BY is used to sort a column.

ASC  -> Ascending order
DESC -> Descending order
*/


SELECT *
FROM emp;


/*----------------------------------------------------------------
Salary in Ascending Order
------------------------------------------------------------------

ASC is the default order.
*/


SELECT *
FROM emp
ORDER BY salary ASC;


SELECT *
FROM emp
ORDER BY salary;


/*----------------------------------------------------------------
Salary in Descending Order
----------------------------------------------------------------*/

SELECT *
FROM emp
ORDER BY salary DESC;


/*----------------------------------------------------------------
ORDER BY can show any column
----------------------------------------------------------------*/

SELECT empname
FROM emp
ORDER BY salary DESC;


/*----------------------------------------------------------------
IMPORTANT NOTE

ORDER BY is also an independent clause.
*/


/*================================================================
10. SCENARIO 1
==================================================================*/

SELECT *
FROM emp;

/*
On the above query I can use:

• WHERE clause
• ORDER BY clause

Since both are independent clauses.
*/


/*================================================================
11. SCENARIO 2
==================================================================*/

SELECT dept
FROM emp
WHERE id = 2
ORDER BY id;


/*
Error:

Msg 207, Level 16, State 1
Invalid column name 'id'.

Reason:
The emp table does not have a column named id.
*/


/*----------------------------------------------------------------
NOTE
------------------------------------------------------------------

WHERE column can be applied on any column in the table,
whether that column is being displayed or not.

HAVING, ORDER BY and GROUP BY can be applied on
the columns in use.
*/


/*================================================================
12. SCENARIO 3 - TRICKY QUESTION
==================================================================*/

/*
How many clauses can be used in the following query?
*/


SELECT MAX(salary)
FROM emp;


/*
Answer:

No clause.

Only one value will be shown.
*/


/*================================================================
13. SCENARIO 4
==================================================================*/

SELECT
    dept,
    MAX(salary)
FROM emp;


/*
All clauses can be used here.
*/


/*================================================================
14. USING ORDER BY WITH PREVIOUSLY WRITTEN QUERY
==================================================================*/

SELECT
    sub,
    AVG(marks) AS avg_marks,
    COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35
  AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50
   AND COUNT(id) > 5
ORDER BY COUNT(id);


/*----------------------------------------------------------------
Sequence is important.

FROM emp
WHERE
GROUP BY dept
-> 1st column fixed

HAVING AVG(marks)
-> 2nd column / aggregate filter

SELECT dept, AVG(salary)

ORDER BY
*/


/*================================================================
15. IMPORTANT - ALIAS WITH ORDER BY
==================================================================*/

/*
Why can we use an alias with ORDER BY
but not with HAVING?
*/


SELECT
    sub,
    AVG(marks) AS avg_marks,
    COUNT(id) AS No_of_student_sub
FROM student_dumy2
WHERE marks > 35
  AND name LIKE '%r%'
GROUP BY sub
HAVING AVG(marks) < 50
   AND COUNT(id) > 5
ORDER BY avg_marks;


/*
We can use the alias because ORDER BY knows
the avg_marks alias at that stage.
*/


/*================================================================
16. TASK BY SUMEDHA MA'AM
   SCENARIO-BASED QUESTIONS
==================================================================*/

/*
NOTE:
Do it in Notepad or Sticky Note.
*/


/*----------------------------------------------------------------
QUESTION 1
------------------------------------------------------------------

From the Employees table, find the total salary per department
for employees who joined after 2020, and show only those
departments where the total salary is more than 3,00,000.

Order the result by total salary descending.
*/


/*----------------------------------------------------------------
QUESTION 2
------------------------------------------------------------------

In the Sales table, calculate the total sales amount done by
each salesperson for products priced above 500.

Display only those salespersons whose total sales exceed 50,000.

Sort the output alphabetically by salesperson name.
*/


/*----------------------------------------------------------------
QUESTION 3
------------------------------------------------------------------

From the Orders table, count how many orders each customer
placed in the year 2023, but include only those orders where
the order amount is greater than 1,000.

Show customers who placed at least 5 such orders,
sorted by number of orders descending.
*/


/*----------------------------------------------------------------
QUESTION 4
------------------------------------------------------------------

In the Products table, calculate the average price for each
product category, considering only products with stock > 50.

Display categories where the average price is greater than 2,000,
sorted by category name.
*/


/*----------------------------------------------------------------
QUESTION 5
------------------------------------------------------------------

From the Transactions table, calculate the total transaction
amount for each customer for transactions made using
UPI or Credit Card only.

Show customers whose total amount exceeds 10,000,
arranged by customer ID in ascending order.
*/


/*----------------------------------------------------------------
QUESTION 6
------------------------------------------------------------------

In the Bookings table, group bookings by hotel and find the
minimum room price booked in each hotel, but consider only
bookings made for more than 2 nights.

Show hotels where the minimum booked price is below 1,500,
sorted by minimum price ascending.
*/


/*----------------------------------------------------------------
QUESTION 7
------------------------------------------------------------------

From the Subscriptions table, group data by plan type and count
how many users subscribed, but only include subscriptions where
the user's country is 'India' or 'Nepal'.

Display plans with at least 200 subscribers,
ordered by subscriber count.
*/


/*----------------------------------------------------------------
QUESTION 8
------------------------------------------------------------------

In the Inventory table, calculate the total stock per supplier
for items whose expiry date is after today.

List suppliers where the stock sum is above 1,000,
sorted by supplier name descending.
*/


/*----------------------------------------------------------------
QUESTION 9
------------------------------------------------------------------

From the Expenses table, group expenses by expense type,
considering only records where the expense amount is
between 500 and 5,000.

Display expense types whose average expense is above 1,000,
ordered by the average value descending.
*/


/*================================================================
                    END OF DAY 4 NOTES
==================================================================*/
