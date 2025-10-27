--Use the product package's product ref cursor

DECLARE 
	-- step 1: declare the variables to fetch product data into
	v_product_id products.product_id%TYPE; 
	v_name	products.name%TYPE; 
	v_price	products.price%TYPE;

	-- step 2: declare the cursor 
	--sys_refcursor allows the cursor to be weakly typed, 
	-- so it can return different numbers and types of columns.
	c_product_cursor SYS_REFCURSOR;

BEGIN
    -- step 3: no need to open the cursor, it opens when the cursor
    -- requests the data.
	c_product_cursor:=  product_package.get_products_ref_cursor;
	LOOP 
		-- step 4: fetch the rows from the cursor 
		FETCH c_product_cursor 
		INTO v_product_id, v_name, v_price;
		EXIT WHEN c_product_cursor%NOTFOUND;
		
		-- use DBMS_OUTPUT.PUT_LINE() to display the variables 
		DBMS_OUTPUT.PUT_LINE(
			'v_product_id = ' || v_product_id || ', v_name = ' || v_name ||
			', v_price = ' || v_price );
	END LOOP;

	-- step 5: close the cursor
	CLOSE c_product_cursor; 
END;
/

--Example of calling the update_product_price() function inside the package:
CALL product_package.update_prodcuct_price(3, 1.25);