-- This procedure computes the square of value of a passed value. This example shows how we
-- can use the same parameter to accept a value and then return another result.
DECLARE
	a number;
PROCEDURE squareNum(x IN OUT number) IS
BEGIN
	x := x * x;
END;
BEGIN
	a:= 5;
	squareNum(a);
	DBMS_OUTPUT.PUT_LINE(' Square of (5): ' || a);
END;
/