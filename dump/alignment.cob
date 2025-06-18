       IDENTIFICATION DIVISION.
       PROGRAM-ID. display-string.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-STRING       PIC X(5) VALUE "Bonjour tout le monde!".
       01 WS-NUM          PIC 9(2) VALUE 12345.
       01 WS-LENGTH       PIC 9(4) BINARY.
       01 WS-I            PIC 9(4) BINARY.
       01 WS-CHAR         PIC X(1).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           COMPUTE WS-LENGTH = FUNCTION LENGTH(WS-STRING)

           DISPLAY "Du début à la fin :"
           PERFORM VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > WS-LENGTH
               MOVE WS-STRING(WS-I:1) TO WS-CHAR
               DISPLAY WS-CHAR
           END-PERFORM

           DISPLAY " "

           DISPLAY "De la fin au début :"
           PERFORM VARYING WS-I FROM WS-LENGTH BY -1
               UNTIL WS-I < 1
               MOVE WS-STRING(WS-I:1) TO WS-CHAR
               DISPLAY WS-CHAR
           END-PERFORM

           DISPLAY " "
           DISPLAY WS-NUM

           STOP RUN.
