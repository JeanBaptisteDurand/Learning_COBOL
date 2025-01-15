       IDENTIFICATION DIVISION.
       PROGRAM-ID. LoopAndEvaluateDemo.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 UserNumber PIC 9(3).
       01 Counter    PIC 9(3) VALUE 1.
       01 RESULT        PIC 9(5) VALUE 0.
       01 TMP    PIC 9(2) VALUE 0.
       
       PROCEDURE DIVISION.
           DISPLAY "Entrez un nombre (1-100) :".
           ACCEPT UserNumber.
       
      *    Boucle pour calculer la somme de 1 à UserNumber.
           PERFORM VARYING Counter FROM 1 BY 1 UNTIL
           Counter > UserNumber
               ADD Counter TO RESULT
           END-PERFORM.
       
           DISPLAY "La somme des nombres de 1 à " UserNumber 
           " est : " RESULT.
       
      *    Boucle conditionnelle pour afficher les multiples de 3.
           MOVE 1 TO Counter.
           PERFORM UNTIL Counter > UserNumber
               DIVIDE Counter BY 3 GIVING TMP REMAINDER TMP
               IF TMP = 0
                   DISPLAY "Multiple de 3 : " Counter
               END-IF
               ADD 1 TO Counter
           END-PERFORM.
       
           EVALUATE UserNumber
               WHEN 1 THRU 10
                   DISPLAY "Petit nombre."
               WHEN 11 THRU 50
                   DISPLAY "Nombre moyen."
               WHEN 51 THRU 100
                   DISPLAY "Grand nombre."
               WHEN OTHER
                   DISPLAY "Nombre hors limites."
           END-EVALUATE.
       
           STOP RUN.
       