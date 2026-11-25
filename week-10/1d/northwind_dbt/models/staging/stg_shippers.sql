SELECT
    trim(id)::int as shipperid, 
    trim(name) as shippername,
    trim(phone) as phone
FROM {{ source('bronze', 'shippers') }}