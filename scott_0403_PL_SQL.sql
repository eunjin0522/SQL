-----------PL/SQL 
--conn session 연결 후 한 번만 실행 - session 끊어지고 다시 접속하면 off상태임
--console 창 처럼 디버깅 창에 결과를 볼 수 있게 해준다
set serveroutput ON; --on은 한번만 설정하면 된다

---sql developer 프로그램    메뉴 보기 > DBMS출력 창으로 확인하기
---DBMS에서 output으로 내보내는 것만 출력해준다

----PL/SQL 기본 모양
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO world');
END;
/ 
--- 슬레시는 여기서 프로시저를 끝내겠다는 의미

declare
    v_empno emp.empno%TYPE;
    v_empname emp.ename%TYPE;
begin
    dbms_output.put_line('------select 앞');
    select empno, ename
    into v_empno,v_empname
    from emp
    where empno='&empno값을넣어라';
    --where empno=7788; 
    dbms_output.put_line('------ 뒤');
    dbms_output.put_line(v_empno || ' : '||v_empname);
    commit;
end;
/

--------- 배열
declare
    --table  = 배열 = ArrayList 이라고 생각합시다
    TYPE empno_table_type IS TABLE OF emp.empno%TYPE INDEX BY BINARY_INTEGER;
    v_arr_no    empno_table_type;
    TYPE empname_table_type IS TABLE OF  emp.ename%TYPE INDEX BY BINARY_INTEGER;
    v_arr_name  empname_table_type;
    
      v_idx BINARY_INTEGER := 0;
begin
    dbms_output.put_line(v_idx);
    for vo  in  (select empno, ename from emp)  loop  --emp테이블에서 한 행을 꺼내서 vo에 넣는다 vo의 자료형 : emp
       --반복되는 부분
       dbms_output.put_line(vo.empno);
      -- v_arr_no(v_idx) := vo.empno;
        v_idx := v_idx +1; --증감식을 위로 배치함 얘는 범위가 <= 이기 때문
        v_arr_no(v_idx) := vo.empno;
        v_arr_name(v_idx) := vo.ename;
       
       dbms_output.put_line(v_idx || ' : '||v_arr_no(v_idx)||' : '||v_arr_name(v_idx));
    end loop;
    
    dbms_output.put_line('------v_idx : '||v_idx);
    for i in 1..v_idx loop
    dbms_output.put_line(v_arr_no(i));
    end loop;
    commit;
end;
/


begin
        for i in 2..9 loop
            for j in 2..9 loop
            dbms_output.put_line(i||'* '||j||'   '||i*j);
            end loop;
        end loop;
        commit;
end;
/
select * from emp;
----------------------ppt13 예시 
DECLARE
    V_EMPNO EMP.EMPNO%TYPE;
    V_ENAME EMP.ENAME%TYPE;
BEGIN
    SELECT EMPNO,ENAME
    INTO V_EMPNO,V_ENAME
    FROM EMP
    WHERE EMPNO = 7521 ;
    dbms_output.put_line(V_EMPNO);
   -- dbms_output.put_line(V_ENAME);
   commit;
END;
/

DECLARE
    e emp%rowtype;
BEGIN
    select * into e
    from emp
    where empno = '&emp_no';
    dbms_output.put_line('emp_no : '||e.empno);
    dbms_output.put_line('NAME : '||e.ename);
    dbms_output.put_line('SALARY : '||e.sal);
    commit;
end;
/
SELECT * FROM USER_TAB_COLUMNS;

DECLARE
--type 선언
    TYPE VO_ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;
    TYPE VO_SAL_TABLE_TYPE IS TABLE OF EMP.SAL%TYPE INDEX BY BINARY_INTEGER;
--변수 선언
    VO_ENAME VO_ENAME_TABLE_TYPE;
    VO_SAL VO_SAL_TABLE_TYPE;
    IDX BINARY_INTEGER := 0;
BEGIN
    FOR K IN (SELECT ename,sal FROM EMP) LOOP
        IDX := IDX + 1;
        VO_ENAME(IDX) := K.ename;
        VO_SAL(IDX) := K.sal;
        DBMS_OUTPUT.PUT_LINE('ename : '||VO_ENAME(IDX));
        DBMS_OUTPUT.PUT_LINE('sal : '||VO_SAL(IDX));
        
    END LOOP;
    commit;
END;
/

------------프로시저
create or replace NONEDITIONABLE PROCEDURE PROC_TEST1
IS
 AAAAK EXCEPTION;
 PRAGMA EXCEPTION_INIT(AAAAK, -00001);

 BBB_OVERFLOW EXCEPTION;
 PRAGMA EXCEPTION_INIT(BBB_OVERFLOW, -01438); -----??

 BEGIN
 UPDATE EMP 
SET EMPNO= 300
 WHERE ENAME= 206; -- 사번 206을 입력한 사번으로 바꾸겠다. 테이블에 이미 있는 사번을 넣으면 예외값 처리된다
 EXCEPTION
 WHEN AAAAK
 THEN DBMS_OUTPUT.PUT_LINE('이미존재하는사번입니다.');
  WHEN BBB_OVERFLOW
 THEN DBMS_OUTPUT.PUT_LINE('넘친다!!!4자리를 넣자');
     commit;
 END;
/
---
create or replace PROCEDURE PRO_SELECT_EMPNO(
    V_EMPNO  in   EMP.EMPNO%TYPE, --in 값은 들어와 있다
    V_ENAME  out  EMP.ENAME%TYPE, --out 값은 없을 것이다. 네가 나중에 채우면 호출한 곳으로 출력해줄게
    V_SAL    out  EMP.SAL%TYPE,
    V_COMM   out  EMP.COMM%TYPE)
IS
BEGIN
    select ename,sal,comm 
    into V_ENAME,V_SAL,V_COMM
    from emp
    where empno=V_EMPNO;
        commit;
END;
/
variable a_name varchar2(100);
variable a_sal number;
variable a_comm number;
exec PRO_SELECT_EMPNO(7788,:a_name,:a_sal,:a_comm);
print a_name;
print a_sal;
print a_comm;
