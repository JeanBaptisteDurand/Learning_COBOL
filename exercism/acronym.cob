       IDENTIFICATION DIVISION.
       PROGRAM-ID. acronym.
       ENVIRONMENT DIVISION.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-ACRONYM               PIC X(80).
       01 WS-RESULT                PIC X(20).
       01 WS-MID                   PIC X(1).
       01 WS-RESULT-POINTER        PIC 9(3).
       01 WS-PTR            PIC 9(3).

       PROCEDURE DIVISION.
       ABBREVIATE.
       INITIALIZE WS-RESULT WS-MID
       MOVE 1 TO WS-RESULT-POINTER
       MOVE 1 TO WS-PTR
       PERFORM 20 TIMES
         UNSTRING WS-ACRONYM DELIMITED BY SPACE OR '-' OR '_'
            INTO WS-MID
            WITH POINTER WS-PTR
         END-UNSTRING
         IF WS-MID <> SPACE
            STRING WS-MID DELIMITED BY SIZE
               INTO WS-RESULT
               WITH POINTER WS-RESULT-POINTER
            END-STRING
         END-IF
       END-PERFORM
       MOVE FUNCTION UPPER-CASE(WS-RESULT) TO WS-RESULT
       .
