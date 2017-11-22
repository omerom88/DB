CREATE OR REPLACE FUNCTION
getFirmPopularity(firmid integer) returns integer as $$

DECLARE
sum integer;
i integer;

BEGIN
	sum := 0;
	for i in (select did from Devices where fid =  firmid) loop
		sum = sum + getpopularity(i);
	end loop;
	return sum;
	
END;
$$ LANGUAGE plpgsql;

