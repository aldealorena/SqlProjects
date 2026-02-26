-- over clause + partition by

select * from customers;
select * from customer_orders;

select *
from customers c
join customer_orders co
	on c.customer_id = co.customer_id;
    
    
select c.customer_id, first_name, order_total
from customers c
join customer_orders co
	on c.customer_id = co.customer_id;
