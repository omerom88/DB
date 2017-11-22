Create or Replace FUNCTION popular_func() RETURNS trigger AS $$
	DECLARE
		pop integer;
		pop_rec mostPopular%rowtype;
		popularity integer;
		i integer;
		j integer;
		l Devices%rowtype;
	
	BEGIN
		delete from mostPopular;
		for i in (select distinct D.dtype from Devices D) loop
			
			pop := 0;
			for j in (select distinct D.did from Devices D where D.dtype = i) loop
				popularity := getPopularity(j);
				if popularity >= pop
					then pop := popularity;
				end if;
			end loop;
			
			for l in (select * from Devices D where D.dtype = i and getPopularity(D.did) = pop) loop
				insert into mostpopular(dtype, did, popularity)
				values (l.dtype, l.did, pop);
			end loop;
		
		end loop;
		return new;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_most_popular_own
AFTER INSERT OR DELETE OR UPDATE ON DeviceTracking
FOR EACH STATEMENT EXECUTE PROCEDURE popular_func();

CREATE TRIGGER update_most_popular_trck
AFTER INSERT OR DELETE OR UPDATE ON Ownerships
FOR EACH STATEMENT EXECUTE PROCEDURE popular_func();
