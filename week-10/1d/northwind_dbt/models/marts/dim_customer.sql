SELECT
    c.customer_id,
    c.customer_name,
    c.contact_name,
    c.address,
    c.city,
    c.postal_code,
    c.country
FROM {{ ref('stg_customers') }} c