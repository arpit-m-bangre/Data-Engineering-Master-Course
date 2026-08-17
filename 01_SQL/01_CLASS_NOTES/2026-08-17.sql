-- 17 aug class 

-- date and datetime in sql 

-- in interview they ask about this data type 
-- in real data base of company date and datetime as a data type used 

-- year -- yy/yyyy format example : 26/2026 
-- Month -- M/MM formate
-- date -- D/DD
-- day -- DY 
-- week -- wk 
-- Quarter -- Q/QQ 
-- Hour -- H/HH
-- Min -- N/NN
-- Sec -- S/SS 
-- Milisec - MS 
-- days of wk - weekday 

-------------------------------------------------------------------------

-- getdate 
-- current date and time 

select getdate()
-- 2026-08-17 21:17:20.133

-- two format are allowed 

-- MM/DD/YY
-- YY/MM/DD 

--------------------------------------------------------------------------
-- 1 . Datediff 

-- we can't interval in any way like in months, in days , in weeks , in quarter ... 
-- at a time in one interval we can get interval 

-- syntax 
-- select datediff(interval,startdate,enddate) 

select datediff(MM,'10/02/2008',getdate()) as diff_in_month -- valid format is mm/dd/yy
select datediff(wk,'10/02/2008',getdate()) as diff_in_week

select datediff(dy,getdate(),'10/02/2008')
-- valud in negative 

select datediff(MM,'24/02/2008',getdate()) diff_in_months 
-- Conversion failed when converting date and/or time from character string.

select datediff(MM,'24/02/2008','24/02/20081')
-- Conversion failed when converting date and/or time from character string.

-- invalid dd/mm/yy 

select datediff(N,'08/16/2026',getdate()) diff_in_minutes
-- 2730 

select datediff(MS,'08/16/2026',getdate()) diff_in_milisecond
-- 163854093

select datediff(MS,'07/16/2026',getdate()) diff_in_milisecond
-- The datediff function resulted in an overflow. The number of dateparts separating two date/time instances is too large. Try to use datediff with a less precise datepart.


-- The size is to big that's why this error comes 

----------------------------------------------------------------------------------
-- my question how exact time thing work here 

select datediff(dy,'08/16/2026',getdate()) diff_in_day
-- it show one day 

select datediff(hh,'08/16/2026',getdate()) diff_in_hour
-- it give me 45 hr 

-- so the starting point is ??? 
------------------------------------------------------------------------------------

-- Datepart 

-- we can extract quarter , month , week , anything ... all intervals 

-- Syntax 
-- select datepart(interval,date) 

select datepart(q,getdate()) 
-- we are in third quarter that's why getting three aug month is third quarter 

select datepart(m,getdate())
-- 8 means 8th month 

select datepart(dd,getdate())
-- 17 todays date 

select datepart(dy,getdate())
-- 229 days 

select datepart(hh,getdate())
-- 21 hr from day start 

select datepart(weekday,getdate())
-- monday is 2nd week day 

