CREATE OR REPLACE FUNCTION change_func() RETURNS trigger AS $$
BEGIN	

	if new.sid < 3 then 
		update OwnerShips set ownershipDropped = 1 where new.ownerid = ownerid;
	end if;
	return null;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER change_trig
AFTER INSERT OR UPDATE ON DeviceTracking
FOR EACH ROW
EXECUTE PROCEDURE change_func();
