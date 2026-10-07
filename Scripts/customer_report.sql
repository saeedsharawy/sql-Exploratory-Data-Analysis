
/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
    2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
        - total orders
        - total sales
        - total quantity purchased
        - total products
        - lifespan (in months)
    4. Calculates valuable KPIs:
        - recency (months since last order)
        - average order value
        - average monthly spend
===============================================================================
*/
create view gold.customer_report as
with base_query as (
/*---------------------------------------------------------------------------
    1) Base Query: Retrieves core columns from tables
 ---------------------------------------------------------------------------*/
select
    f.product_key,
    f.order_number,
    f.sales,
    f.quantity,
    f.price,
    f.order_date,
    c.customer_key,
    c.customer_code,
    concat (c.firstname ,' ', c.lastname) as customer_name,
    DATEDIFF(year,c.birth_date,GETDATE()) as age

    from gold.fact_sales f
    left join gold.dim_customers c
    on f.customer_key = c.customer_key
)
,customer_aggregation as (
    /*---------------------------------------------------------------------------
    2) Customer Aggregations: Summarizes key metrics at the customer level
    ---------------------------------------------------------------------------*/
select 
    customer_key,
    customer_code,
    customer_name,
    age,
    count(distinct product_key) as total_products,
    count(distinct order_number) as total_numbers,
    sum(sales) as total_sales,
    sum(quantity) as total_quantities,
    avg(price) as average_price,
    MAX(order_date) AS last_order_date,
    datediff(month,min(order_date) ,max(order_date) ) as lifespan
    from base_query
    group  by
    customer_key,
    customer_code,
    customer_name,
    age 
)
    /*--------------------------------------------------------------------------------------
    3) segmentions: Customer segmentions into categories (VIP, Regular, New) and age groups
    ----------------------------------------------------------------------------------------*/
select 
    customer_key,
    customer_code,
    customer_name,
    age,
    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50 and above'
    END AS age_group,
    total_products,
    total_numbers,
    total_sales,
    total_quantities,
    average_price,
    case 
         when lifespan >= 12 and total_sales >5000 then 'VIP'
	     when lifespan >= 12 and total_sales <= 5000 then 'Regular'
	     else 'New'
    end customer_segment,
    lifespan,
    last_order_date,
    --recency (months since last order)
    concat (datediff (month , last_order_date, GETDATE()),' ', 'Month') as recency,
    --average order value AVO
    case when  total_numbers= 0 then 0
         else  total_sales/ total_numbers 
    end average_order_value,
    -- average monthly spend
    case when  lifespan= 0 then total_sales -- /*we dont make =0 as this time 0 means that the customer exist 
         else  total_sales/ lifespan            -- for one month so we get his total sales*/
    end average_monthly_spend
   
    from customer_aggregation
    
