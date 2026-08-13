/* ============================================================
               CLASS TASK - 7 AUGUST 2026 (2026-08-07_CLASS_TASK.SQL)
               TOPICS: MULTI-DOMAIN DATASET, GROUP BY, HAVING,
                       WHERE vs HAVING, CLAUSE EXECUTION SEQUENCE
               STATUS: COMPLETED BY STUDENT
   ============================================================ */

-- ============================================================
-- 1. PRACTICE_DATASET SCHEMA CREATION
-- ============================================================

CREATE TABLE practice_data
(
    id INT,
    name VARCHAR(50),

    -- Department / Employee
    department VARCHAR(50),
    salary INT,
    join_date DATE,

    -- Sales
    salesperson VARCHAR(50),
    product_price INT,
    sales_amount INT,

    -- Orders / Customers
    customer_id INT,
    order_date DATE,
    order_amount INT,

    -- Products
    category VARCHAR(50),
    price INT,
    stock INT,

    -- Transactions
    transaction_amount INT,
    payment_method VARCHAR(30),

    -- Bookings
    hotel VARCHAR(50),
    room_price INT,
    nights INT,

    -- Subscriptions
    plan_type VARCHAR(50),
    country VARCHAR(50),

    -- Inventory
    supplier VARCHAR(50),
    expiry_date DATE,

    -- Expenses
    expense_type VARCHAR(50),
    expense_amount INT
);

-- ============================================================
-- 2. PRACTICE_DATASET MULTI-DOMAIN SAMPLE DATA INSERTION (25 ROWS)
-- ============================================================

