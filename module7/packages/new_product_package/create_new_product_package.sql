-- The following example creates a package named product_package with additional functionality
-- FUNCTION get_product_type_name and FUNCTION add_product_type

--Create package specification
CREATE OR REPLACE PACKAGE product_package AS 
    TYPE t_ref_cursor IS REF CURSOR;
	
    FUNCTION get_products_ref_cursor RETURN t_ref_cursor;
	
    FUNCTION get_product_type_name (
        p_product_id IN products.product_id%TYPE
    ) RETURN VARCHAR2;
	
	FUNCTION add_product_type (
		p_product_type_id IN product_types.product_type_id%TYPE,
		p_name        IN product_types.name%TYPE
	) RETURN VARCHAR2;
	
    PROCEDURE update_product_price (
        p_product_id IN products.product_id%TYPE,
        p_factor	IN NUMBER 
    );
    
END product_package;
/

--Create package body
CREATE OR REPLACE PACKAGE BODY product_package AS 

-- The get_products_ref_cursor() function returns a t_ref_cursor, 
-- which contains the rows retrieved from the products table.
-- The update_product_price() procedure multiplies the price of a product and commits the change.
FUNCTION get_products_ref_cursor 
    RETURN t_ref_cursor 
AS
    c_products_ref_cursor t_ref_cursor;
BEGIN
    -- get the REF CURSOR
    OPEN c_products_ref_cursor FOR 
    SELECT product_id, name, price
    FROM products;
    
    -- return the REF CURSOR
    RETURN c_products_ref_cursor; 
END get_products_ref_cursor;

--update a product's price by p_factor
PROCEDURE update_product_price ( 
    p_product_id IN products.product_id%TYPE,
    p_factor	IN NUMBER
    )
AS 
    v_product_count INTEGER;
BEGIN 
    -- count the # of products w/ the supplied product_id 
    -- (count will be 1 if the product exists) 
    SELECT COUNT(*) 
    INTO v_product_count 
    FROM products 
    WHERE product_id = p_product_id;

    -- if the product exists (v_product_count = 1) then 
    -- update that product's price 
    IF v_product_count = 1 THEN
        UPDATE products 
        SET price = price * p_factor 
        WHERE product_id = p_product_id; 
        COMMIT;
    END IF; 
    EXCEPTION
        WHEN OTHERS THEN 
            ROLLBACK;
END update_product_price; 

--get product type name given product id
FUNCTION get_product_type_name (
    p_product_id IN products.product_id%TYPE
) RETURN VARCHAR2 
AS
    v_type_name VARCHAR2(30);
BEGIN
    SELECT pt.name 
    INTO v_type_name 
    FROM products p
    JOIN product_types pt 
        ON p.product_type_id = pt.product_type_id
    WHERE p.product_id = p_product_id;

    RETURN v_type_name;
END get_product_type_name;

--add a new product type to the product_types table
FUNCTION add_product_type (
    p_product_type_id IN product_types.product_type_id%TYPE,
    p_name        IN product_types.name%TYPE
) RETURN VARCHAR2
AS
BEGIN
    INSERT INTO product_types (product_type_id, name)
    VALUES (p_product_type_id, p_name);
	COMMIT;
    RETURN 'Product type added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Error: Product type already exists for this product_id';
    WHEN OTHERS THEN
        RETURN 'Error: ' || SQLERRM;
END add_product_type;

END product_package;
/