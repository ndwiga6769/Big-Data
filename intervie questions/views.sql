-- Fetch the order summary (to be given to client/vendor)
create or replace view order_summary
as
select o.ord_id , o.date, c.cust_name, p.prod_name
, (p.price * o.quantity) - (p.price * o.quantity) * (o.disc_percent::float/100) as cost
,c.cust_id
from tb_customer_data c
join tb_order_details o on o.cust_id = c.cust_id
join tb_product_info p on p.prod_id = o.prod_id
order by o.ord_id,c.cust_name;

-- create role james
-- login
-- password 'james'

grant select on order_summary to james;

select * from order_summary_2
select * from tb_order_details;

alter view order_summary rename to order_summary_2;
drop view order_summary_2;

create or replace  view expensive_products as 
select * from tb_product_info where price > 1000;

select * from expensive_products

alter table tb_product_info add column prod_config varchar(100)

select * from tb_product_info
	
update  tb_product_info
	set prod_name = 'TEST',
		brand = 'Test',
		price = '1299',
		prod_config = null
	 where prod_id = 'p10';

-- updating a view to see whether it will reflect in the real table

update  expensive_products
	set prod_name = 'iphone',
		brand = 'Apple',
		price = '1299',
		prod_config = null
	 where prod_id = 'p10';

-- WITH CHECK OPTION
create or replace view apple_products as
SELECT * FROM tb_product_info
where brand = 'Apple'
with check option

insert into apple_products
values(
'p24','Note 24','Apple',2500,null
	
		)

select * from apple_products