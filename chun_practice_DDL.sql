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