SELECT
    p.category_name,
    COUNT(DISTINCT f.order_id)      AS order_count,
    SUM(f.quantity)                 AS items_sold,
    ROUND(SUM(f.total_price), 2)    AS revenue
FROM {{ ref('fact_orderdetails') }} f
JOIN {{ ref('dim_product') }} p ON p.product_id = f.product_id
GROUP BY p.category_name