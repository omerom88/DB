select distinct rname
from Recipe Natural Join
	(select rid
	from Cooked
	group by rid
	having count(distinct cid) < 4)S1
order by rname;