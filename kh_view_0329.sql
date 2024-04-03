--------깊은복사
--물리적인 공간을 차지하는 테이블

create table employee_copy
as select emp_id,emp_name,SALARY, DEPT_TITLE, JOB_NAME
from employee
left join department on(dept_code=dept_id)
left join job using(job_code);

select * from employee_copy;

--------view : 논리테이블 : 물리적인 공간을 차지하고 있진 않지만 실제 테이블처럼 구동하기 때문이다
--------insufficient privileges : 
 CREATE OR REPLACE VIEW V_EMPLOYEE -- OR REPLACE 를 적지 않으면 바로 위 테이블의 위치에 생성??
 AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
 FROM EMPLOYEE
 --join의 순서는 중요합니다
 LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
 LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 LEFT JOIN NATIONAL USING(NATIONAL_CODE);
 SELECT * FROM V_EMPLOYEE;
 
 desc employee;
 insert into employee values ('999','홍길동','000329-4123456','a@a.a','01012345678','D9','J1','S1',3000000,null,'207',sysdate,null,'N');
 select*from V_EMPLOYEE order by emp_id desc; --employee테이블에 값을 넣어도 view테이블에서 볼 수 있다

create view v_test
as select * from employeeeeeeeeeeee; --ORA-00942: 테이블 또는 뷰가 존재하지 않습니다

 --force옵션 사용 - 생성됨 / force : 기본 테이블이 존재하지 않더라도 뷰 생성
create force view v_test
as select * from employeeeeeeeeeeee;

select * from user_views;
drop view v_test;

---------ppt 실습-----------------------------------------------------------------------
--깊은 복사
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
--UPDATE
UPDATE DEPT_COPY 
SET DEPT_TITLE ='전략기획팀'
WHERE DEPT_ID ='D9';
--EX1
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,
 EMP_NAME,
 DEPT_CODE,
  SALARY,
  BONUS
   FROM EMPLOYEE;
   SELECT * FROM emp_salary;
   
SELECT * FROM emp_salary WHERE EMP_NAME IN('유재식', '방명수');

--UPDATE    -->다중행 서브쿼리로도 가능
UPDATE EMP_SALARY
SET SALARY =(
SELECT SALARY
FROM EMP_SALARY
WHERE  EMP_NAME='유재식'
),
BONUS=(
SELECT BONUS FROM EMP_SALARY
WHERE EMP_NAME='유재식')
WHERE EMP_NAME='방명수';

--EX4
UPDATE EMP_SALARY
SET BONUS =0.3
WHERE EMP_ID IN (
SELECT EMP_ID
 FROM EMPLOYEE
 JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
 JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE LOCAL_NAME LIKE 'ASIA%'
);

UPDATE EMP_SALARY
SET BONUS =0.3
WHERE EMP_ID IN (
SELECT EMP_ID
FROM EMPLOYEE
JOIN department ON(DEPT_ID = DEPT_CODE)
 JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE'ASIA%'
);
SELECT * FROM LOCATION;
SELECT * FROM DEPARTMENT;

-----------ALTER
SELECT * FROM DEPT_COPY;
SELECT * FROM USER_CONSTRAINTS;

ALTER TABLE DEPT_COPY
ADD (CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
ADD (LNAME VARCHAR2(40) DEFAULT'KOREA');

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPU_DID_PK PRIMARY KEY(DEPT_ID); 

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DTITLE_UNQ UNIQUE(DEPT_TITLE); 


ALTER TABLE DEPT_COPY
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;        

INSERT INTO EMPLOYEE --컬럼의 순서가 바뀌면 안된다
VALUES(900, '장채현', '901123-1080503', 'jang_ch@kh.or.kr', '01055569512', 'D1', 'J8', 
'S3', 4300000, 0.2, '200', SYSDATE, NULL, DEFAULT);

--컬럼의 순서가 달라도 가능, NOT NULL값만 아니면 누락해도 무관함
 INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO,DEPT_CODE,
 JOB_CODE, SAL_LEVEL, SALARY, BONUS, MANAGER_ID, 
HIRE_DATE, ENT_DATE, ENT_YN)
 VALUES(903, '장채현', '901123-1080503','D1', 'J8',
 'S3', 4300000, 0.2, '200', SYSDATE, NULL, DEFAULT); --DEFULT값을 원할 때
 
 SELECT * FROM EMPLOYEE;
 
  CREATE TABLE EMP_01(
 EMP_ID NUMBER,
 EMP_NAME VARCHAR2(30),
 DEPT_TITLE VARCHAR2(20)
 );
 
 -- INSERT형식에서 values대신 서브쿼리도 넣어도 된다.
 INSERT INTO EMP_01(
 SELECT EMP_ID,
 EMP_NAME,
 DEPT_TITLE
FROM EMPLOYEE
 LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 );


DELETE FROM EMPLOYEE_COPY WHERE 1=1;
CREATE TABLE EMPLOYEE_COPY2 AS SELECT *FROM EMPLOYEE WHERE 1=0;
DELETE FROM EMPLOYEE_COPY2 WHERE 1=1;
SELECT*FROM EMPLOYEE_COPY2;
INSERT INTO EMPLOYEE_COPY2(SELECT *FROM EMPLOYEE);

--------insert all
CREATE table EMP_DEPT_D1(age number(2));
CREATE table EMP_MANAGER(age number(2));

insert all
    INTO EMP_DEPT_D1 VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
select EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
from employee
where dept_code='D1';

insert all
    into emp_dept_D1 values(a,b,'D9',sysdate)
    into emp_dept_D1 values(a,b,'998')
select'996' as a, 'HONG' as b from employee;
    