{{ config(materialized='table') }}

WITH dates AS (
    SELECT DISTINCT rated_at::date AS rated_at
    FROM {{ ref('stg_ratings') }}
)

SELECT
    TO_CHAR(rated_at, 'YYYYMMDD')::int  AS date_id,
    rated_at,
    EXTRACT(DAY FROM rated_at)::int     AS day,
    EXTRACT(MONTH FROM rated_at)::int   AS month,
    EXTRACT(YEAR FROM rated_at)::int    AS year,
    EXTRACT(ISODOW FROM rated_at)::int  AS day_of_week,
    TRIM(TO_CHAR(rated_at, 'FMDay'))    AS day_name,
    EXTRACT(WEEK FROM rated_at)::int    AS week,
    TRIM(TO_CHAR(rated_at, 'FMMonth'))  AS month_name,
    EXTRACT(QUARTER FROM rated_at)::int AS quarter
FROM dates