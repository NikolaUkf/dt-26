\set ON_error_stop on
\encoding UTF8

create SCHEMA IF NOT EXISTS silver;

create View silver.stg_users as 
select trim(id)::int as user_id, trim(age)::int as age, upper(trim(gender)) as gender,
trim(occupation_id)::int as occupation_id, trim(zip_code) as zip_code, _source_file
from bronze.users;

create view silver.stg_movies as 
    select trim(id)::int as movie_id, trim(title) as title, 
    trim(release_year)::int as release_year
    from bronze.movies;

create view silver.stg_ratings as
    select trim(id)::int as rating_id, trim(user_id)::int as user_id, 
    trim(movie_id)::int as movie_id, trim(rating)::numeric(2,1) as rating, 
    trim(rated_at)::timestamp as rated_at
    from bronze.ratings;

create view silver.stg_occupations as
    select trim(id)::int as occupation_id, 
    trim(name) as occupation_name
    from bronze.occupations;

create view silver.stg_age_groups as
    select trim(id)::int as age_group_id, 
    trim(name) as age_group_name
    from bronze.age_group;

--pozor tu asi chyba
create view silver.stg_genres as
    select trim(id)::int as genre_id, 
    trim(name) as genre_name
    from bronze.genres;

create view silver.stg_genres_movies as
    select trim(id)::int as genre_movie_id, 
    trim(movie_id)::int as movie_id, 
    trim(genre_id)::int as genre_id
    from bronze.genres_movies;

