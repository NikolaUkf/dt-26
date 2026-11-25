SELECT
    trim(id)::int as genre_movie_id, 
    trim(movie_id)::int as movie_id, 
    trim(genre_id)::int as genre_id
FROM {{ source('bronze', 'genres_movies') }}