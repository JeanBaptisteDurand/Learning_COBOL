       IDENTIFICATION DIVISION.
       PROGRAM-ID. collatz-conjecture.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER PIC S9(8) VALUE 1000000.
       01 WS-STEPS PIC 9(4).
       01 WS-ERROR PIC X(35).
       01 WS-M PIC 9.
       01 WS-TMP PIC 9(4).

       PROCEDURE DIVISION.
       COLLATZ-CONJECTURE.
         MOVE 0 TO WS-STEPS.
         MOVE 0 TO WS-M.
         MOVE SPACE TO WS-ERROR.
         IF WS-NUMBER < 1
            MOVE "Only positive integers are allowed" TO WS-ERROR
         ELSE
            PERFORM UNTIL WS-NUMBER = 1
               ADD 1 TO WS-STEPS
               DIVIDE WS-NUMBER BY 2 GIVING WS-TMP REMAINDER WS-M
               IF WS-M = 0
                  DIVIDE WS-NUMBER BY 2 GIVING WS-NUMBER
               ELSE
                  COMPUTE WS-NUMBER = (WS-NUMBER * 3) + 1
               END-IF
            END-PERFORM
         END-IF.

       DISPLAY WS-STEPS.
       DISPLAY WS-ERROR.
       MOVE 0 TO WS-NUMBER.
       .
