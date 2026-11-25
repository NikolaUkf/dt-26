SELECT
    s.shipper_id,
    s.shipper_name,
    s.phone
FROM {{ ref('stg_shippers') }} s