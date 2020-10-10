DATA    SEGMENT
BUFF    DB 0FFH,?,0FFH DUP(?)
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 1H DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA,SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
INPUT:  LEA DX,BUFF
        MOV AH,0AH
        INT 21H
        MOV SI,DX
        MOV BL,[SI+1] ;从[SI+2]开始有输入字符
        XOR BH,BH
        MOV CL,BL
        XOR CH,CH

        MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H

OUTPUT: MOV DL,BUFF+1[BX]
        CMP DL,0AH
        JE STOP
        DEC BX
        MOV AH,2
        INT 21H
        LOOP OUTPUT
STOP:   MOV AH,4CH
        INT 21H
CODE    ENDS
END     START
