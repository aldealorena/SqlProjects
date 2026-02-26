SELECT * FROM world_life_expectancy.worldlifexpectancy;


-- finding duplicates
select country, year, concat(country, year), count(concat(country, year))
from worldlifexpectancy
group by country, year, concat(country, year)
having count(concat(country, year)) > 1;


select *
from(
	select row_id, 
	concat(country, year),
	row_number() over(partition by concat(country, year) order by  concat(country,year)) as row_num
	from worldlifexpectancy
) as row_table
where row_num > 1;


-- delete duplicates
delete from worldlifexpectancy
where 	
	row_id in (select row_id
from(
	select row_id, 
	concat(country, year),
	row_number() over(partition by concat(country, year) order by  concat(country,year)) as row_num
	from worldlifexpectancy
) as row_table
where row_num > 1);

-- empty values
select * from worldlifexpectancy
where status = '';

select distinct(status) from worldlifexpectancy
where status <>'';

select distinct(country) 
from worldlifexpectancy
where status = 'developing';



-- not working
update worldlifexpectancy
set status = 'developing'
where country in (select distinct(country) 
from worldlifexpectancy
where status = 'developing');

update worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
set t1.status = 'developing'
where t1.status = ''
and t2.status <> ''
and t2.status = 'developing';



update worldlifexpectancy t1
join worldlifexpectancy t2
	on t1.country = t2.country
set t1.status = 'developed'
where t1.status = ''
and t2.status <> ''
and t2.status = 'developed';


select * from worldlifexpectancy
where `Lifeexpectancy` = '';

select * from worldlifexpectancy;











