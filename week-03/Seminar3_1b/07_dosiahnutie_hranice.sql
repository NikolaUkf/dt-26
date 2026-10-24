WITH RECURSIVE mesacny_predaj AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS mesiac,
        SUM(total_amount) AS celkom
    FROM flourmills_sales
    GROUP BY DATE_TRUNC('month', sale_date)
),
poradie_mesiacov AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY mesiac) AS rn,
        mesiac,
        celkom
    FROM mesacny_predaj
),
rekurzia AS (
    SELECT
        rn,
        mesiac,
        celkom,
        celkom AS kumulativny_predaj
    FROM poradie_mesiacov
    WHERE rn = 1

    UNION ALL

    SELECT
        next.rn,
        next.mesiac,
        next.celkom,
        current.kumulativny_predaj + next.celkom
    FROM rekurzia current
    JOIN poradie_mesiacov next
        ON next.rn = current.rn + 1
    WHERE current.kumulativny_predaj < 500000000
)
SELECT *
FROM rekurzia
ORDER BY rn;