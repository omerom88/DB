select cid
from (select cid,sum(price) as all
	from Cooked
	group by cid)S1
	Inner join
	(select max(all) as price
	from(select cid,sum(price) as all
		from Cooked
		group by cid)S1)S2 
	on(S1.all = S2.price)
order by cid;
