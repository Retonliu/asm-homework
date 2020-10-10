DATA    SEGMENT
BUF DB 10 DUP(?)
DATA    ENDS
STACK   SEGMENT STACK
DB 10 DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX

        MOV AX,0F1H
        MOV DX,0
        MOV CX,8
L1:     MOV BX,AX
        AND BX,3
        CMP BX,3
        JNE L2
        INC DX
L2:     PUSH CX
        MOV CL,2
        SHR AX,CL
        POP CX
        LOOP L1

        ADD DL,30H
        MOV AH,2
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END MAIN