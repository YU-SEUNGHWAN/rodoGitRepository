drop table rodo_photofile;
drop table rodo_photoreply;
drop table rodo_photoboard;
drop sequence rodo_photoboard_seq;
drop sequence rodo_photoreply_seq;
drop table rodo_freereply;
drop sequence rodo_freereply_seq;
drop table rodo_freefile;
drop table rodo_freeboard;
drop sequence rodo_freeboard_seq;
drop table rodo_videoreply;
drop sequence rodo_videoreply_seq;
drop sequence rodo_video_seq;
drop table rodo_videoboard;
drop table rodo_sendmessage;
drop table rodo_receivemessage;
drop sequence rodo_sendmessage_seq;
drop sequence rodo_receivemessage_seq;
drop sequence rodo_gpsboard_seq;
drop table rodo_gpsboard;
drop table rodo_gpsreply_seq;
drop table rodo_gpsreply;
drop table rodo_qafile;
drop sequence rodo_qareply_seq;
drop table rodo_qareply;
drop table rodo_qaboard;
drop sequence rodo_qaboard_seq;
drop table rodo_member;


create table rodo_member
(
	id varchar2(20) primary key
	, password varchar2(20) not null
	, email varchar2(50) unique
);

insert into rodo_member(id, password, email)
values ('test', 'test', 'test@test.com');

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

create table rodo_photoreply
(
	photoreply_replynum number primary key
	, photo_boardnum number not null
	, photoreply_id varchar2(20) not null
	, photoreply_text varchar2(300) not null
	, photoreply_input_dt date default sysdate
	, photoreply_update_dt date default sysdate
);

alter table rodo_photoreply add foreign key(photo_boardnum) references rodo_photoboard (photo_boardnum);
create sequence rodo_photoreply_seq start with 1 increment by 1;


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
);

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

create table rodo_videoreply
(
	videoreply_replynum number primary key
	, video_boardnum number not null
	, videoreply_id varchar2(20) not null
	, videoreply_text varchar2(300 )not null
	, videoreply_input_dt date default sysdate
	, videoreply_update_dt date default sysdate
);

alter table rodo_videoreply add foreign key(video_boardnum) references rodo_videoboard (video_boardnum);
create sequence rodo_videoreply_seq start with 1 increment by 1;



create table rodo_gpsboard
(
	gps_boardnum number primary key
	, gps_id varchar2(20) not null
	, gps_title varchar2(100) not null
	, gps_content varchar2(2000) not null
	, gps_gpxinfo varchar2(4000) not null
	, gps_location varchar2(10) not null
	, gps_input_dt date default sysdate
	, gps_update_dt date default sysdate
	, gps_marker varchar2(1000) 
	, gps_hit number default 0
	, gpsfile_original varchar2(200) not null
	, gpsfile_saved varchar2(200) not null
);

create sequence rodo_gpsboard_seq start with 1 increment by 1;
alter table rodo_gpsboard add foreign key(gps_id) references rodo_member (id);

delete rodo_gpsboard;

create table rodo_gpsreply
(
	gpsreply_replynum number primary key
	, gps_boardnum number not null
	, gpsreply_id varchar2(20) not null
	, gpsreply_text varchar2(300) not null
	, gpsreply_input_dt date default sysdate
	, gpsreply_update_dt date default sysdate
);

create sequence rodo_gpsreply_seq start with 1 increment by 1;
alter table rodo_gpsreply add foreign key(gps_boardnum) references rodo_gpsboard (gps_boardnum);



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



create table rodo_qaboard
(
	qa_boardnum number primary key
	, qa_id varchar2(20) not null
	, qa_title varchar2(100) not null
	, qa_content varchar2(100) not null
	, qa_input_dt date default sysdate
	, qa_update_dt date default sysdate
	, qa_hit number default 0
);

alter table rodo_qaboard add foreign key(qa_id) references rodo_member (id);

create sequence rodo_qaboard_seq start with 1 increment by 1;

create table rodo_qafile
(
	qa_boardnum number not null
	, qafile_original varchar2(200)
	, qafile_saved varchar2(200)
);

alter table rodo_qafile add foreign key(qa_boardnum) references rodo_qaboard (qa_boardnum);


create table rodo_qareply
(
	qareply_replynum number primary key
	, qa_boardnum number not null
	, qareply_id varchar2(20) not null
	, qareply_text varchar2(300) not null
	, qareply_input_dt date default sysdate
	, qareply_update_dt date default sysdate
);

alter table rodo_qareply add foreign key(qa_boardnum) references rodo_qaboard (qa_boardnum);
create sequence rodo_qareply_seq start with 1 increment by 1;