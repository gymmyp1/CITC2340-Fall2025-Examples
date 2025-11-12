/* You can enforce uniqueness of column values 
using a unique index. */

/* Creates a unique index named i_customers_phone 
on the customers.phone column. */
CREATE UNIQUE INDEX i_customers_phone ON customer(phone);