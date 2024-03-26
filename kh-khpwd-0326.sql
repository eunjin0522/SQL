select * from employee;
select * from department;
select * from location;
SELECT*FROM national;
select EMP_NAME, SALARY*12 year,(SALARY+(salary*bonus))*12 as "calc" from employee;
SELECT EMP_ID, SALARY, salary||'원'as ex from employee;
select distinct dept_code,job_code from employee;
select job_code from employee where dept_code='D9'; 
--select emp_name, salary from employee where salary>'4000000z'; 오류 발생
select emp_name,dept_code,salary from employee where dept_code ='D6' and salary > '2000000';
--부서코드가‘D6’이거나 급여를2000000보다 많이 받는 직원의 이름, 부서코드, 급여조회
select emp_name,dept_code,salary from employee where dept_code ='D6' or salary > '2000000';
select emp_name,dept_code,salary from employee where not(salary > '2000000');
select emp_name,dept_code,salary from employee where dept_code <> 'D9';
--급여가 3000000보다 많고 6000000보다 작은 직원이름 조회
select emp_name from employee --where (salary >= 3000000) and (salary <= 6000000);
where salary between 3000000 and 6000000; -- 이상 이하의 범위를 의미

--부서코드가‘D6’이거나 'D5'인 직원
select emp_name from employee --where dept_code='D9' or dept_code='D5';
where dept_code in('D9','D5'); 

--부서코드가‘D6’나 'D5'가 아닌 직원
select emp_name from employee --where dept_code ^='D9' or dept_code ^='D5';
where dept_code not in('D9','D5'); 

--부서코드가 없는 직원
select emp_name from employee where  dept_code is null;

--‘전’씨성을 가진 직원이름과 급여조회
SELECT EMP_NAME, SALARY FROM EMPLOYEE WHERE EMP_NAME LIKE '전%';

--MAIL ID 중‘_’의앞이3자리인직원이름, 이메일조회
select  EMP_NAME, EMAIL FROM EMPLOYEE WHERE  EMAIL LIKE '___#_%' ESCAPE '#';

--<<<<<<<<<<<<<<<<함수 >>>>>>>>>>>>>>>>
--length
select emp_name,length(emp_name), email, length(email) from employee;
--lengthb 한글 1자 : 3byte
select emp_name,lengthb(emp_name), email, lengthb(email) from employee;

--instr
SELECT emp_name ,instr(email,'@',-1,1) 위치 from employee;
SELECT emp_name ,email,instr(email,'.',5,2) 위치 from employee; --??
--앞에서5번째 글자까진 그냥 찾지마 그 다음 문자들 중에서 두번째로 있는 .을 찾아줘 
--position이 바뀐다고 return 값이 바뀌진 않음 그냥 그 범위는 안 찾는 것이다
select instr('ABCDE','C', 2) from dual; -- 3

--lpad/rpad
select lpad(email,20,'#') as lpad from employee;
select rpad(email,10,'O') as rpad from employee;
--trim - 포함된 문자 제거
select emp_name,ltrim(phone,'010'), rtrim(email,'@kh.or.kr') from employee;
select trim('a'from 'aaaI am a happy orangeaaa')from dual; --I am a happy orange 양 옆 제거
select ltrim('        I am a happy       orange     ',' ')from dual;
select rtrim('        I am a happy       orange     ',' ')from dual;
select ltrim('ppap I am a happy orange','p')from dual; --ap I am a happy orange

--substr
select substr('SHOWMETHEMONEY',5,2) from dual;
select substr('sunday',2,2) from dual;
select substr('sunday',2) from dual;
select substr('sunday',-1) from dual; --음수로 하면 한글자밖에 못 꺼내나..??

--lower/upper/INITCAP
SELECT lower('welcome to my WORLD')from dual;--welcome to my world
SELECT upper('welcome to my WORLD')from dual;--WELCOME TO MY WORLD
SELECT INITCAP('welcome to my WORLD')from dual;--Welcome To My World

--concat
select concat('ABCDE','가나다라')from dual;
select 'ABCDE'||'가나다라'from dual;
--replace
select replace('서울시 강남구','강남구','관악구입니다') from dual;

--숫자값
select abs(-10.9) 숫자값 from dual;--절댓값
select mod(10,3) 나머지 from dual; -- 나머지 1
--SELECT ABS(10.9,-3) FROM DUAL;인수의 개수가 부적합합니다

--round
select round(10.11) from dual;
select round(-10.11) from dual; -- -10
select round(10.91) from dual; -- 11
select round(-10.91) from dual; -- -11
select round(10.12945, 2) from dual; -- 10.13  반올림

