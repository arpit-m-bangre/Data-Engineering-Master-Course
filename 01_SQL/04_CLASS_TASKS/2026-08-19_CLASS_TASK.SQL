-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASK SOLUTIONS
-- 🏢 MODULE 01: SQL Relational Architecture & Query Engine
-- 📆 CLASS DATE: 19 AUGUST 2026 (Day 16)
-- 🎯 TOPIC: Practical Relational Joins, Anti-Joins, Table Aliases & Month-wise Sales Aggregations
-- ====================================================================================================

-- ====================================================================================================
-- ⚙️ PHASE 0: SETUP ENVIRONMENT & SEED DATASETS
-- ====================================================================================================

-- Clean up existing tables
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('D_info', 'U') IS NOT NULL DROP TABLE D_info;
IF OBJECT_ID('p_info', 'U') IS NOT NULL DROP TABLE p_info;
IF OBJECT_ID('set1', 'U') IS NOT NULL DROP TABLE set1;
IF OBJECT_ID('set2', 'U') IS NOT NULL DROP TABLE set2;

-- Table 1: Customers Master
CREATE TABLE Customers
(
    custid INT PRIMARY KEY,
    custname VARCHAR(50) NOT NULL,
    t_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL
);

-- Table 2: Orders Transaction Table
CREATE TABLE Orders
(
    o_id INT PRIMARY KEY,
    custid INT,
    p_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

-- Seed Customers
INSERT INTO Customers (custid, custname, t_date, city)
VALUES
(1, 'Aarav Sharma', '2026-01-15', 'Mumbai'),
(2, 'Priya Patel',  '2026-02-10', 'Pune'),
(3, 'Rohan Verma',  '2026-02-22', 'Bengaluru'),
(4, 'Sneha Reddy',  '2026-03-05', 'Hyderabad'),
(5, 'Vikram Malhotra', '2026-03-18', 'Delhi'),
(6, 'Neha Gupta',   '2026-04-12', 'Chennai'),
(7, 'Amit Roy',     '2026-05-01', 'Kolkata');

-- Seed Orders (Note: custid 6 and 7 have ZERO orders)
INSERT INTO Orders (o_id, custid, p_id, amount)
VALUES
(5001, 1, 101, 1500.00),
(5002, 1, 102, 3200.00),
(5003, 2, 101, 4500.00),
(5004, 3, 103, 1200.00),
(5005, 3, 104, 8900.00),
(5006, 4, 102, 6700.00),
(5007, 5, 105, 5400.00),
(5008, 5, 101, 2300.00);

-- Table 3 & 4: Patient & Doctor Info
CREATE TABLE p_info
(
    p_id INT PRIMARY KEY,
    pname VARCHAR(50) NOT NULL
);

CREATE TABLE D_info
(
    d_id INT PRIMARY KEY,
    p_id INT,
    Dname VARCHAR(50) NOT NULL
);

INSERT INTO p_info (p_id, pname)
VALUES
(101, 'Ramesh Kumar'),
(102, 'Sita Sharma'),
(103, 'Gopal Das'),
(104, 'Anita Desai');

INSERT INTO D_info (d_id, p_id, Dname)
VALUES
(1, 101, 'Dr. Batra'),
(2, 102, 'Dr. Trehan'),
(3, 105, 'Dr. Mukherjee');

-- Table 5 & 6: Set1 & Set2
CREATE TABLE set1
(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50)
);

CREATE TABLE set2
(
    id INT PRIMARY KEY,
    salary DECIMAL(10,2),
    age INT
);

INSERT INTO set1 (id, name, dept)
VALUES
(1, 'Arjun', 'IT'),
(2, 'Priya', 'HR'),
(3, 'Rahul', 'Finance'),
(4, 'Sneha', 'Marketing'),
(5, 'Vikas', 'IT'),
(6, 'Neha', 'Sales'),
(7, 'Amit', 'Finance'),
(8, 'Pooja', 'HR');

INSERT INTO set2 (id, salary, age)
VALUES
(1, 45000.00, 24),
(2, 52000.00, 27),
(3, 60000.00, 29),
(4, 48000.00, 25),
(5, 55000.00, 28),
(6, 42000.00, 23),
(9, 70000.00, 31),
(10, 65000.00, 30);


-- ====================================================================================================
-- 📝 PART 1: FACULTY HOMEWORK SOLUTIONS
-- ====================================================================================================

-- TASK 1: Calculate Month-Wise Average Sales across all customer orders.
-- Explanation: Extract month component from customer transaction date (t_date) and compute AVG(amount).
SELECT 
    DATENAME(MONTH, c.t_date) AS order_month,
    MONTH(c.t_date) AS month_number,
    AVG(o.amount) AS avg_sales_amount,
    SUM(o.amount) AS total_sales_amount,
    COUNT(o.o_id) AS total_orders
FROM Customers AS c
JOIN Orders AS o
    ON c.custid = o.custid
GROUP BY 
    DATENAME(MONTH, c.t_date),
    MONTH(c.t_date)
ORDER BY 
    month_number ASC;


-- TASK 2: Display Customers who did NOT order anything till date.
-- Explanation: Anti-Join technique using LEFT JOIN + WHERE o.o_id IS NULL.
SELECT 
    c.custid,
    c.custname,
    c.city,
    c.t_date AS registration_date
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.custid = o.custid
WHERE o.o_id IS NULL;


-- TASK 3: Display Customer Name (custname), Month Name, Product ID (p_id), and Order Amount.
-- Explanation: Join Customers and Orders, project specific columns, resolving all potential ambiguities.
SELECT 
    c.custname,
    DATENAME(MONTH, c.t_date) AS month_name,
    o.p_id AS product_id,
    o.amount AS order_amount
FROM Customers AS c
JOIN Orders AS o
    ON c.custid = o.custid
ORDER BY 
    c.custname ASC;


-- ====================================================================================================
-- 📝 PART 2: IN-CLASS MEDICAL & DEPARTMENT TASKS
-- ====================================================================================================

-- TASK 4: Display Patients with their Assigned Doctor Name.
SELECT 
    p.pname AS patient_name,
    d.Dname AS doctor_name
FROM p_info AS p
JOIN D_info AS d
    ON p.p_id = d.p_id;


-- TASK 5: Display Patients who have NOT been assigned any Doctor till date.
SELECT 
    p.p_id AS patient_id,
    p.pname AS patient_name
FROM p_info AS p
LEFT JOIN D_info AS d
    ON p.p_id = d.p_id
WHERE d.d_id IS NULL;


-- TASK 6: Department-wise Average Salary (Preserving All Departments).
SELECT 
    s1.dept AS department,
    AVG(s2.salary) AS avg_salary,
    COUNT(s1.id) AS total_employees,
    COUNT(s2.salary) AS employees_with_salary
FROM set1 AS s1
LEFT JOIN set2 AS s2
    ON s1.id = s2.id
GROUP BY 
    s1.dept
ORDER BY 
    avg_salary DESC;
