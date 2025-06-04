       IDENTIFICATION DIVISION.
       PROGRAM-ID. allergies.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SCORE       PIC 999.
       01 WS-ITEM        PIC X(12).
       01 WS-RESULT      PIC A.
       01 WS-RESULT-LIST PIC X(108).
       01 WS-AUX-LIST PIC X(108).
       01 WS-ITEM-AUX    PIC X(12).
       01 WS-VALOR       PIC 9(03).
       01 WS-DIVISIBLE   PIC 9.
       PROCEDURE DIVISION.
       ALLERGIC-TO.
      * Code this paragraph
           PERFORM INICI-VALORES
           IF WS-SCORE > 0
              MOVE WS-SCORE TO WS-VALOR
              PERFORM CALCULAR-ALERG
           END-IF
           CONTINUE.
       LIST-ALLERGENS.
      * Code this paragraph
           PERFORM INICI-VALORES
           IF WS-SCORE > 0
              MOVE WS-SCORE TO WS-VALOR
              PERFORM CALCULAR-ALERG
           END-IF
           .
       CALCULAR-ALERG.
           IF WS-VALOR = 257
              MOVE "eggs" TO WS-AUX-LIST
              MOVE "Y"    TO WS-RESULT
              MOVE 0      TO WS-VALOR
           END-IF
           IF WS-VALOR > 127
              COMPUTE WS-DIVISIBLE = WS-VALOR / 128
              COMPUTE WS-VALOR = WS-VALOR - (128 * WS-DIVISIBLE)
              MOVE "cats" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'cats'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 63) AND (WS-VALOR < 128))
              COMPUTE WS-VALOR = WS-VALOR - 64
              MOVE "pollen" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'pollen'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 31) AND (WS-VALOR < 64))
              COMPUTE WS-VALOR = WS-VALOR - 32
              MOVE "chocolate" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'chocolate'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 15) AND (WS-VALOR < 32))
              COMPUTE WS-VALOR = WS-VALOR - 16
              MOVE "tomatoes" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'tomatoes'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 7)  AND (WS-VALOR < 16))
              COMPUTE WS-VALOR = WS-VALOR - 8
              MOVE "strawberries" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'strawberries'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 3)  AND (WS-VALOR < 8))
              COMPUTE WS-VALOR = WS-VALOR - 4
              MOVE "shellfish" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'shellfish'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF ((WS-VALOR > 1)  AND (WS-VALOR < 4))
              COMPUTE WS-VALOR = WS-VALOR - 2
              MOVE "peanuts" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'peanuts'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           IF (WS-VALOR > 0)
              COMPUTE WS-VALOR = WS-VALOR - 1
              MOVE "eggs" TO WS-ITEM-AUX
              PERFORM ARMA-CADENA
              IF WS-ITEM = 'eggs'
                 MOVE 'Y' TO WS-RESULT
              END-IF
           END-IF
           MOVE WS-AUX-LIST TO WS-RESULT-LIST
           CONTINUE 
           .
       INICI-VALORES.
           INITIALIZE WS-VALOR
                      WS-RESULT-LIST
                      WS-DIVISIBLE
                      WS-AUX-LIST
           MOVE 'N' TO WS-RESULT
           .
       ARMA-CADENA.
           IF WS-AUX-LIST = SPACES
              MOVE WS-ITEM-AUX TO WS-RESULT-LIST
           ELSE
              STRING WS-ITEM-AUX ',' WS-AUX-LIST
                     DELIMITED BY ''
                     INTO WS-RESULT-LIST
           END-IF
           MOVE WS-RESULT-LIST TO WS-AUX-LIST
           MOVE SPACES TO WS-RESULT-LIST
           .