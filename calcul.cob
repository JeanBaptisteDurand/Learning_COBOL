       IDENTIFICATION DIVISION.
       PROGRAM-ID. Calcul.
       AUTHOR. JEDURAND.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  INPUT1 PIC 9(3).
       01  INPUT2 PIC 9(3).
       01  RESULT PIC 9(3).

       PROCEDURE DIVISION.
           DISPLAY "Enter first number :".
           ACCEPT INPUT1.

           DISPLAY "Enter second number :".
           ACCEPT INPUT2.

           ADD INPUT1 TO INPUT2 GIVING RESULT.

           DISPLAY "Sum is : " RESULT.

           IF RESULT > 100
               DISPLAY "Big Result"
           END-IF.

           STOP RUN.
