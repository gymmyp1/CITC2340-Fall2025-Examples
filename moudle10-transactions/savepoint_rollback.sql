--make copy of demo_emp table
CREATE TABLE demo_emp2 AS
SELECT * FROM demo_emp;

BEGIN TRANSACTION;

UPDATE demo_emp
SET deptno = 30
WHERE empno = 7934;

SAVEPOINT before_update;

UPDATE demo_emp
SET deptno = 10
WHERE empno = 7934;

ROLLBACK TO SAVEPOINT before_update;
SELECT * FROM demo_emp WHERE empno = 7934;

COMMIT;