-- Active: 1795004032812@@127.0.0.1@5432@movielens_elt@public
--CREATE DATABASE MOVIELENS_ELT;

\set on_error_stop on 
\encoding UTF8

create SCHEMA IF NOT EXISTS bronze;

create TABLE if NOT exists bronze.ratings(
    id text,
    user_id text,
    movie_id text,
    rating text,
    rated_at text,
    _source_file TEXT DEFAULT 'ratings.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);
create TABLE if NOT exists bronze.users(
    id text,
    age text,
    gender text,
    occupation_id text,
    zip_code text,
    _source_file TEXT DEFAULT 'users.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

create Table if not exists bronze.movies(
    id text,
    title text,
    release_year text,
    _source_file TEXT DEFAULT 'movies.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

create table if not exists bronze.occupations(
    id text,
    name text,
    _source_file TEXT DEFAULT 'occupations.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

create Table if not exists bronze.age_group(
    id text,
    name text,
    _source_file TEXT DEFAULT 'age_group.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

create Table if not exists bronze.genres(
    id text,
    name text,
    _source_file TEXT DEFAULT 'genres.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

create table if not exists bronze.genres_movies(
    id text,
    movie_id text,
    genre_id text,
    _source_file TEXT DEFAULT 'genres_movies.csv',
    _loaded_at TIMESTAMPTZ DEFAULT now()
);

--
truncate bronze.ratings,
bronze.users,
bronze.movies,
bronze.occupations,
bronze.age_group,
bronze.genres,
bronze.genres_movies;

\copy bronze.occupations (id,name) from 'data/occupations.csv' with (format csv, header true);
\copy bronze.age_group (id,name) from 'data/age_group.csv' with (format csv, header true);
\copy bronze.genres (id,name) from 'data/genres.csv' with (format csv, header true);
\copy bronze.genres_movies (id,genre_id,movie_id) from 'data/genres_movies.csv' with (format csv, header true);
\copy bronze.users (id,age,gender,occupation_id,zip_code) from 'data/users.csv' with (format csv, header true);
\copy bronze.occupations (id,name) from 'data/occupations.csv' with (format csv, header true);
\copy bronze.movies (id,title,release_year) from 'data/movies.csv' with (format csv, header true);
\copy bronze.ratings (id,user_id,movie_id,rating,rated_at) from 'data/ratings.csv' with (format csv, header true);

commit;
