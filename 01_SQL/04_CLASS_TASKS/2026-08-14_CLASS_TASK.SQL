-- ==============================================================================
-- IN-CLASS TASK SOLUTIONS - 14 AUGUST 2026 (DAY 13)
-- TOPIC: COMPLEX SQL CLAUSES & ANALYTICAL SCENARIOS
-- ==============================================================================


/*================================================================
1. HIGH-VALUE CUSTOMERS BY REGION
==================================================================*/

/*
Scenario: Region-wide sales budget check.
  
Subquestions:
• Q1.1: Filter the table to include only 'Completed' transactions with 
       an amount strictly greater than 500.
• Q1.2: Group the records by region and compute the total sales amount.
• Q1.3: Apply a filter to show only regions where total sales exceed 1,00,0000.
• Q1.4: Sort the final output by total sales descending.
*/

SELECT 
    region,
    SUM(amount) AS total_sales_amount
FROM table_name
WHERE transaction = 'Completed'
  AND amount > 500
GROUP BY region
HAVING SUM(amount) > 1000000
ORDER BY total_sales_amount DESC;


/*================================================================
2. SALESPERSON PERFORMANCE CHALLENGE
==================================================================*/

/*
Scenario: Top sales agent evaluations.

Subquestions:
• Q2.1: Ignore cancelled transactions and transactions with a discount 
       greater than 30%.
• Q2.2: Group by salesperson and calculate total quantity sold, average 
       amount, and transaction count.
• Q2.3: Restrict to salespeople with > 20 transactions, total quantity > 500, 
       and average amount > 2,000.
• Q2.4: Sort the results by total quantity sold descending.
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
ORDER BY total_quantity DESC;


/*================================================================
3. PRODUCT CATEGORY QUALITY CHECK
==================================================================*/

/*
Scenario: Product sales quality audit.

Subquestions:
• Q3.1: Exclude non-completed sales and sales with quantity less than 2.
• Q3.2: Group by category and compute transaction count, total sales, 
       and average discount.
• Q3.3: Filter for categories with >= 15 transactions, total sales > 5,00,000, 
       and average discount < 15%.
• Q3.4: Sort by average discount ascending.
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
ORDER BY avg_discount ASC;


/*================================================================
4. ACTIVE CUSTOMERS WITH LARGE ORDERS
==================================================================*/

/*
Scenario: VIP customer identifying.

Subquestions:
• Q4.1: Include only transactions from the year 2023 with amount > 1,000.
• Q4.2: Group by customer_id and calculate order count and average amount.
• Q4.3: Retain customers who placed at least 10 orders with an average 
       amount > 1,500.
• Q4.4: Sort by customer ID in ascending order.
*/

SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    AVG(amount) AS avg_order_amount
FROM table_name
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
  AND amount > 1000
GROUP BY customer_id
HAVING COUNT(order_id) >= 10
   AND AVG(amount) > 1500
ORDER BY customer_id ASC;


/*================================================================
5. SEASONAL SALES AUDIT
==================================================================*/

/*
Scenario: Festive period transaction check.

Subquestions:
• Q5.1: Select transactions in Q4 (Oct-Dec) with amount > 2,000.
• Q5.2: Group by product_id and count total quantity and transaction count.
• Q5.3: Filter for products with total quantity > 200 and transaction count > 25.
• Q5.4: Sort by total quantity descending.
*/

SELECT 
    product_id,
    SUM(quantity) AS total_quantity,
    COUNT(transaction_id) AS transaction_count
FROM table_name
WHERE order_date BETWEEN '2023-10-01' AND '2023-12-31'
  AND amount > 2000
GROUP BY product_id
HAVING SUM(quantity) > 200
   AND COUNT(transaction_id) > 25
ORDER BY total_quantity DESC;


/*================================================================
6. TOP PERFORMING BRANCHES
==================================================================*/

