/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/
--explore all the tables in the database
select
  * 
from information_schema.tables
--explore all the columns in the databse
select *  
from information_schema.columns
where table_name = 'dim_customers' -- this for exploring the columns of a specific table

--================================================================================================
