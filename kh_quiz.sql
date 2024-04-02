--1. JOB 테이블의 모든 정보 조회
SELECT
    "A1"."JOB_CODE"    "JOB_CODE",
    "A1"."JOB_NAME"    "JOB_NAME"
FROM
    "QUIZ"."JOB" "A1";

--2. JOB 테이블의 직급 이름 조회 
SELECT job_name FROM JOB;

--3. DEPARTMENT 테이블의 모든 정보 조회
SELECT * from department;

--4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
select emp_name,email,emp_no,hire_date from employee;

--5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
select hire_date,emp_name,salary from employee;

--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 
select emp_name,salary,(salary+nvl(bonus,0)),((salary+nvl(bonus,0))-(salary*0.03)) from employee ;

--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회
select emp_name,salary,hire_date,phone from employee where sal_level <= 'S1'; 

--8. EMPLOYEE테이블에서 실수령액(6번 참고)이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
select emp_name,salary,hire_date from employee where sal_level <= 'S1';

--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--(단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
select emp_name
,trunc(hire_date-sysdate) 근무일수1
,trunc(sysdate-hire_date) 근무일수2
from employee
;

--25.EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--where,groupy by, having은 행을 뽑아내는 일이다 
select count(*)"전체직원수"
,count(decode(extract(year from hire_date),'2001',0,null)) "2001년"
,count(decode(extract(year from hire_date),'2002',0,null)) "2002년"
,count(decode(extract(year from hire_date),'2003',0,null)) "2003년"
,count(decode(extract(year from hire_date),'2004',0,null)) "2004년"
from employee
;
select count(*) from employee where extract(year from hire_date)='2001';
select count(decode(extract(year from hire_date),'2001',0,null)) from employee;