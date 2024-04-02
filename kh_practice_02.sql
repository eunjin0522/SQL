--08 한 사원과 같은 부서에서 일하는 사원의 이름 조회
-----self join
select t1.emp_name,t1.dept_code,t2.emp_name
from employee t1
join employee t2 on(t1.dept_code = t2.dept_code)
where t1.emp_name <> t2.emp_name
order by 1,3
;

--11.부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회 
--11-1. JOIN과 HAVING 사용 

select d.dept_title,sum(e.salary) 
from employee e
join department d on (e.dept_code=d.dept_id)
group by dept_title
having sum(salary) >any (select sum(salary)*0.2 from employee)
order by 1;
--11-2. 인라인 뷰 사용    ----???
select dept_title , sum(salary)
    from ( select dept_title, salary from employee e join department d on (e.dept_code=d.dept_id)) t1
    group by dept_title
    having sum(salary) > any( select sum(salary)*0.2 from employee) 
;
--11-3. WITH 사용

select dept_title , sum_sal
    from ( select dept_title, sum(salary) sum_sal
            from employee e join department d on (e.dept_code=d.dept_id)
            group by dept_title
        ) t1
    where sum_sal > any( select sum(salary)*0.2 from employee) 
;
with t1 as ( select dept_title, sum(salary) sum_sal
                from employee e join department d on (e.dept_code=d.dept_id)
                group by dept_title
            ) 
select dept_title, sum_sal from t1 where sum_sal > any( select sum(salary)*0.2 from employee)
;
