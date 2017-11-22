CREATE OR REPLACE FUNCTION
getpopularity(deviceid integer) returns integer as $$

DECLARE
counter integer;

BEGIN
	select	count(OS.ownerid) into counter
	from OwnerShips OS 
	where OS.did = deviceid and OS.ownerid not in (select DT.ownerid
													from DeviceTracking DT
													where DT.ownerid = OS.ownerid);
	
	return counter;
	
END;
$$ LANGUAGE plpgsql;
