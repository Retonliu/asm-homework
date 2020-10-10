DATA    SEGMENT
BUF DB 10H DUP(?)
STR DB 0DH,0AH,'$'
DATA    ENDS
STACK   SEGMENT STACK
    DW  10 DUP(?)
TOS     LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME  DS:DATA,CS:CODE,SS:STACK
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        XOR SI,SI ;用于计数
        XOR DX,DX
I:      MOV AH,1
        INT 21H
        CMP AL,'$'
        JE  O
        CMP AL,'0'
        JB I
        CMP AL,'9'
        JA I
        INC SI
        JMP I
O:      LEA DX,STR
        MOV AH,9
        INT 21H
        XOR CX,CX
        XOR DX,DX
        MOV AX,SI
O1:     MOV SI,10
        DIV SI
        PUSH DX
        INC CX
        CMP AX,0
        JE O2
O2:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP O2
STOP:   MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END MAIN