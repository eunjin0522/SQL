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
insert into t8 values ('1234567가','가나다라마','1234567가','가나다라마');
insert into t8 values ('1234567가','가나다라마','1234567','가나다라마');

select * from t8 where 1=1 and c2='가나다라마'; 
--where절을 사용할 때 여러 조건을 붙일 경우 and조건, or 조건으로 쓰인다.
-- and(or) 조건 을 하나의 묶음으로 취급하기 위해 앞에 true,false설정을 위해 1=1 또는 1=0을 설정해두기도 한다.
select * from t8 where c3='1234567';

--error :ORA-12899: "SCOTT"."T8"."C1" 열에 대한 값이 너무 큼(실제: 12, 최대값: 10) 한글 크기 : 3byte
--insert into t8 values ('123456789가','123456789가','1234567890가','1234567890가');

create table t9( -- 각 type의 최대값
    c1 varchar2(4000),
    c2 nvarchar2(1000),
    c3 char(2000),
    c4 nchar(1000)
);

create unique index idx_t9 on t9(c1); --유니크를 자동으로 준다
insert into t9 values ('1234567가','가나다라마','1234567가','가나다라마');

select * from user_indexes;
select * from user_ind_columns;

select * from t9 where c1 ='123'; -- index가 걸린 컬럼으로 비교문 속도 향상
select * from t9 order by c3; -- 속도 안 빠름 : index가 걸려있지 않기 때문
select * from t9 where c2*12+c2 > 120000; --함수 인덱스 애초에 자주 사용하는 계산 값 자체에 인덱스를 거는 것

select emp.*,sal*12+nvl(comm,0) as 연봉  from emp where sal*12+nvl(comm,0) > 10000; --함수 인덱스 애초에 자주 사용하는 계산 값 자체에 인덱스를 거는 것
create index inx_emp_sal_func on emp(sal*12+nvl(comm,0));
--한 번 select한 값은 history가 남아서 속도가 빠르다

select * from emp where deptno > 20; 
--deptno에 index걸려있고 
--emp 튜플 100개 , select된 튜플이 15개 미만일 때 효과적이다


