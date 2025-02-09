       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROMAN-NUMERALS.
       DATA DIVISION.
      
       WORKING-STORAGE SECTION.
       01 WS-NUMBER                    PIC 9(04) VALUE ZEROES.
       01 REDEFINES WS-NUMBER.
          05 WS-DIGITS                 PIC 9(01) OCCURS 4 TIMES.
       01 WS-RESULT                    PIC X(20) VALUE SPACES.
      
       01 WS-RN-TBL-DATA.
          05 FILLER                    PIC X(20) VALUE 'I    X    C    M    '.
          05 FILLER                    PIC X(20) VALUE 'II   XX   CC   MM   '.
          05 FILLER                    PIC X(20) VALUE 'III  XXX  CCC  MMM  '.
          05 FILLER                    PIC X(20) VALUE 'IV   XL   CD   -    '.
          05 FILLER                    PIC X(20) VALUE 'V    L    D    -    '.
          05 FILLER                    PIC X(20) VALUE 'VI   LX   DC   -    '.
          05 FILLER                    PIC X(20) VALUE 'VII  LXX  DCC  -    '.
          05 FILLER                    PIC X(20) VALUE 'VIII LXXX DCCC -    '.
          05 FILLER                    PIC X(20) VALUE 'IX   XC   CM   -    '.
      
       01 REDEFINES WS-RN-TBL-DATA.
          05 FILLER                              OCCURS 9 TIMES.
             10 WS-RN-TBL              PIC X(05) OCCURS 4 TIMES.
      
       01 WS-SCRATCHPAD.
          05 WS-DIGIT-POS              PIC 9(02).
          05 WS-TMP-RESULT             PIC X(20).
      
       PROCEDURE DIVISION.
      
       ROMAN-NUMERALS.
           MOVE FUNCTION REVERSE(WS-NUMBER) TO WS-NUMBER
      
           MOVE SPACES TO WS-RESULT WS-TMP-RESULT
      
           PERFORM VARYING WS-DIGIT-POS FROM 1 BY 1 UNTIL WS-DIGIT-POS > 4
             IF WS-DIGITS(WS-DIGIT-POS) <> 0 THEN
               STRING
                 WS-RN-TBL(WS-DIGITS(WS-DIGIT-POS), WS-DIGIT-POS) DELIMITED BY SPACES
                 WS-RESULT DELIMITED BY SPACES
                 INTO WS-TMP-RESULT
               MOVE FUNCTION TRIM(WS-TMP-RESULT) TO WS-RESULT
             END-IF
           END-PERFORM.