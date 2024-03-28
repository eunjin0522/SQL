-------DDL
--create table-------------------------------------------------------------
create table t1(birthday date, name varchar2(30));
comment on column t1.birthday is '생년월일';
select * from t1;

update employee
set emp_name='홍길동'; --emp_name 전체가 홍길동이 됨
rollback; --update이전으로 되돌리기

insert into t1 values(sysdate,null);
insert into t1 values(sysdate,null);

--table t1삭제
drop table t1;

--table t1생성 (null 값이 들어가지 않게 설정 : not null)---------------------------------------
create table t1(birthday date, name varchar2(30) not null);
----오류 보고 -ORA-01400: NULL을 ("SCOTT"."T1"."NAME") 안에 삽입할 수 없습니다
insert into t1 values(sysdate,null); 

--birthday에 null값 삽입
insert into t1 values(null,'HONG');  -- birthday : (null) , name : HONG

---- uniqe 설정--------------------------------------------------------------------------------------
create table t1(birthday date, name varchar2(30) unique);


----------check 설정----------------------------------------------------------------------
create table t1(birthday date, name varchar2(30) UNIQUE
,gender char(1) check(gender in('f','m')));

insert into t1 values(null,'HONG','a'); -- 오류 발생 :ORA-02290: 체크 제약조건(SCOTT.SYS_C008397)이 위배되었습니다
select * from user_constraints where constraint_name = 'SYS_C008397'; --오류가 난 이유를 체크한다 : a를 넣으면 안되는구나!

insert into t1 values(null,'HONG','f'); -- 삽입 성공

--------primary key-------------------------------------------------------------------
create table t1(birthday date, name varchar2(30) primary key);
insert into t1 values(null,'HONG'); 

------------FOREIGN KEY-----------------------------------------------
--다른 테이블의 값을 끌어와서 t2에 넣어주는 것 ex) dept (부서번호)
create table t2 (gender char(1) check(gender in ('m','f'))
, name varchar2(30) references t1(name)); 
--ORA-02291: 무결성 제약조건(SCOTT.SYS_C008401)이 위배되었습니다- 부모 키가 없습니다
insert into t2 values(null, 'KIM');

insert into t2 values(null, 'HONG');

select * from t2;
--F 는 unique속성이 아닙니다 여러번 들어갈 수 있어요

---------------------------UPDATE
--ORA-02292: 무결성 제약조건(SCOTT.SYS_C008401)이 위배되었습니다- 자식 레코드가 발견되었습니다
--HONG이 라는 이름 지금 외래키야 연결된 저 자식 레코드 어떡할래
--1.자식 레코드를 다 지워야 값이 바뀔 수 있다
--2.null값으로 다 바꿔버린다
update t1 set name='HONG3' where name='HONG';
drop table t2;--t2를 삭제하면 t1을 update할 수 있다.

create table t2 (gender char(1) check(gender in ('m','f'))
, name varchar2(30) references t1(name) on delete cascade); 
insert into t2 values(null,'HONG');

--HONG을 두 번 추가하려고하면 오류 발생
----오류 보고 -ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008396)에 위배됩니다
insert into t2 values(null, 'HONG');
insert into t2 values(null,'HONG HONG');
insert into t2 values(null,'HONG2');
insert into t2 values(null,'HONG5');

update t1 set name='HONG!!!!' where name='HONG';

select * from t1;
select * from t2;

--drop 순서 t2먼저 
--------------------------------------------------------다시 정리
create table t1(birthday date, name varchar2(30) primary key);
insert into t1 values(null, 'HONG');
insert into t1 values(null, 'HONG2');

create table t2 (gender char(1) check(gender in ('m','f'))
, name varchar2(30) references t1(name) on delete cascade);  --t2에 있던 값들이 날아가요
-------------------------------------------on delete set null : 널 값이 들어가면서 부모키에 넣을 수 있음
--자식에서 값을 쓰고 있으면 그 값은 update할 수 없다.


insert into t2 values(null, 'HONG');
insert into t2 values(null, 'HONG');
insert into t2 values(null,'HONG HONG');
insert into t2 values(null,'HONG2');
insert into t2 values(null,'HONG3');
insert into t2 values(null,'HONG4');

delete from t1 where name='HONG2';
select * from t1;
select * from t2;



----------oracle의 성능이 우수한 이유 : 
------dictionary
--orcle이 실행될 때 해당 계정에 부여되는 테이블
--oracle은 모든 기록을 테이블에 기록하고 그 기록을 꺼내쓴다
--오류 원인 찾는 법
select * from user_constraints where constraint_name = 'SYS_C008397';
select * from user_cons_columns;

select * from t1;
select * from user_tables;


------------------------------------------------------------------------------------------
------DDL PRACTICE
create table tp(
name varchar2(30),
birth date,
class_no number(3),
class_name varchar2(10),
PRIMARY KEY(class_no, class_name) 
);

create table ts(
name varchar2(30),
birth date,
class_no number(3),
stu_no number(6) ,
class_name varchar2(10),
primary key(class_no,stu_no,class_name), 
--class_no, class_name을 PK로 설정했기 때문에 on delete set null을 할 수 없다. PK는 무조건 값이 있어야하니까
FOREIGN KEY(class_no, class_name) references tp(class_no, class_name)on delete cascade
);


--교수 테이블에 값 넣기
insert into tp values ('KIM',sysdate,111,'kor');
insert into tp values ('LEE','1980-05-27',222,'math');
insert into tp values ('PARK','1988-11-27',333,'eng');

--학생 테이블 값 넣기
insert into ts values ('kim',sysdate,111,240328,'kor');
insert into ts values ('kim',sysdate,222,240328,'math');
insert into ts values ('kim',sysdate,222,240327,'math');
insert into ts values ('lee',sysdate,333,240326,'eng');
insert into ts values ('lee',sysdate,111,240326,'kor');

--table 출력
select * from tp;
select * from ts;

--update tp set class_no='444' where class_no = '111';  
delete from tp where class_no='111';
drop table tp;
drop table ts;

comment on column ts.stu_no is'생일6자';

select * from user_constraints;


