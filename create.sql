drop table if exists Item;
drop table if exists Bids;
drop table if exists User;
drop table if exists Category;

--pragma foreign_keys = ON;

create table Item(
itemid varchar NOT NULL,
name varchar,
buyprice money,
hghstbid money,
firstbid money,
bidcount int,
strttime datetime,
endtime datetime,
sellerid varchar,
descrptn varchar,
primary key (itemid),
foreign key (sellerid) references User(userid),
CHECK (endtime > strttime)
);

create table Bids(
itemid varchar NOT NULL,
userid varchar,
bidtime datetime NOT NULL,
bidvalue money,
primary key (bidtime, itemid),
foreign key (userid) references User(userid),
foreign key (itemid) references Item(itemid)
);

create table User(
userid varchar NOT NULL,
rating int,
location varchar,
country varchar,
primary key(userid)
);

create table Category(
itemid varchar,
name varchar,
foreign key (itemid) references Item(itemid)
);

DROP TABLE if exists CurrentTime;
CREATE TABLE CurrentTime(
time datetime,
primary key(time)
);

INSERT into CurrentTime values ('2001-12-20 00:00:01');
SELECT * from CurrentTime;
