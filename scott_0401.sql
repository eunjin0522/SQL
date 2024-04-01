----dictionary 보는 법 암기----

select * from user_tables;
select * from user_views;
select * from user_constraints;
select * from user_cons_columns;

create table t8(
    c1 varchar2(10),
    c2 nvarchar2(10),
    c3 char(10),
    c4 nchar(10)
);

insert into t8 values ('1234567890','1234567890','1234567890','1234567890');
insert into t8 values ('123456가','123456가','1234567가','1234567가');
-- nvarchar2,nchar은 한글 한 자를 그 자체 하나로 본다 - n개 만큼 들어간다
insert into t8 values ('1234567가','123456789가','1234567가','123456789가');
insert into t8 values ('1234567가','123456789가','1234567가','가나다라마바사아자차');

--error :ORA-12899: "SCOTT"."T8"."C1" 열에 대한 값이 너무 큼(실제: 12, 최대값: 10) 한글 크기 : 3byte
--insert into t8 values ('123456789가','123456789가','1234567890가','1234567890가');

select * from t8;