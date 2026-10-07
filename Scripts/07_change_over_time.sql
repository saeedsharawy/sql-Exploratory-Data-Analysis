/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/
--1* change over the time 
--total  sales over the year 
--total customer added each year
--total quantities sold
select 
year (order_date) order_date,
sum (sales) as total_sales,
count( distinct customer_key ) as total_customers,
sum (quantity) as total_quantity
from gold.fact_sales
where year (order_date) is not null
group  by year (order_date)
order by year (order_date)
--for month and year 
select 
datetrunc (month ,order_date) order_date,
sum (sales) as total_sales,
count( distinct customer_key ) as total_customers,
sum (quantity) as total_quantity
from gold.fact_sales
where datetrunc (month ,order_date) is not null
group  by datetrunc (month ,order_date)
order by datetrunc (month ,order_date)
-- for a specific format of the date
select 
format (order_date , 'yyyy-MMM') order_date,
sum (sales) as total_sales,
count( distinct customer_key ) as total_customers,
sum (quantity) as total_quantity
from gold.fact_sales
where format (order_date , 'yyyy-MMM') is not null
group  by format (order_date , 'yyyy-MMM')
order by format (order_date , 'yyyy-MMM')
