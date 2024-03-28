--natural join
select *
from emp 
--cross join dept;
natural join dept;
--두 테이블이 갖는 공통 컬럼에 대해서 Inner Join은 별개의 컬럼으로,Natural Join은 하나의 컬럼으로 나타낸다.

----------------------subquery
--group by 없이 그룹함수 사용 -> 어디에? select에!
select count(distinct comm) from emp; --comm의 도메인 갯수 : 5개 null값은 카운트 하지 않는다
select * from emp where empno =7499;

--연산자
--any
select empno,ename ,sal from emp
--where sal > any(select sal from emp where job='SALESNAM'); 
where sal = any(select sal from emp where job ='SALESMAN'); 
--괄호 안 1600,1250,1250,1500이며 이것들 중에 하나보다는(any) 크냐 : 1250보다 크냐? 와 비슷하지않나
--salseman 중 단 한 명만이라도 그 사람보다 많은 급여를 받니?

--all
--MANAGER 사원들 중 최고 급여보다 많은 급여를 받는 사원들이 조회된다.
select empno,ename ,sal from emp
where sal >all(select sal from emp where job='MGR');
--MANAGER 사원들과 같은 급여를 받는 사원들이 조회된다.
select empno,ename ,sal from emp
where sal=all(select sal from emp where job='MGR');

--관리자로 등록되어 있는 사원들을 조회
--select empno,ename ,sal from emp e
--where exits (select s.empno from emp s where s.mgr = e.empno); --상호연관 쿼리는 join의 역할과 비슷하다
--데이터의 존재여부 확인 후 찾아줘

-----------------SYSDATE
--select sysdate from dual where sysdate >to_date('2024-03-28 10:36:24','yyyy-mm-dd hh24:mi:ss');
--to_date의 값보다 sysdate가 크다면 sysdate를 출력해줘
--select sysdate,a from (select sysdate a from dual) where sysdate >to_date('2024-03-28 10:36:24','yyyy-mm-dd hh24:mi:ss');

---------inline-view
-----rownum : 페이징을 위해 사용된다
select ename,sal,rownum
from emp
order by sal desc;
--sal의 크기에 맞춰 rownum으로 하고 싶지만 실행 순서로인해 rownum이 먼저 생성된 후 정렬되기 때문에 다르게 나온다

--해결 : 서브쿼리로 만들어버린다
select t1.*,rownum r2  --t1테이블의 모든 컬럼과 r2를 출력해줘
from (select ename,sal,rownum from emp order by sal desc)t1;

--입사일이 빠른 1-5
select rownum r2,t1.*  --t1테이블의 모든 컬럼과 r2를 출력해줘
from (select ename,hiredate from emp order by hiredate asc)t1
where rownum <=5; --where절에서 하나하나 차곡차곡 쌓아서 수행하기에 가능

--6-11
select *
from(select t1.*,rownum r2 
    from (select ename,hiredate from emp order by hiredate asc)t1 )t2
where r2 between 6 and 11;
--rownum은 서브쿼리가 두 개라고 생각하는게 편하다

-------with
with t1 as(select ename,hiredate,rownum r1 from emp order by hiredate asc)
select * from t1;

------rank() over : 분석 함수

----rank()만 썼을 때
--ORA-30484: 이 함수에 대한 윈도우 지정이 없습니다
--30484. 00000 -  "missing window specification for this function"

------over()을 추가 했을 때
--ORA-30485: 윈도우 지정에 ORDER BY 표현식이 없습니다
--30485. 00000 -  "missing ORDER BY expression in the window specification"

------over(order by 속성) : 나는 속성을 기준으로 rank를 메길거야 :56행과 같은 결과가 나옴
with t1 as(select ename,sal,hiredate , rank() over(order by hiredate) r1
    from emp)
select * from t1
    where r1 between 6 and 10
;

----dense_rank() : 중복 등수 다음 그 수만큼 건너뛰지 않고 바로다음 등수 나옴
with t1 as(select ename,sal,hiredate , dense_rank() over(order by hiredate) r1
    from emp)
