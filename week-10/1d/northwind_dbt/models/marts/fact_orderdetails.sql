{{ config(
    materialized='table',
    indexes=[
        {'columns': ['customer_id']},
        {'columns': ['employee_id']},
        {'columns': ['shipper_id']},
        {'columns': ['product_id']},
        {'columns': ['date_id']}
    ]
) }}

SELECT
    od.orderdetail_id,
    od.order_id,
    o.customer_id,
    o.employee_id,
    o.shipper_id,
    od.product_id,
    TO_CHAR(o.order_date, 'YYYYMMDD')::int AS date_id,
    od.quantity,
    p.price                                AS unit_price,
    od.quantity * p.price                  AS total_price
FROM {{ ref('stg_orderdetails') }} od
JOIN {{ ref('stg_orders') }}   o ON o.order_id   = od.order_id
JOIN {{ ref('stg_products') }} p ON p.product_id = od.product_id