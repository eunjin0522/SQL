

--1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
select *
from emp
where comm is not null;

--2.EMP테이블에서 커미션을 받지 못하는 직원 조회
select *
from emp
where comm is null or comm =0;

--3.EMP테이블에서 관리자가 없는 직원 정보 조회
select * 
from emp
where mgr is null;

--4.EMP테이블에서 급여를 많이 받는 직원 순으로 조회
select * 
from emp
order by sal desc;

--5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
select * 
from emp
order by sal desc , comm desc;

--6. EMP테이블에서 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
select empno,ename,hiredate 
from emp
order by hiredate asc;

--7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
select empno,ename 
from emp
order by empno desc;

--8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회
--(부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
select empno,hiredate,ename ,sal
from emp
order by empno asc,hiredate;

--9. 오늘 날짜에 대한 정보 조회
SELECT sysdate from dual;

--10. EMP테이블에서 사번, 사원명, 급여 조회
--(단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
select trunc(123.456,-2) from dual;
select empno,ename ,trunc(sal,-2)
from emp
order by sal desc;

--11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
select *
from emp
where mod(empno,2)=1;

--12.EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
select ename,EXTRACT(year from hiredate) year,extract(month from hiredate) month
from emp;

select ename,to_char(hiredate,'YYYY') year,to_char(hiredate,'mm') month
from emp;

--13.EMP테이블에서 9월에 입사한 직원의 정보 조회
select *
from emp
where extract(month from hiredate)=9 ;

--14. EMP테이블에서 81년도에 입사한 직원 조회
select *
from emp
where to_char(hiredate,'yy')=81;

--15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
select * 
from emp
where ename like '%E';-----??
