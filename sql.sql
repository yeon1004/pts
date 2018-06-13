use web04;

create table workplace(
	wpid int,
    wpname varchar(30) not null,
    wpnum varchar(20) not null,
    primary key(wpid)
);

create table users(
	uid varchar(20),
	upw varchar(40) not null,
	uname varchar(10) not null,
	ubirth date,
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
    stime datetime not null,
    etime datetime not null,
    able enum('가능','불가능') default '가능' not null,
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
    pstatus enum('지급','미지급') default '미지급',
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
    foreign key(uid) references users(uid)
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
    filepath varchar(100) not null,
    fimename varchar(100) not null,
    primary key(iid),
    foreign key(nid) references notice(nid),
    foreign key(wpid) references workplace(wpid)
 );

drop database web04;
create database web04;
use web04;

insert into workplace values('wp1','버거퀸 강남점','456-01-12345','');
insert into users values('he1013','1013','이하은','960906','010-0000-1013','경기도 광주시','관리자','wp1');
insert into users(uid, upw, uname, ubirth, uphone, uaddr, ulevel)
	values ('test', password('1234'), '테스트', '991231', '010-0000-0000', '경기도 용인시', '관리자');

show tables;
select * from users;
select * from workplace;

drop table apply;
drop table schedule;