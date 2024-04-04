----공용세밈
select * from member;
insert into member values('EJ','ehpwd','ej@ej.a.com');
commit;
SELECT * FROM board_reply ORDER BY board_reply_ref DESC , board_reply_step ASC;

update board_reply set board_reply_step =board_reply_step+1 where 
    board_reply_ref= (select board_reply_ref from board_reply where board_reply_id = 20)
    and
    board_reply_step > (select board_reply_step from board_reply where board_reply_id = 20);
insert into board_reply values ((select (nvl(max(board_reply_id),0)+1) from board_reply ),21,'EJ','한화 나름 잘 달리고 있다구욧?',DEFAULT,NULL,
    (select board_reply_level+1     from board_reply where board_reply_id=20),
    (select board_reply_ref         from board_reply where board_reply_id=20),
    (select board_reply_step+1      from board_reply where board_reply_id=20)
);
commit;
exec PRO_BOARD_REPLY_INSERT ('EJ','감사합니다 정진하겠습니다 ㅋㅅㅋ',1,22);