INSERT INTO practice_data
(
    id, name, department, salary, join_date,
    salesperson, product_price, sales_amount,
    customer_id, order_date, order_amount,
    category, price, stock,
    transaction_amount, payment_method,
    hotel, room_price, nights,
    plan_type, country,
    supplier, expiry_date,
    expense_type, expense_amount
)
VALUES
(1, 'Arpit', 'HR', 45000, '2021-05-10', 'Rahul', 650, 12000, 101, '2023-01-10', 2500, 'Electronics', 2500, 120, 6000, 'UPI', 'Taj Hotel', 1200, 3, 'Premium', 'India', 'ABC Supplier', '2027-05-10', 'Travel', 2500),
(2, 'Rahul', 'IT', 65000, '2022-03-15', 'Priya', 800, 18000, 102, '2023-02-15', 3200, 'Electronics', 3000, 150, 7500, 'Credit Card', 'City Hotel', 1400, 5, 'Basic', 'Nepal', 'XYZ Supplier', '2027-08-15', 'Office', 1800),
(3, 'Rohit', 'IT', 72000, '2021-07-20', 'Amit', 900, 22000, 103, '2023-03-20', 4500, 'Furniture', 3200, 80, 4500, 'UPI', 'Grand Palace', 2000, 2, 'Premium', 'India', 'Global Supplier', '2028-01-25', 'Marketing', 4500),
(4, 'Aman', 'HR', 48000, '2019-11-05', 'Sneha', 1200, 30000, 104, '2023-04-12', 5200, 'Furniture', 2800, 95, 8500, 'Credit Card', 'Taj Hotel', 1800, 4, 'Enterprise', 'India', 'ABC Supplier', '2027-09-20', 'Travel', 3500),
(5, 'Priya', 'Finance', 58000, '2023-01-12', 'Rahul', 750, 16000, 105, '2023-05-18', 2800, 'Clothing', 1500, 200, 12000, 'UPI', 'City Hotel', 1500, 3, 'Premium', 'Nepal', 'XYZ Supplier', '2028-02-15', 'Office', 2200),
(6, 'Ravi', 'Finance', 62000, '2021-09-18', 'Priya', 1100, 27000, 101, '2023-06-22', 3500, 'Clothing', 1800, 180, 5500, 'Credit Card', 'Grand Palace', 2200, 4, 'Basic', 'India', 'Global Supplier', '2028-04-12', 'Marketing', 3200),
(7, 'Ajay', 'IT', 70000, '2020-06-25', 'Amit', 950, 19000, 102, '2023-07-14', 4200, 'Grocery', 800, 300, 7000, 'UPI', 'Taj Hotel', 1300, 3, 'Premium', 'India', 'ABC Supplier', '2027-11-10', 'Maintenance', 1500),
(8, 'Neha', 'HR', 52000, '2022-10-10', 'Sneha', 1300, 35000, 103, '2023-08-16', 1800, 'Grocery', 1200, 250, 4000, 'Cash', 'City Hotel', 1600, 5, 'Basic', 'Nepal', 'XYZ Supplier', '2027-12-20', 'Travel', 2800),
(9, 'Karan', 'Sales', 55000, '2021-02-14', 'Rahul', 850, 15000, 104, '2023-09-10', 2700, 'Electronics', 4200, 110, 9500, 'UPI', 'Grand Palace', 2100, 3, 'Enterprise', 'India', 'Global Supplier', '2028-03-18', 'Office', 1300),
(10, 'Sneha', 'Sales', 60000, '2023-04-20', 'Priya', 1500, 28000, 105, '2023-10-05', 5500, 'Electronics', 5000, 75, 6500, 'Credit Card', 'Taj Hotel', 1700, 4, 'Premium', 'India', 'ABC Supplier', '2028-05-22', 'Marketing', 4100),
(11, 'Vikas', 'Sales', 63000, '2022-08-12', 'Amit', 700, 14000, 101, '2023-11-12', 3100, 'Furniture', 3500, 65, 8000, 'UPI', 'City Hotel', 1250, 3, 'Basic', 'Nepal', 'XYZ Supplier', '2027-10-15', 'Travel', 1900),
(12, 'Meena', 'Finance', 67000, '2020-12-01', 'Sneha', 1800, 36000, 102, '2023-12-08', 4800, 'Furniture', 4500, 90, 11000, 'Credit Card', 'Grand Palace', 2300, 5, 'Enterprise', 'India', 'Global Supplier', '2028-06-10', 'Office', 2400),
(13, 'Suresh', 'IT', 75000, '2023-06-15', 'Rahul', 1250, 25000, 103, '2023-01-25', 2200, 'Clothing', 2200, 140, 6000, 'UPI', 'Taj Hotel', 1450, 3, 'Premium', 'India', 'ABC Supplier', '2028-07-15', 'Marketing', 3800),
(14, 'Pooja', 'HR', 47000, '2021-03-11', 'Priya', 600, 11000, 104, '2023-02-28', 2600, 'Clothing', 1700, 220, 5000, 'Cash', 'City Hotel', 1550, 4, 'Basic', 'Nepal', 'XYZ Supplier', '2028-08-20', 'Maintenance', 900),
(15, 'Nitin', 'Sales', 59000, '2018-07-19', 'Amit', 2000, 42000, 105, '2023-03-15', 3900, 'Grocery', 900, 350, 13500, 'UPI', 'Grand Palace', 1900, 3, 'Premium', 'India', 'Global Supplier', '2028-09-12', 'Travel', 4500),
(16, 'Rakesh', 'IT', 68000, '2021-11-25', 'Sneha', 950, 21000, 101, '2023-04-18', 5100, 'Electronics', 2800, 130, 7200, 'Credit Card', 'Taj Hotel', 1350, 5, 'Enterprise', 'India', 'ABC Supplier', '2028-10-05', 'Office', 1700),
(17, 'Riya', 'Finance', 61000, '2022-01-30', 'Rahul', 1400, 29000, 102, '2023-05-22', 2300, 'Furniture', 3800, 85, 4800, 'UPI', 'City Hotel', 1200, 3, 'Basic', 'Nepal', 'XYZ Supplier', '2028-11-15', 'Marketing', 2700),
(18, 'Harsh', 'Sales', 57000, '2021-06-18', 'Priya', 1750, 34000, 103, '2023-06-25', 4600, 'Clothing', 2100, 190, 9000, 'Credit Card', 'Grand Palace', 2100, 4, 'Premium', 'India', 'Global Supplier', '2028-12-10', 'Travel', 3300),
(19, 'Varun', 'HR', 50000, '2022-05-09', 'Amit', 550, 10500, 104, '2023-07-30', 2900, 'Grocery', 700, 400, 6200, 'UPI', 'Taj Hotel', 1100, 3, 'Basic', 'India', 'ABC Supplier', '2029-01-15', 'Office', 1400),
(20, 'Kavita', 'Finance', 64000, '2021-08-22', 'Sneha', 1600, 32000, 105, '2023-08-12', 3700, 'Electronics', 3600, 100, 10500, 'Credit Card', 'City Hotel', 1750, 5, 'Enterprise', 'Nepal', 'XYZ Supplier', '2029-02-20', 'Marketing', 4600),
(21, 'Rohan', 'IT', 73000, '2022-09-14', 'Rahul', 900, 17000, 101, '2023-09-20', 4100, 'Furniture', 2900, 70, 6800, 'UPI', 'Grand Palace', 1950, 3, 'Premium', 'India', 'Global Supplier', '2029-03-15', 'Maintenance', 1200),
(22, 'Anjali', 'HR', 49000, '2023-02-11', 'Priya', 2200, 45000, 102, '2023-10-18', 5300, 'Clothing', 1900, 210, 7500, 'Credit Card', 'Taj Hotel', 1500, 4, 'Basic', 'Nepal', 'ABC Supplier', '2029-04-10', 'Travel', 2900),
(23, 'Vivek', 'Sales', 61000, '2020-10-05', 'Amit', 1150, 23000, 103, '2023-11-25', 3400, 'Grocery', 950, 280, 12500, 'UPI', 'City Hotel', 1350, 3, 'Enterprise', 'India', 'XYZ Supplier', '2029-05-18', 'Office', 2100),
(24, 'Shreya', 'Finance', 66000, '2023-03-17', 'Sneha', 1350, 27000, 104, '2023-12-15', 4900, 'Electronics', 4100, 115, 5800, 'Cash', 'Grand Palace', 2250, 4, 'Premium', 'India', 'Global Supplier', '2029-06-22', 'Marketing', 3500),
(25, 'Manish', 'IT', 78000, '2021-12-12', 'Rahul', 1900, 39000, 105, '2023-12-28', 6200, 'Furniture', 4800, 60, 14500, 'Credit Card', 'Taj Hotel', 1850, 5, 'Enterprise', 'Nepal', 'ABC Supplier', '2029-07-30', 'Travel', 4200);

