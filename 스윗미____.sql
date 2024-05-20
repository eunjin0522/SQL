SELECT distinct SUBJECT_NAME
, SUBJECT_COLOR COLOR
, SUBSTR(DIFFTIME,12,8) DIFFTIME
, TRUNC(SYSDATE) as ONLY_DATE    
from V_RECORD 
join (select * from subject where MEM_ID ='won') using (SUBJECT_NAME)
where RECORD_MEM_ID ='won' and TRUNC(RECORD_DATE) = TRUNC(SYSDATE)
;



SELECT record_mem_id, SUBSTR(NUMTODSINTERVAL( SUM( CAST(RECORD_END as DATE) - CAST(RECORD_START as DATE) ), 'day' ), 12, 8) as DIFFTIME
from RECORD
where to_char(RECORD_START, 'yyyymmdd') =  to_char(SYSDATE, 'yyyymmdd')
group by record_mem_id
order by DIFFTIME desc
;

