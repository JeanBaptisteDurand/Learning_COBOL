       IDENTIFICATION DIVISION.
       PROGRAM-ID. SCRABBLE-SCORE.
      *
       DATA DIVISION.
      *
       WORKING-STORAGE SECTION.
      *Inputs
       01 WS-WORD   PIC X(60).
      *Outputs
       01 WS-RESULT PIC 99.
      *
       LOCAL-STORAGE SECTION.
       01 LEN PIC 9(2).
       01 I PIC 9(2).
      *
       PROCEDURE DIVISION.
      *
       SCRABBLE-SCORE.
           MOVE 0 TO WS-RESULT.
           MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-WORD)) TO LEN.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > LEN
               EVALUATE FUNCTION UPPER-CASE(WS-WORD(I:1))
               WHEN "D"
               WHEN "G"
                   ADD 2 TO WS-RESULT
               WHEN "B"
               WHEN "C"
               WHEN "M"
               WHEN "P"
                   ADD 3 TO WS-RESULT
               WHEN "F"
               WHEN "H"
               WHEN "V"
               WHEN "W"
               WHEN "Y"
                   ADD 4 TO WS-RESULT
               WHEN "K"
                   ADD 5 TO WS-RESULT
               WHEN "J"
               WHEN "X"
                   ADD 8 TO WS-RESULT
               WHEN "Q"
               WHEN "Z"
                   ADD 10 TO WS-RESULT
               WHEN OTHER
                   ADD 1 TO WS-RESULT
               END-EVALUATE
         END-PERFORM.
      *
       SCRABBLE-SCORE-EXIT.
           EXIT.


OTHER SOLUTION

       01 WS-LETTERSET          PIC X.
          88 WS-LETTERSET-1     VALUE "A" "E" "I" "O" "U" 
                                          "L" "N" "R" "S" "T".
          88 WS-LETTERSET-2     VALUE "D" "G".
          88 WS-LETTERSET-3     VALUE "B" "C" "M" "P".
          88 WS-LETTERSET-4     VALUE "F" "H" "V" "W" "Y".
          88 WS-LETTERSET-5     VALUE "K".
          88 WS-LETTERSET-6     VALUE "J" "X".
          88 WS-LETTERSET-7     VALUE "Q" "Z".


                 INCREMENT-SCORE.
         EVALUATE TRUE
            WHEN WS-LETTERSET-1 ADD 1 TO WS-RESULT
            WHEN WS-LETTERSET-2 ADD 2 TO WS-RESULT
            WHEN WS-LETTERSET-3 ADD 3 TO WS-RESULT
            WHEN WS-LETTERSET-4 ADD 4 TO WS-RESULT
            WHEN WS-LETTERSET-5 ADD 5 TO WS-RESULT
            WHEN WS-LETTERSET-6 ADD 8 TO WS-RESULT
            WHEN WS-LETTERSET-7 ADD 10 TO WS-RESULT
         END-EVALUATE.