--더미 회원 만들기 MEMBER 테이블
insert into member values('song','swith','swithall@gmail.com',default,'모두스윗해지세요',default);
insert into member values('oh','swith','ohall@gmail.com',default,'저는 달콤이혜효',default);
insert into member values('kim','swith','kimall@gmail.com',default,'집보내줘요',default);
insert into member values('hyuk','swith','hyukall@gmail.com',default,'모두스윗포테이토되세요',default);
insert into member values('seo','swith','seoall@gmail.com',default,'문라익춘식',default);
insert into member values('hyo','swith','hyoall@gmail.com',default,'이거메가박스아녜요',default);

select * from member;

--SUBJECT 더미
-- 핑크 1, 연두 2, 노랑 3, 파랑 4, 보라 5
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','JAVA',default,null,1);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','python',default,null,3);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','토익',default,null,4);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','spring',default,null,5);

insert into subject values(SEQ_SUBJECT_ID.nextval,'hyuk','C#',default,null,1);
insert into subject values(SEQ_SUBJECT_ID.nextval,'hyuk','HTML',default,null,3);
insert into subject values(SEQ_SUBJECT_ID.nextval,'oh','토익',default,null,4);
insert into subject values(SEQ_SUBJECT_ID.nextval,'seo','spring',default,null,5);

select * from subject;

insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='python') 
    ,'song',(SELECT TO_DATE('2024-04-08 12:30:15', 'YYYY-MM-DD HH24:MI:SS') AS start_date FROM dual),default);
select * from record;