select * from t1
;


------------분석함수 : AVG,SUM,RANK,MAX,MIN,COUNT
--그룹함수를 grouping 안 해주면 오류 발생
--그룹함수 뒤에 over()을 적어주면 정상 출력 : 다만 그 값 전체를 계산한 것을 각각의 행에 넣어줌 : 결과값 참고
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select ename,sal,sum(sal) over() A 
from emp 
--group by ename ,sal
;

--partition by : group by 역할을 하는 것이다.
select ename,sal,sum(sal) over() A ,sum(sal) over(partition by deptno) B
from emp;

------------순위함수 : RANK,DENSE_RANK,....
SELECT ename,deptno,sal,sum(sal) over(partition by deptno) a
,rank() over (order by sal desc) b
,rank() over(partition by deptno order by sal desc) c -- 
from emp
order by deptno;


------------집계함수 : SUM,MIN,MAX,AVG,COUNT

------------기타함수 : LEAD, LAG, FIRST_VALUE,LAST_VALUE,RATIO_TO_REPORT

--lag(조회할 범위, 이전위치, 기준 현재위치)
select ename, deptno, sal,
lag(sal,1,0) over (order by sal) 이전값,
 --1:바로 전 행값, 0 : 이전행이 없으면 0 처리함
lag(sal,1,sal) over (order by sal) "조회2",
--이전행이 없으면 현재 행의 값을 출력
lag(sal,1,sal) over (partition by deptno order by sal) "3"
--부서 그룹안에서의 이전 행값 출력
from emp;
 
 --lead(조회할 범위, 다음위치, 기준 현재위치) /방향 7시의 값을 2시로끌어감
select ename, deptno, sal,
lead(sal,1,0) over (order by sal) 이전값,
 --1:바로 다음 행값, 0 : 다음행이 없으면 0 처리함
lead(sal,1,sal) over (order by sal) "조회2",
--이전행이 없으면 현재 행의 값을 출력
lead(sal,1,sal) over (partition by deptno order by sal) "3"
--부서 그룹안에서의 다음 행값 출력
from emp;



SELECT EMPNO, DEPTNO, SAL
    , SUM(SAL) OVER()"win1과 동일"
    , SUM(SAL) OVER(ORDER BY EMPNO) "win0"
        , SUM(SAL) OVER (ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND current row) "win0-1" --win0와 값이 동일 다만 디테일을 위해...
    , SUM(SAL) OVER (ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) "win1"
        -- rows : 부분그룹인 윈도우의 크기를 물리적인 단위로 행집합을 지정
        -- unbounded preceding : 윈도우의 첫행
        -- unbounded following : 윈도우의 마지막행
        -- current row : 현재 행
        -- N preceding : 현재 행을 중심으로 N번째 이전행
        -- N following : 현재 행을 중심으로 N번째 다음행
        --partition by -> order by -> unbounded 순으로 적는다
--    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "win2" --:첫번째 행부터 지금 행까지
        -- 윈도우의 시작행에서 현재 위치(current row) 까지의 합계를 구해서 win2에
    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) "win3" --:내꺼부터 마지막 행까지 계산
        -- 현재 위치에서 윈도우의 마지막행까지의 합계를 구해서 win3에
        
--    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "win4" -- 1 preceding and 1 following 
        -- 현재 행을 중심으로 이전행과 다음행의 급여합계
    FROM EMP
--    WHERE DEPTNO = 30
    ;
    
    
    ---------현재 조회한 select에 나열된 컬럼이 아닌 다른 컬럼값으로 정렬하고자 한다면,
    --order by에 서브커리를 사용
    --부서이름으로 정렬하여 emp 테이블의 정보를 조회
    select empno, ename,deptno,hiredate,
    (select loc from dept where deptno = e.deptno) loc --활용도는 떨어짐 join을 쓰면 되니까
    from emp e
    order by(select dname from dept where deptno=e.deptno)desc;
    select *from dept order by ename;