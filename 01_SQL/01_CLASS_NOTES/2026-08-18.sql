-- 18 aug 

-- set and date functions are done in previous two classes 
-- date function will ask in interview for sure 

-- New imp topic and it is very imp take 4 classes at least 

-- join 
-- the internal operation of join and set are diff some time output can be same 

-- two types of join primarily 
-- 1 inner join 
-- 2 outer join 
--		2.1 left join 
--		2.2 right join 
--		2.3 full outer join 

-- vain diagram reference are good in revision notes ! 
-- inner join : the common from both just like intersection 
-- left join : the common from both and full from left table 
-- right join : the common from both and full from right table 
-- full join : the full table of both it is inner join + left join + right join 

-- looks like and feel like set thing but it is not in real ... brainstorm it !

-- join - cross product + condition 
/*
set scenarion 

1  3
2  4 
3  5
4  6
null null 

intersect 
3 
4
null 

-- but it don't check like null = null it is simple like the value in table 1 and table 2 show the value present in both 

now cross product (nxn)

each value pari with each value of second table 
i.e
1,3
2,3
3,3
4,3
..
..
..
4,6

and then condition 

chck equal value like 
3=3
4=4 
then output will be 

3
4
the above output is for inner join 
*/
-- null come in intersect but not in inner join 
-- since keyword = keyword never exist 
-- left right and full the null is there 

-- we have to understand where to use what join 
-- syntax is easy but in interview the prob is what to use when 

/*
1  3
2  4 
3  5
4  6
null null 

inner join ouput --> 3 4 

left : inner + remaining from left table 

3 4 1 and 2 

right : inner + remainig from right table  

3 4 5 and 6 

full outer : inner + left + right 
3 4 inner 
1 2 left
5 6 right
1 2 3 4 5 6 
*/

/* 
in class quize 

1	1
1	1
1	null 
null null 


my answer 

inner : 1 1  
left : 1 1 1 null 
right : 1 1 null null 
full 1 1 1 null 1 1 null null 


actuall answer the following are count of ones 

inner : 6 
left : 7 
right : 8 
full : 9 

the cross product game 

note : create trick for such question interview 
note : create full explanation table thing this is like fix question type thing 
-- super important question based on interview thing 

for left or right join thing 

the remaining value respecting value is null 

suppose 

3 table one remaining value 
null table two respecting value 

-- brainstorm it deeply in notes in class notes as well 

one more question 

1		1 
2		1
2		3
3		3
3		null 
3		4
null	4
2		1 

inner :
left : 
right : 
full : 

one more question 

A		A
B		A
C		B
C		B
C		'NULL' 
'NULL'	NULL 
NULL	NULL 
B		D
		D 

inner :
left :
right :
full : 

NOTE : NULL IS KEYWORD AND 'NULL' IS VALUE 

-- THIS TYPE OF QUESTION ARE INTERVIEW ASK THEY ASK COUNT SPECIALLY, TO UNDERSTAND JOIN CONCEPT UNDERSTANDING 

-- note in intersect null come but not in inner join ? 

*/