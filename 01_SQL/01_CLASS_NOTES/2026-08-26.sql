-- case statement

select case 
	when condition 1 then output
	when condition 2 then op
	else 
	end 
	from table 

-- id name dept salary 
-- if salary > 3000 print high salary else low salary 

select case 
	when salary > 30000 then "high salary" 
	else "low" 
	end 
	from table_name

select * from Student

select *, case 
when city = 'pune' then 'bestcity'
else 'goodcity'
end as status -- as is optional 
from student

------------------------------------------------------------------------------

create table marks ( m1 int,m2 int ) 
insert into marks values ( 20,30),(30,40),(50,30),(20,10),(10,10),(20,25) 
insert into marks values (null,20),(null,25),(null,null),(30,null)



-- question 

-- addition m1 and m2 with condition if m1+m2 > 70 best in between 50 to 70 avg else low 
with cte as
(
select *,case 
	when m1+m2 >= 70 then 'best'
	when m1+m2 between 50 and 70 then 'average'
	else 'below_avg'
	end status
	from marks 
)
select  status,count(status) as status_count 
from cte 
group by status
-- question 

-- status count 

----------------------------------------
-- m1 m2 
-- 20 null 
-- null 40 
-- 40 20 

-- do m1 + m2 
-- but m1+null or null + m2 


select *, case 
	when m1 is null then m2 
	when m2 is null then m1 
	else m1+m2 
	end addition 
	from marks 

------------------------------------------
-- cid cname pid orderdate d.date 
-- display cname status 
-- status - 1.delivered - delivery date is present  
--			2. pending - deliver date not present and order date 7 days or more 
--			3. in progress - within 7 days  no d.date 


select cname ,case 
	
	when d.date is null  and datediff(day,o.date,getdate()) >= 7 then 'pending'
	when d.date is null  and datediff(day,o.date,getdate()) < 7 then 'in progress' 
	else 'delivered'
	end status 
	from table_name 


-- home work 

-- q1 . dept wise 1st salary - highest salary 
-- 2nd 2nd hightes salary 
-- rest common 

-- q2 .city order by desc 
-- pune always 1st position 
-- remaing order by desc 

-- q3 table 1 cid cname 
-- table2 cid oid date amount 
-- display cname , amount , month 
-- condtion 1 - customer order in 1st and 3rd quarter print middle 
-- else print last qq 