/*
Scenario: Branch performance audit.

Subquestions:
• Q6.1: Focus on branches in the West or North regions and exclude cash payments.
• Q6.2: Group by branch and calculate total revenue and transaction count.
• Q6.3: Filter for branches generating revenue > 15,00,000.
• Q6.4: Sort branches alphabetically.
*/

SELECT 
    branch,
    SUM(revenue) AS total_revenue,
    COUNT(transaction_id) AS transaction_count
FROM table_name
WHERE region IN ('West', 'North')
  AND payment_method <> 'Cash'
GROUP BY branch
HAVING SUM(revenue) > 1500000
ORDER BY branch ASC;


/*================================================================
7. CUSTOMER LIFETIME VALUE (CLV)
==================================================================*/

/*
Scenario: Customer value segmenting.

Subquestions:
• Q7.1: Exclude pending status rows and orders with amount <= 100.
• Q7.2: Group by customer_id and get total spent, average spent, and order count.
• Q7.3: Retain customers with total spent > 50,000, average spent > 1,000, 
       and at least 5 orders.
• Q7.4: Sort by total spent descending.
*/

SELECT 
    customer_id,
    SUM(amount) AS total_spent,
    AVG(amount) AS avg_spent,
    COUNT(order_id) AS order_count
FROM table_name
WHERE status <> 'pending'
  AND amount > 100
GROUP BY customer_id
HAVING SUM(amount) > 50000
   AND AVG(amount) > 1000
   AND COUNT(order_id) >= 5
ORDER BY total_spent DESC;


/*================================================================
8. HIGH QUANTITY ORDERS IN KEY REGIONS
==================================================================*/

/*
Scenario: Shipping volume check.

Subquestions:
• Q8.1: Select orders shipped to South or East regions with quantity > 5.
• Q8.2: Group by product_category and count total quantity and order count.
• Q8.3: Filter categories where total quantity > 1,000 and order count > 50.
• Q8.4: Sort by total quantity descending.
*/

SELECT 
    product_category,
    SUM(quantity) AS total_quantity,
    COUNT(order_id) AS order_count
FROM table_name
WHERE region IN ('South', 'East')
  AND quantity > 5
GROUP BY product_category
HAVING SUM(quantity) > 1000
   AND COUNT(order_id) > 50
ORDER BY total_quantity DESC;


/*================================================================
9. DISCOUNT AND VOLUME AUDIT
==================================================================*/

/*
Scenario: Discount policy compliance checking.

Subquestions:
• Q9.1: Ignore transactions with discount <= 5% or quantity <= 2.
• Q9.2: Group by manufacturer and calculate avg discount and sum of quantity.
• Q9.3: Filter for manufacturers with avg discount > 15% and sum of quantity > 300.
• Q9.4: Sort by average discount descending.
*/

SELECT 
    manufacturer,
    AVG(discount) AS avg_discount,
    SUM(quantity) AS total_quantity
FROM table_name
WHERE discount > 5
  AND quantity > 2
GROUP BY manufacturer
HAVING AVG(discount) > 15
   AND SUM(quantity) > 300
ORDER BY avg_discount DESC;


/*================================================================
10. HIGH REVENUE, LOW TRANSACTION VOLUME
==================================================================*/

/*
Scenario: High-value sales agent auditing.

Subquestions:
• Q10.1: Only completed transactions, amount > 5000, quantity > 1, 
        and discount <= 25%.
• Q10.2: Group by salesperson and compute total sales, transaction count, 
        avg amount, total quantity, and avg discount.
• Q10.3: Filter for count 20-50, sum > 20,00,000, avg > 40,000, 
        quantity > 100, and avg discount < 10%.
• Q10.4: Sort by average transaction amount descending.
*/

SELECT 
    salesperson,
    COUNT(transaction) AS transaction_count,
    SUM(amount) AS total_sales,
    AVG(amount) AS avg_transaction_amount,
    SUM(quantity) AS total_quantity,
    AVG(discount) AS avg_discount
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
ORDER BY avg_transaction_amount DESC;
