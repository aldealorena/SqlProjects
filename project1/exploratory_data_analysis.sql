
-- life increase in 15 years 
select country, 
min(`lifeexpectancy`), 
max(`lifeexpectancy`),
round(max(`lifeexpectancy`) - min(`lifeexpectancy`), 1) as life_increase_15_years
from worldlifexpectancy
group by country
having min(`lifeexpectancy`) <> 0 
		and max(`lifeexpectancy`) <>0
order by life_increase_15_years desc;

-- 
select country, round(avg(`lifeexpectancy`),1) as life_exp, round(avg(gdp), 1) as gdp
from worldlifexpectancy
group by country;


select country, round(avg(`lifeexpectancy`),1) as life_exp, round(avg(gdp), 1) as gdp
from worldlifexpectancy
group by country
having life_exp > 0
and gdp > 0 
order by gdp asc;


select *
from worldlifexpectancy
order by gdp;


select 
sum(case when gdp >= 1500 then 1 else 0 end ) high_gdp_count,
avg(case when gdp >= 1500 then `lifeexpectancy` else null  end ) high_gdp_life_expectancy,
sum(case when gdp <= 1500 then 1 else 0 end )  low_gdp_count,
avg(case when gdp <= 1500 then `lifeexpectancy` else null  end ) low_gdp_life_expectancy
    from worldlifexpectancy;
    
    
select status, round(avg(`lifeexpectancy`), 1)
from worldlifexpectancy
group by status;

    
select status, count(distinct country)
from worldlifexpectancy
group by status;

    
select country, round(avg(`lifeexpectancy`),1) as life_exp, round(avg(bmi), 1) as bmi
from worldlifexpectancy
group by country
having life_exp > 0
and bmi > 0 
order by bmi desc;



