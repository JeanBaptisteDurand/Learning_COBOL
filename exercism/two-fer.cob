       IDENTIFICATION DIVISION.
       PROGRAM-ID. two-fer.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NAME               PIC X(16) VALUE SPACES.
       01 WS-RESULT             PIC X(64) VALUE SPACES.
       01 WS-DEFAULT-NAME       PIC X(4) VALUE "you".
       01 WS-PREFIX             PIC X(8) VALUE "One for ".
       01 WS-SUFFIX             PIC X(13) VALUE ", one for me.".
       01 WS-LENGTH             PIC 99 VALUE 0.

       PROCEDURE DIVISION.
       TWO-FER.
           IF FUNCTION TRIM(WS-NAME) = SPACES
               MOVE WS-DEFAULT-NAME TO WS-NAME
           END-IF

           COMPUTE WS-LENGTH = FUNCTION LENGTH(FUNCTION TRIM(WS-NAME))
           
           STRING WS-PREFIX DELIMITED BY SIZE
                  FUNCTION TRIM(WS-NAME) DELIMITED BY SIZE
                  WS-SUFFIX DELIMITED BY SIZE
                  INTO WS-RESULT
           END-STRING
           .
