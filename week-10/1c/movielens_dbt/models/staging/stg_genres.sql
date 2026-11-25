SELECT
    trim(id)::int as genre_id, 
    trim(name) as genre_name
FROM {{ source('bronze', 'genres') }}