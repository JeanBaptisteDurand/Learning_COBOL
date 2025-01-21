    IDENTIFICATION DIVISION.
       PROGRAM-ID. luhn.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY. FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CARD-NUMBER PIC X(32).
       01 WS-CARD-DIGITS PIC 9(32).
       01 WS-CHECKSUM PIC 9(2).
       01 WS-VALID PIC X(5).
       01 WS-INDEX PIC 99.
       01 WS-DIGIT PIC 99.
       01 WS-SRC-INDEX PIC 99.
       01 WS-CARD-NUMBER-2 PIC X(32).
       
       PROCEDURE DIVISION.
       LUHN.
          MOVE "FALSE" TO WS-VALID.
      
          MOVE WS-CARD-NUMBER TO WS-CARD-NUMBER-2.
          INSPECT WS-CARD-NUMBER-2 CONVERTING "1234567890" TO "          ".
      
          IF NOT WS-CARD-NUMBER-2 = SPACES OR LENGTH OF FUNCTION TRIM(WS-CARD-NUMBER) = 1 THEN
             EXIT PARAGRAPH
          END-IF.
      
          MOVE 0 TO WS-CHECKSUM
          MOVE 1 TO WS-INDEX
          MOVE 0 TO WS-SRC-INDEX
          PERFORM VARYING WS-SRC-INDEX
            FROM LENGTH OF FUNCTION TRIM(WS-CARD-NUMBER)
            BY -1
          UNTIL WS-SRC-INDEX = 0
             IF WS-CARD-NUMBER(WS-SRC-INDEX:1) >= 0 AND WS-CARD-NUMBER(WS-SRC-INDEX:1) <= 9 THEN
                IF FUNCTION MOD(WS-INDEX, 2) = 0 THEN
                   COMPUTE WS-DIGIT = FUNCTION NUMVAL(WS-CARD-NUMBER(WS-SRC-INDEX:1)) * 2
                   IF WS-DIGIT > 9 THEN
                         SUBTRACT 9 FROM WS-DIGIT
                      END-IF
                      COMPUTE WS-CHECKSUM = WS-CHECKSUM + WS-DIGIT
                   ELSE
                      ADD FUNCTION NUMVAL(WS-CARD-NUMBER(WS-SRC-INDEX:1)) TO WS-CHECKSUM
                   END-IF
                   
                   ADD 1 TO WS-INDEX
                END-IF
             END-PERFORM
      
             IF FUNCTION MOD(WS-CHECKSUM, 10) = 0 THEN
                MOVE "VALID" TO WS-VALID
             END-IF.