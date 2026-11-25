SELECT
    trim(id)::int as orderid, 
    trim(customerid)::int as customerid,
    trim(employeeid)::int as employeeid,
    trim(orderdate)::date as orderdate,
    trim(shipperid)::int as shipperid
FROM {{ source('bronze', 'orders') }}