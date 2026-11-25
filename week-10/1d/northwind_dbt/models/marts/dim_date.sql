WITH dates AS (
    SELECT DISTINCT o.order_date::date AS order_date
    FROM {{ ref('stg_orders') }} o
)

SELECT
    TO_CHAR(d.order_date, 'YYYYMMDD')::int  AS date_id,
    d.order_date,
    EXTRACT(DAY FROM d.order_date)::int     AS day,
    EXTRACT(MONTH FROM d.order_date)::int   AS month,
    EXTRACT(YEAR FROM d.order_date)::int    AS year,
    EXTRACT(ISODOW FROM d.order_date)::int  AS day_of_week,
    TRIM(TO_CHAR(d.order_date, 'FMDay'))    AS day_name,
    EXTRACT(WEEK FROM d.order_date)::int    AS week,
    TRIM(TO_CHAR(d.order_date, 'FMMonth'))  AS month_name,
    EXTRACT(QUARTER FROM d.order_date)::int AS quarter
FROM dates d