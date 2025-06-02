       IDENTIFICATION DIVISION.
       PROGRAM-ID. high-scores.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROPERTY       PIC A(20).
       01 WS-SCORES.
           02 SCORES        PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX.

       01 WS-RESULT-STRING.
            02 RESULT        PIC X(3) OCCURS 20 TIMES.
       01 WS-RESULT-VALUE   PIC 999.
       01 WS-MAXIMUM         PIC 9(3) VALUE 0.
       01 WS-MI            PIC 99 VALUE 1.
       01 WS-INDEX            PIC 99 VALUE 1.
       01 WS-LAST        PIC 9(3) VALUE 0.
       01 WS-RS         PIC 99 VALUE 1.


       PROCEDURE DIVISION.
       HIGH-SCORES.
           initialise WS-RESULT-STRING, WS-RESULT-VALUE, WS-MI,
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
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)

           initialise WS-PROPERTY, WS-SCORES.


       FIND-LAST.
           MOVE 0 TO WS-LAST
           MOVE 20 to WS-INDEX
           PERFORM UNTIL WS-LAST <> 0 OR WS-INDEX < 1
               if SCORES(WS-INDEX) <> 0
                   MOVE SCORES(WS-INDEX) TO WS-LAST
               SUBTRACT 1 FROM WS-INDEX
           END-PERFORM.


       CALCULATE-MAXIMUM.
           MOVE SCORES(1) TO WS-MAXIMUM
           MOVE 1 TO WS-INDEX
           PERFORM VARYING WS-INDEX FROM 2 BY 1 UNTIL WS-INDEX > 10
               IF SCORES(WS-INDEX) > WS-MAXIMUM
                   MOVE SCORES(WS-INDEX) TO WS-MAXIMUM
                   MOVE WS-INDEX TO WS-MI
               END-IF
           END-PERFORM.
