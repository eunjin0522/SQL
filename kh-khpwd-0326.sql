SELECT
    *
FROM
    employee;

SELECT
    *
FROM
    department;

SELECT
    *
FROM
    location;

SELECT
    *
FROM
    national;

SELECT
    emp_name,
    salary * 12                             year,
    ( salary + ( salary * bonus ) ) * 12            AS "calc"
FROM
    employee;

SELECT
    emp_id,
    salary,
    salary || '원' AS ex
FROM
    employee;

SELECT DISTINCT
    dept_code,
    job_code
FROM
    employee;

SELECT
    job_code
FROM
    employee
WHERE
    dept_code = 'D9'; 
--select emp_name, salary from employee where salary>'4000000z'; 오류 발생

SELECT
    emp_name,
    dept_code,
    salary
FROM
    employee
WHERE
        dept_code = 'D6'
    AND salary > '2000000';
--부서코드가‘D6’이거나 급여를2000000보다 많이 받는 직원의 이름, 부서코드, 급여조회

SELECT
    emp_name,
    dept_code,
    salary
FROM
    employee
WHERE
    dept_code = 'D6'
    OR salary > '2000000';

SELECT
    emp_name,
    dept_code,
    salary
FROM
    employee
WHERE
    NOT ( salary > '2000000' );

SELECT
    emp_name,
    dept_code,
    salary
FROM
    employee
WHERE
    dept_code <> 'D9';
--급여가 3000000보다 많고 6000000보다 작은 직원이름 조회

SELECT
    emp_name
FROM
    employee --where (salary >= 3000000) and (salary <= 6000000);
WHERE
    salary BETWEEN 3000000 AND 6000000; -- 이상 이하의 범위를 의미

--부서코드가‘D6’이거나 'D5'인 직원

SELECT
    emp_name
FROM
    employee --where dept_code='D9' or dept_code='D5';
WHERE
    dept_code IN (
        'D9',
        'D5'
    ); 

--부서코드가‘D6’나 'D5'가 아닌 직원

SELECT
    emp_name
FROM
    employee --where dept_code ^='D9' or dept_code ^='D5';
WHERE
    dept_code NOT IN (
        'D9',
        'D5'
    ); 

--부서코드가 없는 직원

SELECT
    emp_name
FROM
    employee
WHERE
    dept_code IS NULL;

--‘전’씨성을 가진 직원이름과 급여조회

SELECT
    emp_name,
    salary
FROM
    employee
WHERE
    emp_name LIKE '전%';

--MAIL ID 중‘_’의앞이3자리인직원이름, 이메일조회

SELECT
    emp_name,
    email
FROM
    employee
WHERE
    email LIKE '___#_%' ESCAPE '#';

--<<<<<<<<<<<<<<<<함수 >>>>>>>>>>>>>>>>
--length

SELECT
    emp_name,
    length(emp_name),
    email,
    length(email)
FROM
    employee;
--lengthb 한글 1자 : 3byte

SELECT
    emp_name,
    lengthb(emp_name),
    email,
    lengthb(email)
FROM
    employee;

--instr

SELECT
    emp_name,
    instr(email, '@', - 1, 1) 위치
FROM
    employee;

SELECT
    emp_name,
    email,
    instr(email, '.', 5, 2) 위치
FROM
    employee; --??
--앞에서5번째 글자까진 그냥 찾지마 그 다음 문자들 중에서 두번째로 있는 .을 찾아줘 
--position이 바뀐다고 return 값이 바뀌진 않음 그냥 그 범위는 안 찾는 것이다

SELECT
    instr('ABCDE', 'C', 2)
FROM
    dual; -- 3

--lpad/rpad

SELECT
    lpad(email, 20, '#') AS lpad
FROM
    employee;

SELECT
    rpad(email, 10, 'O') AS rpad
FROM
    employee;
--trim - 포함된 문자 제거

SELECT
    emp_name,
    ltrim(phone, '010'),
    rtrim(email, '@kh.or.kr')
FROM
    employee;

SELECT
    TRIM('a' FROM 'aaaI am a happy orangeaaa')
FROM
    dual; --I am a happy orange 양 옆 제거

SELECT
    ltrim('        I am a happy       orange     ', ' ')
FROM
    dual;

SELECT
    rtrim('        I am a happy       orange     ', ' ')
FROM
    dual;

SELECT
    ltrim('ppap I am a happy orange', 'p')
FROM
    dual; --ap I am a happy orange

--substr

SELECT
    substr('SHOWMETHEMONEY', 5, 2)
FROM
    dual;

SELECT
    substr('sunday', 2, 2)
FROM
    dual;

SELECT
    substr('sunday', 2)
FROM
    dual;

SELECT
    substr('sunday', - 1)
FROM
    dual; --음수로 하면 한글자밖에 못 꺼내나..??

--lower/upper/INITCAP

SELECT
    lower('welcome to my WORLD')
FROM
    dual;--welcome to my world

SELECT
    upper('welcome to my WORLD')
FROM
    dual;--WELCOME TO MY WORLD

SELECT
    initcap('welcome to my WORLD')
FROM
    dual;--Welcome To My World

--concat

SELECT
    concat('ABCDE', '가나다라')
FROM
    dual;

SELECT
    'ABCDE' || '가나다라'
FROM
    dual;
--replace

SELECT
    replace('서울시 강남구', '강남구', '관악구입니다')
FROM
    dual;

--숫자값

SELECT
    abs(- 10.9) 숫자값
FROM
    dual;--절댓값

SELECT
    mod(10, 3) 나머지
FROM
    dual; -- 나머지 1
--SELECT ABS(10.9,-3) FROM DUAL;인수의 개수가 부적합합니다

--round

SELECT
    round(10.11)
FROM
    dual;

SELECT
    round(- 10.11)
FROM
    dual; -- -10

SELECT
    round(10.91)
FROM
    dual; -- 11

SELECT
    round(- 10.91)
FROM
    dual; -- -11

SELECT
    round(10.12945, 2)
FROM
    dual; -- 10.13  반올림

--floor

SELECT
    floor(10.11)
FROM
    dual;

SELECT
    floor(10.91)
FROM
    dual; -- 10

SELECT
    floor(- 10.11)
FROM
    dual; -- -11

--trunc

SELECT
    trunc(123.456)
FROM
    dual;

SELECT
    trunc(123.456, 1)
FROM
    dual; --123.4

SELECT
    trunc(123.456, 2)
FROM
    dual; --123.45

SELECT
    trunc(123.456, - 2)
FROM
    dual; --100

--ceil

SELECT
    ceil(10.11)
FROM
    dual;

SELECT
    ceil(- 10.11)
FROM
    dual; -- -10

SELECT
    ceil(- 10.91)
FROM
    dual; -- -10

-->>>>>>>>>>>>>>>>>>>>>>날짜
--SYSDATE

SELECT
    sysdate
FROM
    dual;--24/03/26

SELECT
    systimestamp
FROM
    dual;--24/03/26

--꼭 기억하기 
--DUAL 테이블은 oracle에서 임의의 속성값을 확인하고 싶을 때 사용하는 테이블

SELECT
    *
FROM
    dual;

SELECT
    23 * 24
FROM
    dual; --552

SELECT
    23 * 24
FROM
    employee; --

SELECT
    23 * 24
FROM
    department; --

SELECT
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd dy day hh:mi:ss') AS "DATE"
FROM
    dual;

SELECT
    sysdate,
    to_char(sysdate, 'yyyy"년"mm"월"dd"일" dy day hh:mi:ss') AS "DATE"
FROM
    dual;
-- sql은 기본적으로 작은 따옴표 사용 큰따옴표는 별칭, 따옴표 안에 따옴표를 표시할 때 사용 됨

SELECT
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd dy day hh:mi:ss am') AS "DATE"
FROM
    dual; --오전 오후 표시

SELECT
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd dy day hh24:mi:ss ') AS "DATE"
FROM
    dual; --24시 단위
--to_date

SELECT
    TO_DATE('2024/05-22', 'yyyy/mm-dd')
FROM
    dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?

SELECT
    TO_DATE('2024/05-22', 'yyyy/mm-dd'),
    months_between(sysdate, TO_DATE('2024/05-26', 'yyyy/mm-dd')) AS "날짜"
FROM
    dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?

SELECT
    TO_DATE('2024/05-22', 'yyyy/mm-dd')                                  "날짜",
    months_between(TO_DATE('2024/05-26', 'yyyy/mm-dd'), sysdate)         AS "날짜",
    EXTRACT(MONTH FROM sysdate)                                           AS "오늘의 달"
FROM
    dual; --앞의 것이 뒤의 모양으로 되어있을거야 날짜 모양으로 바꿔줄래?

--MONTHS_BETWEEN

