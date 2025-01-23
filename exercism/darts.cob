       IDENTIFICATION DIVISION.
       PROGRAM-ID. DARTS.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-X PIC 99V9.
       01 WS-Y PIC 99V9.
       01 WS-RESULT PIC 99.
       PROCEDURE DIVISION.
       DARTS.
         EVALUATE WS-X ** 2 + WS-Y ** 2
            WHEN <= 1.0
               MOVE 10 TO WS-RESULT
            WHEN <= 25.0
               MOVE 5 TO WS-RESULT
            WHEN <= 100.0
               MOVE 1 TO WS-RESULT
            WHEN OTHER
               MOVE 0 TO WS-RESULT.