select cname
from Chef Natural Join
	(select cid
	from Cooked
	group by cid
	having min(price)>=100)S1
order by cname;