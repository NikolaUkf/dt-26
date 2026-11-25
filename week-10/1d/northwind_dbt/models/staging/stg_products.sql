SELECT
    trim(id)::int as productid, 
    trim(name) as productname,
    trim(supplierid)::int as supplierid,
    trim(categoryid)::int as categoryid,
    trim(unit) as unit,
    trim(price)::numeric(10,2) as price
FROM {{ source('bronze', 'products') }}