      *****************************************************************
      * Program name:    CHAR                               
      * Original author: JEDURAND                                
      *
      * Maintenence Log                                              
      * Date      Author        Maintenance Requirement               
      * --------- ------------  --------------------------------------- 
      * 01/01/08 MYNAME  Created for COBOL class         
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CHAR.
       AUTHOR. JEDURAND. 
       INSTALLATION. COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN. 01/01/08. 
       DATE-COMPILED. 01/01/08. 
       SECURITY. NON-CONFIDENTIAL.
      *****************************************************************

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  C PIC X(1) VALUE ' '.
       01  I PIC 9(3) VALUE 0.


       PROCEDURE DIVISION.
           PERFORM VARYING I
            FROM 0 BY 1
            UNTIL I > 400
              MOVE FUNCTION CHAR(I) TO C
              DISPLAY I " : " C " /"
           END-PERFORM.
              
           