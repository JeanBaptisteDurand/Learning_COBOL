IDENTIFICATION DIVISION.
PROGRAM-ID. EXEMP_SQL.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.

DATA DIVISION.
WORKING-STORAGE SECTION.

* Déclaration des variables hôtes pour l’interaction avec DB2
01 WS-ID-CLIENT       PIC 9(5).         *> Identifiant du client
01 WS-NOM             PIC X(20).        *> Nom du client
01 WS-PRENOM          PIC X(20).        *> Prénom du client
01 WS-SQLCODE         PIC S9(9).        *> Code SQL pour vérifier les erreurs

PROCEDURE DIVISION.

* Étape 1 : Demander l'identifiant du client
AFFICHER-ID.
    DISPLAY "Entrez l'identifiant du client : " WITH NO ADVANCING.
    ACCEPT WS-ID-CLIENT.

* Étape 2 : Exécuter la requête SQL pour récupérer les données du client
REQUETE-SQL.
    EXEC SQL
        SELECT NOM, PRENOM
        INTO :WS-NOM, :WS-PRENOM
        FROM CLIENT
        WHERE ID_CLIENT = :WS-ID-CLIENT
    END-EXEC.

* Étape 3 : Vérifier si la requête a réussi
    MOVE SQLCODE TO WS-SQLCODE.
    IF WS-SQLCODE = 0
        DISPLAY "Nom du client : " WS-NOM
        DISPLAY "Prénom du client : " WS-PRENOM
    ELSE
        DISPLAY "Erreur : Client introuvable ou problème SQL."
    END-IF.

* Étape 4 : Terminer le programme
FIN-PROGRAMME.
    DISPLAY "Programme terminé.".
    STOP RUN.