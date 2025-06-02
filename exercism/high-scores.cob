       IDENTIFICATION DIVISION.
       PROGRAM-ID. high-scores.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROPERTY       PIC A(20).
       01 WS-SCORES.
           02 SCORES        PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX.

       01 WS-RESULT-STRING   PIC X(60).
       01 WS-RESULT-VALUE   PIC 999.
       01 WS-MAXIMUM         PIC 9(3) VALUE 0.
       01 WS-MAXIMUM-H      PIC X(3).
       01 WS-MI            PIC 99 VALUE 1.
       01 WS-INDEX            PIC 99 VALUE 1.
       01 WS-LAST        PIC 9(3) VALUE 0.
       01 WS-RS         PIC 99 VALUE 1.


       PROCEDURE DIVISION.
       HIGH-SCORES.
           initialise WS-RESULT-VALUE, WS-MI,
                       WS-INDEX, WS-RS
           evaluate true
               when WS-PROPERTY = "scores"
                   MOVE WS-SCORES TO WS-RESULT-STRING
      
               when WS-PROPERTY = "latest"
                   PERFORM FIND-LAST
                   MOVE WS-LAST TO WS-RESULT-VALUE
      
               when WS-PROPERTY = "personalBest"
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO WS-RESULT-VALUE
      
               when WS-PROPERTY = "personalTopThree"
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM-H TO WS-RESULT-STRING(1:3)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM-H TO WS-RESULT-STRING(4:6)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM-H TO WS-RESULT-STRING(7:9)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
           .


       FIND-LAST.
           MOVE 0 TO WS-LAST
           MOVE 20 to WS-INDEX
           PERFORM UNTIL WS-LAST <> 0 OR WS-INDEX < 1
               if SCORES(WS-INDEX) <> 0
                   MOVE SCORES(WS-INDEX) TO WS-LAST
               SUBTRACT 1 FROM WS-INDEX
           END-PERFORM.


       CALCULATE-MAXIMUM.
           MOVE 1 TO WS-MAXIMUM
           MOVE SPACES to WS-MAXIMUM-H
           MOVE 1 TO WS-INDEX
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 20
               IF FUNCTION NUMVAL(SCORES(WS-INDEX)) > WS-MAXIMUM
                   MOVE SCORES(WS-INDEX) TO WS-MAXIMUM-H
                   MOVE FUNCTION NUMVAL(SCORES(WS-INDEX)) TO WS-MAXIMUM
                   MOVE WS-INDEX TO WS-MI
               END-IF
           END-PERFORM.








good code :
         IDENTIFICATION DIVISION.
       PROGRAM-ID. high-scores.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROPERTY       PIC A(20).
       01 WS-SCORES.
           02 SCORES        PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX.

       01 WS-SORTED-SCORES.
           02 SORTED-SCORES PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX-S.
      
       01 WS-SCORE-LEN      PIC 9(4) COMP.

       01 WS-RESULT-STRING  PIC X(60).
       01 WS-RESULT-VALUE   PIC 999.

       PROCEDURE DIVISION.
       HIGH-SCORES SECTION.     
           EVALUATE WS-PROPERTY
               WHEN 'scores'
                   MOVE FUNCTION TRIM(WS-SCORES TRAILING) 
                        TO WS-RESULT-STRING

               WHEN 'latest'
                   COMPUTE IDX = LENGTH OF FUNCTION 
                                 TRIM(WS-SCORES TRAILING) / 3
                   MOVE SCORES(IDX) TO WS-RESULT-VALUE WS-RESULT-STRING
      
               WHEN 'personalBest'
                   SET IDX TO 1
                   SEARCH SCORES VARYING IDX
                       WHEN SCORES(IDX) > WS-RESULT-VALUE
                           MOVE SCORES(IDX) TO WS-RESULT-VALUE 
                                               WS-RESULT-STRING
                           CONTINUE
                   END-SEARCH
                        
               WHEN 'personalTopThree'
                   MOVE WS-SCORES TO WS-SORTED-SCORES
                   SORT SORTED-SCORES DESCENDING SORTED-SCORES
                   MOVE WS-SORTED-SCORES(1:9) TO WS-RESULT-STRING
           END-EVALUATE
           EXIT.