       IDENTIFICATION DIVISION.
       PROGRAM-ID. hamming.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DNA-1 PIC X(32).
       01 WS-DNA-2 PIC X(32).
       01 WS-HAMMING PIC 9(2).
       01 WS-ERROR PIC X(31).
       01 WS-L1 PIC 99.
       01 WS-L2 PIC 99.
       01 WS-I PIC 99 VALUE 1.

       PROCEDURE DIVISION.
       MAIN.
       	MOVE "GGACGGATTCTG" TO WS-DNA-1
       	MOVE "AGGACG" TO WS-DNA-2
       	PERFORM HAMMING
       	DISPLAY WS-HAMMING
       	DISPLAY WS-ERROR
         STOP RUN.

       HAMMING.
         MOVE 1 TO WS-I
         MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-DNA-1)) TO WS-L1
         MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-DNA-2)) TO WS-L2
           IF WS-L1 = WS-L2
               PERFORM UNTIL WS-I > WS-L1
                   IF WS-DNA-1(WS-I:1) NOT = WS-DNA-2(WS-I:1)
                       ADD 1 TO WS-HAMMING
                   END-IF
                   ADD 1 TO WS-I
               END-PERFORM
           ELSE
               MOVE "Strands must be of equal length" TO WS-ERROR
           END-IF
         .
         
