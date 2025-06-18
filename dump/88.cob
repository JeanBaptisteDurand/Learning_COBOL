       IDENTIFICATION DIVISION.
       PROGRAM-ID. AddressDemo.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  Adresse.
           05 Rue PIC X(20) VALUE "42 Rue des Lilas".
           05 Ville PIC X(20) VALUE "Paris".
           05 EtatActif PIC X VALUE "A".
           88 EstActif VALUE "A".
           88 EstInactif VALUE "I".
       
       PROCEDURE DIVISION.
           DISPLAY "Adresse : " Rue ", " Ville.
       
           IF EstActif
               DISPLAY "L'état est actif."
           ELSE
               DISPLAY "L'état est inactif."
           END-IF.
       
           STOP RUN.
