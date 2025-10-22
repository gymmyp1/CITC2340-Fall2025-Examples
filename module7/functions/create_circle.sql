
-- Define function called circle_area that which returns the area of a circle as a NUMBER. 
-- The radius of the circle is passed as a parameter named p_radius to the function.

CREATE FUNCTION circle_area ( 
    p_radius IN NUMBER
) RETURN NUMBER AS 
    v_pi	NUMBER := 3.1415926;
    v_area NUMBER;
BEGIN 
    -- circle area is pi multiplied by the radius squared 
    v_area := v_pi * POWER(p_radius, 2);
    RETURN v_area;
END circle_area;
/

-- calls circle_area(), passing a radius of 2 to the function using positional notation:

-- SELECT circle_area(2) FROM dual;

-- In Oracle Database 11g and above, you can also use named and 
-- mixed notation when calling functions.

-- SELECT circle_area(p_radius => 2) FROM dual;
-- this passes the argument of 2 to p_radius.