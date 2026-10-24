CREATE DATABASE retail_sales

ALTER DATABASE retail_sales SET datestyle TO 'ISO, MDY';

CREATE Table orders(
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    region VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ship_mode VARCHAR(30) NOT NULL,
    sales NUMERIC(18,2) NOT NULL,
    profit NUMERIC(18,2) NOT NULL
)
select * FROM orders