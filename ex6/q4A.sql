CREATE OR REPLACE FUNCTION dont_func() RETURNS trigger AS $$
BEGIN	
	return null;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER dont_trig_devices
BEFORE DELETE ON Devices
FOR EACH ROW
EXECUTE PROCEDURE dont_func();

CREATE TRIGGER dont_trig_owenrships
BEFORE DELETE ON OwnerShips
FOR EACH ROW
EXECUTE PROCEDURE dont_func();

CREATE TRIGGER dont_trig_deviceTracking
BEFORE DELETE ON DeviceTracking
FOR EACH ROW
EXECUTE PROCEDURE dont_func();


