DATA    SEGMENT 
        BUF  DB  'Hello, world!$'
DATA    ENDS 
STACK   SEGMENT STACK 'STACK' 
        DW 3H DUP(?) 
STACK   ENDS 
CODE    SEGMENT 
        ASSUME CS:CODE,DS:DATA,SS:STACK 
START:  MOV AX,DATA 
        MOV DS,AX
        LEA BX,BUF
        MOV CX,13
OUTPUT: MOV DL,[BX]
        CMP DL,24H
        JE STOP
        MOV AH,2
        INT 21H
        INC BX
        LOOP OUTPUT
STOP:   MOV AH,4CH 
        INT 21H 
CODE    ENDS 
        END  START
