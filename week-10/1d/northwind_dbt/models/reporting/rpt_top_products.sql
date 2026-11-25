SELECT
    p.product_id,
    p.product_name,
    p.category_name,
    SUM(f.quantity)                 AS items_sold,
    ROUND(SUM(f.total_price), 2)    AS revenue
FROM {{ ref('fact_orderdetails') }} f
JOIN {{ ref('dim_product') }} p ON p.product_id = f.product_id
GROUP BY p.product_id, p.product_name, p.category_name