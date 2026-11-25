SELECT
    trim(id)::int as customerid, 
    trim(name)::int as customername,
    trim(contactname) as contactname,
    trim(address) as address,
    trim(city) as city,
    trim(postalcode) as postalcode,
    trim(country) as country
FROM {{ source('bronze', 'customers') }}