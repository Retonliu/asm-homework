DATA    SEGMENT
BUF     DB 30H DUP('$')
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 20H DUP(?)
TOS     LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
        
START:  MOV AX,DATA
        MOV DS,AX

        MOV CX,16
        MOV BX,65535
L1:     ROL BX,1
        JC L2
        MOV DL,30H
        JMP L3
L2:     MOV DL,31H
L3:     MOV AH,2
        INT 21H
        LOOP L1
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START


