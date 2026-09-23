CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(20),
    segment VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50)
)

create Table products (
    product_id VARCHAR(20) PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(100)
)

create table orders(
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    Foreign Key (customer_id) REFERENCES customers(customer_id),
    product_id VARCHAR(20),
    Foreign Key (product_id) REFERENCES products(product_id),
    order_date DATE,
    ship_date DATE,
    sales decimal(10,2),
    quantity int,
    discount DECIMAL(10,2),
    profit DECIMAL(10,2)

)
