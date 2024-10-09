select * from employee;
select * from department;
select * from employee_history;
select * from sales;

-- scalar subquery
-- willl alway return 1 row and 1 column

select *
from employee e
join (select avg(salary) sal from employee) avg_sal
on  e.salary > avg_sal.sal

-- multiple row sub query
-- subquery which returns  multiple column and multiple row
-- subquery which returns only 1 column and multiple rows

-- find the employees who earn thehighest in each department
with cte as (
	select *,
	rank() over( partition by dept_name order by salary desc) as rnk
	from employee
	)

select * from cte
where rnk = 1

select dept_name, max(salary)
from employee
group by dept_name
-- another way of solving it
select *
from employee
where (dept_name, salary) in (select dept_name, max(salary)
								from employee
								group by dept_name)

-- find the departments who do not have any employees

select *
from department
where dept_name not in (select distinct dept_name from employee)

-- Corelated subquery
--subquery which is related to the other query
--QUESTION: find the emloyees in each department who earn more than the average
			salary in that department 
with cte as (
select *
		,case when salary > avg(salary) over (partition by dept_name) then emp_name end as above_avg 
from employee)

select count(above_avg) from cte

	select * 
	from employee e1
	where salary > (
					select avg(salary)
					from employee e2
					where e1.dept_name = e2.dept_name
						)
-- find the department without any employees
select *
from department d
where not exists (select * from employee e where e.dept_name = d.dept_name )

select * from sales

-- find stores whose sales are better than the average sales across all stores
-- 1 total sales for each store
-- 2 avg sales for all stores
-- compare 1 and 2 
with sales as
(
select store_name, sum(price) as total_sales
from sales
group by store_name)
	
select *
from sales
join	
	(select avg(total_sales) as sales
	from sales ) avg_sales
on sales.total_sales > avg_sales.sales

-- using subquery in the select clause
-- Fetch all the employee details and add remarks to those employees who earn more than average pay

select *, (case when salary > avg_sal.sal then 'Higher than average'else null end) as remarks
from employee
cross join (select avg(salary) sal from employee) avg_sal

-- using a subquery in the having clause
-- HAVING
-- Q find the stores who have sold more units than the average units sold by all stores
select store_name, sum(quantity)
from sales
group by 1
having sum(quantity) > (select avg(quantity) from sales)

-- Question insert data to employee history tablemake sure not to insert duplicate record
insert into employee_history
select e.emp_id,e.emp_name,d.dept_name, e.salary, d.location
from employee e
join department d
on d.dept_name = e.dept_name
where not exists (select 1 from employee_history eh where eh.emp_id = e.emp_id)

--update command using subquery
-- Question Give 10% increament to all employees in bangalore location based on the maximum 
-- salary earned by an emp in each dep. Only consider employees in employees table history

update employee e
set salary = (select max(salary) + (max(salary) * 0.1)
				from employee_history eh
				where eh.dept_name = e.dept_name )
where e.dept_name in (select dept_name from department where location = 'Bangalore')
and e.emp_id in (select emp_id from employee_history)

-- using delete in subquery
-- delete all department that do not have employees
delete from department
where dept_name in (
				select dept_name
				from department d
				where  not exists (select 1 from employee e where d.dept_name = e.dept_name)
				)