--01.영문학과 02 입학년도가 빠른 순으로 정렬
select student_no 학번, student_name 이름, entrance_date 입학년도
from tb_student
where department_no = '002'
order by 3 desc
;
--2. 
-----length 사용 (문자열 길이 반환)
select professor_name , professor_ssn
from tb_professor
where length(professor_name)<>3
;
-----lengthb (문자열의 바이트 크기 반환)
select professor_name , professor_ssn
from tb_professor
where lengthb(professor_name) <>9
;

--03. 기술대 남자 교수들 만나이

select professor_name -- , 만나이
    from tb_professor
    where substr(professor_ssn,8,1) in ('1','3')
    order by 나이 asc
;
select to_char(sysdate,'yy')-mod(to_char(sysdate,'yy'),10)-1 from dual; --19
select to_char(sysdate,'yy')||substr(professor_ssn,1,6) from tb_professor;

---------
select professor_name, professor_ssn
            , birthday 생년월일
            , floor(months_between(sysdate , birthday)/12) 나이
            , months_between(sysdate , birthday)/12 O살아온달
            , floor(sysdate - birthday)/365 x살아온날
    from 
        --tb_professor
        (select  
                case 
                    when substr(professor_ssn,1,2) > to_char(sysdate, 'yy')  
                        then to_date(to_char(sysdate, 'yy') - mod(to_char(sysdate, 'yy'),10)-1||substr(professor_ssn,1,6))
                    else
                        to_date( substr(professor_ssn,1,6) , 'yymmdd')
                end birthday
                ,professor_name, professor_ssn
            from tb_professor
            where substr(professor_ssn, 8, 1) in ('1','3')
            ) t1
    order by 나이 asc
    ;
alter session set nls_date_format='yyyy-mm-dd';

--4.성을 제외한 이름만 출력
select substr(professor_name,2) as 이름
from tb_professor
;

--5.
select student_no, student_name
from tb_student
where (extract(year from entrance_date)-(substr(student_ssn,1,2)+1900)) >19
order by student_ssn desc
;

--6.
select to_char(to_date('20201225','yyyymmdd'),'day') from dual;

--7.
select
    to_date('99/10/11','yy/mm/dd') as "1" --2099
    , to_date('49/10/11','yy/mm/dd') as "2" --2049
    , to_date('90/10/11','rr/mm/dd') as "3"  --1990
    , to_date('49/10/11','rr/mm/dd') as "4"  --2049
from dual;

--8.
----- substr()
select student_no, student_name
from tb_student
where substr(student_no,1,1) <> 'A'
;
----- like
select student_no, student_name
from tb_student
where student_no not like 'A%'
;

--9.
select round(avg(point),1)
from tb_student
join tb_grade using(student_no)
where student_no='A517178';

--10.
select department_no "학과번호", count(*) "학생수(명)"
from tb_student
group by department_no
order by 1;

--11.
select count(*)
from tb_student
where coach_professor_no is null
;
--12.
select substr(term_no,1,4) as 년도, round(avg(point),1) as "년도 별 평점"
from tb_student
join tb_grade using(student_no)
where student_no ='A112113'
group by substr(term_no,1,4)
;
--13.학과별 휴학생 수
select department_no, count(decode(absence_yn,'Y',absence_yn,null))cnt
    from tb_student
    --where absence_yn = 'Y'
    group by department_no
;

--14. having
select student_name as 동일이름, count(*) as "동명인 수"
from tb_student
group by student_name
having count(*) >1
order by student_name
;

--15. rollup 
select substr(term_no,1,4) as 년도,substr(term_no,5) as 학기, round(avg(point),1) as "평점"
from tb_student
join tb_grade using(student_no)
where student_no='A112113'
group by rollup(substr(term_no,1,4),substr(term_no,5))
order by 년도
;