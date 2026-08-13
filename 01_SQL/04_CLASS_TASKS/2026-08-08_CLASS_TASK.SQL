/* ============================================================
               CLASS TASK - 8 AUGUST 2026 (2026-08-08_CLASS_TASK.SQL)
               TOPICS: FACULTY COMPLEX GROUP BY & HAVING EXERCISES
               STATUS: COMPLETED BY STUDENT
   ============================================================ */

-- ============================================================
-- FACULTY TASK QUESTIONS & EXECUTABLE SOLUTIONS
-- ============================================================

-- QUESTION 1 [Department Salary Threshold & City Filter]:
/*
Task: Find departments where:
- Employee salary is greater than 55,000
- Only consider employees from Pune or Mumbai
- Department should have at least 2 qualifying employees
- Average salary of qualifying employees should be greater than 65,000

Display: Department, Average Salary (aliased as avg_sal)
Sort by: Average Salary descending.
*/

SELECT
    dept,
    AVG(salary) AS avg_sal
FROM EmployeeMaster
WHERE city IN ('Pune', 'Mumbai')
  AND salary > 55000
GROUP BY dept
HAVING COUNT(employee) >= 2
   AND AVG(salary) > 65000
ORDER BY avg_sal DESC;


-- QUESTION 2 [Region Completed Sales Volume Screening]:
/*
Task: Find regions where:
- Only Completed sales should be considered (sales_status = 'completed')
- Sale amount should be greater than 4,000
- Region must have at least 2 qualifying sales
- Total sales amount must be greater than 12,000

Display: Region, Total Sales (aliased as total_sales)
Sort by: Total Sales ascending.
*/

SELECT
    regions,
    SUM(sales) AS total_sales
FROM SalesMaster
WHERE sales_status = 'completed'
  AND sales_amount > 4000
GROUP BY regions
HAVING COUNT(sales) >= 2
   AND SUM(sales) > 12000
ORDER BY total_sales ASC;


-- QUESTION 3 [Recent Joiner Department Salary Audit]:
/*
Task: Find departments where:
- Employees who joined on or after 1-Jan-2023 should be considered (join_date >= '2023-01-01')
- Salary must be at least 70,000
- Department should have more than 1 employee
- Average salary should be greater than 80,000

Display: Department, Average Salary (aliased as avg_salary)
Sort by: Average Salary descending.
*/

SELECT
    dept,
    AVG(salary) AS avg_salary
FROM EmployeeMaster
WHERE join_date >= '2023-01-01'
  AND salary >= 70000
GROUP BY dept
HAVING COUNT(emp) > 1
   AND AVG(salary) > 80000
ORDER BY avg_salary DESC;


-- QUESTION 4 [Product Category Sold Volume Screening]:
/*
Task: Find categories where:
- Only Sold products should be considered (prod = 'sold')
- Price must be greater than 5,000
- Category must have at least 2 qualifying products
- Total quantity must be greater than 5

Display: Category, Total Quantity (aliased as total_quantity)
Sort by: Total Quantity descending.
*/

SELECT
    cat,
    SUM(qty) AS total_quantity
FROM ProductsMaster
WHERE prod = 'sold'
  AND price > 5000
GROUP BY cat
HAVING COUNT(prod) >= 2
   AND SUM(qty) > 5
ORDER BY total_quantity DESC;


-- QUESTION 5 [Experienced Staff Department Salary Audit]:
/*
Task: Find departments where:
- Consider only employees having Experience >= 3 years
- Salary must be >= 60,000
- Department must have at least 2 qualifying employees
- Average salary of qualifying employees must be greater than 75,000

Display: Department, Average Salary
Sort by: Average Salary descending.
*/

SELECT
    dept,
    AVG(salary) AS avg_salary
FROM EmployeeMaster
WHERE exp >= 3
  AND salary >= 60000
GROUP BY dept
HAVING COUNT(empid) >= 2
   AND AVG(salary) > 75000
ORDER BY avg_salary DESC;

/* ============================================================
                   END OF CLASS TASK (8 AUG 2026)
   ============================================================ */
