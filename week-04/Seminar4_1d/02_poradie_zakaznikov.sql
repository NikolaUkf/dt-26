WITH CustomerProfit AS (
    SELECT 
        c.region,
        c.customer_name,
        SUM(o.profit) AS total_profit
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY 
        c.region,
        c.customer_name
)
SELECT 
    region,
    customer_name,
    total_profit,
    RANK() OVER (
        PARTITION BY region 
        ORDER BY total_profit DESC
    ) AS profit_rank,
    DENSE_RANK() OVER (
        PARTITION BY region 
        ORDER BY total_profit DESC
    ) AS profit_dense_rank
FROM CustomerProfit
ORDER BY 
    region, 
    total_profit DESC;