--1
SELECT User.userid FROM User
INTERSECT
SELECT User.userid FROM User;

--2

--7
SELECT Item.strttime, Item.endtime FROM Item WHERE Item.endtime < Item.strttime;

--10

