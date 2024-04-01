--1.
select department_name as "학과 명", category as "계열"
from tb_department;

--2.
select department_name ||'의 정원은'|| capacity ||'명 입니다.'
from tb_department;

--3.
--(방법1)
select student_name
from tb_student
where department_no= (select department_no from tb_department where department_name ='국어국문학과')
and mod(substr(student_ssn,8,1),2) = 0 and absence_yn ='Y'
;

--(방법2)
select s.student_name
from tb_student s
join tb_department d using(department_no)
where d.department_name ='국어국문학과'
and mod(substr(student_ssn,8,1),2) = 0 and absence_yn ='Y'
;

--4. 도서 장기 연체가 이름
select STUDENT_NAME
from tb_student
where student_no in ('A513079','A513090','A513091','A513110','A513119')
;

--5.입학정원 20-30인 학과 이름, 계열
select department_name, category
from tb_department
where capacity between '20' and '30'
;

--6.총장이름 알아내기 - 소속학과 없음
select PROFESSOR_NAME
from tb_professor
where department_no is null
;

--7. 학과 없는 학생 찾기
select student_name
from tb_student
where department_no is null
;

--8. 선수과목 존재 여부
select class_no
from tb_class
where preattending_class_no is not null
;

--9. 어떤 계열(categoty)이 있는가
select category_name
from tb_category;

--10. 휴학생을 제외한 재학생 학번,이름, 주민번호

select student_no 학번,student_name 이름,student_ssn 주민번호
from tb_student
where 1=1 and substr(student_no,1,2)='A2' and student_address like'%전주%' and absence_yn ='N'
;