SELECT
    emp_name,
    hire_date,
    months_between(sysdate, hire_date) 먼스비트윈 --근무 개월 수
FROM
    employee;
 
 --ADD_MONTHS

SELECT
    emp_name,
    hire_date,
    add_months(hire_date, 6) AS "6개월" --입사 후 6개월
FROM
    employee;
 
 --NEXT_DAY

SELECT
    sysdate,
    next_day(sysdate, '월요일')
FROM
    employee;

SELECT
    sysdate,
    next_day(sysdate, 2)
FROM
    employee; --일요일 : 1
  
--last-day

SELECT
    emp_name,
    hire_date,
    last_day(hire_date)
FROM
    employee;
 
 --extract

SELECT
    emp_name,
    EXTRACT(YEAR FROM hire_date)      year, --고용 날 중에서 year
    EXTRACT(MONTH FROM hire_date)     month, --고용 날 중에서 month
    EXTRACT(DAY FROM hire_date)       day
FROM
    employee;

SELECT
    emp_name,
    EXTRACT(YEAR FROM hire_date)      AS "year",
    EXTRACT(MONTH FROM hire_date)     AS "month",
    EXTRACT(DAY FROM hire_date)       AS "day"
FROM
    employee;

--형변환 함수 to_char

SELECT
    emp_name,
    to_char(hire_date, 'yy-mm-dd')              "-",
    to_char(hire_date, 'yy/mon, day  dy')       "2번"
FROM
    employee;

SELECT
    emp_no,
    hire_date
FROM
    employee
WHERE
    hire_date > to_date(20000101, 'yyyy-mm-dd');

SELECT
    emp_name,
    to_char(hire_date, 'YYYY-MM-DD'),
    to_char(hire_date, 'YY/MON, DAY, DY')
FROM
    employee;
 
 --to_char에서 date 처럼 표현 방식을 바꿀 수 있다

SELECT
    emp_no,
    to_char(salary, 'L999,999,999'),
    to_char(salary, '000,000,000')
FROM
    employee;
 
 --to_date

SELECT
    emp_no,
    emp_name,
    hire_date
FROM
    employee
WHERE
    hire_date > to_date(20000101, 'yyyy-mm-dd');
 
 --to_number

SELECT
    to_number('1,000,000', '99,999,999') - to_number('550,000', '999,999')
FROM
    dual;

--nvl null로 되어 있는 칼럼의 값을 인자로 지정한 숫자 혹은 문자로 변경하여 반환

SELECT
    emp_no,
    emp_name,
    salary,
    nvl(bonus, 0),
    ( salary + ( salary * nvl(bonus, 0) ) ) * 12
FROM
    employee;

-- avg

SELECT
    floor(AVG(salary))
FROM
    employee
WHERE
    substr(emp_no, 8, 1) = 1;

--sum

SELECT
    SUM(salary)
FROM
    employee
WHERE
    substr(emp_no, 8, 1) = 1;

SELECT
    emp_name,
    SUM(salary) AS 합계
FROM
    employee;

--max/min

SELECT
    MAX(hire_date),
    MIN(hire_date)
FROM
    employee;

--count

SELECT
    COUNT(*)
FROM
    employee; --전체 사원 수 조회
--EMPLOYEE테이블에서부서코드가D5인직원의수조회

SELECT
    COUNT(dept_code)
FROM
    employee
WHERE
    dept_code = 'D5';

--EMPLOYEE테이블에서사원들이속해있는부서의수조회

SELECT
    COUNT(DISTINCT dept_code)
FROM
    employee;

-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>03/27
--decode

SELECT
    emp_id,
    emp_name,
    decode(substr(emp_no, 8, 1), '2', '여성', 1, '남') AS 성별
FROM
    employee;

--case when

SELECT
    emp_name,
    CASE
        WHEN substr(emp_no, 1, 1) = 6           THEN
            '60년생'
        WHEN substr(emp_no, 1, 1) = 7           THEN
            '70년생'
        ELSE
            'PASS'
    END "n년생"
FROM
    employee;

SELECT
    emp_name,
    decode(substr(emp_no, 1, 1), '6', '60년생', 7, '70년생',
           'pass') 몇년생
FROM
    employee;


--group by

SELECT
    SUM(salary) 평균,
    job_code,
    dept_code
FROM
    employee
GROUP BY
    job_code,
    dept_code;


--order by

SELECT
    *
FROM
    employee
