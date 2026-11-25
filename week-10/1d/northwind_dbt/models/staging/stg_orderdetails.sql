SELECT
    trim(id)::int as orderdetailid,
    trim(orderid)::int as orderid,
    trim(productid)::int as productid,
    trim(quantity)::int as quantity 
FROM {{ source('bronze', 'orderdetails') }}