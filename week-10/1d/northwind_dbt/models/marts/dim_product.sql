    SELECT
    p.product_id,
    p.product_name,
    p.unit,
    p.price,
    COALESCE(c.category_name, 'unknown') AS category_name,
    c.description                        AS category_description,
    COALESCE(s.supplier_name, 'unknown') AS supplier_name,
    s.city                               AS supplier_city,
    s.country                            AS supplier_country
FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_categories') }} c ON c.category_id = p.category_id
LEFT JOIN {{ ref('stg_suppliers') }} s ON s.supplier_id = p.supplier_id