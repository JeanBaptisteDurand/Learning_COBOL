       IDENTIFICATION DIVISION.
       PROGRAM-ID. reverse-string.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-STRING   PIC X(64).
       01  WS-REVERSE PIC X(64).
       77  WS-LENGTH      PIC 9(4) BINARY.
       77  WS-I        PIC 9(4) BINARY.
       77  WS-J        PIC 9(4) BINARY.

       PROCEDURE DIVISION.
       REVERSE-STRING.

           MOVE FUNCTION LENGTH(WS-STRING) TO WS-LENGTH.
           PERFORM VARYING WS-LENGTH FROM WS-LENGTH BY -1
               UNTIL WS-LENGTH < 1 OR WS-STRING(WS-LENGTH:1) NOT = ' '
           END-PERFORM.

           MOVE WS-LENGTH TO WS-I.
           MOVE 1 TO WS-J.
           PERFORM VARYING WS-I FROM WS-LENGTH BY -1
               UNTIL WS-I < 1
               MOVE WS-STRING(WS-I:1) TO WS-REVERSE(WS-J:1)
               ADD 1 TO WS-J
           END-PERFORM.

           MOVE SPACES TO WS-STRING.
           MOVE WS-REVERSE TO WS-STRING.
           MOVE SPACES TO WS-REVERSE.
           .

