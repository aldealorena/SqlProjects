-- removing duplicates
select * from customer_sweepstakes;

-- find the duplicates1
select customer_id, count(customer_id) 
from customer_sweepstakes
group by customer_id
having count(customer_id) > 1;

-- find the duplicates2
select *
from (select customer_id, 
row_number() over (partition by customer_id order by customer_id) as row_num
from customer_sweepstakes) as table_row
where row_num > 1;


-- delete the duplicates
delete from customer_sweepstakes
where sweepstake_id IN (
		select sweepstake_id
		from (select sweepstake_id, 
		row_number() over (partition by customer_id order by customer_id) as row_num
		from customer_sweepstakes) as table_row
		where row_num > 1
        );






