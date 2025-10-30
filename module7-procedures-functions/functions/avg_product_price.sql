-- Creates a function named average_product_price(), which returns the average 
-- price of products whose product_type_id equals the parameter value.

CREATE OR REPLACE FUNCTION average_product_price (
    p_product_type_id IN INTEGER
)
RETURN NUMBER
AS
    v_average_product_price NUMBER;
BEGIN
    SELECT AVG(price)
    INTO v_average_product_price
    FROM products
    WHERE product_type_id = p_product_type_id;

    RETURN v_average_product_price;
END average_product_price;
/

-- Example call to average_product_price(), passing the parameter 
-- value 1 to the function to get the average price of products 
-- whose product_type_id is 1:

SELECT average_product_price(1) FROM dual;

