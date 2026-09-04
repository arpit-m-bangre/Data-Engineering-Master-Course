-- 3 sep 2026 

delete table_name 
commit 

drop table table_name 
rollback 


delete student_dumy
rollback 

-- note possible 

--- the thing we have to rollback should be under begin transaction 

begin transaction 
delete q2 
rollback 


begin transaction 
delete q2 
commit 
rollback -- not possible due to commit 

-- this is only in sql server not in other 


-- is null 

update table_name set name = 'a' where name is null 

select * from student_dumy

select *,isnull(name,'no info')info from StudentDumy

select *,coalesce(name,city,'no info')info from student_dumy
-- coalesce make no sense in sql server 

-- subquery 

-- don't use in interview at all go for other approach 

-- just for knowledge purpose 

select max(marks) from StudentInfo

-- with CTE as 

(dense_rank)
r = 2 



-- subquery

select max(marks) from studentinfo where marks < (select max(marks) from Studentinfo 

-- but not good for speed thing 

select id from a where id in 
(select id from b )

-- easy but not good 

-- stay out of subquery 

-- like comapny salesforce only use subquery ???