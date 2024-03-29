drop table t7;
create table t7(
c1 number constraint t7_pk_c1 primary key,  --constraint 이름 설정 시 대소문자 상관 x 대문자로 표시됨
c2 number constraint t7_nn_c1 not null,     --오류발생 시 해당이름으로 표시된다
c3 number constraint t7_uk_c3 unique,
c4 number constraint t7_fk_c4 references dept
);

select * from user_constraints;
create table emp_copy
    as select * from emp;
select * from emp_copy;
create Table emp_copy
    as select* from emp where 1<>1;
    create Table emp_copy
    as select* from emp where 1<>0;

------검색 기능에 많이 쓰임
--전체를 선택한 상황에서 가져가겠다
select * from emp where 1<>0;
--전체 선택 안 한 상황에서 가져가겠다
select *from emp where 1<>1; -- 텅 비어있지만 구조는 잡혀있다  : truncate와 유사

--truncate 내용물만 지워버림

delete from emp_copy; --보다는
truncate table emp_copy; -- 속도는 빠르되 앞의 것과 같은 효과를 볼 수 있다




