       IDENTIFICATION DIVISION.
       PROGRAM-ID. BOB.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-HEYBOB                PIC X(60) VALUE "WATCH OUT!".
       01 WS-RESULT                PIC X(40).
       77 WS-LENGTH      PIC 9(4) BINARY.
       77 WS-Q PIC 9 VALUE 0.
       77 WS-Y PIC 9 VALUE 1.
       77 WS-YT PIC 9 VALUE 0.
       77 WS-N PIC 9 VALUE 0.

       PROCEDURE DIVISION.
       BOB.
           MOVE FUNCTION LENGTH(WS-HEYBOB) TO WS-LENGTH
           MOVE 0 TO WS-Q.
           MOVE 1 TO WS-Y.
           MOVE 0 TO WS-YT.
           MOVE 0 TO WS-N.

           PERFORM VARYING WS-LENGTH FROM WS-LENGTH BY -1
               UNTIL WS-LENGTH < 1 OR WS-HEYBOB(WS-LENGTH:1) NOT = ' '
           END-PERFORM.

           IF WS-LENGTH < 1 THEN
               MOVE 1 TO WS-N
           ELSE
               IF WS-HEYBOB(WS-LENGTH:1) = '?' THEN
                   MOVE 1 TO WS-Q
               END-IF
           END-IF.

           PERFORM IS_ALL_UPPER

           MOVE SPACE TO WS-RESULT.

           EVALUATE TRUE
               WHEN WS-N = 1
                   MOVE "Fine. Be that way!" TO WS-RESULT
               WHEN WS-Y = 1 AND WS-Q = 1 AND WS-YT = 1
                   MOVE "Calm down, I know what I'm doing!" TO WS-RESULT
               WHEN WS-Q = 1
                   MOVE "Sure." TO WS-RESULT
               WHEN WS-Y = 1 AND WS-YT = 1
                   MOVE "Whoa, chill out!" TO WS-RESULT
               WHEN OTHER
                   MOVE "Whatever." TO WS-RESULT
           END-EVALUATE.

           DISPLAY WS-RESULT.
           MOVE SPACE TO WS-HEYBOB.
           STOP RUN.

       IS_ALL_UPPER.
           PERFORM VARYING WS-LENGTH FROM WS-LENGTH BY -1
               UNTIL WS-LENGTH < 1
               IF WS-HEYBOB(WS-LENGTH:1) >= 'a' AND 
                  WS-HEYBOB(WS-LENGTH:1) <= 'z' THEN
                   MOVE 0 TO WS-Y
               END-IF
               IF WS-HEYBOB(WS-LENGTH:1) >= 'A' AND 
                  WS-HEYBOB(WS-LENGTH:1) <= 'Z' THEN
                   MOVE 1 TO WS-YT
               END-IF
           END-PERFORM.
           .
       .
