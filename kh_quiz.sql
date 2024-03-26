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



--5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회

--6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회

--7. EMPLOYEE테이블에서 SAL_LEVEL이 S1인 사원의 이름, 월급, 고용일, 연락처 조회