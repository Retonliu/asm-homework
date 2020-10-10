S1    SEGMENT
A DB 3
B DB 2
C DB 4
D DB 1 DUP(?)
S1    ENDS
STACK   SEGMENT STACK
 DB 10 DUP (?)
TOS LABEL WORD
STACK   ENDS
CODE  SEGMENT
    ASSUME DS:S1,SS:STACK,CS:CODE,ES:S1
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS
        LEA DI,A
        XOR AX,AX
        MOV CX,3
        CLD
        REPNE SCASB
        JZ CLEAN
        JCXZ SUM
CLEAN:  LEA DI,A
        MOV CX,3
Q:      MOV BX,0
        MOV [DI],BX
        INC DI
        LOOP Q
        JMP STOP

SUM:    LEA DI,A
        XOR BX,BX
        MOV CX,3
S:      ADD BL,[DI]
        INC DI
        LOOP S
        MOV D,BL    
STOP:   MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN