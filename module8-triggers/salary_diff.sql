-- Create a trigger

DROP TABLE demo_emp2;

--make a copy of the demo_emp table
CREATE TABLE demo_emp2 AS
SELECT *
FROM demo_emp;

-- Create trigger that prints the salary difference when 
-- an employee is added/removed or an existing 
-- employee's salary is updated.
CREATE OR REPLACE TRIGGER display_salary_changes  
BEFORE DELETE OR INSERT OR UPDATE ON demo_emp2
FOR EACH ROW
DECLARE 
   sal_diff NUMBER;
BEGIN
   IF INSERTING THEN
      dbms_output.put_line('Inserted new salary: ' || :NEW.sal);

   ELSIF UPDATING THEN
      sal_diff := :NEW.sal - :OLD.sal;
      dbms_output.put_line('Old salary: ' || :OLD.sal);
      dbms_output.put_line('New salary: ' || :NEW.sal);
      dbms_output.put_line('Salary difference: ' || sal_diff);

   ELSIF DELETING THEN
      dbms_output.put_line('Deleted employee with salary: ' || :OLD.sal);
   END IF;
END;
/

-- Alternative: Instead of printing the salary difference, 
-- log the change in a table.

DROP TABLE salary_changes;

--create the table
CREATE TABLE salary_changes (
    empno        NUMBER(6),
    old_salary   NUMBER(10,2),
    new_salary   NUMBER(10,2),
    change_date  DATE
);

CREATE OR REPLACE TRIGGER audit_salary_changes
BEFORE DELETE OR INSERT OR UPDATE ON demo_emp2
FOR EACH ROW
DECLARE
    sal_diff NUMBER;
BEGIN
    -- Handle different trigger events
    IF INSERTING THEN
        INSERT INTO salary_changes (empno, old_salary, new_salary, change_date)
        VALUES (:NEW.empno, NULL, :NEW.sal, SYSDATE);

    ELSIF UPDATING THEN
        sal_diff := :NEW.sal - :OLD.sal;
        INSERT INTO salary_changes (empno, old_salary, new_salary, change_date)
        VALUES (:NEW.empno, :OLD.sal, :NEW.sal, SYSDATE);

    ELSIF DELETING THEN
        INSERT INTO salary_changes (empno, old_salary, new_salary, change_date)
        VALUES (:OLD.empno, :OLD.sal, NULL, SYSDATE);
    END IF;
END;
/

-- Cause the trigger to fire
-- Example updates
INSERT INTO demo_emp2 (empno,ename,sal,deptno) VALUES (101, 'Alice', 5000, 1);
UPDATE demo_emp2 SET sal = 5500 WHERE empno = 101;
DELETE FROM demo_emp2 WHERE empno = 101;

-- Check the log table
SELECT * FROM salary_changes;
