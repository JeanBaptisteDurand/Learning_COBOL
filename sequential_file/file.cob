       *****************************************************************
       * Exemple de manipulation de fichiers séquentiels en COBOL      *
       *                                                               *
       * F-CLIENT : fichier en lecture (assigné à INP001)              *
       * F-SORTIE : fichier en écriture (assigné à OUT001)              *
       *****************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. FILE-EXAMPLE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           * Déclaration du fichier F-CLIENT en lecture
           SELECT F-CLIENT ASSIGN TO "INP001"
               FILE STATUS IS WS-FS-CLIENT.
           * Déclaration du fichier F-SORTIE en écriture
           SELECT F-SORTIE ASSIGN TO "OUT001"
               FILE STATUS IS WS-FS-SORTIE.

       DATA DIVISION.
       FILE SECTION.
           * (1) Description du fichier F-CLIENT
           FD F-CLIENT
               RECORD CONTAINS 80 CHARACTERS
               BLOCK CONTAINS 10 RECORDS.
           01 FS-ENR-CLIENT PIC X(80).

           * (2) Description du fichier F-SORTIE
           FD F-SORTIE
               RECORD CONTAINS 80 CHARACTERS
               BLOCK CONTAINS 10 RECORDS.
           01 FS-ENR-SORTIE PIC X(80).

       WORKING-STORAGE SECTION.
           * (3) Variables FILE STATUS pour chaque fichier
           01 WS-FS-CLIENT   PIC X(02).
           01 WS-FS-SORTIE   PIC X(02).

           * (4) Structure de l’enregistrement pour F-CLIENT
           01 WS-ENR-CLIENT.
              05 WS-PRENOM  PIC X(20).
              05 WS-NOM     PIC X(20).
              05 WS-ADDR    PIC X(40).

           * Structure de travail pour F-SORTIE
           01 WS-ENR-SORTIE.
              05 WS-DATA    PIC X(80).

       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           *****************************************************************
           * Ouverture des fichiers                                      *
           *****************************************************************
           DISPLAY "Ouverture du fichier F-CLIENT en lecture...".
           OPEN INPUT F-CLIENT.
           IF WS-FS-CLIENT NOT = "00"
               DISPLAY "Erreur lors de l'ouverture de F-CLIENT. FILE STATUS: " WS-FS-CLIENT
               STOP RUN
           END-IF.

           DISPLAY "Ouverture du fichier F-SORTIE en écriture...".
           OPEN OUTPUT F-SORTIE.
           IF WS-FS-SORTIE NOT = "00"
               DISPLAY "Erreur lors de l'ouverture de F-SORTIE. FILE STATUS: " WS-FS-SORTIE
               STOP RUN
           END-IF.

           *****************************************************************
           * Écriture d’un enregistrement dans le fichier F-SORTIE         *
           *****************************************************************
           * Préparation des données dans la zone de travail WS-ENR-SORTIE *
           MOVE "John                " TO WS-DATA (1:20).  *> Exemple : prénom
           MOVE "Doe                 " TO WS-DATA (21:40). *> Exemple : nom
           MOVE "Adresse Exemple, Ville, CP                " TO WS-DATA (41:80).
           WRITE FS-ENR-SORTIE FROM WS-ENR-SORTIE.
           END-WRITE.
           IF WS-FS-SORTIE NOT = "00"
               DISPLAY "Erreur lors de l'écriture dans F-SORTIE. FILE STATUS: " WS-FS-SORTIE
           END-IF.

           *****************************************************************
           * Réécriture d’un enregistrement dans F-SORTIE                  *
           *****************************************************************
           * Dans cet exemple, nous lisons d'abord un enregistrement,      *
           * puis nous le modifions et le réécrivons.                        *
           READ F-SORTIE FROM WS-ENR-SORTIE.
           END-READ.
           IF WS-FS-SORTIE NOT = "00" OR WS-FS-SORTIE = "10"
               DISPLAY "Erreur ou fin de fichier lors de la lecture pour réécriture. FILE STATUS: " WS-FS-SORTIE
           ELSE
               * Modification des données de l’enregistrement
               MOVE "Modification de l'enregistrement dans F-SORTIE après lecture.    "
                   TO WS-DATA.
               REWRITE FS-ENR-SORTIE FROM WS-ENR-SORTIE.
               END-REWRITE.
               IF WS-FS-SORTIE NOT = "00"
                   DISPLAY "Erreur lors de la réécriture dans F-SORTIE. FILE STATUS: " WS-FS-SORTIE
               END-IF.
           END-IF.

           *****************************************************************
           * Fermeture des fichiers                                        *
           *****************************************************************
           CLOSE F-CLIENT.
           CLOSE F-SORTIE.

           DISPLAY "Traitement terminé.".
           STOP RUN.
