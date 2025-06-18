       IDENTIFICATION DIVISION. 
       PROGRAM-ID. user_input.

       DATA DIVISION.
       WORKING-STORAGE SECTION. 
       01  WS-STORAGE PIC X(12).
 
       PROCEDURE DIVISION.
              DISPLAY "Enter your name: ".
              ACCEPT WS-STORAGE.
              DISPLAY "Hello, " WS-STORAGE "!".
              STOP RUN.

              