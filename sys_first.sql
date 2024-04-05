alter session set "_ORACLE_SCRIPT"=true;
create user kh identified by khpwd;
--상태: 실패 -테스트 실패: ORA-01045: 사용자 KH는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
--CREATE SESSION 권한을 줘야함 권한 : GRANT
--생성과 권한 부여는 따로따로 실행 됨 : 얘 깡통이야..
--grant CREATE SESSION to kh;
--권한 뺏기
--revoke CREATE SESSION from kh;
create user kh2 identified by khpwd;
--connect는 create를 포함하고 있다 , 여러 권한을 여러 명에 줄 수 있음
grant connect, resource, unlimited tablespace to kh,kh2;
--resource : 개체 생성, 삭제 권한부여
create user kh3 identified by khpwd;


create user ej identified by ejpwd;
grant connect, resource, unlimited tablespace to ej;
revoke create session from ej ;
create user ej identified by pwd;

grant connect, resource, unlimited tablespace to ej;
revoke connect from ej ; --줬던 권한 그대로 선언해서 권한을 회수해야한다
revoke resource from ej;
revoke unlimited tablespace from ej;

create user quiz identified by quiz;
grant connect, resource, unlimited tablespace to  quiz;

create user chun identified by chunpwd;
grant connect,resource,unlimited tablespace to chun;

grant create view to scott,kh,kh2; --view만들 권한 부여
grant create view to chun;
--암기
--create user 유저명 identified by 비밀번호;  : 계정 생성
--grant 권한명, 롤명,... to 유저명1,유저명2...,롤명; 
--revoke 뺏고싶은 권한 명, 롤명 ... from 유저명or 롤명,... : 권한 뺏기
--connect : 접속관련 권한들로 만들어진 롤명
--resource : 테이블(객체)관련 권한들로 만들어진 롤명

alter session set "_ORACLE_SCRIPT"=TRUE;
CREATE USER SEMIMM IDENTIFIED BY khpwd;
GRANT CONNECT,RESOURCE, UNLIMITED TABLESPACE TO SEMIMM;


