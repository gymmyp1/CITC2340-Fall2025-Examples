-- Find the minimum of two numbers
DECLARE
	a number;
	b number;
	c number;
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS
BEGIN
	IF x < y THEN
		z:= x;
	ELSE
		z:= y;
	END IF;
END;

BEGIN
	a:= 23;
	b:= 45;
	findMin(a, b, c);
	DBMS_OUTPUT.PUT_LINE(' Minimum of (23, 45) : ' || c);
END;
/