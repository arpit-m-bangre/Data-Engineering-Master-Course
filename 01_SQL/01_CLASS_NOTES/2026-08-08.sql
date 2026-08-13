/* ============================================================
                    SQL PRACTICE
                    08 AUGUST 2026

            COMPLEX SCENARIO-BASED QUESTIONS
   ============================================================ */


/* ------------------------------------------------------------
QUESTION 1 - FINANCE BONUS ELIGIBILITY
---------------------------------------------------------------
Consider only employees earning more than ₹40,000.

Find departments having:
    • At least 6 employees
    • Average salary greater than ₹75,000
    • Maximum experience more than 10 years

Display:
    • Department
    • Employee Count
    • Average Salary
    • Maximum Experience

Sort by Average Salary (Highest First).
*/

SELECT
    dept,
    COUNT(empid) AS employee_count,
    AVG(salary)  AS avg_salary,
    MAX(exp)     AS max_experience
FROM emp
WHERE salary > 40000
GROUP BY dept
HAVING COUNT(empid) >= 6
   AND AVG(salary) > 75000
   AND MAX(exp) > 10
ORDER BY avg_salary DESC;


/*
MISTAKE:
No major mistake here. ✅

Your logic was correct:
WHERE    → salary filter
GROUP BY → department-wise
HAVING   → aggregate filters
ORDER BY → average salary descending
*/


/* ------------------------------------------------------------
QUESTION 2 - CITY PERFORMANCE
---------------------------------------------------------------
Ignore employees aged below 25.

Find cities where:
    • Employee count is at least 8
    • Minimum salary is above ₹30,000
    • Average experience is greater than 5 years

Display:
    • City
    • Count
    • Minimum Salary
    • Average Experience

Sort by Employee Count descending.
*/

SELECT
    city,
    COUNT(empid) AS employee_count,
    MIN(salary)  AS min_salary,
    AVG(exp)     AS avg_experience
FROM emp
WHERE age >= 25
GROUP BY city
HAVING COUNT(empid) >= 8
   AND MIN(salary) > 30000
   AND AVG(exp) > 5
ORDER BY employee_count DESC;


/*
MISTAKES IN YOUR QUERY:

1. You wrote:
   WHERE age < 25

   But the question says:
   "Ignore employees aged below 25."

   Therefore:
   WHERE age >= 25

2. You forgot:
   GROUP BY city

3. You wrote:
   COUNT(emp) > 8

   Question says:
   "At least 8"

   Therefore:
   COUNT(empid) >= 8
*/


/* ------------------------------------------------------------
QUESTION 3 - DEPARTMENT SCREENING
---------------------------------------------------------------
Consider only Female employees.

Find departments where:
    • Employee count is at least 4
    • Total salary exceeds ₹5,00,000
    • Highest salary is above ₹1,20,000

Sort by Total Salary descending.
*/

SELECT
    dept,
    COUNT(empid) AS employee_count,
    SUM(salary)  AS total_salary,
    MAX(salary)  AS max_salary
FROM table_name
WHERE employee_gender = 'female'
GROUP BY dept
HAVING COUNT(empid) >= 4
   AND SUM(salary) > 500000
   AND MAX(salary) > 120000
ORDER BY total_salary DESC;


/*
MISTAKE:

You wrote:
MAX(salary) > 1200000

But the question says:
₹1,20,000

Therefore:
MAX(salary) > 120000
*/


/* ------------------------------------------------------------
QUESTION 4 - SALARY AUDIT
---------------------------------------------------------------
Ignore employees with experience less than 3 years.

Find cities where:
    • Average salary is between ₹60,000 and ₹90,000
    • Employee count is greater than 5

Display:
    • City
    • Average Salary
    • Count

Sort by Average Salary descending.
*/

SELECT
    city,
    AVG(salary)  AS avg_salary,
    COUNT(empid) AS employee_count
FROM table_name
WHERE exp >= 3
GROUP BY city
HAVING COUNT(empid) > 5
   AND AVG(salary) BETWEEN 60000 AND 90000
ORDER BY avg_salary DESC;


/*
MISTAKE:
No major mistake. ✅

Your query logic was correct.
*/


