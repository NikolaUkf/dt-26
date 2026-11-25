SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.first_name || ' ' || e.last_name AS full_name,
    e.birth_date
FROM {{ ref('stg_employees') }} e