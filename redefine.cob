       IDENTIFICATION DIVISION.
       PROGRAM-ID.  TEST.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  CR PIC X(10) VALUE "123".
       01  NUM REDEFINES CR PIC 9(10).

       PROCEDURE DIVISION.
             DISPLAY CR
             DISPLAY NUM
             DISPLAY ""

             MOVE "78" TO CR

             DISPLAY CR
             DISPLAY NUM
             DISPLAY ""

             MOVE 37 TO NUM

             DISPLAY CR
             DISPLAY NUM
             DISPLAY ""

             MOVE "U8U" TO CR

             DISPLAY CR
             DISPLAY NUM
             DISPLAY ""
             .
