select * from customer_orders;


-- am grupat dupa customer id suma tipsurilor 
select customer_id, sum(tip)
from customer_orders
group by customer_id;

-- am grupat dupa product id si am facut avg(order total)
select product_id, avg(order_total) as average_tips
from customer_orders 
group by product_id
order by avg(order_total) desc;

-- am grupat dupa customer id si am facut max(tip)
select customer_id, max(tip) as biggest_tips
from customer_orders 
group by customer_id
order by biggest_tips;

-- count of tips
select customer_id, count(tip) as count_of_tips
from customer_orders
group by customer_id
order by count_of_tips;


-- count distinct
select product_id, count(tip), count(distinct tip)
from customer_orders
group by product_id
order by product_id;

select * from customer_orders;


-- having
select customer_id, sum(tip) as total_tips
from customer_orders
group by customer_id
having total_tips > 5;

-- where
select customer_id, order_total
from customer_orders
where order_total > 10
group by customer_id, order_total;


-- rollup
select customer_id, count(tip) as count_tips
from customer_orders
group by customer_id with rollup;