/* ------------------------------------------------------------
QUESTION 5 - PROMOTION LIST
---------------------------------------------------------------
Consider only employees aged 30 or above.

Find departments where:
    • Average experience is greater than 8 years
    • Minimum salary is at least ₹50,000
    • Employee count is more than 3

Display:
    • Department
    • Average Experience
    • Minimum Salary
    • Count

Sort by Average Experience descending.
*/

SELECT
    dept,
    AVG(exp)     AS avg_experience,
    MIN(salary)  AS min_salary,
    COUNT(empid) AS employee_count
FROM table_name
WHERE age >= 30
GROUP BY dept
HAVING AVG(exp) > 8
   AND MIN(salary) >= 50000
   AND COUNT(empid) > 3
ORDER BY avg_experience DESC;


/*
MISTAKE:

You wrote:
MIN(sal)

But your other queries use:
salary

Therefore:
MIN(salary)
*/


/* ------------------------------------------------------------
QUESTION 6 - MOST TRICKY
---------------------------------------------------------------
Ignore employees whose salary is less than ₹45,000.

Group the data only by Department.

Return only those departments where:
    • Employee count is between 5 and 10
    • Average salary is greater than ₹70,000
    • Maximum salary is greater than ₹1,20,000
    • Minimum experience is at least 2 years

Display:
    • Department
    • Employee Count
    • Average Salary
    • Maximum Salary
    • Minimum Experience

Finally, sort by:
    • Average Salary descending
    • Department ascending
*/

SELECT
    dept,
    COUNT(empid) AS employee_count,
    AVG(salary)  AS avg_salary,
    MAX(salary)  AS max_salary,
    MIN(exp)     AS min_experience
FROM table_name
WHERE salary >= 45000
GROUP BY dept
HAVING COUNT(empid) BETWEEN 5 AND 10
   AND AVG(salary) > 70000
   AND MAX(salary) > 120000
   AND MIN(exp) >= 2
ORDER BY avg_salary DESC,
         dept ASC;


/*
MISTAKES:

1. You wrote:
   AVG(salary) > 700000

   Question says:
   Average salary > ₹70,000

   Correct:
   AVG(salary) > 70000


2. You wrote:
   ORDER BY average salary DESC

   This is not valid SQL syntax.

   Correct approach:
   AVG(salary) AS avg_salary

   and then:
   ORDER BY avg_salary DESC


3. You did not display COUNT(emp)
   even though the question asks for:
   Employee Count

   So COUNT(empid) should be included in SELECT.


===============================================================
IMPORTANT NOTES
===============================================================

1. In most real scenarios, ORDER BY can contain multiple columns.
   Example:
   ORDER BY avg_salary DESC, dept ASC


2. In real-world tables, we usually don't have an Experience column.
   Instead, we generally have a Date of Joining column and calculate experience from it.


3. In interviews, they may ask you to:
   • Share your screen
   • Open Notepad
   • Write the SQL query without looking at notes


4. DISTINCT is generally used to remove duplicate combinations from the selected result.


===============================================================
                    QUICK MISTAKE SUMMARY
===============================================================

Q1 → ✅ Correct

Q2 →
    ❌ age < 25
    ✅ age >= 25

    ❌ Missing GROUP BY city

    ❌ COUNT > 8
    ✅ COUNT >= 8

Q3 →
    ❌ 1200000
    ✅ 120000

Q4 → ✅ Correct

Q5 →
    ❌ MIN(sal)
    ✅ MIN(salary)

Q6 →
    ❌ AVG(salary) > 700000
    ✅ AVG(salary) > 70000

    ❌ ORDER BY average salary
    ✅ ORDER BY avg_salary

    ❌ Employee Count missing from SELECT
    ✅ COUNT(empid) AS employee_count


===============================================================
                    MAIN LEARNING
===============================================================

WHERE
→ Filters individual rows

GROUP BY
→ Creates groups

HAVING
→ Filters groups using aggregate conditions

ORDER BY
→ Sorts the final result

Remember:
WHERE  → ROWS
HAVING → GROUPS

"department-wise / city-wise / category-wise"
→ GROUP BY

===============================================================
*/