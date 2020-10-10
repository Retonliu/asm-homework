S1    SEGMENT
DATA DW 2,-4,8
LEN  DW ($-DATA)/2
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

        XOR DX,DX
        XOR AX,AX
        LEA SI,DATA
        MOV CX,LEN

NEXT:   PUSH CX
        CWD ;拓展AX
        MOV BX,AX
        MOV CX,DX
        MOV AX,DATA[SI]
        CWD ;拓展AX
        ADD AX,BX
        ADC DX,CX ;把进位也添加进去
        ADD SI,2
        POP CX
        LOOP NEXT

        MOV DI,LEN
        DIV DI
        LEA DI,DATA
        MOV CX,LEN
        XOR BX,BX

PAN:    MOV DX,DATA[DI]
        CMP DX,AX
        JGE TIAO
        INC BX
TIAO:   ADD DI,2
        LOOP PAN

        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN



