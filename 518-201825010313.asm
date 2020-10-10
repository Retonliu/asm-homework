DATA    SEGMENT
GRADE DB 3,4,5 ;30 DUP(?)
RANK DB 3 DUP(?) ;30 DUP(?)
DATA    ENDS
STACK   SEGMENT STACK
 DB 10 DUP (?)
TOS LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA, SS:STACK, CS:CODE
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS

        LEA SI,GRADE
        MOV CX,3
        XOR AX,AX
O:      MOV AL,[SI]
        PUSH CX
        MOV CX,3
        MOV BX,0 ;用于计数
        LEA DI,GRADE
I:      CMP AL,[DI]
        JGE NEXT
        INC BX
NEXT:   INC DI
        LOOP I
        INC BX  ;人数加一
        MOV RANK[SI],BL ;SI是从0开始的，所以可以用来作为有效地址的一部分
        INC SI
        POP CX
        LOOP O
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN