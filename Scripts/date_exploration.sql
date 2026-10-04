/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the timespan by getting the earlist  and latest dates.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/
--3.1 we will need to know the timespan by getting the earlist  and latest dates
--    find the date of the first and the last order
--    how many years of sales are available
select  
max (order_date) earliest_date_lastOrder ,
min (order_date) oldest_date_firstOrder,
datediff(year ,min (order_date) ,max (order_date) ) as range_of_years --years of sales are available
from gold.fact_sales
-- find the youngest and the oldest customer 
select 
max (birth_date) as youngest_customer,
min (birth_date) as oldest_customer,
datediff (year , min (birth_date),getdate()) oldest_age,
datediff (year , max (birth_date),getdate()) youngest_age
from gold.dim_customers
--*******************************************************************************
-- 4)Exploring the measure 
