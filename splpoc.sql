create database sqlpoc;
use sqlpoc;

create table author (
id int primary key,
name varchar(100)
);

create table post(
id int primary key,
name varchar(100),
authorid int,
createdts datetime,
foreign key(authorid) references author(id) on delete cascade
);

create table user (
id int primary key,
name varchar(100)
);

create table comment (
id int primary key,
content varchar(1000),
postid int, 
createdts datetime,
userid int,
foreign key(userid) references user(id) on delete cascade,
foreign key(postid) references post(id) on delete cascade
);

insert into author(id,name) values(1,"James Bond"),(2,"Ram"),(3,"Sharma");
select * from author;

insert into user(id,name) values(1,"Abc"),(2,"Def"),(3,"Ghi"),(4,"Jkl");
select * from user;

insert into post(id,name,authorid,createdts) values(1,"Post1",1,'2022-01-30 12:20:30'),(2,"Post2",1,'2022-01-31 16:30:45'),(3,"Post3",2,'2022-01-30 10:10:10'),(4,"Post4",3,'2022-02-01 01:07:23');
select * from post;

insert into comment(id,content,postid,createdts,userid) values(1,"comment1",1,'2022-01-30 14:31:23',3),
(3,"comment3",1,'2022-01-30 13:13:23',2),(5,"comment5",1,'2022-01-30 15:21:09',1),(7,"comment7",1,'2022-01-30 15:08:01',3),
(9,"comment9",1,'2022-01-30 14:23:45',1),(11,"comment11",1,'2022-01-30 12:31:33',4),(13,"comment13",1,'2022-01-30 21:45:25',4),
(15,"comment15",1,'2022-01-30 18:07:56',1),(17,"comment17",1,'2022-01-30 17:54:32',4),(19,"comment19",1,'2022-01-30 19:37:24',2),
(2,"comment2",2,'2022-01-31 18:42:54',2),(6,"comment6",2,'2022-02-01 01:21:34',4),(4,"comment4",2,'2022-01-31 19:56:50',1),
(8,"comment8",2,'2022-01-31 20:40:00',1),(10,"comment10",2,'2022-02-01 10:20:30',3),(20,"comment20",2,'2022-01-31 18:24:43',1),
(21,"comment21",2,'2022-01-31 23:02:32',2),(22,"comment22",2,'2022-02-01 02:27:45',1),(23,"comment23",2,'2022-01-31 18:42:54',4),
(24,"comment24",2,'2022-01-31 17:34:12',3),(12,"comment12",3,'2022-01-30 12:20:30',2),(16,"comment16",3,'2022-01-30 13:24:35',1),
(14,"comment14",4,'2022-02-01 02:24:32',4),(18,"comment18",4,'2022-02-01 02:25:34',3);
insert into comment(id,content,postid,createdts,userid) values(30,"comment30",1,'2022-01-29 14:31:23',3);
select * from comment;


-- Query:

select * from 
(select p.id as pid,p.name,p.createdts as pdates,p.authorid,c.id as cid,c.content,c.createdts as cdates,c.userid,
row_number() OVER (PARTITION BY p.id Order by p.createdts DESC) AS Sno  
from post p left join comment c on c.postid=p.id 
where c.postid in 
(select p.id from post p left join author a on a.id=p.authorid 
where a.name="James Bond") 
order by c.postid,c.createdts desc)aliasname where Sno<=10;