--floor
select floor(10.11) from dual;
select floor(10.91) from dual; -- 10
select floor(-10.11) from dual; -- -11

--trunc
select trunc(123.456) from dual;
select trunc(123.456, 1) from dual; --123.4
select trunc(123.456, 2) from dual; --123.45
select trunc(123.456, -2) from dual; --100

--ceil
SELECT CEIL(10.11) FROM DUAL;
SELECT CEIL(-10.11) FROM DUAL; -- -10
SELECT CEIL(-10.91) FROM DUAL; -- -10

-->>>>>>>>>>>>>>>>>>>>>>날짜
--SYSDATE
SELECT SYSDATE FROM DUAL;--24/03/26
SELECT SYSTIMESTAMP FROM DUAL;--24/03/26

--꼭 기억하기 
--DUAL 테이블은 oracle에서 임의의 속성값을 확인하고 싶을 때 사용하는 테이블
select * from dual;
select 23*24 from dual; --552
select 23*24 from employee; --
select 23*24 from department; --

select sysdate, to_char(sysdate,'yyyy-mm-dd dy day hh:mi:ss') as "DATE" from dual;
select sysdate, to_char(sysdate,'yyyy"년"mm"월"dd"일" dy day hh:mi:ss') as "DATE" from dual;
-- sql은 기본적으로 작은 따옴표 사용 큰따옴표는 별칭, 따옴표 안에 따옴표를 표시할 때 사용 됨
select sysdate, to_char(sysdate,'yyyy-mm-dd dy day hh:mi:ss am') as "DATE" from dual; --오전 오후 표시
select sysdate, to_char(sysdate,'yyyy-mm-dd dy day hh24:mi:ss ') as "DATE" from dual; --24시 단위
--to_date
select to_date('2024/05-22' , 'yyyy/mm-dd')from dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?

select to_date('2024/05-22' , 'yyyy/mm-dd'), months_between(sysdate, to_date('2024/05-26' , 'yyyy/mm-dd')) as"날짜" from dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?
select to_date('2024/05-22' , 'yyyy/mm-dd') "날짜", months_between( to_date('2024/05-26' , 'yyyy/mm-dd'),sysdate)as"날짜",extract(month from sysdate)as"오늘의 달" from dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?

--MONTHS_BETWEEN
SELECT EMP_NAME, HIRE_DATE,
 MONTHS_BETWEEN(SYSDATE, HIRE_DATE) 먼스비트윈 --근무 개월 수
 FROM EMPLOYEE;
 
 --ADD_MONTHS
 SELECT EMP_NAME, HIRE_DATE,
 ADD_MONTHS(HIRE_DATE, 6) as "6개월" --입사 후 6개월
 FROM EMPLOYEE;
 
 --NEXT_DAY
 select sysdate,next_day(sysdate,'월요일')from employee;
  select sysdate,next_day(sysdate,2)from employee; --일요일 : 1
  
--last-day
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
 FROM EMPLOYEE;
 
 --extract
 SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) YEAR, --고용 날 중에서 year
 EXTRACT(MONTH FROM HIRE_DATE) MONTH, --고용 날 중에서 month
 EXTRACT(DAY FROM HIRE_DATE) DAY
 FROM EMPLOYEE;
 
select emp_name, EXTRACT(YEAR from hire_date)as "year",
extract(month from hire_date) as "month",
extract(day from hire_date) as"day" from EMPLOYEE;

--형변환 함수 to_char
select emp_name, to_char(hire_date,'yy-mm-dd')"-",
to_char(hire_date,'yy/mon, day  dy') "2번" from employee;

select emp_no, hire_date from employee where hire_date> to_date(20000101,'yyyy-mm-dd');
SELECT EMP_NAME,
TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'),
 TO_CHAR(HIRE_DATE, 'YY/MON, DAY, DY')
 FROM EMPLOYEE;
 
 --to_char에서 date 처럼 표현 방식을 바꿀 수 있다
 select emp_no, to_char(salary,'L999,999,999'),to_char(salary,'000,000,000') from employee;
 
 --to_date
 SELECT EMP_NO, EMP_NAME, HIRE_DATE
 FROM EMPLOYEE
 WHERE HIRE_DATE > TO_DATE(20000101,'yyyy-mm-dd');
 
 --to_number
 SELECT TO_NUMBER('1,000,000', '99,999,999') -TO_NUMBER('550,000', '999,999')
 FROM DUAL;

--nvl null로 되어 있는 칼럼의 값을 인자로 지정한 숫자 혹은 문자로 변경하여 반환
select emp_no
