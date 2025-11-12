-- ou can also create a composite index on multiple columns.
CREATE INDEX i_customers_first_name_last_name ON 
employees(first_name,last_name);