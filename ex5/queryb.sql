select max(price)
from Cooked natural join (select rid
                          from Recipe
                          where rname = 'Sushi')Ri

