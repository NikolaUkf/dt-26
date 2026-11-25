SELECT
    trim(id)::int as rating_id, 
    trim(user_id)::int as user_id, 
    trim(movie_id)::int as movie_id, 
    trim(rating)::numeric(2,1) as rating, 
    trim(rated_at)::timestamp as rated_at
FROM {{ source('bronze', 'ratings') }}