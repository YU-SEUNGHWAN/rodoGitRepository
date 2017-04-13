create sequence gps_seq start with 1 increment by 1;
create sequence photo_seq start with 1 increment by 1;
create sequence video_seq start with 1 increment by 1;
create sequence free_seq start with 1 increment by 1;
=======
create table rodo_member
(
	id varchar2(20) primary key
	, password varchar2(20) not null
	, name varchar2(20) not null
	, email varchar2(50) unique
)

select * from rodo_member;

create table rodo_photoboard
(
	photo_boardnum number primary key
	, photo_id varchar2(20) not null
	, photo_title varchar2(100) not null
	, photo_content varchar2(100) not null
	, photo_share varchar2(10) default 0
	, photo_input_dt date default sysdate
	, photo_update_dt date default sysdate
	, photo_hit number default 0
	, photofile_tn varchar2(200) not null
)

alter table rodo_photoboard add foreign key(photo_id) references rodo_member (id);

create sequence rodo_photoboard_seq start with 1 increment by 1;

create table rodo_photofile
(
	photo_boardnum number not null
	, photofile_original varchar2(200) not null
	, photofile_saved varchar2(200) not null
)

alter table rodo_photofile add foreign key(photo_boardnum) references rodo_photoboard (photo_boardnum);

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
	, freefile_original varchar2(200) not null
	, freefile_saved varchar2(200) not null
)

alter table rodo_freefile add foreign key(free_boardnum) references rodo_freeboard (free_boardnum);
