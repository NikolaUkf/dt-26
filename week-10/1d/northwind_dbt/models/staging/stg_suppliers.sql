SELECT
    trim(id)::int as supplierid, 
    trim(name)::int as suppliername,
    trim(contactname) as contactname,
    trim(address) as address,
    trim(city) as city,
    trim(postalcode) as postalcode,
    trim(country) as country,
    trim(phone) as phone
FROM {{ source('bronze', 'suppliers') }}