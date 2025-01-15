       IDENTIFICATION DIVISION.
       PROGRAM-ID. ClientExample.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Client.
          05 Nom         PIC X(20) VALUE "Jean Dupont".
          05 Adresse.
             10 Rue        PIC X(30) VALUE "10 Rue de la Paix".
             10 CodePostal PIC 9(5)  VALUE 75001.
             10 Ville      PIC X(20) VALUE "Paris".
          05 Contact.
             10 Telephone  PIC X(10) VALUE "0612345678".
             10 Email      PIC X(30) VALUE "jean.dupont@mail.com".
       
       PROCEDURE DIVISION.
           DISPLAY "Fiche client initiale :".
           DISPLAY "Nom : " Nom.
           DISPLAY "Adresse : " Rue ", " CodePostal ", " Ville.
           DISPLAY "Contact : Tel=" Telephone ", Email=" Email.
       
      *    Mise à jour des informations du client
           MOVE "Marie Curie" TO Nom.
           MOVE "5 Boulevard Haussmann" TO Rue.
           MOVE 75009 TO CodePostal.
           MOVE "Paris" TO Ville.
           MOVE "0712345678" TO Telephone.
           MOVE "marie.curie@mail.com" TO Email.
       
           DISPLAY "Fiche client mise à jour :".
           DISPLAY "Nom : " Nom.
           DISPLAY "Adresse : " Rue ", " CodePostal ", " Ville.
           DISPLAY "Contact : Tel=" Telephone ", Email=" Email.
       
           STOP RUN.
