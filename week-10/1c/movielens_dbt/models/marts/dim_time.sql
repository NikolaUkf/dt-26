SELECT
    (EXTRACT(HOUR FROM rated_time)::int * 10000
     + EXTRACT(MINUTE FROM rated_time)::int * 100
     + EXTRACT(SECOND FROM rated_time)::int)  AS time_id,
    rated_time,
    EXTRACT(HOUR FROM rated_time)::int        AS hour,
    EXTRACT(MINUTE FROM rated_time)::int      AS minute,
    EXTRACT(SECOND FROM rated_time)::int      AS second,
    CASE
        WHEN EXTRACT(HOUR FROM rated_time) BETWEEN 5  AND 11 THEN 'morning'
        WHEN EXTRACT(HOUR FROM rated_time) BETWEEN 12 AND 16 THEN 'afternoon'
        WHEN EXTRACT(HOUR FROM rated_time) BETWEEN 17 AND 20 THEN 'evening'
        ELSE 'night'
    END                                       AS time_of_day
FROM times