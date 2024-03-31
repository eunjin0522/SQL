
---------실습1 -----------------------------------------------------
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
where ename like '%E';

--16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회 
SELECT
    *
FROM emp
--where ename like'__R%' --like 사용
where substr(ename,3,1)='R' --SUBSTR() 함수 사용 
;

--17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
select empno,ename, hiredate,add_months(hiredate,40*12) as "40주년" 
from emp;

--18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
select *
from emp
where months_between(sysdate,hiredate) >= 12*38;
select*from emp;

--19. 오늘 날짜에서 년도만 추출
select EXTRACT(year from sysdate) as "년도" from dual;


---------실습3 -----------------------------------------------------
--1.
select e.* ,s.grade 
from emp e 
join salgrade s on( e.sal between losal and hisal )
order by s.grade asc
;

--2.

select e.* ,s.grade 
from emp e 
join salgrade s on( e.sal between losal and hisal )
where s.grade <= 4
order by s.grade desc
;

--3. DEPTNO가 20,30인 부서 사람들의 등급별 평균연봉
    --조건 : 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
    --2. 연봉 계산은 SAL*12+COMM
    --3. 순서는 평균연봉이 내림차순으로 정렬한다.

select s.grade , avg(SAL*12 + nvl(comm,0)) as 연봉
from emp e
join salgrade s on( e.sal between losal and hisal )
where e.deptno in ('20','30')
group by s.grade
order by 2 DESC;

--4. 1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 조회
    --2. 연봉 계산은 SAL*12+COMM
    --3. 순서는 평균연봉이 내림차순으로 정렬한다.
    
select deptno , avg(SAL*12 + nvl(comm,0)) as 연봉
from emp 
where deptno in ('20','30')
group by deptno
order by 2 DESC ;--평균연봉;

--확인용
select deptno , SAL*12 + nvl(comm,0) as 연봉
from emp 
where deptno in ('20','30')
order by 1 DESC ;

--5.사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회- 정렬
select e.empno,e.ename, e.job,e.mgr, m.ename as manager
from emp e
left join emp m on e.mgr = m.empno
order by 1 asc;

--6.사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회- 정렬
select e.empno,e.ename, e.job,e.mgr, (select ename  from emp m where e.mgr = m.empno ) as manager
from emp e
order by e.mgr ;

--7.MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번부서인 사원 조회
select * 
from emp
where sal >(select sal from emp where ename = 'MARTIN') 
and deptno in ('20',(select deptno from emp where ename='ALLEN'));

--8.‘RESEARCH’부서의 사원 이름과 매니저 이름을 나타내시오.
-----(1)
select e.ename, m.ename as manager
from emp e
left join emp m on e.mgr = m.empno
where e.deptno = (select deptno from dept where dname ='RESEARCH')
;
-----(2)
select e.ename, m.ename as manager
from emp e
join dept d on d.deptno = e.deptno --using (deptno) USING 절의 열 부분은 식별자를 가질 수 없음
join emp m on e.mgr = m.empno
where e.deptno = '20'
;

--9.GRADE별로 급여를 가장 작은 사원명을 조회

--9.GRADE별로 급여를 가장 작은 사원명을 조회

select grade, ename 
from emp e
join salgrade s on( e.sal between s.losal and s.hisal )
where (e.sal, s.grade) in(select min(e.sal),s.grade from emp e join salgrade s on e.sal between s.losal and s.hisal group by s.grade)
;
--10. GRADE별로 가장 많은 급여, 가장 작은 급여, 평균 급여를 조회
select grade, min(sal) MIN_SAL, max(sal) MAX_SAL , floor(avg(sal)) AVG_SAL
from emp e
join salgrade s on( e.sal between s.losal and s.hisal )
group by s.grade;

--11. GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회- 정렬
select s.grade,e.ename as "평균10프로내외인사원"
from emp e
join salgrade s on( e.sal between s.losal and s.hisal )
where e.sal 
    between(select avg(sal)*0.9 from emp join salgrade s1 on( sal between s1.losal and s1.hisal )where s.grade=s1.grade) 
    and (select avg(sal)*1.1 from emp join salgrade s2 on( sal between s2.losal and s2.hisal )where s.grade=s2.grade) 
;


--12.지역 재난 지원금을 사원들에게 추가 지급
-----(조건) :
----- 1. NEW YORK지역은 SAL의 2%, DALLAS지역은 SAL의 5%, CHICAGO지역은 SAL의 3%,BOSTON지역은 SAL의 7%
----- 2. 추가지원금이 많은 사람 순으로 정렬

select empno,ename,sal,
    case when d.loc =  'NEW YORK' then e.sal*1.02
        when d.loc =  'DALLAS' then e.sal*1.03
        when d.loc='BOSTON' then e.sal*1.07
        else 0
    end as SAL_SUBSIDY
from emp e
join dept d using(deptno)
order by SAL_SUBSIDY desc
;
