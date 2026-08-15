-- ==============================================================================
-- IN-CLASS TASK SUMMARY: 2026-08-14
-- TOPIC: SET OPERATORS & CLAUSES TEST
-- ==============================================================================

-- NOTE: No specific SQL coding tasks were assigned in today's class.
-- The faculty instructed students to complete a Google Form MCQ Test 
-- focusing specifically on SQL Clauses (WHERE, GROUP BY, HAVING, ORDER BY).

-- ACTION REQUIRED: 
-- 1. Complete the Google Form Test.
-- 2. Proceed to the 14-Question Practice Drills file for today.


-- 14 aug in class task google form "SQL_test_clauses"

/*
1.High-Value Customers by Region
Management wants to identify regions where the total sales amount from 
completed transactions is greater than ₹10,00,000.

However:

Only Completed transactions should be considered. Transactions with 
amount <= 500 should be ignored. Group the result by region only. Display 
only regions satisfying the required total. Sort regions by total sales 
amount from highest to lowest.
*/


SELECT 
    region,
    SUM(amount) AS total_sales_amount
FROM table_name
WHERE transaction = 'Completed'
  AND amount > 500
GROUP BY region
HAVING SUM(amount) > 1000000
ORDER BY SUM(amount) DESC;

/*
2. Salesperson Performance Challenge

The company wants to identify salespeople who have:
More than 20 completed transactions Total quantity sold greater than 500 
Average transaction amount greater than ₹2,000

Additional conditions:

Ignore cancelled transactions. Ignore transactions where discount is 
greater than 30%. Group by salesperson only. Sort by total quantity sold in
descending order.
*/

SELECT 
    salesperson,
    SUM(quantity) AS total_quantity,
    AVG(amount) AS avg_amount,
    COUNT(transaction) AS total_transactions
FROM table_name
WHERE transaction = 'completed'
  AND discount <= 30
GROUP BY salesperson
HAVING COUNT(transaction) > 20
   AND SUM(quantity) > 500
   AND AVG(amount) > 2000
ORDER BY SUM(quantity) DESC;

/*
3. Product Category Quality Check

The company wants to find product categories where:

- At least 15 transactions exist.
- Total sales amount is greater than ₹5,00,000.
- Average discount is less than 15%.

But:

- Only completed sales should be included.
- Sales with quantity less than 2 should not participate.
- Group by category only.
- Sort categories by average discount from lowest to highest.
*/

SELECT 
    category,
    COUNT(transaction) AS total_transactions,
    SUM(sales_amount) AS total_sales_amount,
    AVG(discount) AS avg_discount
FROM table_name
WHERE transaction_status = 'completed'
  AND quantity >= 2
GROUP BY category
HAVING COUNT(transaction) >= 15
   AND SUM(sales_amount) > 500000
   AND AVG(discount) < 15
ORDER BY AVG(discount) ASC;

/*
4. Region With Strong Quantity but Weak Revenue

Management wants to find regions where:

- Total quantity sold is greater than 1,000.
- Total sales amount is less than ₹10,00,000.
- There must be at least 50 transactions.

Conditions:

- Only completed transactions.
- Ignore sales where amount < ₹500.
- Group only by region.
- Sort by total quantity sold descending.
*/


SELECT 
    region,
    SUM(quantity) AS total_quantity,
    SUM(amount) AS total_sales_amount,
    COUNT(transaction) AS total_transaction
FROM table_name
WHERE transaction = 'completed'
  AND amount > 500
GROUP BY region
HAVING SUM(amount) < 1000000
   AND COUNT(transaction) >= 50
   AND SUM(quantity) > 1000
ORDER BY SUM(quantity) DESC;

/*
5. Payment Mode Analysis

The finance team wants to identify payment modes where:

- Number of transactions is greater than 100.
- Total transaction amount is greater than ₹20,00,000.
- Average transaction amount is greater than ₹3,000.

Conditions:

- Only completed transactions.
- Ignore transactions with quantity = 1.
- Group by payment_mode only.
- Sort by total transaction amount descending.
*/

SELECT 
    payment_mode,
    COUNT(transaction) AS number_of_transaction,
    SUM(amount) AS total_transaction_amount,
    AVG(amount) AS avg_transaction_amount
FROM table_name
WHERE transaction = 'completed'
  AND quantity <> 1
GROUP BY payment_mode
HAVING COUNT(transaction) > 100
   AND SUM(amount) > 2000000
   AND AVG(amount) > 3000
ORDER BY SUM(amount) DESC;

