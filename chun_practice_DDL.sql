--1.
create table TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN char(1) default 'Y'
);

--2.
create table TB_CLASS_TYPE (
    NO VARCHAR2(5) primary key,
    NAME char(10) 
);

--3.
alter table TB_CATEGORY
add CONSTRAINT TCATE_NAME_PK primary key(name);


--4.
alter table TB_CLASS_TYPE
modify NAME CONSTRAINT TCTYP_NAME_NN not null;

--5.
ALTER TABLE TB_CLASS_TYPE
modify NO VARCHAR2(10);

ALTER TABLE TB_CATEGORY
modify NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
modify NAME VARCHAR2(20);

--6.
ALTER TABLE TB_CLASS_TYPE
rename column NO to CLASS_NO;
ALTER TABLE TB_CLASS_TYPE
rename column NAME to CLASS_NAME;
ALTER TABLE TB_CATEGORY
rename column NAME to  CATEGORY_NAME;

--7.
ALTER TABLE TB_CLASS_TYPE
rename column  CLASS_NAME to PK_CLASS_NAME;

--8.
insert into TB_CATEGORY values('공학','Y');
insert into TB_CATEGORY values('자연과학','Y');
insert into TB_CATEGORY values('의학','Y');
insert into TB_CATEGORY values('예체능','Y');
insert into TB_CATEGORY values('인문사회','Y');

--9.
alter table TB_DEPARTMENT 
add constraint DEPT_CATE_FK  foreign key (CATEGORY) references TB_CATEGORY (CATEGORY_NAME);

--10.
create view VW_학생일반정보 as
select student_no, student_name,student_address
from tb_student;


--11.
------01   ---0.015초
create view VW_지도면담 as
select student_name,department_name,professor_name
from tb_student
join tb_department using(department_no)
left outer join tb_professor on(coach_professor_no = professor_no)
;
select * from "VW_지도면담";
------02   --- ?? 초
--create view VW_지도면담이 as
--select student_name,department_name,professor_name --각각의 값이 각각의 테이블에 있어서 where로는 못 해요
--from tb_student
--join tb_department using(department_no)
--where coach_professor_no =(select professor_no from tb_professor );
drop view VW_지도면담;

--12.
create view VW_학과별학생수 as
select department_name, count(student_no) as student_count --count(*)??
from tb_department
join tb_student using(department_no)
group by department_name
;
select * from VW_학과별학생수;
drop view VW_학과별학생수;

--13.
update VW_학생일반정보
set student_name = '김은진'
where student_no ='A213046'; 

select * from tb_student where student_name ='김은진';--확인용
rollback; --변경 전으로 되돌림

--14
create view VW_학생일반정보_with_read_only as 
select student_no, student_name,student_address
from tb_student
with read only; --읽기 전용

--15
----------
SELECT 순위, EMP_NAME, SALARY
 FROM(SELECT EMP_NAME, SALARY,
 RANK() OVER(ORDER BY SALARY DESC) AS 순위
FROM EMPLOYEE
 ORDER BY SALARY DESC);
----------
select class_no as 과목번호, class_name as 과목이름, "누적수강생수(명)"
from (select class_no, class_name,count(student_no) "누적수강생수(명)", rank() over(order by count(student_no) desc )as 수강순위
from tb_class
join tb_grade using(class_no)
where substr(term_no,1,4) > 2006
group by class_no, class_name 
order by 수강순위)
where 수강순위 < 4
;
select term_no from tb_grade order by 1 desc;