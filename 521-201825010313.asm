S1  SEGMENT
ARRAY DW -1,-1,-1; -1,-1,512; -1,10,512
S1  ENDS
STACK   SEGMENT STACK
    DW 5 DUP(?)
STACK ENDS
CODE SEGMENT
        ASSUME DS:S1,SS:STACK,CS:CODE,ES:S1
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX

        XOR BX,BX ;用于计数多少个数相等
        LEA SI,ARRAY
        MOV CX,2
O:      LODSW ;AX
I:      PUSH CX
        MOV DI,SI
        CLD
        REPNE SCASW
        JZ E
        JCXZ N
E:      INC BX
N:      POP CX
        LOOP O
        MOV AH,2
        MOV DL,BL
        ADD DL,30H
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN