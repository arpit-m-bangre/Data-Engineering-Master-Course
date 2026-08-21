/*================================================================
   SQL CLASS NOTES - 20 AUGUST 2026 (DAY 17)
   TOPICS: MULTI-TABLE JOINS (3+ TABLES), ANSI CROSS JOIN, EQUI JOINS & QUARTER FILTERING
==================================================================*/

/*================================================================
1. MULTI-TABLE RELATIONAL JOIN SYNTAX ARCHITECTURE
==================================================================*/

/* Theory: Joining 3 or more tables requires chaining ON clauses. 
   Table A connects to Table B, Table B connects to Table C, etc. */

-- Abstract 2-Table Join
-- Table A (aid, aname), Table B (bid, bname, aid)
-- SELECT * FROM A JOIN B ON A.aid = B.bid;

-- Abstract 3-Table Join
-- Table C (cid, cname, bid)
-- SELECT * FROM A JOIN B ON A.aid = B.bid JOIN C ON B.bid = C.bid;

-- Abstract 4-Table Join
-- Table D (did, dname, cid)
-- SELECT * FROM A JOIN B ON A.aid = B.bid JOIN C ON B.bid = C.bid JOIN D ON C.bid = D.did;


/*================================================================
2. ENVIRONMENT SETUP: CUSTOMER, PRODUCT & ORDERS SCHEMA
==================================================================*/

IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Product', 'U') IS NOT NULL DROP TABLE Product;
IF OBJECT_ID('Customer', 'U') IS NOT NULL DROP TABLE Customer;

CREATE TABLE Customer
(
    custid   INT,
    Custname VARCHAR(50),
    city     VARCHAR(50)
);

CREATE TABLE Product
(
    Pid      INT,
    Pname    VARCHAR(50),
    price    INT,
    category VARCHAR(50)
);

CREATE TABLE Orders
(
    custid   INT,
    pid      INT,
    oid      INT,
    quantity INT,
    T_date   DATE
);

INSERT INTO Customer (custid, Custname, city) VALUES
(1, 'Amit',  'Pune'),
(2, 'Puja',  'Pune'),
(3, 'Neha',  'Mumbai'),
(4, 'Sumit', 'Nagpur'),
(5, 'Amit',  'Mumbai'),
(6, 'Leena', 'Nagpur');

INSERT INTO Product (Pid, Pname, price, category) VALUES
(101, 'Laptop', 50000, 'Electr'),
(102, 'Mobile', 40000, 'Elect'),
(103, 'soap',   500,   'Glosary');

INSERT INTO Orders (custid, pid, oid, quantity, T_date) VALUES
(1, 101, 1000, 2,  '2024-01-10'),
(1, 102, 1001, 5,  '2025-02-11'),
(4, 103, 1003, 10, GETDATE()),
(3, 101, 1004, 5,  '2022-01-01');

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;


/*================================================================
3. MULTI-TABLE 3-WAY JOINS & COMPUTED COLUMNS
==================================================================*/

-- Q1: Display Customer Name, Product Name, Category and Total Amount (quantity * price)
-- Best Practice: Use concise table aliases (c, o, p) in enterprise code
SELECT 
    c.Custname,
    p.Pname,
    p.category,
    (o.quantity * p.price) AS TotalAmount
FROM Customer AS c
INNER JOIN Orders AS o ON c.custid = o.custid
INNER JOIN Product AS p ON o.pid = p.pid;


/*================================================================
4. MULTI-TABLE AGGREGATIONS: LEFT JOIN VS INNER JOIN
==================================================================*/

-- Q2: 1 Display Customer Name with Total Amount Spent (LEFT JOIN - Includes non-purchasing customers)
SELECT 
    c.Custname,
    SUM(o.quantity * p.price) AS TotalSpent
FROM Customer AS c
LEFT JOIN Orders AS o ON c.custid = o.custid
LEFT JOIN Product AS p ON o.pid = p.pid
GROUP BY c.Custname;

-- Q2: 2 
(INNER JOIN - Only customers with valid orders and products)

SELECT 
    c.Custname,
    SUM(o.quantity * p.price) AS TotalSpent
FROM Customer AS c
INNER JOIN Orders AS o ON c.custid = o.custid
INNER JOIN Product AS p ON o.pid = p.pid
GROUP BY c.Custname;


/*================================================================
5. COMPLEX MULTI-TABLE QUERY: FILTERING, AGGREGATING & SORTING
==================================================================*/

-- Filter by name pattern, group by customer, filter aggregate sum, sort by amount
SELECT 
    c.Custname,
    SUM(o.quantity * p.price) AS amount
FROM Customer AS c
INNER JOIN Orders AS o ON c.custid = o.custid
INNER JOIN Product AS p ON o.pid = p.pid
WHERE c.Custname LIKE '%a%'
GROUP BY c.Custname
HAVING SUM(o.quantity * p.price) > 250000
ORDER BY amount ASC;


/*================================================================
6. TEMPORAL JOIN FILTERING (DATEPART QUARTERS)
==================================================================*/

-- Display Customer Name with Product Name where transaction occurred in Q1 or Q3
SELECT 
    c.Custname,
    p.Pname,
    o.T_date,
    DATEPART(qq, o.T_date) AS OrderQuarter
FROM Customer AS c
INNER JOIN Orders AS o ON c.custid = o.custid
INNER JOIN Product AS p ON o.pid = p.pid
WHERE DATEPART(qq, o.T_date) IN (1, 3);


/*================================================================
7. ANSI CROSS JOIN (CARTESIAN PRODUCT MATRIX)
==================================================================*/

/* Theory: CROSS JOIN generates every possible combination of rows (N x M).
   Used for pairing matrices, schedule planning, and tournament match generation. */

-- 2-Table CROSS JOIN: 6 Customers * 3 Products = 18 Rows
SELECT 
    c.Custname,
    p.Pname,
    p.price
FROM Customer AS c
CROSS JOIN Product AS p;

-- 3-Table CROSS JOIN: 6 Customers * 3 Products * 4 Orders = 72 Rows (N x M x P)
SELECT 
    c.Custname,
    p.Pname,
    o.oid
FROM Customer AS c
CROSS JOIN Product AS p
CROSS JOIN Orders AS o;


/*================================================================
8. NON-ANSI EQUI JOIN VS ANSI INNER JOIN
==================================================================*/

/* Theory: Non-ANSI Equi Join lists tables in FROM and matches keys in WHERE.
   ANSI SQL-92 JOIN ... ON separates relational links from row filters. */

-- Cartesian Cross Product via legacy comma syntax (6 * 4 = 24 rows)
SELECT * 
FROM Customer, Orders;

-- Equi Join via comma syntax and WHERE condition (4 matching rows)
SELECT 
    c.Custname,
    o.oid,
    o.quantity
FROM Customer AS c, Orders AS o
WHERE c.custid = o.custid;

-- ANSI Equivalent (Standard Industry Practice)
SELECT 
    c.Custname,
    o.oid,
    o.quantity
FROM Customer AS c
INNER JOIN Orders AS o ON c.custid = o.custid;

/* Faculty Homework: see 04_CLASS_TASKS/2026-08-20_CLASS_TASK.SQL */
