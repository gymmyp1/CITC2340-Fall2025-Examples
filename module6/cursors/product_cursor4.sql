-- example of using 1 ref cursor and assigning it to 2 different queries
SET SERVEROUTPUT ON

DECLARE
    -- Strongly typed REF CURSOR
    TYPE t_product_cursor IS REF CURSOR RETURN products%ROWTYPE;
    v_product_cursor t_product_cursor;

    v_product products%ROWTYPE;
BEGIN
    -- First query: products with ID < 5
    OPEN v_product_cursor FOR
        SELECT * FROM products WHERE product_id < 5;

    DBMS_OUTPUT.PUT_LINE('--- Products with ID < 5 ---');
    LOOP
        FETCH v_product_cursor INTO v_product;
        EXIT WHEN v_product_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'product_id = ' || v_product.product_id ||
            ', name = ' || v_product.name ||
            ', price = ' || v_product.price
        );
    END LOOP;
    CLOSE v_product_cursor;

    -- Second query: products with price > 15
    OPEN v_product_cursor FOR
        SELECT * FROM products WHERE price > 15;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Products with price > 15 ---');
    LOOP
        FETCH v_product_cursor INTO v_product;
        EXIT WHEN v_product_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'product_id = ' || v_product.product_id ||
            ', name = ' || v_product.name ||
            ', price = ' || v_product.price
        );
    END LOOP;
    CLOSE v_product_cursor;
END;
/
