       IDENTIFICATION DIVISION.
       PROGRAM-ID. ROTATIONAL-CIPHER.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-KEY             PIC 9(2).       *> 0..26 shift
       01  WS-TEXT            PIC X(128).     *> Input text
       01  WS-CIPHER          PIC X(128).     *> Output cipher

       01  WS-INDEX           PIC 9(3) VALUE 0.
       01  WS-CHAR            PIC X(1).
       01  WS-ASCII           PIC 9(4) BINARY.
       01  WS-LVAL            PIC 9(4) BINARY.
       01  WS-DUM             PIC 9(4) BINARY.
       01  WS-OFFSET          PIC 9(4) BINARY.
       01  WS-SHIFTED-CHAR    PIC X(1).

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           MOVE 1 TO WS-KEY
           MOVE "xyza" to WS-TEXT

           PERFORM ROTATIONAL-CIPHER

           DISPLAY WS-CIPHER

           STOP RUN.


       ROTATIONAL-CIPHER.
           INSPECT WS-TEXT
               CONVERTING 'abcdefghijklmnopqrstuvwxyz'
                          TO 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

           DISPLAY WS-TEXT

           MOVE ALL ' ' TO WS-CIPHER

           PERFORM VARYING WS-INDEX FROM 1 BY 1
             UNTIL WS-INDEX > LENGTH OF WS-TEXT

               MOVE WS-TEXT(WS-INDEX:1) TO WS-CHAR
               COMPUTE WS-ASCII = FUNCTION ORD(WS-CHAR)

               IF WS-ASCII >= 66 AND WS-ASCII <= 91
                  COMPUTE WS-LVAL = (WS-ASCII - 66) + WS-KEY
                  DIVIDE WS-LVAL BY 26
                     GIVING WS-DUM
                     REMAINDER WS-OFFSET
                  COMPUTE WS-ASCII = 66 + WS-OFFSET

                  MOVE FUNCTION CHAR(WS-ASCII) TO WS-SHIFTED-CHAR
               ELSE
                  MOVE WS-CHAR TO WS-SHIFTED-CHAR
               END-IF

               MOVE WS-SHIFTED-CHAR TO WS-CIPHER(WS-INDEX:1)
           END-PERFORM
           .
