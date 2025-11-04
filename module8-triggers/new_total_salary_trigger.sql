
-- new total_salary so that it will update the department total if it exists, 
-- or create a new row if it doesn’t. Here’s how you can do it safely in PL/SQL.
CREATE OR REPLACE TRIGGER total_salary
AFTER DELETE OR INSERT OR UPDATE OF deptno, sal
ON demo_emp
FOR EACH ROW
BEGIN
    -- 1. Deduct salary from old department if deleting or moving
    IF DELETING OR (UPDATING AND (:OLD.deptno != :NEW.deptno)) THEN
        UPDATE dept_budget
        SET total_sal = total_sal - :OLD.sal
        WHERE deptno = :OLD.deptno;
    END IF;

    -- 2. Add salary to new department (insert if missing)
    IF INSERTING OR (UPDATING AND (:OLD.deptno != :NEW.deptno)) THEN
        UPDATE dept_budget
        SET total_sal = total_sal + :NEW.sal
        WHERE deptno = :NEW.deptno;

        -- if no row was updated, insert a new one
        -- SQL%ROWCOUNT contains the number of rows affected by the most recent SQL statement
        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO dept_budget(deptno, total_sal)
            VALUES(:NEW.deptno, :NEW.sal);
        END IF;
    END IF;

    -- 3. Adjust salary if only changed within same department
    IF UPDATING AND (:OLD.deptno = :NEW.deptno AND :OLD.sal != :NEW.sal) THEN
        UPDATE dept_budget
        SET total_sal = total_sal + (:NEW.sal - :OLD.sal)
        WHERE deptno = :OLD.deptno;
    END IF;
END;
/
