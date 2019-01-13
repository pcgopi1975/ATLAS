SET SERVEROUTPUT ON;
DECLARE
   type array_t is  VARRAY(69) OF INTEGER;
   type array_b is  VARRAY(42) OF INTEGER;
   
   array1 array_t := array_t(); -- Initialise it
   array2 array_b := array_b(); -- Initialise it
BEGIN

 FOR i in 1 .. 69 LOOP 
     array1.extend(); -- Extend it
      array1(i) := 0;
   END LOOP; 
   
   FOR i in 1 .. 42 LOOP 
     array2.extend(); -- Extend it
      array2(i) := 0;
   END LOOP; 
--    dbms_output.put_line('gopi');
    FOR REC IN (SELECT d1,d2,d3,d4,d5,ball From POWERBALL) LOOP
         array1(REC.d1) :=  array1(REC.d1) + 1 ;
         array1(REC.d2) :=  array1(REC.d2) + 1 ;
         array1(REC.d3) :=  array1(REC.d3) + 1 ;
         array1(REC.d4) :=  array1(REC.d4) + 1 ;
         array1(REC.d5) :=  array1(REC.d5) + 1 ;
         array2(REC.ball) :=  array2(REC.ball) + 1 ;
         
    END LOOP;
    
    DELETE FROM NUMBER_TBL;
    DELETE FROM BALL_TBL;
        
    FOR i in 1 .. 69 LOOP 
    INSERT INTO NUMBER_TBL(DIGIT,COUNT) VALUES(i,array1(i));
   END LOOP; 

 FOR i in 1 .. 26 LOOP 
    INSERT INTO BALL_TBL(BALL,COUNT) VALUES(i,array2(i));
   END LOOP; 
   
   
   DELETE FROM TICKET_TBL;
   
        DECLARE 
            rnum1 integer := 0;
            rnum2 integer := 0;
            rnum3 integer := 0;
            rnum4 integer := 0;
            rnum5 integer := 0;
            rnumball INTEGER :=0;
            X_DIGIT1 INTEGER :=0;
            X_DIGIT2 INTEGER :=0;
            X_DIGIT3 INTEGER :=0;
            X_DIGIT4 INTEGER :=0;
            X_DIGIT5 INTEGER :=0;
            X_BALLDIGIT INTEGER := 0;
        BEGIN
   	      FOR I IN 1..10 LOOP
              select round(dbms_random.value(1,35)) rnum1   into rnum1   from dual;
              select round(dbms_random.value(1,35)) rnum2   into rnum2   from dual;
              select round(dbms_random.value(36,52)) rnum3   into rnum3   from dual;
              select round(dbms_random.value(36,52)) rnum4   into rnum4   from dual;
              select round(dbms_random.value(53,65)) rnum5   into rnum5   from dual;
              
            select round(dbms_random.value(1,26)) rnumball   into rnumball   from dual;
              
             
                SELECT DGT INTO  X_DIGIT1 FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT DIGIT DGT,COUNT CNT FROM NUMBER_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = RNUM1;
                
                 SELECT DGT INTO  X_DIGIT2 FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT DIGIT DGT,COUNT CNT FROM NUMBER_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = RNUM2;
                
                SELECT DGT INTO  X_DIGIT3 FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT DIGIT DGT,COUNT CNT FROM NUMBER_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = RNUM3;
                
                SELECT DGT INTO  X_DIGIT4 FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT DIGIT DGT,COUNT CNT FROM NUMBER_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = RNUM4;
                
                SELECT DGT INTO  X_DIGIT5 FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT DIGIT DGT,COUNT CNT FROM NUMBER_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = RNUM5;
                
                SELECT DGT INTO  X_BALLDIGIT FROM (SELECT DGT,CNT,ROWNUM R1
                FROM 
                (SELECT BALL DGT,COUNT CNT FROM BALL_TBL ORDER BY COUNT DESC)
                ) TBL1
				WHERE TBL1.R1 = rnumball;               
                
          INSERT INTO TICKET_TBL(SLNO,TICKETNO,DIGIT1,DIGIT2,DIGIT3,DIGIT4,DIGIT5,BALLDIGIT) VALUES(I,'POWERBALL TICKET'||I,X_DIGIT1,X_DIGIT2,X_DIGIT3,X_DIGIT4,X_DIGIT5,X_BALLDIGIT); 

          END LOOP; 
	 END;
END;

