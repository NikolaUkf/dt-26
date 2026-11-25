-- Active: 1795004032812@@127.0.0.1@5432@movielens_elt


create SCHEMA IF NOT EXISTS gold;

--dim user
create table if not exists gold.dim_user (
    user_id int primary key,
    gender char(1) not null check(gender in ('M', 'F')),
    zip_code varchar(10) not null,
    age_group varchar(20) not null,
    occupation varchar(50) not null
);

create Table gold.dim_movie(
    movie_id int not null unique,
    title VARCHAR(200) not null,
    release_year int,
    genre_name VARCHAR(200) not null 
);

--dim date
create table gold.dim_date(
    date_id int PRIMARY KEY,
    rated_at date not null UNIQUE,
    day int not null,
    month int not null,
    year int not null,
    day_of_week int not null,
    day_name varchar(10) not null,
    week int not null,
    month_name VARCHAR(10) not null,
    quarter int not null
);

create table gold.dim_time(
    time_id int PRIMARY KEY,
    rated_time time not null UNIQUE,
    hour int not null,
    minute int not null,
    second int not null,
    time_of_day varchar(10)not null
);

--fact rating
create table gold.fact_rating(
    rating_id int PRIMARY KEY,
    user_id int not null REFERENCES gold.dim_user(user_id),
    movie_id int not null REFERENCES gold.dim_movie(movie_id),
    date_id int not null REFERENCES gold.dim_date(date_id),
    time_id int not null REFERENCES gold.dim_time(time_id),
    rating numeric(2,1) not null check (rating between 1 and 5),
    rating_count int not null,
    rating_percentage int not null 
);

--indexy na cudzie kluce postgre nevztvara automaticky :(
create index on gold.fact_rating(user_id);
create index on gold.fact_rating(movie_id);
create index on gold.fact_rating(date_id);
create index on gold.fact_rating(time_id);

begin;
truncate gold.fact_rating,
gold.dim_user,
gold.dim_movie,
gold.dim_date,
gold.dim_time;

-- RESTART IDENTITY v pripade autoincrementu
insert into gold.dim_user(user_id, gender, zip_code, age_group, occupation)
select u.user_id, u.gender, u.zip_code, COALESCE(ag.age_group_name, 'Unknown') as age_group, COALESCE(o.occupation_name, 'Unknown') as occupation
from silver.stg_users u
left join silver.stg_age_groups ag on u.age = ag.age_group_id
left join silver.stg_occupations o on u.occupation_id = o.occupation_id;
order by u.user_id;


insert into gold.dim_movie(movie_id, title, release_year, genre_name)
select 
    m.movie_id, 
    m.title, 
    m.release_year, 
    coalesce(agg.genre_name, 'Unknown') as genre_name
from silver.stg_movies m
left join (
    select 
        gm.movie_id, 
        string_agg(g.genre_name, ', ' order by g.genre_name) as genre_name
    from silver.stg_genres_movies gm
    join silver.stg_genres g on gm.genre_id = g.genre_id
    group by gm.movie_id
) agg on agg.movie_id = m.movie_id
order by m.movie_id;

commit;