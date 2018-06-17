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
    pay double not null default 7530,
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
    adate date not null,
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
	values ('test1', password('1234'), '테스트1', '010-0000-0000', '경기도 광주시', '관리자', 2);
insert into users(uid, upw, uname, uphone, uaddr, ulevel, wpid, pay)
	values ('test2', password('1234'), '테스트2', '010-0000-0000', '경기도 광주시', '직원', 1, 8000);
    

show tables;
select * from users;
select * from workplace;
select * from images;
drop table apply;
drop table scheduler;
select * from images;
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
show tables;
delete from scheduler where sid = 8;
select sid, sday, stime, etime, able from scheduler where wpid = 0 order by stime, sday;
select sid, sday, stime, etime from scheduler where wpid = 1 order by stime, sday;

insert into apply(astatus, sid, uid) values ('승인', 11, 'test');
select * from apply;
update apply set astatus='승인' where aid = 1;
select users.uname from scheduler, apply, users where scheduler.sid=10 and scheduler.sid = apply.sid and apply.uid=users.uid;

select * from workplace;
select * from images;
insert into workplace(wpname, wpnum) values('333', '33-333-33333');
insert into workplace(wpid, filename) values(5, '222.jpg');

select aid, sday, stime, etime, uid, astatus from scheduler, apply where apply.sid = scheduler.sid and scheduler.wpid=1 order by sday;
drop table pay;
select * from pay;
CREATE TABLE pay (
  pid INT(11) NOT NULL AUTO_INCREMENT,
  uid VARCHAR(20) NOT NULL,
  sdate DATE NOT NULL,
  edate DATE NOT NULL,
  total INT(11) NOT NULL DEFAULT '0',
  pstatus ENUM('미지급', '지급') NOT NULL DEFAULT '미지급',
  PRIMARY KEY (pid),
  FOREIGN KEY (uid)
    REFERENCES users (uid)) AUTO_INCREMENT = 1;
select aid, sday, stime, etime, apply.uid, astatus from scheduler, apply, users where apply.sid = scheduler.sid and scheduler.wpid=1 and sday = '화' and astatus = '신청' and apply.uid = users.uid and uname = '테스트' order by sday;
insert into pay(uid, sdate, edate, total) values('test', '2018-06-01', '2018-06-30', 50000);
select * from pay;
select pid, pay.uid, sdate, edate, total, pstatus from pay, users where pay.uid = users.uid && wpid = 1;
select * from users where uname like '%테%';
select * from users;
select aid, sday, stime, etime, apply.uid, astatus, uname 
from scheduler, apply, users 
where apply.sid = scheduler.sid and scheduler.wpid = 1 and uname like '%테%' order by sday;

select aid, sday, stime, etime, apply.uid, astatus, uname
from scheduler, apply, users 
where apply.sid = scheduler.sid and scheduler.wpid = 1 and uname like '%테%' order by sday;

select aid, sday, stime, etime, apply.uid, astatus, uname 
from scheduler, apply, users 
where apply.sid = scheduler.sid and scheduler.wpid = 1 and apply.uid = users.uid and uname like '%테%' order by sday desc;

select * from apply;
select * from scheduler;

select aid, astatus, adate, sid, uid from apply where astatus = '승인';

select sum(etime - stime) from scheduler, apply, users where apply.uid = users.uid and apply.sid = scheduler.sid and users.uid='test';

select aid, adate, apply.sid, scheduler.stime, scheduler.etime, (scheduler.etime - scheduler.stime), apply.uid, users.uname 
from apply, users, scheduler 
where apply.uid = users.uid and apply.sid = scheduler.sid and users.uid = 'test';

select apply.uid, users.uname, sum(scheduler.etime - scheduler.stime) 
from apply, users, scheduler 
where apply.uid = users.uid and apply.sid = scheduler.sid group by uid;

select * from users;
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('﻿ny1234', password('1234'), '이나연', '010-0000-0001', '경기도 용인시', '관리자', 7530, 1);
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('sr1235', password('1234'), '홍세리', '010-0000-0002', '서울시 송파구', '관리자', 7530, 2);
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('sy1236', password('1234'), '박시욱', '010-0000-0003', '경기도 안산시', '관리자', 7530, 3);
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('js1237', 'password('1234')', '최진선', '010-0000-0004', '경기도 광주시', '관리자', '7530', '4');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('ti1238', 'password('1234')', '이태일', '010-0000-0005', '서울시 송파구', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jh1239', 'password('1234')', '우지호', '010-0000-0006', '서울시 강남구', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jh1240', 'password('1234')', '안재효', '010-0000-0007', '서울시 종로구', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('mh1241', 'password('1234')', '이민혁', '010-0000-0008', '서울시 광진구', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('pk1242', 'password('1234')', '박경', '010-0000-0009', '서울시 종로구', '직원', '7530', '2');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jh1243', 'password('1234')', '표지훈', '010-0000-0010', '서울시 광진구', '직원', '7530', '2');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('yg1244', 'password('1234')', '김유권', '010-0000-0011', '경기도 용인시', '직원', '7530', '2');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('ir1245', 'password('1234')', '아이린', '010-0000-0012', '경기도 용인시', '직원', '7530', '3');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('wd1246', 'password('1234')', '웬디', '010-0000-0013', '경기도 광주시', '직원', '7530', '3');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('yr1247', 'password('1234')', '예린', '010-0000-0014', '서울시 송파구', '직원', '7530', '3');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('sk1248', 'password('1234')', '슬기', '010-0000-0015', '서울시 송파구', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jy1249', 'password('1234')', '조이', '010-0000-0016', '경기도 광주시', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jy1250', 'password('1234')', '홍진영', '010-0000-0017', '경기도 용인시', '직원', '7530', '1');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('jk1251', 'password('1234')', '김종국', '010-0000-0018', '경기도 안산시', '직원', '7530', '4');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('js1252', 'password('1234')', '유재석', '010-0000-0019', '서울시 종로구', '직원', '7530', '4');
INSERT INTO `web04`.`users` (`uid`, `upw`, `uname`, `uphone`, `uaddr`, `ulevel`, `pay`, `wpid`) VALUES ('hd1253', 'password('1234')', '강호동', '010-0000-0020', '경기도 안산시', '직원', '7530', '4');
