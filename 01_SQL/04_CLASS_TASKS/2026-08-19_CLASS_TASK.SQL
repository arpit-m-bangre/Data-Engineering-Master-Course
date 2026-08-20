-- ====================================================================================================
-- 🎓 FACULTY IN-CLASS & HOMEWORK TASKS
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

-- Verify Seed Tables
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM p_info;
SELECT * FROM D_info;
SELECT * FROM set1;
SELECT * FROM set2;


-- ====================================================================================================
-- 📝 PART 1: FACULTY HOMEWORK TASKS (WRITE QUERIES BELOW)
-- ====================================================================================================

-- TASK 1: Calculate Month-Wise Average Sales across all customer orders.
-- Requirements: Extract month name/number from t_date and calculate average amount per month.
-- Write your SQL Query below:

select month(t_date) as month,avg(amount) as avg_amount_per_month 
from Customers as c left join Orders o 
on c.custid = o.custid 
group by month(t_date) 


-- TASK 2: Display Customers who did NOT order anything till date.
-- Requirements: Identify customers with zero matching orders in Orders table (Anti-Join).
-- Write your SQL Query below:

select * 
from Customers as c  full join Orders as o 
on c.custid = o.custid
where o_id is null 


-- TASK 3: Display Customer Name (custname), Month Name, Product ID (p_id), and Order Amount.
-- Requirements: Join Customers with Orders and project specific columns avoiding any ambiguity.
-- Write your SQL Query below:

select custname,month(t_date) as month,p_id as porduct_id,amount as order_amount
from Customers as c  full join orders as o 
on c.custid = o.custid


-- ====================================================================================================
-- 📝 PART 2: IN-CLASS MEDICAL & DEPARTMENT TASKS (WRITE QUERIES BELOW)
-- ====================================================================================================

-- TASK 4: Display Patients with their Assigned Doctor Name.
-- Requirements: Display pname and Dname for patients who have an assigned doctor.
-- Write your SQL Query below:

select p.pname , d.Dname 
from p_info as p left join D_info as d 
on p.p_id = d.p_id
where d.Dname is not null 

-- TASK 5: Display Patients who have NOT been assigned any Doctor till date.
-- Requirements: Anti-join on p_info and D_info.
-- Write your SQL Query below:

select p.pname  
from p_info as p left join D_info as d 
on p.p_id = d.p_id
where d.Dname is null 



-- TASK 6: Department-wise Average Salary (Preserving All Departments).
-- Requirements: Group by dept from set1 and calculate AVG(salary) from set2 using appropriate join.
-- Write your SQL Query below:

select dept , avg(salary) as avg_salary 
from set1 as s1 left join set2 as s2 
on s1.id = s2.id
group by dept 


-- ====================================================================================================
