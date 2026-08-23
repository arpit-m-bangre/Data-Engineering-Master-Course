-- windows functions 

-- windows functions are imp but not de point of it is used by da mostly 

-- so many scenario based question create here 

-- 1 ranking -- most imp 
-- 2 value based 
-- 3 aggregate 

-- Ranking 
-- 1 row number 
-- 2 dense rank 
-- 3 rank

-- rank 
-- the column should be in ordered way that is sorted 
-- important for interview without writing query explain the output 
-- used in company at good level 
/*
marks desc order	row_number position   dense_rank value    rank value position 
99					1						1				   1
99                  2                       1				   1
98                  3                       2				   3 
98                  4                       2
98                  5                       2
94                  6 
90
90
85
85
85
80
80
70
70                 15                        7                14
null               16						 8				  16
-- exam rank system used here 
-- null also count in that 
-- group by we can't use here since need aggregate function 

-- here we use partition by 
-- used with window function + aggregate as well 
*/
