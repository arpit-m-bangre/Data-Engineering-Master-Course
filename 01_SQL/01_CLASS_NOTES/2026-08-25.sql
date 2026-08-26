-- sql 25 aug class 

-- value based windows function 
-- 1 lead  
-- 2 lag 


/*
note : coloumn - columnn possible not row-row it is but very long meth 
product year sale lead lag 
a	2023	30000	40000	null 
a	2024	40000	20000	40000
a	2025	20000	null	20000

*/

select * from studentinfo 

select Marks ,lead(marks) over ( order by studentid) r1 from studentinfo 
select marks ,lag(marks) over ( order by studentid) r1 from studentinfo 

-- note : create ideal table for that 
select subject, marks ,lag(marks) over ( partition by subject order by studentid) r1 from studentinfo 

-- used for data reporting 


-- create table 

-- products date stock 

drop table stock
create table stock ( pname varchar(10),dateT date,stock int)

insert into stock values ('laptop', '10/10/2026',70),('laptop', '10/11/2026',100),('Mobile', '10/10/2026',300),
('laptop', '10/12/2026',140),('Mobile', '10/11/2026',40),('Mobile', '10/12/2026',100)


select * from stock 

with CTE as 
(select *,lead(stock) over (partition by pname order by dateT) r from stock )
select * ,stock-r from cte

-- sql weightage is around 60 % in interview according to sumedha ma'am 


----------------------------------------------------------------

-- aggregate with windows function 
-- try all 

select *,min(marks) over(partition by subject order by marks ) r1 from studentinfo 

select *,sum(marks) over(partition by subject order by marks ) r1 from studentinfo 


-- question 

-- emp,empid,name,dept,salary 
-- salary > previous < next 

-- example 

-- 1 20000 
-- 2 30000 -- display this
-- 3 40000



------------------------------------

-- home work 
/*
cid date amount 
1 01/01/2026  40000   
1 04/02/2026  10000 

find customer second order amount is less than 50% of the first order amount 

*/

/*
Scenario 1 — Employee Salary Analysis
You have two tables:
Employees
EmpID
EmpName
DeptID
JoiningDate
Salary
Departments
DeptID
DeptName
Question:
Find the top 2 highest-paid employees in each department who joined the company in the last 3 years.
Output: DeptName, EmpID, EmpName, Salary, JoiningDate, SalaryRank


Scenario 2 — Customer Monthly Orders
Customers
CustomerID
CustomerName
City
Orders
OrderID
CustomerID
OrderDate
OrderAmount
Question:
Find customers who placed more than 3 orders in 2026.
For each customer, display: CustomerID, CustomerName, TotalOrders, TotalAmount, FirstOrderDate, LastOrderDate
Also assign a rank based on TotalAmount within each city.

Scenario 3 — Product Sales
Products
ProductID
ProductName
Category
Orders
OrderID
ProductID
OrderDate
Quantity
Amount
Question:
For each category, find the top-selling product for every month of 2026, based on total sales amount.
Output: Category, Month, ProductName, TotalSales, ProductRank


Scenario 4 — Employee Joining Trend
Employees
EmpID
EmpName
DeptID
JoiningDate
Salary
Departments
DeptID
DeptName
Question:
For every department, display the number of employees who joined in each month.
Also show:
DeptName, YearMonth, EmployeeCount, PreviousMonthCount, Difference


Scenario 5 — Customer Order Gap 
Customers
CustomerID
CustomerName
Orders
OrderID
CustomerID
OrderDate
OrderAmount
Question:
Find customers whose latest order was at least 30 days after their previous order.
Output:
CustomerID, CustomerName, PreviousOrderDate, LatestOrderDate, DaysGap
*/