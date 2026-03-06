create database ECommerce;
use ecommerce;
select * from basket_details;
select * from customer_details;
SHOW VARIABLES LIKE 'secure_file_priv';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_details.csv'
INTO TABLE customer_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/basket_details.csv'
INTO TABLE basket_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select
count(*) from customer_details;
select count(*) from basket_details;

select * from customer_details limit 10;
select * from basket_details limit 10;
describe customer_details;

select count(*) as null_customer_id from customer_details
where customer_id is null;



SELECT customer_id, COUNT(*) AS repetitions
FROM customer_details
GROUP BY customer_id
HAVING COUNT(*) > 1;
describe customer_details;

select * from(
select *,count(*) over (partition by customer_id order by customer_id ) as duplicates 
from customer_details
) as sub
where duplicates>1 ;
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_age DESC) AS rn
    FROM customer_details
)
DELETE FROM customer_details
WHERE customer_id IN (
    SELECT customer_id
    FROM ranked
    WHERE rn > 1
);
alter table customer_details 
modify customer_id  int not null primary key ;
describe customer_details;

describe basket_details;
select * from basket_details
where product_id is null;

select product_id , count(*) as duplicates
from basket_details 
group by product_id
having count(*)>1;

select * from(
select *, count(*) over(partition by product_id order by product_id) as dups
from basket_details) as sub
where dups>1;

describe basket_details;
-- here diff customers are ourchaching same product on different dates so no need for pk here

describe customer_details;

alter table customer_details modify column sex  enum('Male', 'Female', 'Unknown') not null;

select distinct sex, count(*) from customer_details group by sex;
update customer_details set sex='Male'where sex='male';
update customer_details set sex='Unknown' where sex is null or  sex not in('Male', 'Female')  ;

select * from customer_details group by customer_age;


select round(avg(customer_age),0)
from customer_details where customer_age<100;

update customer_details 
set customer_age=(
select round(avg(customer_age),0)
from ( select  customer_age from customer_details where customer_age<100)  as tempage)
where customer_age>100;
select * from customer_details ;
describe customer_details;
alter table customer_details modify column customer_age int not null;
select * from customer_details where tenure is null;

describe basket_details;
alter table basket_details add 
constraint fk_basket_customer_id foreign key(customer_id) references  customer_details(customer_id);

select * from basket_details where
customer_id not in (select customer_id from customer_details);

insert into customer_details(customer_id) select
distinct customer_id from basket_details where customer_id not in(select customer_id from customer_details);
select * from customer_details where customer_id=42366585;
alter table customer_details modify column customer_age int null;

update customer_details 
set customer_age=(
 select round(avg(customer_age),0)
 from(
 select  customer_age from customer_details where customer_age is not null) as tempagee) 
 where customer_age is null;
select * from customer_details where customer_age is null;
alter table customer_details modify column customer_age int not null;
describe customer_details;
alter table basket_details add constraint fk_basket_customer_id foreign key(customer_id)
references customer_details(customer_id);
describe basket_details;
select * from basket_details limit 5;
alter table basket_details modify column product_id  int not null;

alter table basket_details add column basket_id int primary key auto_increment;

alter table basket_details modify column basket_date date not null;


-- product id has no key so index it to fetch easily
alter table basket_details add index idx_product_id(product_id);
show index from basket_details;


-- question1.Find the average basket_count of all customers.
-- Then find all customers whose basket_count is higher than that average.

select * from (
select customer_id,
basket_date,
basket_count,
avg(basket_count) over() avgbasket from basket_details)  t
where basket_count>avgbasket ;
select * from basket_details where customer_id=851082;


delete from basket_details
where basket_id in  (
select basket_id from(
select basket_id,
row_number() over(
partition by customer_id,basket_count, basket_date 
order by basket_id) rn from
basket_details) as repetitions
where rn>1) ;

-- question 2 find the top 3 customers with the 
-- highest total basket_count. show their customer_id and total

select * from(
select  customer_id, sum(basket_count) as totalcount
 from basket_details 
group by customer_id
order by totalcount desc
)t limit 3;

