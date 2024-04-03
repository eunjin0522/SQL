desc dept;
desc emp;
select  * from dept order by 1;
insert into dept values ((select nvl(max(deptno),0)+1 from dept ),'KH','seoul');

create sequence seq_dept_deptno start with 78; --작명 : 보통 table이름을 사용
insert into dept values (seq_dept_deptno.nextval,'KH','seoul');

select seq_dept_deptno.currval from dual;
alter sequence seq_dept_deptno maxvalue 99 cycle;

select * from user_constraints;
drop sequence seq_dept_deptno; --단독객체여서 바로 삭제 됨

select * from user_sequences;

CREATE sequence seq_dept_deptno start with 70
MAXVALUE 99 cycle;
delete from dept where deptno> 69;
insert into dept values (seq_dept_deptno.nextval,'KH','seoul');
--cycle : max값이 넘어가면 1로 돌아감 : PK는 적용시킬 수 없단 얘기 : PK는 중복이 안되니까!


--currval
insert all
    into dept values(seq_dept_deptno.nextval ,'AK','서울') 
    into emp (empno,ename,deptno) values(456,'AHHHH',seq_dept_deptno.nextval)
select * from dual;

insert all
    into emp (empno,ename,deptno) values(456,'AHHHH',c1)
    into dept values(c1 ,'AK','서울') 
select nvl(max(deptno),0)+1 c1 from dept;