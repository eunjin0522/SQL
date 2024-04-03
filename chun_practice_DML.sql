--01
insert into tb_class_type values (01,'전공필수');
insert into tb_class_type values (02,'전공선택');
insert into tb_class_type values (03,'교양필수');
insert into tb_class_type values (04,'교양선택');
insert into tb_class_type values (05,'논문지도');

--02
------01
create table TB_학생일반정보 (
    학번 varchar2(10),
    학생이름 varchar2(10),
    주소 varchar2(200)
);
insert All into TB_학생일반정보 values (학번,학생이름,주소)
select student_no 학번, student_name 학생이름,student_address 주소 from tb_student; --이름 같게

------02
create table TB_학생일반정보2 as select student_no 학번, student_name 학생이름,student_address 주소 from tb_student;
select * from TB_학생일반정보2;


--03
------01
create table TB_국어국문학과 as (
select s.student_no 학번, s.student_name 학생이름, substr(s.student_ssn,1,4) 출생년도, p.professor_name 교수이름 
from tb_student s
join tb_professor p on(s.coach_professor_no = p.professor_no)
where p.department_no = (select department_no
    from tb_department
    where department_name='국어국문학과')
);

select* from TB_국어국문학과;
drop table TB_국어국문학과;
------02
--TODO

--04
-----복사본 만들어서 사용
create table DEPARTMENT_COPY as select * from tb_department;
select * from DEPARTMENT_COPY;
drop table DEPARTMENT_COPY;

update DEPARTMENT_COPY 
set capacity = round(capacity*1.1,0);

--05
update tb_student
set student_address = '서울시 종로구 숭인동 181-21'
where student_no='A413042';
select * from tb_student where student_no='A413042';

--06
create table STUDENT_COPY as select student_ssn from tb_student; --주소만 따로 빼내서 테이블 생성
update STUDENT_COPY a
set student_ssn = (select substr(student_ssn,1,6) from STUDENT_COPY b where a.student_ssn = b.student_ssn);
SELECT * FROM STUDENT_COPY;--확인용

--07
update GRADE_COPY set point = 3.5
where student_no like(
    select student_no 
    from tb_student 
    where department_no like(select department_no from tb_department where department_name like '의학과')
    and student_name like '김명훈')and term_no like '200501'
    and class_no like(select class_no from tb_class where class_name like'피부생리학');
--08
create table GRADE_COPY as select * from tb_grade;
delete from GRADE_COPY
where student_no in (select student_no 
from tb_student where tb_student.absence_yn='Y');
rollback;
select count(*) from tb_student where absence_yn='Y';