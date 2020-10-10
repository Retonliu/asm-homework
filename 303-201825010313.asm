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
        MOV BX,27707
        MOV CX,4
L1:     PUSH CX
        MOV CL,4
        ROL BX,CL
        MOV DL,BL
        AND DL,15
        ADD DL,30H
        CMP DL,39H
        JBE L2
        ADD DL,7
L2:     MOV AH,2
        INT 21H
        POP CX
        LOOP L1
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START
