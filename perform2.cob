       IDENTIFICATION DIVISION.
       PROGRAM-ID. Perform2.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Counter PIC 9(2) VALUE 0.
       01 MaxValue PIC 9(2) VALUE 5.
       01 Total    PIC 9(4) VALUE 0.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY "== Début des exemples de PERFORM ==".
           
      * Exécution de procédures successives avec THROUGH
           DISPLAY "Exemple de PERFORM ... THROUGH :".
           PERFORM STEP-1 THROUGH STEP-3.

      * Exécution d'une procédure un nombre défini de fois avec TIMES
           DISPLAY "Exemple de PERFORM ... TIMES :".
           PERFORM DISPLAY-MESSAGE 3 TIMES.

      * Exécution avec une boucle contrôlée par VARYING
           DISPLAY "Exemple de PERFORM ... VARYING :".
           PERFORM CALCULATE-SUM
               VARYING Counter FROM 1 BY 1
               UNTIL Counter > MaxValue.

           DISPLAY "La somme des nombres de 1 à " 
           MaxValue " est : " Total.

           DISPLAY "== Fin des exemples de PERFORM ==".
           STOP RUN.

      * Procédures appelées par PERFORM ... THROUGH
       STEP-1.
           DISPLAY "Étape 1 : Initialisation.".
       STEP-2.
           DISPLAY "Étape 2 : Traitement intermédiaire.".
       STEP-3.
           DISPLAY "Étape 3 : Finalisation.".

      * Procédure appelée par PERFORM ... TIMES
       DISPLAY-MESSAGE.
           DISPLAY "Message répété.".

      * Procédure appelée par PERFORM ... VARYING
       CALCULATE-SUM.
           ADD Counter TO Total.
           DISPLAY "Ajout de " Counter " à Total. Total = " Total.
