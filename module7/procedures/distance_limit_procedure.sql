-- Create a procedure that will check if a charter
-- flew a specific distance.

CREATE OR REPLACE PROCEDURE distance_check(
	p_trip_id IN charter.char_trip%TYPE,
	p_distance_limit NUMBER
)
AS 
	dlimit NUMBER; --declaring a variable that will be used for storing result of query
BEGIN
	SELECT char_distance
	INTO dlimit
	FROM charter
	WHERE char_trip = p_trip_id;
	
	IF dlimit > p_distance_limit THEN
		DBMS_OUTPUT.PUT_LINE('Trip # ' || p_trip_id || ' was above the limit ');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Trip # ' || p_trip_id || ' was not above the limit ');
	END IF;
END;
/

--Test the procedure on a few different charters.
BEGIN
    distance_check(10001, 100);
END;
/

--Output: Trip # 10001 was above the limit 
-- Since this charter's distance was 936

--Verify the answer
SELECT char_trip, char_distance
FROM charter 
WHERE CHAR_TRIP = 10001

-- We can try to make the procedure print the
-- other answer by increasing the limit parameter.
--Test the procedure on a few different charters.
BEGIN
    distance_check(10001, 950);
END;
/