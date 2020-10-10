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

        MOV BX,65535
        ROL BX,1
        MOV DL,0 ;清零
        ADC DL,30H
        MOV AH,2
        INT 21H
        MOV CX,5
L1:     PUSH CX
        MOV CL,3
        ROL BX,CL
        MOV DL,BL
        AND DL,7
        ADD DL,30H
        MOV AH,2
        INT 21H
        POP CX
        LOOP L1
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START

