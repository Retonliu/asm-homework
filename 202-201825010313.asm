DATA    SEGMENT
BUF     DB 30 DUP('$')
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 1H DUP(?)
TOS     LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
START:  MOV AX,DATA
        MOV DS,AX
        LEA BX,BUF+11 ;将数据段的段基址放到SI当中
        MOV CX,12
L1:     MOV AH,1
        INT 21H
        MOV [BX],AL
        DEC BX
        LOOP L1

        MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H

        LEA DX,BUF
        MOV AH,9
        INT 21H
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START