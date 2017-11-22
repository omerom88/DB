select cname
from 
  (select cid
   from
      (select rid
      from Recipe
      where rname = 'Pizza') REC natural join (select rid, cid
                                               from Cooked
                                               where price < 15) R) ER natural join Chef