/*
6. Discount Abuse Detection

The company suspects that some salespeople are giving excessive discounts.

Find salespeople where:

- Average discount is greater than 20%.
- Total sales amount is greater than ₹3,00,000.
- Number of transactions is at least 30.

Conditions:

- Only completed transactions.
- Ignore transactions with discount = 0.
- Ignore transactions where amount is less than ₹1,000.
- Group by salesperson only.
- Sort by average discount from highest to lowest.
*/


SELECT 
    salesperson,
    SUM(amount) AS total_sales_amount,
    COUNT(transaction) AS number_of_transaction,
    AVG(discount) AS avg_discount
FROM table_name
WHERE transaction = 'completed'
  AND discount <> 0
  AND amount >= 1000
GROUP BY salesperson
HAVING SUM(amount) > 300000
   AND COUNT(transaction) >= 30
   AND AVG(discount) > 20
ORDER BY AVG(discount) DESC;

/*
7. Product Sales Consistency Analysis

The company wants to identify products that have:

- More than 25 transactions.
- Total quantity sold greater than 300.
- Average quantity per transaction greater than 8.
- Total sales amount greater than ₹8,00,000.

Conditions:

- Only completed transactions.
- Ignore transactions with discount greater than 40%.
- Group by product only.
- Sort by total sales amount descending.
*/

SELECT 
    product,
    COUNT(transaction) AS number_of_transaction,
    SUM(quantity) AS total_quantity,
    AVG(quantity) AS avg_quantity_per_transaction,
    SUM(amount) AS total_sales_amount
FROM table_name
WHERE transaction = 'completed'
  AND discount <= 40
GROUP BY product
HAVING COUNT(transaction) > 25
   AND SUM(quantity) > 300
   AND AVG(quantity) > 8
   AND SUM(amount) > 800000
ORDER BY total_sales_amount DESC;

/*
8. Regional Return Investigation

Management wants to investigate regions with potentially problematic sales.

Find regions where:

- Total returned transaction amount is greater than ₹1,00,000.
- Number of returned transactions is greater than 20.

But there is a twist:

The analysis should consider only transactions where:

- amount > ₹2,000.
- quantity >= 2.

Group by region only.

Sort the result by total returned amount from highest to lowest.
*/

SELECT 
    region,
    SUM(amount) AS total_returned_amount,
    COUNT(transaction) AS number_of_transaction
FROM table_name
WHERE transaction = 'returned'
  AND quantity >= 2
  AND amount > 2000
GROUP BY region
HAVING SUM(amount) > 100000
   AND COUNT(transaction) > 20
ORDER BY SUM(amount) DESC;

/*
9. Difficult Revenue Threshold Analysis

Find product categories satisfying all of the following:

- At least 40 completed transactions.
- Total quantity sold greater than 1,000.
- Total sales amount between ₹15,00,000 and ₹50,00,000.
- Average transaction amount greater than ₹4,000.
- Average discount less than 25%.

Additional condition:

Only transactions having:

- quantity >= 3
- amount >= 1000
- status = 'Completed'

should be considered.

Group by category only.

Sort by total quantity sold in descending order.
*/


SELECT 
    category,
    COUNT(transaction) AS number_of_transaction,
    SUM(quantity) AS total_quantity,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount,
    AVG(discount) AS avg_discount
FROM table_name
WHERE quantity >= 3
  AND amount >= 1000
  AND status = 'completed'
GROUP BY category
HAVING COUNT(transaction) >= 40
   AND SUM(quantity) > 1000
   AND SUM(amount) BETWEEN 1500000 AND 5000000
   AND AVG(amount) > 4000
   AND AVG(discount) < 25
ORDER BY SUM(quantity) DESC;

/*
10. High Revenue, Low Transaction Volume

A company wants to identify salespersons who generate high revenue
but operate with low transaction volume.

Find salespeople satisfying:

- Number of transactions is between 20 and 50.
- Total sales amount is greater than ₹20,00,000.
- Average transaction amount is greater than ₹40,000.
- Total quantity sold is greater than 100.
- Average discount is less than 10%.

Additional rules:

- Only Completed transactions.
- Amount must be greater than ₹5,000.
- Quantity must be greater than 1.
- Ignore transactions with discount greater than 25%.
- Group by salesperson only.
- Sort by average transaction amount descending.
- Display only salespeople satisfying all conditions.
*/


SELECT 
    salesperson
FROM table_name
WHERE status = 'completed'
  AND amount > 5000
  AND quantity > 1
  AND discount <= 25
GROUP BY salesperson
HAVING COUNT(transaction) BETWEEN 20 AND 50
   AND SUM(amount) > 2000000
   AND AVG(amount) > 40000
   AND SUM(quantity) > 100
   AND AVG(discount) < 10
ORDER BY AVG(amount) DESC;