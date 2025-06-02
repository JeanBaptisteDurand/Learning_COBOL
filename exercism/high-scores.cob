       IDENTIFICATION DIVISION.
       PROGRAM-ID. high-scores.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-PROPERTY       PIC A(20).
       01 WS-SCORES.
           02 SCORES        PIC X(3) OCCURS 20 TIMES
                            INDEXED BY IDX.

       01 WS-RESULT-STRING.
            02 RESULT        PIC X(3) OCCURS 20 TIMES.
       01 WS-RESULT-VALUE   PIC 999.
       01 WS-MAXIMUM         PIC 9(3) VALUE 0.
       01 WS-MAXIMUM-H      PIC X(3).
       01 WS-MI            PIC 99 VALUE 1.
       01 WS-INDEX            PIC 99 VALUE 1.
       01 WS-LAST        PIC 9(3) VALUE 0.
       01 WS-RS         PIC 99 VALUE 1.


       PROCEDURE DIVISION.
       HIGH-SCORES.
           initialise WS-RESULT-STRING, WS-RESULT-VALUE, WS-MI,
                       WS-INDEX, WS-RS
           evaluate true
               when WS-PROPERTY = "scores"
                   MOVE WS-SCORES TO WS-RESULT-STRING
      
               when WS-PROPERTY = "latest"
                   PERFORM FIND-LAST
                   MOVE WS-LAST TO WS-RESULT-VALUE
      
               when WS-PROPERTY = "personalBest"
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO WS-RESULT-VALUE
      
               when WS-PROPERTY = "personalTopThree"
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)
      
                   PERFORM CALCULATE-MAXIMUM
                   MOVE WS-MAXIMUM TO RESULT(WS-RS)
                   ADD 1 to WS-RS
                   MOVE "000" to SCORES(WS-MI)

           initialise WS-PROPERTY, WS-SCORES.


       FIND-LAST.
           MOVE 0 TO WS-LAST
           MOVE 20 to WS-INDEX
           PERFORM UNTIL WS-LAST <> 0 OR WS-INDEX < 1
               if SCORES(WS-INDEX) <> 0
                   MOVE SCORES(WS-INDEX) TO WS-LAST
               SUBTRACT 1 FROM WS-INDEX
           END-PERFORM.


       CALCULATE-MAXIMUM.
           MOVE FUNCTION NUMVAL(SCORES(1)) TO WS-MAXIMUM
           MOVE SPACES to WS-MAXIMUM-H
           MOVE 1 TO WS-INDEX
           PERFORM VARYING WS-INDEX FROM 2 BY 1 UNTIL WS-INDEX > 20
               IF SCORES(WS-INDEX) > WS-MAXIMUM
                   MOVE SCORES(WS-INDEX) TO WS-MAXIMUM-H
                   MOVE FUNCTION NUMVAL(SCORES(WS-INDEX)) TO WS-MAXIMUM
                   MOVE WS-INDEX TO WS-MI
               END-IF
           END-PERFORM.




TestCase "List of scores"
    MOVE " 30 50 20 70" TO WS-SCORES
    MOVE "scores" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 30 50 20 70"
TestCase "Latest score"
    MOVE "100  0 90 30" TO WS-SCORES
    MOVE "latest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-VALUE =  30
TestCase "Personal best"
    MOVE " 40100 70" TO WS-SCORES
    MOVE "personalBest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-VALUE = 100
TestCase "Personal top three from a list of scores"
    MOVE " 10 30 90 30100 20 10  0 30 40 40 70 70" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = "100 90 70"
TestCase "Personal top highest to lowest"
    MOVE " 20 10 30" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 30 20 10"
TestCase "Personal top when there is a tie"
    MOVE " 40 20 40 30" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 40 40 30"
TestCase "Personal top when there are less than 3"
    MOVE " 30 70" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 70 30"
TestCase "Personal top when there is only one"
    MOVE " 40" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 40"
TestCase "Latest score after personal top scores"
    MOVE " 70 50 20 30" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    MOVE "latest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-VALUE =  30
TestCase "Scores after personal top scores"
    MOVE " 30 50 20 70" TO WS-SCORES
    MOVE "personalTopThree" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    MOVE "scores" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 30 50 20 70"
TestCase "Latest score after personal best"
    MOVE " 20 70 15 25 30" TO WS-SCORES
    MOVE "personalBest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    MOVE "latest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-VALUE =  30
TestCase "Scores after personal best"
    MOVE " 20 70 15 25 30" TO WS-SCORES
    MOVE "personalBest" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    MOVE "scores" TO WS-PROPERTY
    PERFORM HIGH-SCORES
    EXPECT WS-RESULT-STRING = " 20 70 15 25 30"



PASS:   1. List of scores                                                                  
     PASS:   2. Latest score                                                                    
     PASS:   3. Personal best                                                                   
**** FAIL:   4. Personal top three from a list of scores                                        
    EXPECTED <100 90 70>, WAS <010010>
**** FAIL:   5. Personal top highest to lowest                                                  
    EXPECTED < 30 20 10>, WAS <020020>
**** FAIL:   6. Personal top when there is a tie                                                
    EXPECTED < 40 40 30>, WAS <040040>
**** FAIL:   7. Personal top when there are less than 3                                         
    EXPECTED < 70 30>, WAS <030030>
**** FAIL:   8. Personal top when there is only one                                             
    EXPECTED < 40>, WAS <040040>
**** FAIL:   9. Latest score after personal top scores                                          
    EXPECTED +00000000030.0000000, WAS +00000000000.0000000
**** FAIL:  10. Scores after personal top scores                                                
    EXPECTED < 30 50 20 70>, WAS <>
     PASS:  11. Latest score after personal best                                                
     PASS:  12. Scores after personal best 