       IDENTIFICATION DIVISION.
       PROGRAM-ID. luhn.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CARD-NUMBER              PIC X(32).
       01 WS-CLEANED-NUMBER           PIC X(32).
       01 WS-DIGIT                    PIC 9 VALUE 0.
       01 WS-CARD-LENGTH              PIC 9(2) VALUE 0.
       01 WS-CHECKSUM                 PIC 9(4) VALUE 0.
       01 WS-INDEX                    PIC 9(2) VALUE 0.
       01 WS-MULTIPLIED-DIGIT         PIC 9 VALUE 0.
       01 WS-VALID                    PIC X(5) VALUE "FALSE".

       PROCEDURE DIVISION.
       LUHN.
           MOVE SPACES TO WS-CLEANED-NUMBER

      * Remove spaces from the input
           PERFORM VARYING WS-INDEX FROM 1 BY 1
               UNTIL WS-INDEX > FUNCTION LENGTH(WS-CARD-NUMBER)
               IF WS-CARD-NUMBER(WS-INDEX:1) NOT = SPACE
                   MOVE WS-CARD-NUMBER(WS-INDEX:1) TO WS-CLEANED-NUMBER(
                     FUNCTION LENGTH(FUNCTION TRIM(
                     WS-CLEANED-NUMBER)) + 1:1)
               END-IF
           END-PERFORM

      * Validate input: Ensure all characters are digits
           PERFORM VARYING WS-INDEX FROM 1 BY 1
               UNTIL WS-INDEX > FUNCTION LENGTH(
               FUNCTION TRIM(WS-CLEANED-NUMBER))
               IF WS-CLEANED-NUMBER(WS-INDEX:1) NOT NUMERIC
                   MOVE "FALSE" TO WS-VALID
                   EXIT PARAGRAPH
               END-IF
           END-PERFORM

      * Determine length and validity of the string
           COMPUTE WS-CARD-LENGTH = FUNCTION LENGTH(FUNCTION TRIM(WS-CLEANED-NUMBER))
           IF WS-CARD-LENGTH <= 1
               MOVE "FALSE" TO WS-VALID
               EXIT PARAGRAPH
           END-IF

      * Apply Luhn algorithm
           PERFORM VARYING WS-INDEX FROM WS-CARD-LENGTH BY -1
               UNTIL WS-INDEX < 1
               MOVE FUNCTION NUMVAL(WS-CLEANED-NUMBER(WS-INDEX:1)) TO WS-DIGIT

               IF MOD(WS-CARD-LENGTH - WS-INDEX + 1, 2) = 0
                   COMPUTE WS-MULTIPLIED-DIGIT = WS-DIGIT * 2
                   IF WS-MULTIPLIED-DIGIT > 9
                       COMPUTE WS-MULTIPLIED-DIGIT = WS-MULTIPLIED-DIGIT - 9
                   END-IF
                   ADD WS-MULTIPLIED-DIGIT TO WS-CHECKSUM
               ELSE
                   ADD WS-DIGIT TO WS-CHECKSUM
               END-IF
           END-PERFORM

      * Check if the checksum is divisible by 10
           IF MOD(WS-CHECKSUM, 10) = 0
               MOVE "VALID" TO WS-VALID
           ELSE
               MOVE "FALSE" TO WS-VALID
           END-IF

           DISPLAY "Input Number: " WS-CARD-NUMBER
           DISPLAY "Validation Result: " WS-VALID

           STOP RUN.
