       IDENTIFICATION DIVISION.
       PROGRAM-ID. PANGRAM.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-SENTENCE            PIC X(60).

       01  WS-RESULT              PIC 9    VALUE 0.

       01  WS-ALPHABET            PIC X(26) VALUE
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ".

       01  WS-I                   PIC 99 VALUE 0.
       01  WS-COUNT               PIC 99 VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Enter a sentence: "
           ACCEPT WS-SENTENCE

           PERFORM ISOGRAM

           IF WS-RESULT = 1
               DISPLAY "The sentence is a Pangram."
           ELSE
               DISPLAY "The sentence is NOT a Pangram."
           END-IF

           STOP RUN.

       ISOGRAM.
           MOVE 0 TO WS-RESULT

           INSPECT WS-SENTENCE
               CONVERTING 'abcdefghijklmnopqrstuvwxyz'
                          TO 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 26
               MOVE 0 TO WS-COUNT

               INSPECT WS-SENTENCE
                   TALLYING WS-COUNT FOR ALL WS-ALPHABET(WS-I:1)

               IF WS-COUNT > 1
                  MOVE 0 TO WS-RESULT
                  EXIT PERFORM
               END-IF
           END-PERFORM

           IF WS-I > 26
              MOVE 1 TO WS-RESULT
           END-IF
           .
