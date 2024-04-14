exec PRO_BOARD_INSERT('aaaaa','title3',11);
select * from board;
---------------------------------
--한 페이지당 글수 
--화면 하단에 나타낼 페이지수
--현재페이지
--총 글 갯수
---------------------------------
--한 페이지에 몇개씩 나타낼 것인가? 3개씩
--화면 하단에 나타낼 '페이지 수'는 몇? 5씩
--현재페이지는 어디인가
-- 3이다!!  --> 하단에 12345 표시
-- 10이다!! --> 하단에 678910표시
-- 하단에 몇 페이지씩 표시할 것인가
--그렇다면 전체 페이지 수가 몇 장이 될 것인가
--- 전체 글 갯수(25) / 한페이지에 나타낼 게시글 수(4)
select ceil(count(*)/3) from board; 

--전체 페이지수 = ceil(총글개수/한 페이지당 글 수)
select t2.*
from( select t1.*,rownum rn from(select * from board order by board_id desc) t1) t2
where rn between 7 and 9 --3page
--where rn between 한페이지당 글 수 * (현재페이지-1)+1 and  한페이지당 글 수 * (현재페이지)
;
--현재 페이지를 기준으로 
----(현재페이지 % 페이지수 ==0)?
-- 시작 페이지 start page 와 
---- startPageNum =(현재페이지 % 페이지수 ==0)? ((현제페이지 / 페이지수)* 페이지 수 +1 : ((현재페이지/페이지수 )*페이지수 +1)
-- 마지막 페이지 end page를 정할 것이다
----  endPageNum = (현재페이지/페이지수 +1) * 페이지 수
---- endPageNum =(endPageNum> 전체페이지수 ) ? 전체 페이지 수 : startPageNum+vpdlwltn -1;
SELECT T2.* FROM(SELECT T1.*, ROWNUM RN FROM (SELECT BOARD_ID, SUBJECT,CONTENT,WRITE_TIME,LOG_IP,BOARD_WRITER,READ_COUNT FROM BOARD ORDER BY BOARD_ID DESC) T1  ) T2 WHERE RN  BETWEEN 7 AND 9;


select * from member;
INSERT INTO MEMBER(MEM_ID,MEM_PWD,MEM_EMAIL) VALUES ('111','111','111@111.com');