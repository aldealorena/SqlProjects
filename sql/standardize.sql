-- standardize data
select phone from customer_sweepstakes;

-- select what has to be removed from phone number
select phone, REGEXP_REPLACE(phone, '[()-/+]','')
from customer_sweepstakes;

-- actually remove them
update customer_sweepstakes
set phone = REGEXP_REPLACE(phone, '[()-/+]','');

-- add delimiter between numbers
select phone, concat(substring(phone,1,3),'-', substring(phone,4,3),'-', substring(phone,7,4))
from customer_sweepstakes
where phone <> '';

-- actually add the delimiter
update customer_sweepstakes
set phone = concat(substring(phone,1,3),'-', substring(phone,4,3),'-', substring(phone,7,4))
where phone <> '';


-- modify date

-- not working
select birth_date, 
if(str_to_date(birth_date,'%m/%d/%y') is not null, str_to_date(birth_date,'%m/%d/%y'),str_to_date(birth_date,'%Y/%d/%m')),
str_to_date(birth_date,'%m/%d/%y'),
str_to_date(birth_date,'%Y/%d/%m')
from customer_sweepstakes;


update customer_sweepstakes
set birth_date =  if(str_to_date(birth_date,'%m/%d/%y') is not null, str_to_date(birth_date,'%m/%d/%y'),str_to_date(birth_date,'%Y/%d/%m'));

-- not working
update customer_sweepstakes
set birth_date =  case
when str_to_date(birth_date,'%m/%d/%y') is not null then str_to_date(birth_date,'%m/%d/%y')
when str_to_date(birth_date,'%m/%d/%y') is null then str_to_date(birth_date,'%Y/%d/%m')
end;


-- modify "are you over 18?" column
select `Are you over 18?`
from customer_sweepstakes;


select `Are you over 18?`,
CASE 
	WHEN `Are you over 18?` = 'yes' then 'Y'
    WHEN `Are you over 18?` = 'no' then 'N'
    ELSE `Are you over 18?`
END
from customer_sweepstakes;



update customer_sweepstakes
set `Are you over 18?` = CASE 
	WHEN `Are you over 18?` = 'yes' then 'Y'
    WHEN `Are you over 18?` = 'no' then 'N'
    ELSE `Are you over 18?`
END;

select * from customer_sweepstakes;

-- break one column intro multiple columns

select address,
substring_index(address, ',', 1) as street,
substring_index(substring_index(address, ',', 2),',',-1) as city,
substring_index(address, ',', -1) as state
from customer_sweepstakes;

-- creating new columns
alter table customer_sweepstakes
add column street varchar(50) after address;

alter table customer_sweepstakes
add column city varchar(50) after street,
add column state varchar(50) after  city
;

-- adding data intro columns

update customer_sweepstakes
set street = substring_index(address, ',', 1);

update customer_sweepstakes
set city = substring_index(substring_index(address, ',', 2),',',-1);

update customer_sweepstakes
set state = substring_index(address, ',', -1);

select * from customer_sweepstakes;

select state, upper(state)
from customer_sweepstakes;

update customer_sweepstakes
set state = upper(state);


update customer_sweepstakes
set city = trim(city);

update customer_sweepstakes
set state = trim(state);

select * from customer_sweepstakes;

-- update blank to null
update customer_sweepstakes
set phone = null 
where phone = '';

update customer_sweepstakes
set income = null 
where income = '';


-- delete unused columns
alter table customer_sweepstakes
drop column favorite_color;


