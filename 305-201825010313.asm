DATA    SEGMENT
BUF     DB 30H DUP('$')
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 20H DUP(?)
TOS     LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        MOV BX,0FFFFH=
        TEST BX,BX
        JNZ L1
        MOV DL,'0' ;bx存储的数据为0
        MOV AH,2
        INT 21H
        JMP L5 ;程序结束
L1:     JNS L2 ;如果是正数则跳转
        MOV DL,'-'
        MOV AH,2
        INT 21H
        NEG BX ;求得BX里面的数的补数
L2:     XOR CX,CX
        MOV AX,BX
L3:     XOR DX,DX
        MOV SI,10
        DIV SI
        PUSH DX
        INC CX
        CMP AX,0
        JNE L3
L4:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP L4

L5:     MOV AH,4CH
        INT 21H
CODE    ENDS
END     START


