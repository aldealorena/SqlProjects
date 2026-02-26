-- subqueries
 select * from customers;
 
 select * from customers 
 where customer_id in 
	(select customer_id
	from customer_orders
    where tip > 1)
;


-- the subquery
select max(quantity * unit_price) as total_order_price
from ordered_items
where shipper_id = 1;

-- the query with MAX
select order_id, quantity, unit_price, (quantity *unit_price) as total_order_price 
from ordered_items
where  (quantity * unit_price) >
								(select max(quantity * unit_price) as total_order_price
								from ordered_items
								where shipper_id = 1);
                                
-- the query with ALL
select order_id, quantity, unit_price, (quantity *unit_price) as total_order_price 
from ordered_items
where  (quantity * unit_price) >
								all (select (quantity * unit_price) as total_order_price
								from ordered_items
								where shipper_id = 1);
                                
-- the query with ANY
select order_id, quantity, unit_price, (quantity *unit_price) as total_order_price 
from ordered_items
where  (quantity * unit_price) >
								any (select (quantity * unit_price) as total_order_price
								from ordered_items
								where shipper_id = 1);
                                
                                
-- EXISTS
select *
from customers
where customer_id in
	(select customer_id 
		from customer_orders);
        
        
select *
from customers
where exists
	(select customer_id 
		from customer_orders);
        
        
-- subqueries in select and from statements
select product_id, 
quantity,
(select avg(quantity) from ordered_items) as avg_quantity
from ordered_items;



select product_id, 
quantity,
(quantity/(select sum(quantity) from ordered_items) * 100) as sum_quantity
from ordered_items;












