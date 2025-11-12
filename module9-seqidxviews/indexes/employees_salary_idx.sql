CREATE TABLE big_employees (
    emp_id   NUMBER PRIMARY KEY,
    name     VARCHAR2(50),
    salary   NUMBER,
    dept_id  NUMBER
);

-- Insert 500,000 rows with a small fraction high salary
INSERT INTO big_employees (emp_id, name, salary, dept_id)
SELECT LEVEL,
       'Employee ' || LEVEL,
       CASE
         WHEN LEVEL <= 980000 THEN ROUND(DBMS_RANDOM.VALUE(1000, 5000))  -- 98% low salary
         ELSE ROUND(DBMS_RANDOM.VALUE(9500, 10000))                        -- 2% high salary
       END,
       TRUNC(DBMS_RANDOM.VALUE(1, 11))
FROM dual
CONNECT BY LEVEL <= 500000;

COMMIT;

DROP INDEX i_bigemp_salary;

SET TIMING ON

--Run query before index
SELECT COUNT(*) FROM big_employees WHERE salary > 9000;

-- create the index on big_employees
CREATE INDEX i_bigemp_salary ON big_employees(salary);

-- Run query on table with the index
SELECT COUNT(*) FROM big_employees WHERE salary > 9000;

SET TIMING OFF










BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(USER, 'BIG_EMPLOYEES');
END;
/

SET TIMING ON

--Try a query before creating an index
EXPLAIN PLAN FOR
SELECT * FROM big_employees WHERE salary > 9000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- create the index
CREATE INDEX i_bigemp_salary ON big_employees(salary);

--Rerun plan
EXPLAIN PLAN FOR
SELECT * FROM big_employees WHERE salary > 9000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


SET TIMING ON

-- Run your query before creating the index:
SELECT COUNT(*) FROM big_employees WHERE salary > 9000;

-- Create the index
CREATE INDEX i_bigemp_salary ON big_employees(salary);

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(USER, 'BIG_EMPLOYEES', cascade => TRUE);
END;
/

-- Run the same query again:
SELECT COUNT(*) FROM big_employees WHERE salary > 9000;

SET TIMING OFF
