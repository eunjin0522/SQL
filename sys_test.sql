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
grant connect, resource to kh,kh2;
create user kh3 identified by khpwd;
--암기
--create user 유저명 identified by 비밀번호;  : 계정 생성
--grant 권한명, 롤명,... to 유저명1,유저명2...,롤명; 
--revoke 뺏고싶은 권한 명, 롤명 ... from 유저명or 롤명,... : 권한 뺏기
--connect : 접속관련 권한들로 만들어진 롤명
--resource : 테이블(객체)관련 권한들로 만들어진 롤명