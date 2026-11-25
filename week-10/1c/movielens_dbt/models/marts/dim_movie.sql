SELECT
    m.movie_id,
    m.title,
    m.release_year,
    COALESCE(g.genre_name, 'unknown') AS genre_name
FROM {{ ref('stg_movies') }} m
LEFT JOIN genres g ON g.movie_id = m.movie_id