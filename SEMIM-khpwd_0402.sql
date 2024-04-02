alter session set "_ORACLE_SCRIPT"=TRUE;
create user SEMIM identified by khpwd;
grant connect,resource,UNLIMITED TABLESPACE, create view to SEMIM;