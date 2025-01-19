       IDENTIFICATION DIVISION.
       PROGRAM-ID. raindrops.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NUMBER           PIC 9(4) VALUE ZERO.
       01 WS-NUMBER-TEXT      PIC X(4) VALUE SPACES.
       01 WS-RESULT           PIC X(20) VALUE SPACES.
       01 WS-HAS-SOUND        PIC X VALUE "N".
           88 HAS-SOUND        VALUE "Y".
           88 NO-SOUND         VALUE "N".

       PROCEDURE DIVISION.
       RAINDROPS.
           MOVE SPACES TO WS-RESULT
           MOVE "N" TO WS-HAS-SOUND
           SET NO-SOUND TO TRUE

           IF FUNCTION MOD(WS-NUMBER, 3) = 0
               STRING FUNCTION TRIM(WS-RESULT) DELIMITED BY SIZE
                      "Pling" DELIMITED BY SIZE
                      INTO WS-RESULT
               MOVE "Y" TO WS-HAS-SOUND
           END-IF

           IF FUNCTION MOD(WS-NUMBER, 5) = 0
               STRING FUNCTION TRIM(WS-RESULT) DELIMITED BY SIZE
                      "Plang" DELIMITED BY SIZE
                      INTO WS-RESULT
               MOVE "Y" TO WS-HAS-SOUND
           END-IF

           IF FUNCTION MOD(WS-NUMBER, 7) = 0
               STRING FUNCTION TRIM(WS-RESULT) DELIMITED BY SIZE
                      "Plong" DELIMITED BY SIZE
                      INTO WS-RESULT
               MOVE "Y" TO WS-HAS-SOUND
           END-IF

           IF NO-SOUND
               MOVE WS-NUMBER TO WS-RESULT
           END-IF.

