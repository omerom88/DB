CREATE OR REPLACE FUNCTION dates_func() RETURNS trigger AS $$

DECLARE
	checker record;

BEGIN	
	select datemonth, dateyear into checker
	from OwnerShips
	where OwnerShips.ownerid = new.ownerid;
	
	if  new.dateyear < checker.dateyear or (new.dateyear = checker.dateyear and new.datemonth < checker.datemonth) then 
		return null;
	end if;
	
	return new;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER dates_trig
BEFORE INSERT OR UPDATE ON DeviceTracking
FOR EACH ROW
EXECUTE PROCEDURE dates_func();


