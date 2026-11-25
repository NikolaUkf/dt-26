SELECT
    trim(id)::int as categoryid, 
    trim(name) as categoryname,
    trim(description) as description
FROM {{ source('bronze', 'categories') }}