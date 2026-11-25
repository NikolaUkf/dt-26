-- Active: 1790189759050@@127.0.0.1@5432@northwind_elt
create schema if not exists gold;
create table if not exists gold.dim_customer (
customer_id   int primary key,
customer_name varchar(60) not null,
contact_name  varchar(40) not null,
address       varchar(80) not null,
city          varchar(30) not null,
postal_code   varchar(15),
country       varchar(30) not null
);

create table if not exists gold.dim_employee (
employee_id int primary key,
first_name  varchar(30) not null,
last_name   varchar(30) not null,
full_name   varchar(61) not null,
birth_date  date not null
);


create table if not exists gold.dim_shipper (
shipper_id   int primary key,
shipper_name varchar(40) not null,
phone        varchar(25) not null
);


create table if not exists gold.dim_product (
product_id           int primary key,
product_name         varchar(60) not null,
unit                 varchar(40) not null,
price                numeric(10,2) not null,
category_name        varchar(25) not null,
category_description varchar(100),
supplier_name        varchar(60) not null,
supplier_city        varchar(30),
supplier_country     varchar(30)
);


create table if not exists gold.dim_date (
date_id     int primary key,            
order_date  date not null unique,
day         int not null,
month       int not null,
year        int not null,
day_of_week int not null,
day_name    varchar(10) not null,
week        int not null,
month_name  varchar(10) not null,
quarter     int not null
);


create table if not exists gold.fact_orderdetails (
orderdetail_id int primary key,
order_id       int not null,           
customer_id    int not null references gold.dim_customer(customer_id),
employee_id    int not null references gold.dim_employee(employee_id),
shipper_id     int not null references gold.dim_shipper(shipper_id),
product_id     int not null references gold.dim_product(product_id),
date_id        int not null references gold.dim_date(date_id),
quantity       int not null check (quantity > 0),
unit_price     numeric(10,2) not null,
total_price    numeric(12,2) not null   
);


create index if not exists idx_fact_customer on gold.fact_orderdetails(customer_id);
create index if not exists idx_fact_employee on gold.fact_orderdetails(employee_id);
create index if not exists idx_fact_shipper  on gold.fact_orderdetails(shipper_id);
create index if not exists idx_fact_product  on gold.fact_orderdetails(product_id);
create index if not exists idx_fact_date     on gold.fact_orderdetails(date_id);

begin;

truncate gold.fact_orderdetails,
        gold.dim_customer,
        gold.dim_employee,
        gold.dim_shipper,
        gold.dim_product,
        gold.dim_date;

insert into gold.dim_customer (customer_id, customer_name, contact_name, address, city, postal_code, country)
select customer_id, customer_name, contact_name, address, city, postal_code, country
from silver.stg_customers
order by customer_id;

insert into gold.dim_employee (employee_id, first_name, last_name, full_name, birth_date)
select employee_id, first_name, last_name, full_name, birth_date
from silver.stg_employees
order by employee_id;

insert into gold.dim_shipper (shipper_id, shipper_name, phone)
select shipper_id, shipper_name, phone
from silver.stg_shippers
order by shipper_id;

insert into gold.dim_product (product_id, product_name, unit, price,
                            category_name, category_description,
                            supplier_name, supplier_city, supplier_country)
select p.product_id,
    p.product_name,
    p.unit,
    p.price,
    coalesce(c.category_name, 'Unknown'),
    c.description,
    coalesce(s.supplier_name, 'Unknown'),
    s.city,
    s.country
from silver.stg_products p
left join silver.stg_categories c on c.category_id = p.category_id
left join silver.stg_suppliers  s on s.supplier_id = p.supplier_id
order by p.product_id;

insert into gold.dim_date (date_id, order_date, day, month, year, day_of_week, day_name, week, month_name, quarter)
select to_char(d, 'YYYYMMDD')::int,
    d::date,
    extract(day from d),
    extract(month from d),
    extract(year from d),
    extract(isodow from d),
    trim(to_char(d, 'FMDay')),
    extract(week from d),
    trim(to_char(d, 'FMMonth')),
    extract(quarter from d)
from generate_series('1996-01-01'::date, '1998-12-31'::date, interval '1 day') as d;

insert into gold.fact_orderdetails (orderdetail_id, order_id, customer_id, employee_id, shipper_id,
                                product_id, date_id, quantity, unit_price, total_price)
select od.orderdetail_id,
    od.order_id,
    o.customer_id,
    o.employee_id,
    o.shipper_id,
    od.product_id,
    to_char(o.order_date, 'YYYYMMDD')::int,
    od.quantity,
    p.price,
    od.quantity * p.price
from silver.stg_orderdetails od
join silver.stg_orders   o on o.order_id   = od.order_id
join silver.stg_products p on p.product_id = od.product_id
order by od.orderdetail_id;

commit;

select count(*) as fact_rows from gold.fact_orderdetails;

select d.year, d.month, round(sum(f.total_price), 2) as revenue
from gold.fact_orderdetails f
join gold.dim_date d on d.date_id = f.date_id
group by d.year, d.month
order by d.year, d.month;