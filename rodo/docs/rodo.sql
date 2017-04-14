drop table rodo_member;
drop table rodo_freeboard;
drop sequence rodo_freeboard_seq;
drop table rodo_freefile;


create table rodo_member
(
	id varchar2(20) primary key
	, password varchar2(20) not null
	, name varchar2(20) not null
	, email varchar2(50) unique
);

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
);

alter table rodo_photoboard add foreign key(photo_id) references rodo_member (id);

create sequence rodo_photoboard_seq start with 1 increment by 1;

create table rodo_photofile
(
	photo_boardnum number not null
	, photofile_original varchar2(200) not null
	, photofile_saved varchar2(200) not null
);

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
);

alter table rodo_freeboard add foreign key(free_id) references rodo_member (id);

create sequence rodo_freeboard_seq start with 1 increment by 1;

create table rodo_freefile
(
	free_boardnum number not null
	, freefile_original varchar2(200)
	, freefile_saved varchar2(200)
);

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


create table rodo_videoboard
(
	video_boardnum number primary key
	, video_id varchar2(20) not null
	, video_title varchar2(100) not null
	, video_content varchar2(100) not null
	, video_input_dt date default sysdate
	, video_update_dt date default sysdate
	, video_originalfile varchar2(150) not null
	, video_savedfile varchar2(150) not null
	, video_thumbnail varchar2(150) not null
	, video_hits number default 0
);

alter table rodo_videoboard add foreign key(video_id) references rodo_member (id);

create sequence rodo_video_seq start with 1 increment by 1;

select * from rodo_videoboard;



create table rodo_sendmessage
(
	sendmessage_num number primary key
	, sendmessage_sender varchar2(30) not null
	, sendmessage_receiver varchar2(30) not null
	, sendmessage_title varchar2(30) not null
	, sendmessage_text varchar2(600) not null
	, sendmessage_send_dt date default sysdate
	, sendmessage_read_fl number default 0
);

create sequence rodo_sendmessage_seq start with 1 increment by 1;


create table rodo_receivemessage
(
	receivemessage_num number primary key
	, receivemessage_sender varchar2(30) not null
	, receivemessage_receiver varchar2(30) not null
	, receivemessage_title varchar2(30) not null
	, receivemessage_text varchar2(600) not null
	, receivemessage_send_dt date default sysdate
	, receivemessage_read_fl number default 0
);

create sequence rodo_receivemessage_seq start with 1 increment by 1;