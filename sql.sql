use web04;

create table workplace(
	wpid int auto_increment,
    wpname varchar(30) not null,
    wpnum varchar(20) not null,
    opentime double not null default 9,
    closetime double not null default 18,
    primary key(wpid)
);

create table users(
	uid varchar(20),
	upw varchar(50) not null,
	uname varchar(10) not null,
	uphone varchar(20),
	uaddr varchar(20),
    ulevel enum('관리자','직원') default '직원',
    wpid int not null,
    primary key(uid),
    foreign key(wpid) references workplace(wpid)
);

create table scheduler(
	sid int auto_increment,
    sday enum('월','화','수','목','금','토','일') not null,
    stime double not null,
    etime double not null,
    wpid int not null,
    primary key(sid),
    foreign key(wpid) references workplace(wpid) on delete cascade on update cascade
    );
    
create table apply(
	aid int auto_increment,
    astatus enum('신청','승인','거절'),
    sid int not null,
    uid varchar(20) not null,
    primary key(aid),
    foreign key(sid) references scheduler(sid),
    foreign key(uid) references users(uid)
 );   

create table pay(
	pid int auto_increment,
    uid varchar(20) not null,
    sdate datetime not null,
    edate datetime not null,
    total int not null default 0,
    pstatus bool default false,
    primary key(pid),
    foreign key(uid) references users(uid) 
 );
 
 create table notice(
	nid int auto_increment,
    uid varchar(20) not null,
    ntitle varchar(100) not null,
    ncont varchar(1000) not null,
    ndate datetime default current_timestamp,
    nhit int default 0,
    primary key(nid),
    foreign key(uid) references users(uid) on delete cascade on update cascade
 );
 
 create table reply(
	rid int auto_increment,
    nid int not null,
    uid varchar(20) not null,
    rcont varchar(400) not null,
    primary key (rid),
    foreign key(nid) references notice(nid),
    foreign key(uid) references users(uid)
 );
 
 create table images(
	iid int auto_increment,
    nid int default null,
    wpid int default null,
    filename varchar(100) not null,
    primary key(iid),
    foreign key(nid) references notice(nid),
    foreign key(wpid) references workplace(wpid)
 );
 
 drop table images;

drop database web04;
create database web04;
use web04;

insert into workplace(wpname, wpnum, opentime, closetime) values('버거퀸 강남점','456-01-12345', 9, 18);
insert into workplace(wpname, wpnum, opentime, closetime) values('삼디야 강남점','446-01-12345', 8, 20);
insert into users(uid, upw, uname, uphone, uaddr, ulevel, wpid)
	values ('test', password('1234'), '테스트', '010-0000-0000', '경기도 광주시', '관리자', 1);
insert into users(uid, upw, uname, uphone, uaddr, ulevel, wpid)
	values ('test1', password('1234'), '테스트', '010-0000-0000', '경기도 광주시', '관리자', 2);

show tables;
select * from users;
select * from workplace;

drop table apply;
drop table scheduler;

select length(password('1234'));
select uname from users where uid='test' and upw=password('1234');

select wpname from workplace where wpid = (select wpid from users where uid='test' and upw=password('1234'));
select users.wpid, workplace.wpname from users, workplace where uid='test' and upw=password('1234') and users.wpid=workplace.wpid;
select wpname from workspace where wpid=0;

insert into scheduler(sday, stime, etime, wpid) values('월',  9.0, 14.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('월',  14.0, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('화',  9.0, 12.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('화',  12.0, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('수',  9.0, 16.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('수',  16.0, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('목',  9.0, 14.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('목',  14.0, 16.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('목',  16.0, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('금',  9.0, 10.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('금',  10.0, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('토',  9.0, 13.5, 1);
insert into scheduler(sday, stime, etime, wpid) values('토',  13.5, 18.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('일',  9.0, 14.0, 1);
insert into scheduler(sday, stime, etime, wpid) values('일',  14.0, 18.0, 1);
select * from scheduler;


select sid, sday, stime, etime, able from scheduler where wpid = 0 order by stime, sday;

insert into apply(astatus, sid, uid) values ('승인', 10, 'test');
select * from apply;
select users.uname from scheduler, apply, users where scheduler.sid=10 and scheduler.sid = apply.sid and apply.uid=users.uid;

select * from workplace;
select * from images;
insert into workplace(wpname, wpnum) values('333', '33-333-33333');
insert into workplace(wpid, filename) values(5, '222.jpg');