S1    SEGMENT
STRING DB 'ABC123D'
LEN  DB ($-STRING)
S1    ENDS
STACK   SEGMENT STACK
    DB 10 DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME  DS:S1,SS:STACK,CS:CODE
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX

        XOR CX,CX
        XOR AX,AX
        LEA SI,STRING
        MOV CL,LEN
NEXT:   LODSB
        CMP AL,30H
        JB L
        CMP AL,39H
        JA L
        MOV CX,16
        JMP STOP
L:      LOOP NEXT
STOP:   MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN