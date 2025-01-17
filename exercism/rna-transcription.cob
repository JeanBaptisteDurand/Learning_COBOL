       IDENTIFICATION DIVISION.
       PROGRAM-ID. rna-transcription.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-COMPLEMENT PIC X(64).

       PROCEDURE DIVISION.
       RNA-TRANSCRIPTION.
          INSPECT WS-COMPLEMENT
               CONVERTING 'GCTA'
                          TO 'CGAU'
       .

