SELECT
    trim(id)::int as occupation_id, 
    trim(name) as occupation_name
FROM {{ source('bronze', 'occupations') }}