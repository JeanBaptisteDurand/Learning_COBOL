       IDENTIFICATION DIVISION.
       PROGRAM-ID. TRIANGLE.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Incoming
       01 WS-SIDES PIC X(20).
       01 WS-PROPERTY PIC X(11).
       01 str-part1 PIC X(5).
       01 str-part2 PIC X(5).
       01 str-part3 PIC X(5).
       01 num1 PIC 9(2)V9.
       01 num2 PIC 9(2)V9.
       01 num3 PIC 9(2)V9.
       01 sum1     PIC 9(3)V9 VALUE 0.
       01 sum2     PIC 9(3)V9 VALUE 0.
       01 sum3     PIC 9(3)V9 VALUE 0.

      *Outgoing
       01 WS-RESULT PIC 9.
       PROCEDURE DIVISION.
       TRIANGLE.
         INITIALIZE WS-RESULT, str-part1, str-part3, str-part2,
            num1, num2, num3, sum1, sum2, sum3.

         UNSTRING WS-SIDES
            DELIMITED BY ','
            INTO str-part1, str-part2, str-part3

         MOVE FUNCTION NUMVAL(str-part1) TO num1
         MOVE FUNCTION NUMVAL(str-part2) TO num2
         MOVE FUNCTION NUMVAL(str-part3) TO num3

         COMPUTE sum1 = num1 + num2
         COMPUTE sum2 = num2 + num3
         COMPUTE sum3 = num1 + num3

         IF sum1 >= num3 AND
            sum2 >= num1 AND
            sum3 >= num2

            IF FUNCTION TRIM(WS-PROPERTY) = "equilateral"
               IF num1 = num2 AND num2 = num3 AND num1 NOT = 0
                  MOVE 1 TO  WS-RESULT
               END-IF
            END-IF
   
            IF FUNCTION TRIM(WS-PROPERTY) = "isosceles"
               IF num1 = num2 or num2 = num3 or num1 = num3
                  MOVE 1 TO  WS-RESULT
               END-IF
            END-IF
   
            IF FUNCTION TRIM(WS-PROPERTY) = "scalene"
               IF num1 NOT = num2 AND num1 NOT = num3 AND
                  num2 NOT = num3
                  MOVE 1 TO  WS-RESULT
               END-IF
            END-IF
         END-IF

       INITIALIZE WS-SIDES, WS-PROPERTY
       