SELECT
    trim(id)::int as age_group_id, 
    trim(name) as age_group_name
FROM {{ source('bronze', 'age_group') }}