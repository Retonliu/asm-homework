S1    SEGMENT
STRING DW 2,-4,1
LEN  DW ($-STRING)/2
PIAN DW ?
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
        MOV BX,0 ;存放绝对值最大
        LEA SI,STRING 
        MOV CX,LEN
        CLD
NEXT:   LODSW ;把数字放入AX

        TEST AX,8000h
        JZ P
        NEG AX
P:      CMP BX,AX
        JGE L
        MOV BX,AX ;如果AX绝对值最大，则放到BX
        MOV DI,SI
        SUB DI,2 ;纪录便宜地址
L:      LOOP NEXT
        
        MOV LEN,BX
        MOV PIAN,DI
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN
