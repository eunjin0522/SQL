---------------------------------SEMIM BOARD DDL


----&기호가 대체입력창이 아니라 문자 그대로 동작하도록 함
set define off;
--set feedback off; -> 삭제 갱신 등의 내용을 출력하지 않음 :속도가 조금 향상됨
-- prompt 내용 : prompt창에 내용 출력


--DROP TABLE "LOGIN_LOG";
--DROP TABLE "BOARD_REPLY";
--DROP TABLE "BOARD_REPORT";
--DROP TABLE "BOARD_FILE";
--DROP TABLE "BOARD";
--DROP TABLE "MEMBER";
---INSERT순서는 DROP반대순서

--------------TABLE MEMBER insert
--MEM_ID    NOT NULL VARCHAR2(20)  
--MEM_PWD   NOT NULL VARCHAR2(20)  
--MEM_EMAIL NOT NULL VARCHAR2(100) 
DESC MEMBER;
INSERT INTO MEMBER VALUES('kh1','pwd1','kh1@a.com'); --회원가입한 유저들
INSERT INTO MEMBER VALUES('kh2','pwd2','kh2@a.com');
INSERT INTO MEMBER VALUES('kh3','pwd3','kh3@a.com');
INSERT INTO MEMBER VALUES('kh4','pwd4','kh4@a.com');
INSERT INTO MEMBER VALUES('kh5','pwd5','kh5@a.com');

COMMIT;
select * from member;

--------------TABLE BOARD insert
--BOARD_ID     NOT NULL NUMBER         
--SUBJECT      NOT NULL VARCHAR2(120)  
--CONTENT      NOT NULL VARCHAR2(4000) 
--WRITE_TIME   NOT NULL TIMESTAMP(6)   
--LOG_IP                VARCHAR2(15)   
--BOARD_WRITER NOT NULL VARCHAR2(20)    
--READ_COUNT   NOT NULL NUMBER   
DESC BOARD;
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval,'제목1','내용1',DEFAULT,'127.0.0.1','kh1',default); --SEQ_BOARD_ID.nextval가 게시글 옆에 있는 게시글 번호
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval,'제목2','내용2',DEFAULT,'127.0.0.1','kh2',default);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval,'제목3','내용3',DEFAULT,'127.0.0.1','kh3',default);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval,'제목4','내용4',DEFAULT,'127.0.0.1','kh4',default);
INSERT INTO BOARD VALUES(SEQ_BOARD_ID.nextval,'제목5','내용5',DEFAULT,'127.0.0.1','kh5',default);

select * from BOARD order by write_time desc; --최신순으로 댓글 나열

-------------TABLE BOARD_REPLY insert
desc BOARD_REPLY;
--BOARD_REPLY_ID         NOT NULL NUMBER         
--BOARD_ID               NOT NULL NUMBER         
--MEM_ID                 NOT NULL VARCHAR2(20)   
--BOARD_REPLY_CONTENT    NOT NULL VARCHAR2(4000) 
--BOARD_REPLY_WRITE_TIME NOT NULL TIMESTAMP(6)   
--BOARD_REPLY_LOG_IP              VARCHAR2(15)   
--BOARD_REPLY_LEVEL      NOT NULL NUMBER(2)      
--BOARD_REPLY_REF        NOT NULL NUMBER         
--BOARD_REPLY_STEP                NUMBER(3)    

--BOARD_ID 5:댓글 달기1 :원본글 :댓글인 애들은 다 dufault값이 된다
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','댓글1',DEFAULT,NULL,
    DEFAULT,(SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),DEFAULT);
    
SELECT * FROM board_reply;

--1번 댓글에 대댓글 달기 STEP부분이 중요합니다 이부분을 UPDATE한 후 댓글을 보여줄 수 있어요

INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','대댓글1',DEFAULT,NULL,
    2,1,2);
    
--1번 댓글에 대대댓글 달기
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','대대댓글1',DEFAULT,NULL,
    3,1,3);

--1번 댓글에 대댓글 달기
--INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
--    ,'kh1','대댓글2',DEFAULT,NULL,
--    2,1,2);

--댓글 달기 2
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','댓글2',DEFAULT,NULL,
    1,(SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),1);

--댓글 달기 3
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','댓글3',DEFAULT,NULL,
    1,(SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),1);
    
--1번 댓글에 대댓글 달기 STEP부분이 중요합니다 STEP부분을 UPDATE한 후 댓글을 보여줄 수 있어요 -원래 값보다 1씩 증가됨
UPDATE board_reply SET board_reply_step= board_reply_step+1 WHERE BOARD_REPLY_STEP>1; --대댓글 달기전 STEP 번호 밀기
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','대댓글2<댓글1에 달리는>',DEFAULT,NULL,
    2,1,2);
    --ROLLBACK;
    
----ID가 6인 대댓글2에 대대댓글을 달자 
UPDATE BOARD_REPLY SET board_reply_step= board_reply_step+1 WHERE 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 6) 
    AND 
    BOARD_REPLY_STEP > (SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 6); --WHERE 뒤 숫자가 중요
INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','대대댓글2',DEFAULT,NULL,
    3,1,3);
    --ROLLBACK;
----5에 댓글
UPDATE BOARD_REPLY SET board_reply_step= board_reply_step+1 WHERE
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5)
    AND
    BOARD_REPLY_STEP> (SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 5);

INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','5번에 또 달기',DEFAULT,NULL,
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID=5),
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID=5),
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID=5));
----4에 댓글
UPDATE BOARD_REPLY SET board_reply_step= board_reply_step+1 WHERE 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 4)
    AND
    BOARD_REPLY_STEP>(SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 4);

INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','4번에 또 달기',DEFAULT,NULL,
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID=4),
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID=4),
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID=4));
    
----9에 댓글 --대대댓글
UPDATE BOARD_REPLY SET board_reply_step= board_reply_step+1 WHERE 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9)
    AND
    BOARD_REPLY_STEP>(SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9);

INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','9번에 또 달기',DEFAULT,NULL,
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9),
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9),
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9));
    
----9에 댓글 -2번째 달기 --대대댓글
UPDATE BOARD_REPLY SET board_reply_step= board_reply_step+1 WHERE 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9)
    AND
    BOARD_REPLY_STEP>(SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 9);

INSERT INTO BOARD_REPLY VALUES((SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY),5
    ,'kh1','9번에 또 달기2',DEFAULT,NULL,
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9),
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9),
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID=9));
--새 댓글 달기

INSERT INTO BOARD_REPLY VALUES((select nvl(max(BOARD_REPLY_ID),0)+1 from BOARD_REPLY),5,'kh1','댓글달기',DEFAULT,null,1,(select nvl(max(BOARD_REPLY_ID),0)+1 from BOARD_REPLY),1);

--새 댓글에 대댓글 달기
--step update
update board_reply set board_reply_step=board_reply_step+1 where 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 12)
    AND
    board_reply_step>(select board_reply_step from board_reply where board_reply_id =12);  
--insert
insert into board_reply values ((select (nvl(max(board_reply_id),0)+1) from board_reply ),5,'kh1','댓글달기에 대댓글 달기',DEFAULT,NULL,
    (select board_reply_level+1     from board_reply where board_reply_id=12),
    (select board_reply_ref         from board_reply where board_reply_id=12),
    (select board_reply_step+1      from board_reply where board_reply_id=12)
);
----새 댓글에 대댓글 달기2
update board_reply set board_reply_step=board_reply_step+1 where 
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 12)
    AND
    board_reply_step>(select board_reply_step from board_reply where board_reply_id =12);  
insert into board_reply values ((select (nvl(max(board_reply_id),0)+1) from board_reply ),5,'kh1','댓글달기에 대댓글 달기2',DEFAULT,NULL,
    (select board_reply_level+1     from board_reply where board_reply_id=12),
    (select board_reply_ref         from board_reply where board_reply_id=12),
    (select board_reply_step+1      from board_reply where board_reply_id=12)
);
--달기2에 대대댓글 달기

update board_reply set board_reply_step=board_reply_step+1 where
    BOARD_REPLY_REF = (SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 14)
    AND
    board_reply_step>(select board_reply_step from board_reply where board_reply_id =14);  
insert into board_reply values ((select (nvl(max(board_reply_id),0)+1) from board_reply ),5,'kh1','달기2 대대댓글 달기',DEFAULT,NULL,
    (select board_reply_level+1     from board_reply where board_reply_id=14),
    (select board_reply_ref         from board_reply where board_reply_id=14),
    (select board_reply_step+1      from board_reply where board_reply_id=14)
);
--댓글 2에 대댓글 달기
UPDATE board_reply SET board_reply_step = board_reply_step +1 where
    board_reply_ref = (select board_reply_ref from board_reply where board_reply_id=4)
    and 
    board_reply_step > (select board_reply_step from board_reply where board_reply_id=4);
INSERT INTO board_reply values( (select (nvl(max(board_reply_id),0)+1) from board_reply),5,'kh1','댓글2에 대댓글 작성',DEFAULT,null,
    (select board_reply_level +1    from board_reply where board_reply_id = 4),
    (select board_reply_ref         from board_reply where board_reply_id = 4),
    (select board_reply_step+1      from board_reply where board_reply_id = 4)

);
--댓글 순서 맞추기
SELECT * FROM board_reply ORDER BY board_reply_ref DESC , board_reply_step ASC;
--update board_reply set board_reply_content = '달기2 대대댓글 달기' where board_reply_id=15;
commit;
delete from board_reply;


-----------프로시저
select * from board order by board_id desc;


------ 게시글 여러개 만들기
CREATE OR REPLACE PROCEDURE PRO_BOARD_INSERT(P_WRITER_KEY board.board_writer%TYPE, P_SUBJECT_STR board.subject%TYPE,P_MAXCOUNT NUMBER)
IS
    V_B BOARD%ROWTYPE;
begin
 for I in 1..P_MAXCOUNT loop
    select SEQ_BOARD_ID.NEXTVAL INTO V_B.BOARD_ID FROM DUAL;
    V_B.BOARD_WRITER := P_WRITER_KEY;
    INSERT INTO BOARD
    VALUES(
        V_B.BOARD_ID,
        P_SUBJECT_STR||I,
        '내용-----1'||I,
        default,
        '127.0.0.1',
        V_B.BOARD_WRITER,
        default
    );
    END LOOP;
END;
/
EXEC PRO_BOARD_INSERT('kh1','title-------',10); --kh1 회원으로 10개 만들기

----- 멤버 만들기
--MEM_ID    NOT NULL VARCHAR2(20)  
--MEM_PWD   NOT NULL VARCHAR2(20)  
--MEM_EMAIL NOT NULL VARCHAR2(100) 
create or replace procedure PRO_MEMBER(P_MEM_ID member.mem_id%TYPE, P_MEM_PWD member.mem_pwd%TYPE, P_MAXCOUNT number)
IS
    V_M MEMBER%ROWTYPE;
BEGIN
    for J in 1..P_MAXCOUNT loop
        insert into member 
        values(
            P_MEM_ID||J,
            P_MEM_PWD||J,
            'khkh@a.com'
        );
    end loop;
end;
/
exec  PRO_MEMBER('pro','propwd',5);
select * from member;

---------
desc member;
desc board;
desc board_reply;