-- q3   Find all customers from customer_details 
-- who have never made a purchase 
-- (i.e. they don't appear in basket_details at all)
-- using joins
select * from customer_details as cd
left join basket_details as bd on
cd.customer_id=bd.customer_id
where bd.customer_id is null;

-- using subquery
select count(*) from customer_details where
customer_id not in (
select customer_id from basket_details);

-- 19200 customers have never purchased


--  q4 find customers whose basket_count is above
-- the average basket_count of their own age group
select * from (
select *,
avg(basket_count) over (partition by customer_age) as avgbasket
from 
(select 
	cd.customer_id,
    cd.customer_age, 
    bd.basket_count 
    from basket_details as bd
    join customer_details as cd 
    on bd.customer_id=cd. customer_id) as tables 
    ) as average
    where basket_count>avgbasket;

-- q5 Find customers whose basket_count is higher than the overall 
-- average basket_count. 
-- Show customer_id, basket_count, customer_age, sex
select * from(
select  *,avg(basket_count) over() as averagebasket
 from 
(select cd.customer_id, 
bd.basket_count,
cd.customer_age,
cd.sex
from customer_details as cd
join basket_details as bd on
cd.customer_id=bd.customer_id) as joining ) t 
where basket_count>averagebasket;




select cd.customer_id, 
bd.basket_count,
cd.customer_age,
cd.sex
from customer_details as cd
join basket_details as bd on
cd.customer_id=bd.customer_id;


-- q6 Find the average basket_count per gender.
-- Show sex and avg_basket
select *

 from(
select sex, avg(basket_count) as avg_basket  from(
 select cd.customer_id , 
 cd.sex,
 bd.basket_count
 from customer_details as cd
 join basket_details as bd 
 on cd.customer_id= bd.customer_id) as avg_basket
 group by sex) m ;
 
 -- q 7  Find customers whose basket_count is above the
 -- average of their own gender group
 
 select * from (
 select *, avg(basket_count) over(partition by sex) as avgbasket from(
 select cd.customer_id, 
 bd.basket_count,
 cd.sex
 from customer_details as cd
 join  basket_details AS bd
 on cd.customer_id=bd.customer_id) as t) as m
 where basket_count>avgbasket;
 
 
 
 -- q 8 Find the top 5 dates with the highest total basket_count
select * from basket_details;



select * from (
select basket_date,
sum(basket_count) as totalcount 
from basket_details
group by basket_date order by totalcount desc limit 5) as t ;

-- q 9 Find customers who shopped on more than 3 different dates
select * from(
select customer_id, count(distinct basket_date) as datess
from basket_details
group by customer_id) as t 
where datess>3 ;

-- q 10 Find all customers whose total basket_count
-- is above the average total basket_count of all customers

select * from(
 select customer_id,
 sum(basket_count) as totalforeachcustomer
 from basket_details
 group by customer_id) as t
 where  totalforeachcustomer >
 (select  avg(totaloverall) 
 from
 (select sum(basket_count) as totaloverall from basket_details 
 group by customer_id)total);
 
 
 -- qFind customers whose total basket_count 
 -- is above the maximum total of all customers divided by 2
 select * from(
 select customer_id ,sum( basket_count) 
 as totalbasketcount
 from basket_details
 group by customer_id) as totalbasketcount
 where totalbasketcount > (
 select max(total)/2 from(
 select sum(  basket_count) as total
 from basket_details 
 group by customer_id)total );
 
 
 -- q Find customers whose total basket_count is below
 -- the minimum total basket_count of all customers multiplied by 2
 
select * from(
select customer_id , sum( basket_count) as totalbasketcount
from basket_details 
group  by customer_id) as totalbasketcount
where totalbasketcount< (
select min(totalcount)*2 from(
select sum(basket_count) as  totalcount
from basket_details
group by customer_id) totalcount );


-- Find the top 3 dates where total
--  basket_count was above the average daily total
select * from(
select * from(
select basket_date, sum(basket_count) as totalbasketcount from basket_details 
group by basket_date) as totalbasketcount
where totalbasketcount >(
select avg(totalcount)  from(
select sum(basket_count) as totalcount 
from basket_details 
group by basket_date) totalcount)
) as t
order by totalbasketcount
limit 3;

-- Show all unique customer_id from BOTH customer_details 
-- and basket_details combined


select distinct customer_id from
customer_details
union
select distinct customer_id from
basket_details;
-- q2 Show all customer_id from both tables
-- including duplicates. Then count total rows.


select customer_id from
customer_details 
union all 
select customer_id  from basket_details
;


-- q CTE1: Get customers with total basket_count above average
-- CTE2: Get customers who never purchased
-- UNION both results — show customer_id and a label column 
-- saying "High Spender" or "Never Purchased"

 with high_spender as(
select customer_id ,
sum(basket_count) as totalbasket
from basket_details
group by customer_id
having totalbasket>(
select  avg(total) from(
             select  sum(basket_count) as total
             from basket_details
             group by customer_id) as total
)),
 never_purchased as (
 select customer_id from 
 customer_details
 where customer_id not in(
 select customer_id from basket_details
 ))
 select customer_id , 'High Spender' as label
 from high_spender
 union
 select customer_id ,'Never Purchased' as label 
 from never_purchased;
 
-- q4 Find top 5 youngest customers who purchased
-- UNION with
 -- top 5 oldest customers who purchased
-- Show customer_id and customer_age
select * from customer_details;


with young_customer as(
select distinct cd.customer_id , cd.customer_age
from customer_details as cd
join basket_details as bd  
on cd.customer_id=bd.customer_id
order by cd.customer_age asc
limit 5
),

 old_customer as(
 select distinct cd.customer_id, cd.customer_age 
 from customer_details as cd
 join basket_details as bd 
 on cd.customer_id=bd.customer_id
 order by customer_age desc
 limit 5
 
)

select customer_id , customer_age, 'young customer' as label
from young_customer
union all
select  customer_id , customer_age, 'old customer' as label
from old_customer;



 




 










 

 
 