-- ============================================================
-- 3. QUICK SQL EXECUTION NOTES & MEMORY RULES
-- ============================================================

/*
SQL CLAUSE EXECUTION SEQUENCE:
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

MEMORY RULES:
- WHERE  -> filters individual ROWS before grouping
- HAVING -> filters GROUPS / aggregate results after grouping
- "WISE" -> implies GROUP BY (department-wise, city-wise, category-wise)
- ORDER BY can use SELECT aliases (e.g. ORDER BY total_salary DESC)
- HAVING must use aggregate expressions (e.g. HAVING SUM(salary) > 300000)
- Easy Memory: FROM -> FILTER -> GROUP -> HAVING -> SHOW -> SORT
*/

-- ============================================================
-- 4. FACULTY CLASS TASK QUESTIONS & SOLUTIONS
-- ============================================================

-- QUESTION 1 [Employee Payroll Audit]:
/*
Task: Write a query returning Department and SUM(salary) AS total_salary for employees joined after 2020-12-31, returning departments where total_salary > 300,000, sorted by total_salary DESCENDING.
*/

SELECT
    department,
    SUM(salary) AS total_salary
FROM practice_data
WHERE join_date > '2020-12-31'
GROUP BY department
HAVING SUM(salary) > 300000
ORDER BY total_salary DESC;


-- QUESTION 2 [Salesperson High-Value Performance]:
/*
Task: Write a query returning Salesperson and SUM(sales_amount) AS total_sales_amount for orders where product_price > 500, returning salespersons with total_sales_amount > 50,000, sorted by Salesperson ASCENDING.
*/

