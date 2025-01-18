       IDENTIFICATION DIVISION.
       PROGRAM-ID. reverse-string.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-STRING   PIC X(64).
       01  WS-REVERSED PIC X(64).
       77  WS-LEN      PIC 9(4) BINARY.
       77  WS-I        PIC 9(4) BINARY.
       77  WS-J        PIC 9(4) BINARY.

       PROCEDURE DIVISION.
       REVERSE-STRING.

           INSPECT WS-STRING
               TALLYING WS-LEN FOR CHARACTERS.

           MOVE WS-LEN TO WS-J

           PERFORM VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > WS-LEN
               MOVE WS-STRING(WS-J:1) TO WS-REVERSED(WS-I:1)
               SUBTRACT 1 FROM WS-J
           END-PERFORM

           MOVE WS-REVERSED TO WS-STRING

           .
