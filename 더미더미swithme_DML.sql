--더미 회원 만들기 MEMBER 테이블
insert into member values('song','swith','swithall@gmail.com',default,'모두스윗해지세요',default);
insert into member values('oh','swith','ohall@gmail.com',default,'저는 달콤이혜효',default);
insert into member values('kim','swith','kimall@gmail.com',default,'집보내줘요',default);
insert into member values('hyuk','swith','hyukall@gmail.com',default,'모두스윗포테이토되세요',default);

insert into member values('seo','swith','seoall@gmail.com',default,'문라익춘식',default);
insert into member values('hyo','swith','hyoall@gmail.com',default,'이거메가박스아녜요',default);
insert into member values('bae','swith','baeall@gmail.com',default,'햄버거는 멕도날드',default);
insert into member values('won','swith','wonall@gmail.com',default,'뼛속까지 ISFP',default);
insert into member values('jun','swith','junall@gmail.com',default,'환영합니다',default);


select * from member;

--SUBJECT 더미
-- 핑크 1, 연두 2, 노랑 3, 파랑 4, 보라 5
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','JAVA',default,null,1);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','C#',default,null,2);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','python',default,null,3);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','토익',default,null,4);
insert into subject values(SEQ_SUBJECT_ID.nextval,'song','spring',default,null,5);

insert into subject values(SEQ_SUBJECT_ID.nextval,'hyuk','C#',default,null,1);
insert into subject values(SEQ_SUBJECT_ID.nextval,'hyuk','HTML',default,null,3);
insert into subject values(SEQ_SUBJECT_ID.nextval,'hyuk','천칭',default,null,5);

insert into subject values(SEQ_SUBJECT_ID.nextval,'oh','토플',default,null,2);
insert into subject values(SEQ_SUBJECT_ID.nextval,'oh','토익',default,null,4);
insert into subject values(SEQ_SUBJECT_ID.nextval,'oh','게시판만들기',default,null,3);
insert into subject values(SEQ_SUBJECT_ID.nextval,'oh','수학',default,null,1);

insert into subject values(SEQ_SUBJECT_ID.nextval,'kim','spring',default,null,5);
insert into subject values(SEQ_SUBJECT_ID.nextval,'kim','수학',default,null,1);

-- 한 사람당 과목 5개씩
EXEC PRO_SUBJECT_INSERT('seo','A_',5); 
EXEC PRO_SUBJECT_INSERT('hyo','B_',3); 
EXEC PRO_SUBJECT_INSERT('bae','C_',5); 
EXEC PRO_SUBJECT_INSERT('won','D_',5); 
EXEC PRO_SUBJECT_INSERT('jun','E_',4); 

select * from SUBJECT;

---record 더미 값 추가
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='python') 
    ,'song',(SELECT TO_DATE('2024-04-08 12:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 17:30:53', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='JAVA') 
    ,'song',(SELECT TO_DATE('2024-04-08 18:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 20:30:47', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='토익') 
    ,'song',(SELECT TO_DATE('2024-04-08 06:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='토익') 
    ,'song',(SELECT TO_DATE('2024-04-08 09:50:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 11:23:22', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='song' and subject_name='spring') 
    ,'song',(SELECT TO_DATE('2024-04-08 08:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 09:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));

--------

insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-08 12:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 17:30:53', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='HTML') 
    ,'hyuk',(SELECT TO_DATE('2024-04-08 18:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 20:30:47', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='천칭') 
    ,'hyuk',(SELECT TO_DATE('2024-04-08 06:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-08 09:50:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-08 11:23:22', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='HTML') 
    ,'hyuk',(SELECT TO_DATE('2024-04-08 08:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 09:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));

-------------------------------------04-09 hyuk
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-09 12:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 17:30:53', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='HTML') 
    ,'hyuk',(SELECT TO_DATE('2024-04-09 18:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 20:30:47', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='천칭') 
    ,'hyuk',(SELECT TO_DATE('2024-04-09 06:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-09 09:50:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 11:23:22', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='천칭') 
    ,'hyuk',(SELECT TO_DATE('2024-04-09 08:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 09:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
--------------------------------------------
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-10 12:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 17:30:53', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='HTML') 
    ,'hyuk',(SELECT TO_DATE('2024-04-10 18:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 20:30:47', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='천칭') 
    ,'hyuk',(SELECT TO_DATE('2024-04-10 06:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='C#') 
    ,'hyuk',(SELECT TO_DATE('2024-04-10 09:50:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 11:23:22', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));
insert into record values(SEQ_RECORD_ID.nextval
    ,(select SUBJECT_ID from SUBJECT where mem_id='hyuk' and subject_name='HTML') 
    ,'hyuk',(SELECT TO_DATE('2024-04-10 08:30:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),(SELECT TO_DATE('2024-04-09 09:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual));




select * from RECORD  order by  record_mem_id,record_start ;

--exec PRO_RECORD_INSERT('hyuk',12,'10');