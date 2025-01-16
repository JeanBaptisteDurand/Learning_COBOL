       IDENTIFICATION DIVISION.
       PROGRAM-ID. YACHT.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Dice input is a 5-digit string, each digit from 1 to 6.
       01  WS-DICE                PIC X(5).

      * Category is up to 15 characters (e.g., "full house").
       01  WS-CATEGORY            PIC X(15).

      * Result is up to two digits in these examples, but you
      * may wish to increase depending on possible sums.
       01  WS-RESULT              PIC 999 VALUE 0.

      * Frequency table: how many 1's, 2's, 3's, etc.
       01  WS-FREQ.
           05  WS-FREQ-CNT OCCURS 6 TIMES INDEXED BY I-FREQ
               PIC 9    VALUE 0.

      * Miscellaneous fields used during calculation
       01  WS-SUM                 PIC 999 VALUE 0.
       01  WS-INDEX               PIC 9   VALUE 1.
       01  WS-DIE                 PIC 9   VALUE 0.
       01  WS-TRIPLE-FOUND       PIC 9   VALUE 0.
       01  WS-DOUBLE-FOUND       PIC 9   VALUE 0.
       01  WS-TEMP                PIC 999 VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.

      ******************************************************************
      * This is just a skeleton main. In a real environment, you might
      * accept or move values into WS-DICE and WS-CATEGORY, then
      * PERFORM the YACHT subroutine. For testing or an interactive
      * environment, you might do ACCEPT statements, etc.
      *
      * For the code that performs scoring, see PERFORM YACHT
      * below. Adjust as needed for your environment.
      ******************************************************************

           DISPLAY "Enter 5 dice digits (e.g. 12345): "
           ACCEPT WS-DICE

           DISPLAY 
           "Enter category (e.g. 'ones', 'full house', 'yacht'):"
           ACCEPT WS-CATEGORY

           PERFORM YACHT

           DISPLAY "Score is: " WS-RESULT

           STOP RUN.

      ******************************************************************
      * YACHT:  
      *   - Resets WS-RESULT
      *   - Builds frequency table from WS-DICE
      *   - UPPERCASEs WS-CATEGORY
      *   - EVALUATEs WS-CATEGORY to determine final score
      *   - Places final score in WS-RESULT
      ******************************************************************
       YACHT.
           MOVE 0 TO WS-RESULT
           MOVE 0 TO WS-SUM
           PERFORM VARYING I-FREQ FROM 1 BY 1 UNTIL I-FREQ > 6
               MOVE 0 TO WS-FREQ-CNT(I-FREQ)
           END-PERFORM

      ******************************************************************
      * Build frequency table from WS-DICE
      ******************************************************************
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 5
              MOVE FUNCTION NUMVAL(WS-DICE(WS-INDEX:1)) TO WS-DIE
              IF WS-DIE >= 1 AND WS-DIE <= 6
                 ADD 1 TO WS-FREQ-CNT (WS-DIE)
              END-IF
           END-PERFORM

      ******************************************************************
      * UPPERCASE the category so EVALUATE works easily
      ******************************************************************
           INSPECT WS-CATEGORY 
               CONVERTING 'abcdefghijklmnopqrstuvwxyz'
                          TO 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

      ******************************************************************
      * EVALUATE the category
      ******************************************************************
           EVALUATE WS-CATEGORY
             WHEN "ONES"
                COMPUTE WS-RESULT = WS-FREQ-CNT(1) * 1

             WHEN "TWOS"
                COMPUTE WS-RESULT = WS-FREQ-CNT(2) * 2

             WHEN "THREES"
                COMPUTE WS-RESULT = WS-FREQ-CNT(3) * 3

             WHEN "FOURS"
                COMPUTE WS-RESULT = WS-FREQ-CNT(4) * 4

             WHEN "FIVES"
                COMPUTE WS-RESULT = WS-FREQ-CNT(5) * 5

             WHEN "SIXES"
                COMPUTE WS-RESULT = WS-FREQ-CNT(6) * 6

             WHEN "CHOICE"
                PERFORM CALC-SUM-OF-DICE
                MOVE WS-SUM TO WS-RESULT

             WHEN "YACHT"
      *       All five dice must be the same face => freq = 5
                PERFORM CHECK-YACHT

             WHEN "FULL HOUSE"
      *        Exactly 3 of one face and 2 of another => sum of all dice
                PERFORM CHECK-FULL-HOUSE

             WHEN "FOUR OF A KIND"
                PERFORM CHECK-FOUR-OF-A-KIND

             WHEN "LITTLE STRAIGHT"
                PERFORM CHECK-LITTLE-STRAIGHT

             WHEN "BIG STRAIGHT"
                PERFORM CHECK-BIG-STRAIGHT

             WHEN OTHER
                MOVE 0 TO WS-RESULT
           END-EVALUATE

           EXIT.

      ******************************************************************
      * CALC-SUM-OF-DICE: sum of all dice => (freq(1)*1 + freq(2)*2 + ..
      ******************************************************************
       CALC-SUM-OF-DICE.
           MOVE 0 TO WS-SUM
           PERFORM VARYING I-FREQ FROM 1 BY 1 UNTIL I-FREQ > 6
               COMPUTE WS-TEMP = WS-FREQ-CNT(I-FREQ) * I-FREQ
               ADD WS-TEMP TO WS-SUM
           END-PERFORM
           EXIT.

      ******************************************************************
      * CHECK-YACHT: If freq(i) = 5 for some i, score = 50, else 0
      ******************************************************************
       CHECK-YACHT.
           MOVE 0 TO WS-RESULT
           PERFORM VARYING I-FREQ FROM 1 BY 1 UNTIL I-FREQ > 6
              IF WS-FREQ-CNT(I-FREQ) = 5
                 MOVE 50 TO WS-RESULT
                 EXIT PERFORM
              END-IF
           END-PERFORM
           EXIT.

      ******************************************************************
      * CHECK-FULL-HOUSE:
      *   We want exactly one freq = 3 and exactly one freq = 2
      *   If found, result = sum of all dice
      ******************************************************************
       CHECK-FULL-HOUSE.
           MOVE 0 TO WS-TRIPLE-FOUND
           MOVE 0 TO WS-DOUBLE-FOUND
           PERFORM VARYING I-FREQ FROM 1 BY 1 UNTIL I-FREQ > 6
              EVALUATE WS-FREQ-CNT(I-FREQ)
                WHEN 3
                   ADD 1 TO WS-TRIPLE-FOUND
                WHEN 2
                   ADD 1 TO WS-DOUBLE-FOUND
                WHEN OTHER
                   CONTINUE
              END-EVALUATE
           END-PERFORM

           IF WS-TRIPLE-FOUND = 1 AND WS-DOUBLE-FOUND = 1
              PERFORM CALC-SUM-OF-DICE
              MOVE WS-SUM TO WS-RESULT
           ELSE
              MOVE 0 TO WS-RESULT
           END-IF
           EXIT.

      ******************************************************************
      * CHECK-FOUR-OF-A-KIND:
      *   If any freq(i) >= 4, result = i * 4
      *   (If freq(i) = 5, still only 4 are counted, per the rules)
      ******************************************************************
       CHECK-FOUR-OF-A-KIND.
           MOVE 0 TO WS-RESULT
           PERFORM VARYING I-FREQ FROM 1 BY 1 UNTIL I-FREQ > 6
              IF WS-FREQ-CNT(I-FREQ) >= 4
                 COMPUTE WS-RESULT = I-FREQ * 4
                 EXIT PERFORM
              END-IF
           END-PERFORM
           EXIT.

      ******************************************************************
      * CHECK-LITTLE-STRAIGHT:
      *   Must be exactly 1 of each: 1,2,3,4,5 => freq(1..5) all = 1
      ******************************************************************
       CHECK-LITTLE-STRAIGHT.
           IF (WS-FREQ-CNT(1) = 1 AND
               WS-FREQ-CNT(2) = 1 AND
               WS-FREQ-CNT(3) = 1 AND
               WS-FREQ-CNT(4) = 1 AND
               WS-FREQ-CNT(5) = 1 AND
               WS-FREQ-CNT(6) = 0)
              MOVE 30 TO WS-RESULT
           ELSE
              MOVE 0 TO WS-RESULT
           END-IF
           EXIT.

      ******************************************************************
      * CHECK-BIG-STRAIGHT:
      *   Must be exactly 1 of each: 2,3,4,5,6 => freq(2..6) all = 1
      ******************************************************************
       CHECK-BIG-STRAIGHT.
           IF (WS-FREQ-CNT(1) = 0 AND
               WS-FREQ-CNT(2) = 1 AND
               WS-FREQ-CNT(3) = 1 AND
               WS-FREQ-CNT(4) = 1 AND
               WS-FREQ-CNT(5) = 1 AND
               WS-FREQ-CNT(6) = 1)
              MOVE 30 TO WS-RESULT
           ELSE
              MOVE 0 TO WS-RESULT
           END-IF
           EXIT.
