create database retail;

CREATE TABLE retail_sales(
    invoice_no varchar(20),
    stock_code varchar(50),
    description text,
    quantity int,
    invoice_date timestamp, 
    unit_price numeric(10,2),
    customer_id int,
    country varchar(100)
);