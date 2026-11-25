SELECT
    trim(id)::int as employeeid, 
    TRIM(firstname) || ' ' || TRIM(lastname) AS full_name,
    trim(birthdate)::date as birthdate,
    trim(photo) as photo,
    trim(notes) as notes
FROM {{ source('bronze', 'employees') }}