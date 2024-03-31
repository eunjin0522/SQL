--1.
select department_name as "학과 명", category as "계열"
from tb_department;

--2.
select department_name as "학과 명", capacity as "정원"
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

--4.