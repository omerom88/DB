  select Nik.rname
  from 
    (select rname
     from Chef natural join Recipe natural join Cooked
     where cname = 'Nikib')Nik 
     natural join
     (select rname
     from Chef natural join Recipe natural join Cooked
     where cname = 'Goren')Gor