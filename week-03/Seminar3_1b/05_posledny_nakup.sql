WITH posledny_nakup AS (
    SELECT 
        customer_id,
        product_name,
        sale_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY sale_date DESC
        ) AS poradie
    FROM flourmills_sales
)
SELECT *
FROM posledny_nakup
WHERE poradie = 1
ORDER BY customer_id asc;