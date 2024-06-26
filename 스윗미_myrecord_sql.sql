select * from subject;
select RECORD_ID ,
RECORD_SUBJECT_ID ,
RECORD_MEM_ID ,
RECORD_START ,
RECORD_END  from record;
INSERT INTO RECORD VALUES(SEQ_RECORD_ID.nextval,171,'a',DEFAULT,NULL);
INSERT INTO RECORD VALUES(SEQ_RECORD_ID.nextval,172,'a',to_date('20240419213048', 'yyyymmddhh24miss'),NULL);
ROLLBACK;

select * from record order by record_id desc;

select SUBJECT_ID, SUBJECT_NAME ,DIFFTIME    
from (SELECT SUBJECT_ID, SUBJECT_NAME  FROM SUBJECT WHERE MEM_ID ='a' AND SUBJECT_DEL_DATE IS NULL) t1   
	FULL JOIN 
	( SELECT RECORD_SUBJECT_ID, SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) as DIFFTIME 
	  FROM RECORD WHERE RECORD_MEM_ID = 'a'  and to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd') 
	  group by cube(RECORD_SUBJECT_ID) ) t2 
	on (SUBJECT_ID = RECORD_SUBJECT_ID) 
ORDER BY SUBJECT_ID ASC NULLS FIRST
;