--order by emp_name desc
--order by dept_code nulls first;
ORDER BY
    dept_code ASC,
    job_code,
    salary DESC;

SELECT
    *
FROM
    employee
ORDER BY
    dept_code ASC,
    salary DESC;

SELECT
    emp_name,
    dept_code,
    job_code,
    salary,
    ( salary + ( salary * nvl(bonus, 0) ) ) * 12 AS a1
FROM
    employee
WHERE
    dept_code IS NOT NULL
 --   and a1 > 30000000  --error 왜냐 ! 컬럼 별칭은 orderby에서만 쓸 수 있기 때문
    AND ( salary + ( salary * nvl(bonus, 0) ) ) * 12 > 30000000
--view 생성 또는 subQuery 를 사용하여 출력시간을 줄여야함 -> 위의 코드는 연산을 두 번 하게 되는 현상임
ORDER BY
    a1 DESC;

--having
--1.번

SELECT
    dept_code,
    floor(AVG(salary)) AS 평균
FROM
    employee
WHERE
    dept_code IS NOT NULL
GROUP BY
    dept_code
HAVING
    floor(AVG(salary)) >= 3000000
ORDER BY
    dept_code;

--2.번

SELECT
    dept_code,
    floor(AVG(salary)) AS 평균
FROM
    employee 
--where dept_code is not null
GROUP BY
    dept_code
--having floor(avg(salary)) >= 3000000
HAVING
    dept_code IS NOT NULL -- 그룹을 먼저 속아내는 것을 where에 먼저 넣자 where가 가장먼저 실행됨
ORDER BY
    dept_code;

SELECT
    salary,
    emp_name
FROM
    employee
ORDER BY
    salary DESC;

--group by

SELECT
    dept_code,
    SUM(salary)
FROM
    employee 
--group by가 없으면 sum(그룹함수)aks select 앞에 쓸 수 있다
GROUP BY
    dept_code,
    job_code; -- dept_code와 jop_code를 기준으로 하여 그룹을 묶는다

SELECT
    dept_code,
    SUM(salary)               합계,
    floor(AVG(salary))        평균,
    COUNT(*)                  인원수
FROM
    employee
GROUP BY
    dept_code
ORDER BY
    dept_code ASC;

SELECT
    dept_code,
    COUNT(bonus)
FROM
    employee
WHERE
    bonus IS NOT NULL
GROUP BY
    dept_code
ORDER BY
    dept_code ASC;

SELECT
    decode(substr(emp_no, 8, 1), 1, 'M', 2, 'W')                    성별,
    floor(AVG(salary))                                        평균,
    SUM(salary)                                               합계,
    COUNT(*)                                                  인원수
FROM
    employee
GROUP BY
    decode(substr(emp_no, 8, 1), 1, 'M', 2, 'W')
ORDER BY
    4 DESC;

--rollup cube    
select dept_code, job_code,floor(avg(salary)),count(*)
from employee
--group by cube(dept_code,job_code)
group by rollup(dept_code,job_code) --잡코드를 기준으로 dept가 다른 애들끼리 묶어줘
order by 1;

--select dept_code, job_code,sum(salary) from employee

--해보기
select dept_code,job_code,
decode(grouping(job_code),1,decode(GROUPING(dept_code),1,'총합','부서별 합계'),decode(GROUPING(dept_code),1,'직급별','a')) as a
,sum(salary) from employee
group by cube(job_code,dept_code) order by 1;

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
 UNION
 SELECT '', JOB_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY 1;
 
 --sum으로 나오다가 a 부분은 AVG로 나옴 컬럼명도 select에 있는 컬럼명으로 나옴
 --avg의 컬럼 명이 sum으로 나옴
 --union : 각각의 select를 산출한 후 합쳐서 출력
 SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
 UNION
 SELECT 'a', JOB_CODE, AVG(SALARY)
 FROM EMPLOYEE
 GROUP BY ROLLUP(JOB_CODE)
 ORDER BY 1; --첫번째 컬럼을 기준으로 나열
 
 --grouping sets
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
 FROM EMPLOYEE
 GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
 (DEPT_CODE, MANAGER_ID), 
(JOB_CODE, MANAGER_ID));


SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY(DEPT_CODE, JOB_CODE, MANAGER_ID);
SELECT DEPT_CODE, 'j', MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY(DEPT_CODE, MANAGER_ID);
SELECT 'd', JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY)) FROM EMPLOYEE GROUP BY(JOB_CODE, MANAGER_ID);