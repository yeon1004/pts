use web04;

create table users(
	uid int,					/*직원아이디*/
	upw varchar(20) not null,	/*비밀번호*/
	uname varchar(10) not null,	/*이름*/
	ubirth date,				/*생년월일*/
	uphone varchar(20),			/*전화번호*/
	uaddr varchar(20),			/*주소*/
    urank enum('관리자','직원'),	/*직급*/
    wpid int not null,			/*근무지아이디*/
    primary key(uid),
    foreign key(wpid) references workplace(wpid)
);

create table workplace(
	wpid int,					/*근무지아이디*/
    wpname varchar(30) not null,/*상호명*/
    wpnum varchar(20) not null,	/*사업자번호*/
    primary key(wpid)
);

create table scheduler(
	sid int,									/*일정아이디*/
    sday enum('월','화','수','목','금','토','일'),	/*요일*/
    stime datetime,								/*시작시간*/
    etime datetime,								/*종료시간*/
    able enum('가능','불가능'),						/*신청 가능 여부*/
    wpid int not null,							/*근무지아이디*/
    primary key(sid),
    foreign key(wpid) references workplace(wpid) on delete cascade on update cascade
    );
    
create table apply(
	aid int,						/*신청아이디*/
    astatus enum('신청','승인','거절'),	/*신청 상태*/
    sid int not null,				/*일정아이디*/
    uid int not null,				/*직원아이디*/
    primary key(aid),
    foreign key(sid) references scheduler(sid),
    foreign key(uid) references users(uid)
 );   

create table pay(
	pid int,
    uid int not null,
    sdate datetime,
    edate datetime,
    total int,
    pstatus enum('지급','미지급'),
    primary key(pid),
    foreign key(uid) references users(uid)
 );
 
 create table notice(
	nid int,
    uid int not null,
    ntitle varchar(100) not null,
    ncont varchar(1000) not null,
    ndate datetime default current_timestamp,
    nhit int,
    primary key(nid),
    foreign key(uid) references users(uid)
 );
 
 create table images(
	iid int,
    nid int,
    wpid int,
    filepath varchar(100),
    fimename varchar(100),
    primary key(iid),
    foreign key(nid) references notice(nid),
    foreign key(wpid) references workplace(wpid)
 );

drop database web04;
create database web04;

insert into workplace values('wp1','버거퀸 강남점','456-01-12345','이미지...');
insert into users values('he1013','1013','이하은','960906','010-0000-1013','경기도 광주시','관리자','wp1');

show tables;
select * from users;
select * from workplace;