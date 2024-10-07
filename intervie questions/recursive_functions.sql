WITH [RECURSIVE] CTE_name AS
(
	SELECT query (Non Recursive query or the Base query)
	UNION [ALL]
	SELECT query (Recursive query using CTE_name [with a termination condition])	
)

SELECT * FROM CTE_name

-- display number from one to 10 without using any in built function

with recursive numbers as(
	select 1 as n 
	union
	select n + 1
	from numbers where n < 9
)

select * from numbers;

-- find the hierachy of employees under a given manager

--- Q8: Find the hierarchy --- 

drop TABLE emp_details;
CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)
    );
INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');


select * from emp_details;

 with recursive emp_hierachy as
			(
			select id_id,designation, 1 as lvl
	 		from emp_details
	 		where name ='Asha'
	 		union
	 		select E.id,E.name,E.manager_id,E.designation,H.lvl+1 as lvl
	 		from emp_hierachy H
	 		join emp_details E ON H.id = E.manager_id
			)
select H2.id as emp_id,H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierachy H2
join emp_details E2 on E2.id = H2.manager_id;,name,manager

-- find the hierachy of manager for a given employee

with recursive emp_hierachy as
			(
			select id,name,manager_id,designation, 1 as lvl
	 		from emp_details
	 		where name ='David'
	 		union
	 		select E.id,E.name,E.manager_id,E.designation,H.lvl+1 as lvl
	 		from emp_hierachy H
	 		join emp_details E ON H.manager_id = E.id
			)
select H2.id as emp_id,H2.name as emp_name, E2.name as manager_name, H2.lvl as level
from emp_hierachy H2
join emp_details E2 on E2.id = H2.manager_id;
