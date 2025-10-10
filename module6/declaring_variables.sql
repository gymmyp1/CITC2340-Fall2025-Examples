--Declare Record type
DECLARE
  TYPE EmpRecTyp IS RECORD (
    emp_id     NUMBER := 1,
    emp_fname  VARCHAR2(10) := 'Alice',
    mgr_id     NUMBER NOT NULL := 2,
    sal     NUMBER(6,0) NOT NULL := 50000
  );
 
  emp_rec EmpRecTyp;
BEGIN
  DBMS_OUTPUT.PUT_LINE('emp_id:   ' || emp_rec.emp_id);
  DBMS_OUTPUT.PUT_LINE('emp_name: ' || emp_rec.emp_fname);
  DBMS_OUTPUT.PUT_LINE('mgr_id:    ' || emp_rec.mgr_id);
  DBMS_OUTPUT.PUT_LINE('salary:    ' || emp_rec.sal);
END;
/

--Declare Record using %ROWTYPE
DECLARE
  emp_rec employees%ROWTYPE;
BEGIN
  -- Assign values to fields:
  
  emp_rec.employee_id   := 1;
  emp_rec.first_name := 'Alice';
  emp_rec.manager_id      := 2;
  emp_rec.salary     := 50000;
 
  -- Print fields:
 
  DBMS_OUTPUT.PUT_LINE('emp_id:   ' || emp_rec.employee_id);
  DBMS_OUTPUT.PUT_LINE('emp_first_name: ' || emp_rec.first_name);
  DBMS_OUTPUT.PUT_LINE('mgr_id:    ' || emp_rec.manager_id);
  DBMS_OUTPUT.PUT_LINE('salary:    ' || emp_rec.salary);
END;
/

--Record with VARRAY example
DECLARE
  TYPE full_name IS VARRAY(2) OF VARCHAR2(20);
 
  TYPE emp_name IS RECORD (
    name  full_name := full_name('John', 'Smith')  -- varray field
  );
 
  emp_rec emp_name;
BEGIN

  DBMS_OUTPUT.PUT_LINE (
    emp_rec.name(1) || ' ' || emp_rec.name(2)
    );
END;
/
