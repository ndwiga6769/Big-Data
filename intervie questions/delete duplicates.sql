
drop table if exists cars;
create table cars
(
	model_id		int primary key,
	model_name		varchar(100),
	color			varchar(100),
	brand			varchar(100)
);
insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla');
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');


-- The above function removes duplicates
-- using the minimum function
select * from cars;

DELETE FROM cars
WHERE model_id not in (
		select min(model_id)
		from cars
		group by model_name, brand
	)
DELETE FROM cars
	where model_id in 
	(
		SELECT max(model_id)
		from cars
		group by model_name, brand
		having count(1) > 1
	)
delete from cars where model_id in(
select model_id from 
(
select *,
row_number() over(partition by model_name,brand order by model_id) as rnk
from cars ) x
where x.rnk > 1);