SELECT
    trim(id)::int as movie_id, 
    trim(title) as title, 
    trim(release_year)::int as release_year
FROM {{ source('bronze', 'movies') }}