       IDENTIFICATION DIVISION.
       PROGRAM-ID. nucleotide-count.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DNA PIC X(128).
       01 WS-A PIC 9(4).
       01 WS-C PIC 9(4).
       01 WS-G PIC 9(4).
       01 WS-T PIC 9(4).
       01 WS-ERROR PIC X(36).
       01 WS-SPACE-COUNT PIC 9(4).

       PROCEDURE DIVISION.
       NUCLEOTIDE-COUNT.
           MOVE SPACES TO WS-ERROR.
           MOVE 0 TO WS-SPACE-COUNT.
           INSPECT WS-DNA TALLYING WS-A FOR ALL 'A'
                            WS-C FOR ALL 'C'
                            WS-G FOR ALL 'G'
                            WS-T FOR ALL 'T'.
           INSPECT WS-DNA CONVERTING 'ACGT' TO SPACES.
           INSPECT WS-DNA TALLYING WS-SPACE-COUNT FOR ALL SPACE.
           IF FUNCTION LENGTH(WS-DNA) > WS-SPACE-COUNT
               MOVE "ERROR: Invalid nucleotide in strand" TO WS-ERROR
           END-IF.
         

