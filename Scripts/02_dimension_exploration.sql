/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    -  exploring the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
--Dimension Exploration 
--1) for the customers 
select * from gold.dim_customers ;
-- by looking in table we find that the 'country' column is the column that can be used for grouping 
select distinct country from gold.dim_customers; 
--2) for the products
select *  from gold.dim_product;
-- 2.1 founded that ypu can group  tha data using the category 
select  distinct  category from gold.dim_product -- 4 main categories founded  
-- 2.2 can be grouped by the subcategory 
--exppected to have more details than the category  
select  distinct  category, sub_category from gold.dim_product -- around 36  rows found
-- 2.3 can be grouped by the product_name 
--expected more rows than the subcategory
select  distinct  category, sub_category, product_name from gold.dim_product -- around  295 rows
--===========    ===========     ============
-- category      subcategory     product_name
-- level 1   >>>  level 2    >>>   level 3
-- 4 rows          36 rows         295 rows
--===========    ===========     ============
