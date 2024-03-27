--2024/03/27
--join
select * from emp;
select * from dept;

--smith 로그인 - 마이페이지로 들어감
--부서이름, 지사, 급여, 등급, 메니저이름이나 부서를 알고싶어한다.
--emp.deptno 위치가 겹치거나 헷갈리는 경우 테이블 명을 적어준다
select empno,ename,job,mgr,hiredate,sal,emp.deptno,dept.deptno,dname,loc  --dname,loc은 다른 테이블에 존재
    from emp , dept
    where ename='SMITH' and emp.deptno=dept.deptno --각 테이블의 deptno가 같에 해달라
    ;
    
--ORA-25154: USING 절의 열 부분은 식별자를 가질 수 없음 어느 테이블의 deptno인지 모른다    
    select empno,ename,job,mgr,hiredate,sal,deptno,deptno,dname,loc 
    --from emp cross join dept --join조건 필요없음 - 카테시안 곱 : 모든 경우의 수 
    from emp join dept --on emp.deptno=dept.deptno --on 조인을 위한 조건
    using (deptno) -- 각각의 dpetno열을 합친 후 거기서 찾음
    where ename='SMITH'
    ;
   
select * from emp join dept using (deptno); --출력시 deptno열이 하나, 맨 앞에 deptno컬럼이 나옴
select * from emp join dept on emp.deptno=dept.deptno; --deptno열이 두개
select emp.*,dname,loc from emp join dept on emp.deptno=dept.deptno; --
select emp.*,dept.*,ename re_ename from emp join dept on emp.deptno=dept.deptno; --ename컬럼이 2개
--select * from emp join salgrade on emp.sal=salgrade.losal; 

select * from emp join salgrade on emp.sal>= salgrade.losal and  emp.sal<=salgrade.hisal order by ename; 
select * from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal order by ename; 
select * from emp e join salgrade s on e.sal between s.losal and s.hisal order by ename; --테이블의 별칭은 보통 첫글자 하나를 쓴다 as사용 불가
select grade,deptno from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal order by ename; 

--join의 테이블에 주로 별칭을 많이 씁니다. 
 select * from emp join salgrade s on sal between s.losal and s.hisal order by s.grade;
 
 --컬럼 출력 순서가 좀 달라요, 기준선도 달라요
 select * from emp left outer join dept using (deptno); --SMITH의 deptno가 null로 나타남
 select * from dept left outer join emp using (deptno); 
  select * from dept full outer join emp using (deptno); --두 테이블이 가진 모든 행
 --dept는 다 나타내고 emp와 deptno가 같으면 나타내고 아니면 ㅏㄷ null로 나타내
 
 --오라클 전용 outer join
  select * from dept,emp where dept.deptno =emp.deptno(+); 
 select * from emp ,dept where emp.deptno(+)=dept.deptno;
 --둘 다 같은 의미
 --full outer join에는 지원 안 함
 
 --두 테이블 모드 deptno가 있어야 그 값이 나온다
  select * from emp join dept using (deptno); 
 
select * from emp join dept on emp.deptno=dept.deptno;

select * from emp join dept using(deptno) ;
select e.* ,d.dname,d.loc,s.grade 
from emp e join dept d on e.deptno= d.deptno 
join salgrade s on e.sal between s.losal and s.hisal ;
select * from dept join emp using(deptno);

--self join 자기 자신의 테이블에 조인하는 것
--select e.emp ,e.emp_name 사원이름 , emdept_code, E.MANAGER_ID,
-- M.EMP_NAME 관리자이름
--FROM EMP E join EMP on e.sal between s.losal and s.hisal
-- WHERE e.mgr = M.EMP_ID;
select * from emp e1 join emp e2 on e1.mgr = e2.empno;

--subquery
select empno,job,ename ,sal from emp where sal >=(select avg(sal) from emp);

select deptno, max(sal)from emp group by deptno;

----------------------
--방법 1
select *
from emp 
--where (deptno,sal) in (select deptno ,max(sal) from emp group by deptno)
where (deptno,sal) in (select deptno ,max(sal) from emp where ename <>'KING'  group by deptno)
;
--방법 2
select *
from emp 
where (deptno,sal) in ((20,3000),(30,2850),(10,5000))
;

----
select *
from emp e
join (select deptno,avg(sal) svg_sal from emp group by deptno) sq
on e.deptno =sq.deptno
where e.sal > sq.svg_sal;

--dept의 deptno를 찾아서 거기서 dname만 emp랑 같이 보여줘
--열은 딱 하나만 있으면 될 땐 join없이 subquery를 활용
select e.*,(select dname from dept where deptno =e.deptno) as 이름 
    from emp e
;
