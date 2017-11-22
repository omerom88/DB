CREATE FUNCTION
getMonthPassed(trackingid integer) returns integer as $$

DECLARE
calculator integer;

BEGIN
	select	(DT.dateyear - OS.dateyear)*12 + (DT.datemonth - OS.datemonth) into calculator
	from DeviceTracking DT , OwnerShips OS
	where DT.tid =  trackingid and DT.ownerid = OS.ownerid;
	return calculator;
	
END;
$$ LANGUAGE plpgsql;
