--01
select student_name as "학생 이름", student_address as 주소지
from tb_student
order by "학생 이름"
;

--02
select student_name, student_ssn
from tb_student
where absence_yn ='Y'
order by student_ssn desc
;

--03
select student_name as 학생이름, student_no as 학번, student_address "거주지 주소"
from tb_student
where 1=1 and student_no not like 'A%' and (student_address like'강원%'or student_address like'경기%')
;

--04
select professor_name, professor_ssn
from tb_professor
join tb_department using(department_no)
where department_name='법학과' 
order by 2 asc
;

--05
select student_no, point
from tb_student
join tb_grade using(student_no)
where term_no='200402'
and class_no='C3118100'
order by 2 desc
;

--06
select student_no, student_name, department_name
from tb_student
join tb_department using(department_no)
order by 1
;

--07
select class_name, department_name
from tb_department
join tb_class using(department_no)
;

--08
select class_name, professor_name
from tb_class
join tb_class_professor using(class_no)
join tb_professor using(professor_no)
;

--09
select class_name, professor_name
from tb_class
join tb_professor using(department_no)
join tb_department using(department_no)
where category='인문사회'
;

--10
select student_no as 학번, student_name "학생 이름" , round(avg(point),1)"전체 평점"
from tb_student
join tb_grade using(student_no)
join tb_department using(department_no)
where department_name='음악학과'
group by student_no,student_name
order by student_no
;

--11
select department_name as 학과이름, student_name "학생 이름" , professor_name "지도교수이름"
from tb_student
join tb_department using(department_no)
join tb_professor on coach_professor_no = professor_no
where student_no='A313047'
;
--12
select student_name, term_no
from tb_student
join tb_grade using(student_no)
join tb_class using(class_no)
where class_name='인간관계론' and substr(term_no,1,4)='2007'
;

--13
select class_name , department_name
from tb_class 
join tb_department using(department_no)
left join tb_class_professor using(class_no)
where category ='예체능' and professor_no is null
order by 2;

--14
select student_name "학생 이름" , nvl(professor_name,'지도교수 미지정' )"지도교수이름"
from tb_student
join tb_department using(department_no)
left join tb_professor on coach_professor_no = professor_no
where department_name='서반아어학과'
;

--15
select student_no, student_name,department_name,평점
from(select student_no, student_name,department_name,avg(point) 평점
from tb_student
join tb_department using(department_no)
left join tb_grade using(student_no)
where absence_yn ='N'
group by student_no, student_name,department_name)
where 평점 >= 4
;

--16
select class_no, class_name,round(avg(point),8)
from tb_class 
left join tb_department using(department_no)
join tb_grade using(class_no)
where department_name = '환경조경학과' and class_type in ('전공선택')
group by  class_no, class_name
order by 1
;

--17
select student_name, student_address
from tb_student
where department_no=(select department_no from tb_student where student_name='최경희')
order by 2
;


SELECT 순위, EMP_NAME, SALARY
 FROM(SELECT EMP_NAME, SALARY,
 RANK() OVER(ORDER BY SALARY DESC) AS 순위
FROM EMPLOYEE
 ORDER BY SALARY DESC);
--18
--연산 낭비 --하수  -- 0.008초
select student_no, student_name
from (
    select student_no, student_name,rank()over(order by avg(point) desc) as 순위
    from tb_grade
    join tb_student using (student_no)
    join tb_department using (department_no)
    where department_name in('국어국문학과')
    group by student_no, student_name
    order by 순위)
where 순위 ='1';

--연산낭비를 하지 않음  -- 0.001초
select student_no, student_name
from (
    select student_no, student_name,rank()over(order by avg(point) desc) as 순위
    from tb_grade
    join tb_student using (student_no)
   
    where department_no=(select department_no from tb_department where department_name ='국어국문학과')
    group by student_no, student_name
    order by 순위)
where rownum =1;
--19
select department_name "계열 학과명", round(avg(point),1) 전공평점
from tb_department
join tb_class using(department_no)
join tb_grade using(class_no)
where category = (
    select category
    from tb_department
    where department_name ='환경조경학과'
)
group by department_name
order by 1;

select *
from tb_department
where department_name ='환경조경학과';