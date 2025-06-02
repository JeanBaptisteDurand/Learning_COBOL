       IDENTIFICATION DIVISION.
       PROGRAM-ID. QUEEN-ATTACK.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Inputs
       01 WS-QUEEN PIC X(9).
       01 WS-WHITE_QUEEN PIC X(9).
       01 WS-BLACK_QUEEN PIC X(9).
       01 WS-PROPERTY PIC X(11).
      *Outputs
       01 WS-RESULT PIC 9.
       01 ws-local.
          03 ws-row    pic s9.
          03 ws-col    pic s9.
          03 ws-wr     pic 9.
          03 ws-wc     pic 9.
          03 ws-br     pic 9.
          03 ws-bc     pic 9.      
          03 ws-d1     pic 9.
          03 ws-d2     pic 9.
      
       PROCEDURE DIVISION.
       QUEEN-ATTACK.
           move 1 to ws-result
           evaluate true
            when WS-PROPERTY = "create"
               unstring WS-QUEEN delimited by "," into ws-row, ws-col
               if ws-col < 0 or ws-row < 0 or
                  ws-col > 7 or ws-row > 7 
                   move 0 to ws-result
            when WS-PROPERTY = "canAttack"
               unstring WS-WHITE_QUEEN delimited by "," 
                   into ws-wr, ws-wc
               unstring WS-BLACK_QUEEN delimited by "," 
                   into ws-br, ws-bc
               subtract ws-wr from ws-br giving ws-d1
               subtract ws-wc from ws-bc giving ws-d2
               if ws-wr <> ws-br and ws-wc <> ws-bc
                   if ws-d1 <> ws-d2
                       move 0 to ws-result
           end-evaluate
           display ws-result
       .
       QUEEN-ATTACK-EXIT.
       goback
       .
      