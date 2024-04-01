--01.영문학과 02 입학년도가 빠른 순으로 정렬
select student_no 학번, student_name 이름, to_date(entrance_date,'yyyy-mm-dd') 입학년도
from tb_student
where department_no = '002'
order by 3 desc
;

--03. 기술대 남자 교수들 만나이

select professor_name -- , 만나이
    from tb_professor
    where substr(professor_ssn,8,1) in ('1','3')
    order by 나이 asc
;
select to_char(sysdate,'yy')-mod(to_char(sysdate,'yy'),10)-1 from dual; --19
select to_char(sysdate,'yy')||substr(professor_ssn,1,6) from tb_professor;

---오류발생
select 
    professor_name,professor_ssn
    ,floor(months_between(sysdate,birthday) /12) 나이
    ,months_between(sysdate,birthday)/12 o살아온달
    ,floor(sysdate - birthday)/365 x살아온날
from(
    select
    case
        when substr(professor_ssn,1,2) > to_char(sysdate,'yy') 
            then to_date(to_char(sysdate,'yy')-mod(to_char(sysdate,'yy'),10)-1||substr(professor_ssn,1,6))
        else
            to_date(substr(professor_ssn,1,6),'yymmdd')
    end as "birthday"
    ,to_date(substr(professor_ssn,1,6),'rrmmdd') a1
    ,to_date(substr(professor_ssn,1,6),'yymmdd') a2
    from tb_professor
    where substr(professor_ssn,8,1) in ('1','3')
    ) t1
order by 나이
;
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

--13.학과별 휴학생 수
select department_no, count(decode(absence_yn,'Y',absence_yn,null))cnt
    from tb_student
    --where absence_yn = 'Y'
    group by department_no
;