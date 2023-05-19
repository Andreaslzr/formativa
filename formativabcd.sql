create database formativa;
use formativa;

create table users(
id bigint not null auto_increment,
name varchar(100) not null,
email varchar(100) not null,
datebirth date not null,
dateregister datetime not null default now(),
password varchar(20) not null, 
active enum ('Y','N') default'Y',
primary key(id)
);

create table post(
id bigint not null auto_increment,
postName varchar(50) not null,
primary key(id)
);

create table post_user(
id bigint not null auto_increment,
userFK bigint not null,
postFK bigint not null,
primary key(id),
foreign key(userFK) references users(id),
foreign key(postFK) references post(id)
);

create table access(
id bigint not null auto_increment,
accessName varchar(30) not null,
can varchar(100),
primary key(id)
);

create table access_user(
id bigint not null auto_increment,
userFK bigint not null,
accessFK bigint not null,
primary key(id),
foreign key(userFK) references users(id),
foreign key(accessFK) references access(id)
);

create table local(
id bigint not null auto_increment,
localName varchar(50) not null,
block enum('A','B','C','D') not null,
occupation int not null,
primary key(id)
);

create table equipaments(
id bigint not null auto_increment,
equipament varchar(30) not null,
primary key(id)
);

create table checklist(
id bigint not null auto_increment,
localFK bigint not null,
equipFK bigint not null,
primary key(id),
foreign key(localFK) references local(id),
foreign key(equipFK) references equipaments(id)
);

create table events(
id bigint not null auto_increment,
eventName varchar(50) not null,
localFK bigint not null,
eventDate datetime not null,
eventend datetime not null,
responsibleFK bigint not null,
startcheckin datetime not null,
endcheckin datetime not null,
primary key(id),
foreign key(localFK) references local(id),
foreign key(responsibleFK) references users(id)
);

create table checkin(
id bigint not null auto_increment,
eventFK bigint not null,
userFK bigint not null,
primary key(id),
foreign key(eventFK) references events(id),
foreign key(userFK) references users(id)
);

insert into users(name,email,datebirth,password) values
('José Carlos','josec@email.com','1990-05-03','joseccc'),('Maria Santos','mariast@email.com','1970-03-01','Maria149'),
('Calos Eduardo','cadu@email.com','1995-09-14','cadu995'),('Pedro Paulo','pedrop@email.com','2000-03-31','pedropac'),
('Felipe Silva','felpsv@email.com','2001-08-02','felpsrl'),('Fernando Almeida','feralm@email.com','1992-12-24','nando44');

insert into post(postName) values 
('coordenador'),('orientador'),('secretaria'),('RH');

insert into post_user(userFK,postFK) values 
(1,4),(2,3),(3,2),(4,1),(5,1),(6,4);

insert into access(accessName) values
('admin'),('gestor'),('usuário'),('visitante');

insert into access_user(userFK,accessFK) values
(1,2),(2,3),(3,3),(4,1),(5,2),(6,3);

insert into local(localName,block,occupation) values
('sala b01','B',30),('sala a01','A',25),('sala b02','B',20),('sala c01','C',40);

insert into equipaments(equipament) values
('projetor'),('tv smart'),('ar condicionado'),('workstation');

insert into checklist(localFK,equipFK) values
(1,1),(1,2),(1,3),(1,4),(2,1),(3,3),(4,3); 

insert into events(eventName,localFK,eventDate,eventEnd,responsibleFK,startcheckin,endcheckin)values
('entrega de medalhas',1,'2023-05-19 10:00:00','2023-05-19 12:00:00',4,'2023-05-17 00:00:00','2023-05-18 23:59:59'),
('palestra',1,'2023-05-18 11:00:00','2023-05-18 12:00:00',4,'2023-05-16 00:00:00','2023-05-17 23:59:59'),
('palestra',2,'2023-05-20 10:00:00','2023-05-20 13:00:00',5,'2023-05-19 00:00:00','2023-05-19 23:59:59');

insert into checkin(eventFK,userFK) values
(1,6),(3,6),(3,2);

#1
select distinct l.localName from local l
inner join events ev on l.id=ev.localFK;

#2
select localName from local
where localName not in(
select localName from local l
inner join events ev on l.id=ev.localFK
group by l.id);

#3
select * from events
where date(eventDate) ='2023-05-19' and date(eventEnd)='2023-05-19';

#4
select distinct name from users u
inner join checkin ch on u.id=ch.userFK;

#5
select *from events ev
inner join checkin ch on ev.id=ch.eventFK
where eventDate>now();

#6
select name, count(*) as 'registros em eventos' from users u 
inner join checkin ch on u.id=ch.userFK
group by u.id;

#7
select eventName, count(*) as n_checkins from events ev
inner join checkin ch on ev.id=ch.eventFK
group by ev.id
order by n_checkins desc
limit 1;

select eventName, count(*) as n_checkins from events ev
inner join checkin ch on ev.id=ch.eventFK
group by ev.id
order by n_checkins asc
limit 1;

#8
select avg(occupation) from local;

#9
select name,accessName from users u
inner join access_user au on u.id=au.userFK
inner join access a on a.id=au.accessFK;

#10
select * from events ev
inner join local l on l.id=ev.localFK
where l.occupation>0 and startcheckin<now() and endcheckin>now();

#11
select * from events ev
inner join local l on l.id=ev.localFK
where eventDate>now() and l.occupation=0;

#12
select * from(
select name, count(*) as registros_eventos from users u 
inner join checkin ch on u.id=ch.userFK
where date(dateregister)='2023-05-19'
group by u.id) t where registros_eventos>1

