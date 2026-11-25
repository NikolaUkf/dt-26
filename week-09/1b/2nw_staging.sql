\set ON_error_stop on
\encoding UTF8

create SCHEMA IF NOT EXISTS silver;


CREATE OR REPLACE VIEW silver.categories AS
SELECT categoryid,
    TRIM(categoryname) AS categoryname,
    description
FROM bronze.categories;

CREATE OR REPLACE VIEW silver.customers AS
SELECT customerid,
    TRIM(customername) AS customername,
    contactname,
    address,
    city,
    NULLIF(TRIM(postalcode), '') AS postalcode,   
    country
FROM bronze.customers;

CREATE OR REPLACE VIEW silver.employees AS
SELECT employeeid,
    firstname,
    lastname,
    firstname || ' ' || lastname AS fullname,
    birthdate,
    photo,
    notes
FROM bronze.employees;

CREATE OR REPLACE VIEW silver.shippers AS
SELECT shipperid,
    TRIM(shippername) AS shippername,
    phone
FROM bronze.shippers;

CREATE OR REPLACE VIEW silver.suppliers AS
SELECT supplierid,
    TRIM(suppliername) AS suppliername,
    contactname,
    address,
    city,
    postalcode,
    country,
    phone
FROM bronze.suppliers;

CREATE OR REPLACE VIEW silver.products AS
SELECT productid,
    TRIM(productname) AS productname,
    supplierid,
    categoryid,
    unit,
    price
FROM bronze.products;

CREATE OR REPLACE VIEW silver.orders AS
SELECT orderid,
    customerid,
    employeeid,
    orderdate,
    shipperid
FROM bronze.orders;

CREATE OR REPLACE VIEW silver.orderdetails AS
SELECT orderdetailid,
    orderid,
    productid,
    quantity
FROM bronze.orderdetails;