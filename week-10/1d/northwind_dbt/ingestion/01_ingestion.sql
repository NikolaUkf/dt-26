\set on_error_stop on 
\encoding UTF8

create SCHEMA IF NOT EXISTS bronze;

create TABLE if NOT exists bronze.categories(
    categoryid text,
    categoryname TEXT,
    description TEXT,
    _source_file TEXT DEFAULT 'categories.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);
CREATE Table if not exists bronze.customers( 
    customerid text,
    customername text,
    contactname text,
    address text,
    city text,
    postalcode text,
    country text,
    _source_file TEXT DEFAULT 'customers.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);
CREATE Table if not exists bronze.employees(
    employeeid text,
    lastname text,
    firstname text,
    birthdate date,
    photo text,
    notes text,
    _source_file TEXT DEFAULT 'employees.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()

);
CREATE Table if not exists bronze.orderdetails(
    orderdetailid text,
    orderid text,
    productid text,
    quantity text,
    _source_file TEXT DEFAULT 'orderdetails.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);
CREATE Table if not exists bronze.orders(
    orderid text,
    customerid text,
    employeeid text,
    orderdate date,
    shipperid text,
    _source_file TEXT DEFAULT 'orderdetails.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
); 
CREATE Table if not exists bronze.products(
    productid text,
    productname text,
    supplierid text,
    categoryid text,
    unit text,
    price text,
    _source_file TEXT DEFAULT 'products.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()

);
CREATE Table if not exists bronze.shippers(
    shipperid text,
    shippername text,
    phone text,
    _source_file TEXT DEFAULT 'shippers.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);
CREATE Table if not exists bronze.suppliers(
    supplierid text,
    suppliername text,
    contactname text,
    address text,
    postalcode text,
    country text,
    phone text,
    _source_file TEXT DEFAULT 'customers.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

truncate bronze.categories,
bronze.customers,
bronze.employees,
bronze.orderdetails,
bronze.orders,
bronze.products,
bronze.shippers,
bronze.suppliers;

\copy bronze.categories (categoryid,categoryname,description) from 'data/categories.csv' with (format csv, header true);
\copy bronze.customers (customerid,customername,contactname,address,city,postalcode,country) from 'data/customers.csv' with (format csv, header true);
\copy bronze.employees (employeeid,lastname,firstname,birthdate,photo,notes) from 'data/employees.csv' with (format csv, header true);
\copy bronze.orderdetails (orderdetailid,orderid,productid,quantity) from 'data/orderdetails.csv' with (format csv, header true);
\copy bronze.orders (orderid;customerid,employeeid,orderdate,shipperid) from 'data/orders.csv' with (format csv, header true);
\copy bronze.products (productid,productname,supplierid,categoryid,unit,price) from 'data/products.csv' with (format csv, header true);
\copy bronze.shippers (shipperid,shippername,phone) from 'data/shippers.csv' with (format csv, header true);
\copy bronze.suppliers (supplierid,suppliername,contactname,address,city,postalcode,country,phone) from 'data/suppliers.csv' with (format csv, header true);

commit;