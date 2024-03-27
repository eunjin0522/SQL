----------------수업 내용 복기 -------------
--order by--
select * from employee order by dept_code nulls first;

--group by--
--EMPLOYEE에서부서코드, 그룹별급여의합계, 그룹별급여의 평균(정수처리), 인원수를조회하고부서코드순으로정렬
select dept_code, sum(salary), floor(avg(salary)),count(*) 
    from EMPLOYEE 
    group by dept_code 
    order by dept_code;
--EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
   select dept_code, count(bonus) 
    from EMPLOYEE 
    group by dept_code 
    order by dept_code; 
--- EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
 select decode(substr(emp_no,8,1),'1','남','2','여') 성별, floor(avg(salary)) as 평균,sum(salary)as 합계, count(*) 
    from EMPLOYEE 
    group by decode(substr(emp_no,8,1),'1','남','2','여') 
    order by 4 desc; 
    
--having--
--부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
   select dept_code,avg(salary) 
    from EMPLOYEE 
    where salary >= 3000000
    group by dept_code 
    order by 1; 
--부서 코드와 급여 평균이 3000000 이상인 그룹 조회
   select dept_code,avg(salary) 
    from EMPLOYEE 
    group by dept_code 
    having floor(avg(salary)) >=3000000
    order by 1; 

--rollup  
select job_code, sum(salary) 
    from employee
    group by rollup(job_code) --rollup은 그 그룹의 합을 알려준다, 그리고 그 합들의 총합
    order by 1;
    
    select job_code, sum(salary)  
    from employee
    group by job_code
    order by 1;
    
select job_code,dept_code, sum(salary) 
    from employee
    group by rollup(job_code,dept_code) 
    order by 1;
 
 --cube ---   
select dept_code, job_code,sum(salary) 
    from employee
    group by cube(job_code,dept_code) 
    order by 1;

--union
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
UNION
SELECT '빈문자', JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

--union all
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
UNION all
SELECT '빈문자', JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

--intersect
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
intersect
SELECT '빈문자', JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

--MINUS
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
MINUS
SELECT '빈문자', JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

--group sets
--null값 구분
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
(DEPT_CODE, MANAGER_ID),
(JOB_CODE, MANAGER_ID));

--join
--여러 테이블에서 데이터를 조회하기 위해
--수행 결과는 result set 하나!
SELECT EMP_ID, EMP_NAME, DEPT_CODE,DEPT_TITLE --오라클 방식 잘 사용 X
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE=DEPT_ID;

SELECT EMP_ID, EMP_NAME, DEPT_CODE,DEPT_TITLE 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID --컬럼명이 다른 경우 ON
;

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM employee
JOIN job USING(JOB_CODE); --칼럼명이 같은 경우 USING ()

--RIGHT JOIN
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT
ON (DEPT_CODE = DEPT_ID); --EMP_NAME이 NULL인 값이 맨 밑으로, DEPT_TITLE NULL값 표시 X

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT --EMP_NAME이 NULL인 값이 맨 밑으로, DEPT_TITLE NULL값 표시 
ON (DEPT_CODE = DEPT_ID);

SELECT EMP_ID,EMP_NAME,MANAGER_ID
FROM EMPLOYEE;

--SELF JOIN
SELECT E.EMP_ID, E.EMP_NAME 사원이름, E.DEPT_CODE, E.MANAGER_ID,M.EMP_NAME AS 관리자이름
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

--다중 JOIN
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

---------------------------SUBQUERY
SELECT  EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY >= ( SELECT AVG(SALARY) FROM EMPLOYEE) ORDER BY 2;

--다중행 일반비교연산자 X , 
--IN/ NOT IN , >ANY / <ANY, >ALL / <ALL, EXIST / NOT EXIST
SELECT  EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE 
WHERE SALARY IN ( SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE) ORDER BY 3;

--다중 열 
--- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
SELECT  EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE (DEPT_CODE,JOB_CODE) IN(SELECT DEPT_CODE,JOB_CODE FROM EMPLOYEE WHERE SUBSTR(emp_no,8,1)=2 AND ENT_YN='Y');


SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
