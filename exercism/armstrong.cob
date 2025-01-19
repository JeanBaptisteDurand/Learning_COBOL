       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARMSTRONG-NUMBERS.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-NUMBER          PIC X(8) VALUE SPACES.
       01 WS-RESULT          PIC 9 VALUE 0.
       01 WS-LENGTH          PIC 9 VALUE 0.
       01 WS-SUM             PIC 9(8) VALUE 0.
       01 WS-DIGIT           PIC 9 VALUE 0.
       01 WS-POWER           PIC 9(8) VALUE 1.
       01 WS-I               PIC 9 VALUE 1.
       01 WS-J               PIC 9 VALUE 1.

       PROCEDURE DIVISION.

       ARMSTRONG-NUMBERS.
           MOVE "9474" TO WS-NUMBER
           MOVE 0 TO WS-SUM
           MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-NUMBER)) TO WS-LENGTH
           MOVE 1 TO WS-I

           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-LENGTH
               MOVE FUNCTION NUMVAL(WS-NUMBER(WS-I:1)) TO WS-DIGIT
               MOVE 1 TO WS-POWER

               PERFORM VARYING WS-J FROM 1 BY 1 UNTIL WS-J > WS-LENGTH
                   MULTIPLY WS-POWER BY WS-DIGIT GIVING WS-POWER
               END-PERFORM

               ADD WS-POWER TO WS-SUM
           END-PERFORM

           IF WS-SUM = FUNCTION NUMVAL(WS-NUMBER)
               MOVE 1 TO WS-RESULT
           ELSE
               MOVE 0 TO WS-RESULT
           END-IF.

           DISPLAY WS-RESULT

           STOP RUN.

