  create table Actors(
    aid int primery key,
    name varchar(50) not null,
    salary int default (3000));
    
  create table Movie(
    mid int primery key,
    title varchar(50) not null,
    length int default (60) check 
    (length >= 1 and length <= 200),
    rating int check(rating >= 1 and rating <= 10)
    check(length <= 100 or rating >= 3));
    
  create table Played(
    aid int not null primery key,
    mid int not null foreign key references Movie(mid)
    unique('mid','aid'));