SELECT
    salesperson,
    SUM(sales_amount) AS total_sales_amount
FROM practice_data
WHERE product_price > 500
GROUP BY salesperson
HAVING SUM(sales_amount) > 50000
ORDER BY salesperson ASC;


-- QUESTION 3 [Customer Order Frequency Audit]:
/*
Task: Write a query returning customer_id and COUNT(order_amount) AS count_order for orders placed in 2023 with order_amount > 1000, returning customers with at least 5 orders, sorted by count_order DESCENDING.
*/

SELECT
    customer_id,
    COUNT(order_amount) AS count_order
FROM practice_data
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND order_amount > 1000
GROUP BY customer_id
HAVING COUNT(order_amount) >= 5
ORDER BY count_order DESC;


-- QUESTION 4 [Category Product Pricing Audit]:
/*
Task: Write a query returning Category and AVG(product_price) AS avg_price_prod_cat for products with stock > 50, returning categories where avg_price_prod_cat > 2000, sorted by Category ASCENDING.
*/

SELECT
    category,
    AVG(product_price) AS avg_price_prod_cat
FROM practice_data
WHERE stock > 50
GROUP BY category
HAVING AVG(product_price) > 2000
ORDER BY category ASC;


-- QUESTION 5 [Customer Digital Payment Total Audit]:
/*
Task: Write a query returning customer_id and SUM(transaction_amount) AS total_tran_amount for UPI or Credit Card payments, returning customers with total_tran_amount > 10000, sorted by customer_id ASCENDING.
*/

SELECT
    customer_id,
    SUM(transaction_amount) AS total_tran_amount
FROM practice_data
WHERE payment_method IN ('UPI', 'Credit Card')
GROUP BY customer_id
HAVING SUM(transaction_amount) > 10000
ORDER BY customer_id ASC;


-- QUESTION 6 [Hotel Booking Economy Price Screening]:
/*
Task: Write a query returning Hotel and MIN(room_price) AS min_room_price for bookings with nights > 2, returning hotels where min_room_price < 1500, sorted by min_room_price ASCENDING.
*/

SELECT
    hotel,
    MIN(room_price) AS min_room_price
FROM practice_data
WHERE nights > 2
GROUP BY hotel
HAVING MIN(room_price) < 1500
ORDER BY min_room_price ASC;


-- QUESTION 7 [Plan Subscription User Volume Audit]:
/*
Task: Write a query returning plan_type and COUNT(customer_id) AS no_user_subscribed for subscribers in India or Nepal, returning plan types with at least 2 users, sorted by no_user_subscribed.
*/

SELECT
    plan_type,
    COUNT(customer_id) AS no_user_subscribed
FROM practice_data
WHERE country IN ('India', 'Nepal')
GROUP BY plan_type
HAVING COUNT(customer_id) >= 2
ORDER BY no_user_subscribed;


-- QUESTION 8 [Supplier Stock Inventory Expiry Audit]:
/*
Task: Write a query returning Supplier and SUM(stock) AS total_stock for unexpired items (expiry_date > '2026-08-08'), returning suppliers with total_stock > 1000, sorted by Supplier ASCENDING.
*/

SELECT
    supplier,
    SUM(stock) AS total_stock
FROM practice_data
WHERE expiry_date > '2026-08-08'
GROUP BY supplier
HAVING SUM(stock) > 1000
ORDER BY supplier ASC;


-- QUESTION 9 [Expense Type Average Spending Audit]:
/*
Task: Write a query returning expense_type and AVG(expense_amount) AS avg_exp_amount for expenses between 500 and 5000, returning expense types where avg_exp_amount > 1000, sorted by avg_exp_amount.
*/

SELECT
    expense_type,
    AVG(expense_amount) AS avg_exp_amount
FROM practice_data
WHERE expense_amount BETWEEN 500 AND 5000
GROUP BY expense_type
HAVING AVG(expense_amount) > 1000
ORDER BY avg_exp_amount ASC;

/* ============================================================
                   END OF CLASS TASK (7 AUG 2026)
   ============================================================ */
