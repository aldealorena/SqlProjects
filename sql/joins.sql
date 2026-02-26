-- inner join
select * from customers;
select * from customer_orders;

select * 
from customers c
inner join customer_orders co
	on c.customer_id = co.customer_id
order by c.customer_id
;

-- ex1 
select *
from products;
select *
from customer_orders;


select p.product_name, sum(order_total) as total
from products p 
join customer_orders co
	on p.product_id = co.product_id
group by product_name
order by 2;

-- ex2
select * 
from suppliers;
select *
from ordered_items;

select *
from suppliers s
inner join ordered_items oi
	on s.supplier_id = oi.shipper_id;

-- joining multiple tables
select product_name, order_total, first_name
from products p
join customer_orders co
	on p.product_id = co.product_id
join customers c
	on co.customer_id = c.customer_id;

-- joining on multiple conditions
select *
from customer_orders;
select * 
from customer_orders_review;

select * 
from customer_orders co
join customer_orders_review cor
	on co.order_id = cor.order_id
    and co.customer_id = cor.customer_id
    and co.order_date = cor.order_date;
    
    
-- outer joins

-- inner join
select c.customer_id, first_name, co.order_id
from customers c
join customer_orders co
	on c.customer_id = co.customer_id
order by c.customer_id, co.customer_id;

-- left join
select c.customer_id, first_name, co.order_id
from customers c
left outer join customer_orders co
	on c.customer_id = co.customer_id
order by c.customer_id
;

-- right join
select c.customer_id, first_name, co.order_id
from customers c
right outer join customer_orders co
	on c.customer_id = co.customer_id
order by c.customer_id
;

-- self join
select c.customer_id, c.first_name, c.last_name, ss.customer_id, ss.first_name, ss.last_name
from customers c
join customers ss
	on c.customer_id + 1 = ss.customer_id
;

-- cross joins/ cartesian join
select * 
from customers
cross join customer_orders;

-- natural join
select *
from products p
natural join customer_orders co
order by p.product_id;


-- union
select first_name, last_name
from customers
union
select product_id, product_name
from products;

select first_name, last_name, 'old' as label
from customers
where year(birth_date)< 1950
union
select first_name, last_name, 'gold tipper'
from customers c
join customer_orders co
	on c.customer_id = co.customer_id
where tip > 3
union
select first_name, last_name, 'big spender'
from customers
where total_money_spent > 1000
order by first_name, last_name;

-- join use case 1
-- “Which products generate the highest potential profit based on current stock levels?”

select DISTINCT 
p.product_name, 
oi.unit_price, 
p.sale_price,
units_in_stock,
p.sale_price - oi.unit_price as profit,
(p.sale_price - oi.unit_price)  *  units_in_stock as potential_profit
from ordered_items oi
join products p
	using(product_id)
order by potential_profit desc;


-- join use case 2
-- “Which orders shipped more than two years ago are still not delivered, and which suppliers are responsible for them?”

select * 
from supplier_delivery_status;
select*
from ordered_items;
select *
from suppliers;


select oi.order_id, sds.name, oi.status, oi.shipped_date, s.name
from ordered_items oi
join supplier_delivery_status sds
	on oi.status = sds.order_status_id
join suppliers s
	on oi.shipper_id = s.supplier_id
where sds.name <> 'delivered'
and year(shipped_date) < year(now() - 2);


-- join use case 3 
-- Which are the top 5 products that generated the highest total profit based on all recorded sales?
 
    
SELECT
  p.product_name,
  SUM( (p.sale_price - oi.unit_price) * oi.quantity ) AS total_profit
FROM ordered_items oi
JOIN products p USING (product_id)
GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 5;
    
select * from ordered_items;
select * from products;


-- join use case 4
-- Which suppliers have the highest number of orders that were shipped more than two years ago but are still not marked as delivered?

SELECT
  s.name AS supplier_name,
  COUNT(DISTINCT oi.order_id) AS overdue_orders
FROM ordered_items oi
JOIN supplier_delivery_status sds
  ON oi.status = sds.order_status_id
JOIN suppliers s
  ON oi.shipper_id = s.supplier_id
WHERE sds.name <> 'delivered'
  AND oi.shipped_date < DATE_SUB(NOW(), INTERVAL 2 YEAR)
GROUP BY s.name
ORDER BY overdue_orders DESC;
    
    
    
    
    
    











