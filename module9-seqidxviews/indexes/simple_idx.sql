--  The example will be for creating a B-tree index 
-- for the customers.last_name column. Assume that 
-- the customers table contains a large number of rows 
-- and that rows are often retrieved using the following type of query:
SELECT customer_id, first_name, last_name 
FROM customers 
WHERE last_name = 'Brown';

-- Create an index named i_customers_last_name on the 
-- last_name column of the customers table
CREATE INDEX i_customers_last_name ON customers(last_name);

-- With an index, the previous query will take less time to complete.

