--1.
create table TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN char(1) default 'Y'
);

--2.
create table TB_CLASS_TYPE (
    NO VARCHAR2(5) primary key,
    NAME char(10) 
);

--3.
alter table TB_CATEGORY
add CONSTRAINT TCATE_NAME_PK primary key(name);


--4.
alter table TB_CLASS_TYPE
modify NAME CONSTRAINT TCTYP_NAME_NN not null;

--5.
ALTER TABLE TB_CLASS_TYPE
modify NO VARCHAR2(10);

ALTER TABLE TB_CATEGORY
modify NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
modify NAME VARCHAR2(20);

--6.
ALTER TABLE TB_CLASS_TYPE
rename column NO to CLASS_NO;
ALTER TABLE TB_CLASS_TYPE
rename column NAME to CLASS_NAME;
ALTER TABLE TB_CATEGORY
rename column NAME to  CATEGORY_NAME;

--7.
ALTER TABLE TB_CLASS_TYPE
rename column  CLASS_NAME to PK_CLASS_NAME;

--8.
insert into TB_CATEGORY values('공학','Y');
insert into TB_CATEGORY values('자연과학','Y');
insert into TB_CATEGORY values('의학','Y');
insert into TB_CATEGORY values('예체능','Y');
insert into TB_CATEGORY values('인문사회','Y');

--9.
alter table TB_DEPARTMENT 
add constraint DEPT_CATE_FK  foreign key (CATEGORY) references TB_CATEGORY (CATEGORY_NAME);

--10.
create view VW_학생일반정보 as
select student_no, student_name,student_address
from tb_student;
