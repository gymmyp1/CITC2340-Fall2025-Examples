--test get_product_type_name and add_product_type from the new product_package
DECLARE
    v_type_name VARCHAR2(30);
	v_add_product_type_result VARCHAR2(200);
BEGIN
	--Call get_product_type_name
	--This function returns the product type name for a given product ID.
    v_type_name := product_package.get_product_type_name(3);
    DBMS_OUTPUT.PUT_LINE('Product type name: ' || v_type_name);

	--Call add_product_type
	--This function inserts a new product type into the product_types 
	--table and returns a confirmation message.
    v_add_product_type_result := product_package.add_product_type(10, 'Fabric');
    DBMS_OUTPUT.PUT_LINE(v_add_product_type_result);
    
    --attempt to add a type that has an id that already exists
    v_add_product_type_result := product_package.add_product_type(1, 'Food');
    DBMS_OUTPUT.PUT_LINE(v_add_product_type_result);
    
END;
/