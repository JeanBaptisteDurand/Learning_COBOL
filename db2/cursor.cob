IDENTIFICATION DIVISION.
PROGRAM-ID. MISE-A-JOUR-CURSEUR.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
EXEC SQL INCLUDE SQLCA END-EXEC.

01 WS-ID-CLIENT       PIC 9(5).
01 WS-NOM-CLIENT      PIC X(50).
01 WS-EMAIL-CLIENT    PIC X(100).

PROCEDURE DIVISION.
    DISPLAY "Ouverture du curseur pour les mises à jour des emails..."

    EXEC SQL
        DECLARE CURSOR_CLIENT CURSOR FOR
        SELECT ID_CLIENT, NOM_CLIENT, EMAIL_CLIENT
        FROM CLIENTS
        WHERE ETAT = 'ACTIF'
        FOR UPDATE OF EMAIL_CLIENT
    END-EXEC.

    EXEC SQL
        OPEN CURSOR_CLIENT
    END-EXEC.

    IF SQLCODE = 0
        DISPLAY "Curseur ouvert avec succès."
    ELSE
        DISPLAY "Erreur lors de l'ouverture du curseur : " SQLCODE.

    PERFORM UNTIL SQLCODE = 100
        EXEC SQL
            FETCH CURSOR_CLIENT
            INTO :WS-ID-CLIENT, :WS-NOM-CLIENT, :WS-EMAIL-CLIENT
        END-EXEC.

        IF SQLCODE = 0
            IF WS-EMAIL-CLIENT NOT CONTAINING '@'
                DISPLAY "Correction de l'email pour le client : " WS-NOM-CLIENT
                MOVE "email.corrige@exemple.com" TO WS-EMAIL-CLIENT

                EXEC SQL
                    UPDATE CLIENTS
                    SET EMAIL_CLIENT = :WS-EMAIL-CLIENT
                    WHERE CURRENT OF CURSOR_CLIENT
                END-EXEC.

                IF SQLCODE = 0
                    DISPLAY "Email mis à jour avec succès."
                ELSE
                    DISPLAY "Erreur lors de la mise à jour : " SQLCODE.
            END-IF
        ELSE IF SQLCODE = 100
            DISPLAY "Fin du curseur."
        ELSE
            DISPLAY "Erreur lors de la lecture du curseur : " SQLCODE.
    END-PERFORM.

    EXEC SQL
        CLOSE CURSOR_CLIENT
    END-EXEC.

    STOP RUN.
