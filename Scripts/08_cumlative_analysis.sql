/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/
select 
order_date,
total_sales,
sum(total_sales) over ( order by order_date ) as running_total
from (
select  
datetrunc(month, order_date) as order_date ,
sum(sales) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)

)t
--******************************************
-- finding moving average
select 
order_date,
avg_sales,
avg(avg_sales) over ( order by order_date ) as moving_average
from (
select  
datetrunc(month, order_date) as order_date ,
avg(sales) as avg_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)
)t
