select * from member;
select * from board ;
select * from board where board_id = 5;
select * from board_reply where board_id = 5;
select * from board_reply ;
--create or replace PROCEDURE "PRO_BOARD_REPLY_INSERT" 
--(  P_WRITER_KEY     BOARD_REPLY.BOARD_REPLY_WRITER%TYPE
--  ,P_CONTENT_STR    BOARD_REPLY.BOARD_REPLY_CONTENT%TYPE
--  ,P_RE_BOARD_ID    BOARD_REPLY.BOARD_ID%TYPE
--  ,P_RE_BOARD_REPLY_ID  BOARD_REPLY.BOARD_REPLY_ID%TYPE);

SELECT
    *
FROM (SELECT * FROM board where board_id=5) t1
    join (select * from board_reply where board_id =5 order by board_reply_ref desc, board_reply_step) t2
on t1.board_id = t2.board_id;
desc board_reply;

-- 인덱스에서 누락된 IN 또는 OUT매개변수 ::1 ?가 코드에 들어가 있다는 뜻