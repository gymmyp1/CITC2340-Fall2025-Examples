-- You can retrieve information on your indexes from the user_indexes view. 
SELECT index_name, table_name, uniqueness, s_order_status2
FROM user_indexes
WHERE table_name IN ('CUSTOMERS', 'EMPLOYEES')
ORDER BY index_name;