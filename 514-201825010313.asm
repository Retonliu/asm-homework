S1    SEGMENT
STRING DW 2,1,1
LEN  DW ($-STRING)/2
COUNT   DW 0
NUM DW ?
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

        LEA SI,STRING
        MOV CX,LEN
NEXT:   LODSW ;把字符存放到AX里面
        PUSH CX
        MOV CX,LEN
        MOV DI,0
L1:     MOV BX,STRING[DI]
        CMP AX,BX
        JNE L2
        INC DX
L2:     ADD DI,2
        LOOP L1
        CMP DX,COUNT
        JB L3
        MOV COUNT,DX
        MOV NUM,AX
        
L3:     POP CX
        XOR DX,DX
        LOOP NEXT
        MOV AX,NUM
        MOV CX,COUNT
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN