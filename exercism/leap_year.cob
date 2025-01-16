       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEAP.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-YEAR             PIC 9(4) VALUE 2100.
       01  WS-RESULT           PIC 9    VALUE 0.

       01  WS-QUOTIENT-4       PIC 9(4) VALUE 0.
       01  WS-REMAINDER-4      PIC 9(4) VALUE 0.

       01  WS-QUOTIENT-100     PIC 9(4) VALUE 0.
       01  WS-REMAINDER-100    PIC 9(4) VALUE 0.

       01  WS-QUOTIENT-400     PIC 9(4) VALUE 0.
       01  WS-REMAINDER-400    PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.
       LEAP.
           PERFORM CHECK-MOD-4
           IF WS-REMAINDER-4 = 0
              PERFORM CHECK-MOD-100
              IF WS-REMAINDER-100 = 0
                 PERFORM CHECK-MOD-400
                 IF WS-REMAINDER-400 = 0
                    MOVE 1 TO WS-RESULT
                 ELSE
                    MOVE 0 TO WS-RESULT
                 END-IF
              ELSE
                 MOVE 1 TO WS-RESULT
              END-IF
           ELSE
              MOVE 0 TO WS-RESULT
           END-IF

           DISPLAY "YEAR: " WS-YEAR " LEAP YEAR: " WS-RESULT
           GOBACK.

       CHECK-MOD-4.
           DIVIDE WS-YEAR BY 4
               GIVING WS-QUOTIENT-4
               REMAINDER WS-REMAINDER-4.

       CHECK-MOD-100.
           DIVIDE WS-YEAR BY 100
               GIVING WS-QUOTIENT-100
               REMAINDER WS-REMAINDER-100.

       CHECK-MOD-400.
           DIVIDE WS-YEAR BY 400
               GIVING WS-QUOTIENT-400
               REMAINDER WS-REMAINDER-400.
       END PROGRAM LEAP.
