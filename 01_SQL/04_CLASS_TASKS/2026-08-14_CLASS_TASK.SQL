-- ==============================================================================
-- IN-CLASS TASK SOLUTIONS - 14 AUGUST 2026 (DAY 13)
-- TOPIC: COMPLEX SQL CLAUSES & ANALYTICAL SCENARIOS
-- ==============================================================================


/*================================================================
1. HIGH-VALUE CUSTOMERS BY REGION
==================================================================*/

/*
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find geographical areas (regions) that are bringing in a lot of money 
(more than ₹10 Lakhs/1,00,0000) from successfully completed sales.

💡 REAL-LIFE EXAMPLE:
Imagine you run a grocery delivery app. You want to see which neighborhoods 
(like West Nagpur or East Mumbai) are spending a huge amount of money in total, 
so you can direct more delivery drivers there.

📚 VOCABULARY:
• Region: A specific area, city, or zone.
• Completed: A sale that was successfully paid for and delivered (no cancellations).
• Sales amount: The total money spent by the customer.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Only look at 'Completed' sales and ignore tiny orders (<= ₹500).
2. GROUP BY (Bucketing): Group the rows together so we can count totals for each region.
3. HAVING (Group filter): Filter the region groups to keep only those with total sum > ₹10 Lakhs.
4. ORDER BY (Sorting): Put the highest-earning region at the top of the list.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to identify the top-performing sales agents who have closed a high number 
of deals (more than 20), sold a lot of items (over 500), and made a high average 
order value (over ₹2,000).

💡 REAL-LIFE EXAMPLE:
Think of an automobile showroom. The manager wants to find star salespeople 
who sell multiple cars per month (high transaction count) and generate high average 
revenue per car, ignoring cancelled test drives or discounted deals.

📚 VOCABULARY:
• Salesperson: The employee who made the sale.
• Quantity: Number of physical items sold in a transaction.
• Transaction: A single sales event or deal.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Look only at completed transactions and ignore heavily discounted sales (> 30%).
2. GROUP BY (Bucketing): Bucket the database rows by individual salesperson.
3. HAVING (Group filter): Restrict the salespeople groups to those who meet all three targets:
   - Count of transactions > 20
   - Sum of quantities sold > 500
   - Average transaction value > ₹2,000
4. ORDER BY (Sorting): Sort the list by total quantity sold, highest first.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find product departments (categories) that have high demand (at least 15 sales), 
high total earnings (over ₹5 Lakhs), and low average discounts (under 15%).

💡 REAL-LIFE EXAMPLE:
A supermarket manager wants to find which sections (like Electronics vs Clothing) 
are selling well without needing heavy discount promotions to attract customers.

📚 VOCABULARY:
• Product Category: Group of similar items (like Furniture, Electronics).
• Discount: Price reduction given to the customer.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Focus on completed sales and ignore single-item purchases (< 2 items).
2. GROUP BY (Bucketing): Group the product rows by category.
3. HAVING (Group filter): Keep only the categories satisfying:
   - Transaction count >= 15
   - Total sales sum > ₹5 Lakhs
   - Average discount < 15%
4. ORDER BY (Sorting): Sort categories by average discount from lowest to highest.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find our most active and valuable customers from the year 2023. 
Specifically, customers who placed at least 10 orders with a high average 
order value (> ₹1,500).

💡 REAL-LIFE EXAMPLE:
An e-commerce store wants to identify VIP customers to send them a special 
anniversary reward card.

📚 VOCABULARY:
• Customer ID: Unique code identifying a buyer.
• Order Date: The date the purchase was made.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Filter orders placed strictly in the year 2023 and ignore tiny purchases (<= ₹1,000).
2. GROUP BY (Bucketing): Group all orders by customer_id.
3. HAVING (Group filter): Keep only customers who placed >= 10 orders and had an average order value > ₹1,500.
4. ORDER BY (Sorting): Sort the list by customer ID in ascending order.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find which specific items (products) performed best during the end-of-year 
festive season (October to December), focusing on products with high volume sales 
(> 200 items) and high transaction counts (> 25).

💡 REAL-LIFE EXAMPLE:
A toy store owner checks which toys were best-sellers during the Christmas holiday 
season to order more stock for the next year.

📚 VOCABULARY:
• Product ID: Code identifying a specific item.
• Seasonal: Linked to a particular time of the year.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Limit data to Q4 dates (Oct 1 to Dec 31) and ignore orders valued <= ₹2,000.
2. GROUP BY (Bucketing): Group the transactions by product_id.
3. HAVING (Group filter): Retain products where total quantity sold > 200 and transaction count > 25.
4. ORDER BY (Sorting): Sort products by total quantity sold descending.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find our branch locations in the West or North regions that are bringing in 
high total revenue (over ₹15 Lakhs), ignoring cash transactions.

💡 REAL-LIFE EXAMPLE:
A coffee shop chain wants to identify which branches in the North and West zones 
are generating the highest digital sales, so they can award the branch managers.

📚 VOCABULARY:
• Branch: A specific store location.
• Revenue: Total money earned from sales.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Include only West and North regions and filter out 'Cash' payment methods.
2. GROUP BY (Bucketing): Group the transactions by branch.
3. HAVING (Group filter): Show only branches where the total revenue sum exceeds ₹15 Lakhs.
4. ORDER BY (Sorting): Sort branches alphabetically by name.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to identify the absolute highest-spending customers. These are customers 
who have spent a total of > ₹50,000, placed at least 5 orders, and average > ₹1,000 per order.

💡 REAL-LIFE EXAMPLE:
An airline company checks passenger flight history to identify passengers who fly 
frequently and buy business-class tickets, so they can invite them to the VIP lounge.

📚 VOCABULARY:
• Customer Lifetime Value (CLV): The total amount of money a customer spends at your business.
• Pending: A transaction that is not completed yet (e.g. waiting for payment).

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Ignore pending status transactions and ignore small purchases (<= ₹100).
2. GROUP BY (Bucketing): Group all records by customer_id.
3. HAVING (Group filter): Filter customer groups to keep only those with sum > ₹50,000, avg > ₹1,000, and count >= 5.
4. ORDER BY (Sorting): Sort by total amount spent, highest first.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find product categories that are shipping in massive volume (more than 1,000 units) 
across at least 50 orders in the South or East regions.

💡 REAL-LIFE EXAMPLE:
A shipping company checks which categories of items (like Books or Appliances) 
are being ordered in bulk in the East zone so they can set up a warehouse there.

📚 VOCABULARY:
• Product Category: Group of similar items.
• Quantity: Number of units in a single order.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Look only at orders shipped to South or East regions with quantity > 5.
2. GROUP BY (Bucketing): Group the orders by product_category.
3. HAVING (Group filter): Filter for categories with total units > 1,000 and order count > 50.
4. ORDER BY (Sorting): Sort categories by total quantity sold descending.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to find manufacturers whose products are being heavily discounted (average discount > 15%) 
and are selling in high volumes (total quantity > 300 units).

💡 REAL-LIFE EXAMPLE:
A retail auditor checks if certain brands (like Samsung or Sony) are giving away 
too many discounts, which might hurt long-term brand value.

📚 VOCABULARY:
• Manufacturer: The company that made the product.
• Discount: Price reduction in percentage.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Ignore minor discounts (<= 5%) and ignore low quantity orders (<= 2 units).
2. GROUP BY (Bucketing): Group the transactions by manufacturer.
3. HAVING (Group filter): Filter groups to show only those with average discount > 15% and total quantity > 300.
4. ORDER BY (Sorting): Sort by average discount in descending order.
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
📖 THE PROBLEM IN SIMPLE WORDS:
We want to identify salespeople who make a lot of money (total sales > ₹20 Lakhs) 
but do it with a small number of deals (between 20 and 50 transactions).

💡 REAL-LIFE EXAMPLE:
Think of a real estate agency. The owner wants to find agents who sell high-end luxury penthouses 
(huge sales amount, few deals) rather than agents who lease 500 cheap apartments.

📚 VOCABULARY:
• Revenue: Total money earned from sales.
• Transaction Volume: The number of deals closed.

🛠️ STEP-BY-STEP SQL BUILDING BLOCKS:
1. WHERE (Row filter): Limit data to completed sales, amount > ₹5,000, quantity > 1, and discount <= 25%.
2. GROUP BY (Bucketing): Group the transactions by salesperson.
3. HAVING (Group filter): Keep only salespeople who satisfy all five goals:
   - Transaction count is between 20 and 50.
   - Total sales amount > ₹20 Lakhs.
   - Average transaction amount > ₹40,000.
   - Total quantity sold > 100.
   - Average discount given < 10%.
4. ORDER BY (Sorting): Sort by average transaction amount descending.
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
