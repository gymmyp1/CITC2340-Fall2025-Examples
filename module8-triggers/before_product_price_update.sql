-- Trigger that is included in the store schema

CREATE OR REPLACE TRIGGER before_product_price_update
BEFORE UPDATE OF price
ON products
FOR EACH ROW WHEN (new.price < old.price * 0.75)
BEGIN
  dbms_output.put_line('product_id = ' || :old.product_id);
  dbms_output.put_line('Old price = ' || :old.price);
  dbms_output.put_line('New price = ' || :new.price);
  dbms_output.put_line('The price reduction is more than 25%');

  -- insert row into the product_price_audit table
  INSERT INTO product_price_audit (
    product_id, old_price, new_price
  ) VALUES (
    :old.product_id, :old.price, :new.price
  );
END before_product_price_update;
/
