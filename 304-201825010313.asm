DATA    SEGMENT
BUF     DB 30H DUP('$')
Z       DB 10
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
        MOV BX,27707
        MOV AX,BX
        XOR CX,CX
L1:     XOR DX,DX
        MOV SI,10
        DIV SI
        PUSH DX ;余数压入堆栈段
        INC CX ;标记当前压入了多少个数
        CMP AX,0
        JNE L1

L2:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP L2
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START