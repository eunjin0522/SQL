--create index indexnmae on table tname(col,func,..);

--고유 unique
create unique index IDX_EMPNO on employee(EMP_NO);
select * from user_ind_columns where table_name ='EMPOYEE';

 CREATE UNIQUE INDEX IDX_DEPTCODE
 ON EMPLOYEE(DEPT_CODE); --UNIQUE INDEX는중복값이있는컬럼에생성시에러발생

--비고유
 CREATE INDEX IDX_DEPTCODE
 ON EMPLOYEE(DEPT_CODE); --그냥 INDEX는중복값이 있어도 생성 

 SELECT * FROM USER_IND_COLUMNS
 WHERE TABLE_NAME = 'EMPLOYEE';

--결합
create index IDX_DEPT
on department(dept_id,dept_title);

 SELECT * FROM USER_IND_COLUMNS
 WHERE TABLE_NAME = 'DEPARTMENT';