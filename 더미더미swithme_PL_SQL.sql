------ subject 프로시저
--파라미터 (멤버ID, 과목명, 돌릴 횟수[최대5]) 

CREATE OR REPLACE PROCEDURE PRO_SUBJECT_INSERT(P_MEM_ID_PK subject.mem_id%TYPE, P_SUBJECT_NAME subject.subject_name%TYPE,P_MAXCOUNT NUMBER)
IS  
    --SUBJECT 모든 컬럼 가져오기
    V_S SUBJECT%ROWTYPE;
begin
 for I in 1..P_MAXCOUNT loop
    select SEQ_SUBJECT_ID.NEXTVAL INTO V_S.SUBJECT_ID FROM DUAL;
    V_S.MEM_ID := P_MEM_ID_PK;
    INSERT INTO SUBJECT
    VALUES(
        V_S.SUBJECT_ID,
        V_S.MEM_ID,
        P_SUBJECT_NAME||I,
        default,
        null,
        I
    );
    END LOOP;
    COMMIT;
END;
/

--desc SUBJECT;

------ RECORD 프로시저
--RECORD_ID         NOT NULL NUMBER       
--RECORD_SUBJECT_ID NOT NULL NUMBER       
--RECORD_MEM_ID     NOT NULL VARCHAR2(20) 
--RECORD_START      NOT NULL TIMESTAMP(6) 
--RECORD_END                 TIMESTAMP(6) 

--(SELECT TO_DATE('2024-04-08 07:40:00', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual
--CREATE OR REPLACE PROCEDURE PRO_RECORD_INSERT(P_RECORD_MEM_ID record.record_mem_id%TYPE, P_SRECORD_SUBJECT_ID record.record_subject_id%TYPE, sday VARCHAR2 )
--IS  
--    --SUBJECT 모든 컬럼 가져오기
--    V_R RECORD%ROWTYPE;
--     v_record_id NUMBER;
--begin
----for I in 1..sday loop
--    select SEQ_RECORD_ID.NEXTVAL INTO v_record_id FROM DUAL;
--
--        INSERT INTO RECORD
--        VALUES(
--            v_record_id,
--            P_SRECORD_SUBJECT_ID,
--            P_RECORD_MEM_ID,
--            (SELECT TO_DATE('2024-04-0'||sday||' 08:20:00', 'YYYY-MM-DD HH24:MI:SS')FROM dual),
--           (SELECT TO_DATE('2024-04-0'||sday||' 09:50:00', 'YYYY-MM-DD HH24:MI:SS')FROM dual)
--        );
--
--        INSERT INTO RECORD
--        VALUES(
--            v_record_id,
--            P_SRECORD_SUBJECT_ID,
--             P_RECORD_MEM_ID,
--           (SELECT TO_DATE('2024-04-0'||sday||' 09:50:15', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_START FROM dual),
--           (SELECT TO_DATE('2024-04-0'||sday||' 11:23:22', 'YYYY-MM-DD HH24:MI:SS') AS RECORD_END FROM dual)
--        );
--
--   -- END LOOP;
--    COMMIT;
--END;
--/