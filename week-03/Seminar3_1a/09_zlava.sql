CREATE OR REPLACE PROCEDURE apply_regional_discount(
    IN p_region_name VARCHAR,
    IN p_discount_rate NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE orders
    SET sales = sales * (1 - p_discount_rate)
    WHERE region = p_region_name;

    RAISE NOTICE 'zlava vo vyske % aplikovana pre region %.', p_discount_rate, p_region_name;
END;
$$;
CALL apply_regional_discount('West', 0.10);