<<<<<<< HEAD
create sequence gps_seq start with 1 increment by 1;
create sequence photo_seq start with 1 increment by 1;
create sequence video_seq start with 1 increment by 1;
create sequence free_seq start with 1 increment by 1;
=======
=======
drop table rodo_member;
drop table rodo_freeboard;
drop sequence rodo_freeboard_seq;
drop table rodo_freefile;


>>>>>>> branch 'master' of https://github.com/YU-SEUNGHWAN/rodoGitRepository.git
create table rodo_member
(
	id varchar2(20) primary key
	, password varchar2(20) not null
	, name varchar2(20) not null
	, email varchar2(50) unique
)

<<<<<<< HEAD
select * from rodo_member;
=======
insert into rodo_member values('aaa', 'aaa', 'aaa', 'aaa');
>>>>>>> branch 'master' of https://github.com/YU-SEUNGHWAN/rodoGitRepository.git

create table rodo_freeboard
(
	free_boardnum number primary key
	, free_id varchar2(20) not null
	, free_title varchar2(100) not null
	, free_content varchar2(100) not null
	, free_input_dt date default sysdate
	, free_update_dt date default sysdate
	, free_hit number default 0
)

alter table rodo_freeboard add foreign key(free_id) references rodo_member (id);
create sequence rodo_freeboard_seq start with 1 increment by 1;

create table rodo_freefile
(
	free_boardnum number not null
	, freefile_original varchar2(200)
	, freefile_saved varchar2(200)
)

alter table rodo_freefile add foreign key(free_boardnum) references rodo_freeboard (free_boardnum);


create table rodo_freereply
(
	freereply_replynum number primary key
	, free_boardnum number not null
	, freereply_id varchar2(20) not null
	, freereply_text varchar2(300) not null
	, freereply_input_dt date default sysdate
	, freereply_update_dt date default sysdate
)

alter table rodo_freereply add foreign key(free_boardnum) references rodo_freeboard (free_boardnum);
create sequence rodo_freereply_seq start with 1 increment by 1;

select * from rodo_freereply;


