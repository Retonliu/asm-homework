DATA    SEGMENT
ENG     DB 'SUNSANSUN$'
KEY     DB 'SUN'
STR     DB 'SUN:$'
DATA    ENDS
STACK   SEGMENT STACK
        DW 10H DUP(?)
    TOP LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA,SS:STACK,ES:DATA
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOP

        XOR AX,AX;用于计数
        MOV DX,KEY-ENG-2 ;判断什么时候结束比较
        LEA BX,ENG
L1:     MOV DI,BX
        LEA SI,KEY
        MOV CX,3
        REPE CMPSB
        JNZ L2
        INC AX ;计数
L2:     INC BX
        DEC DX
        CMP DX,0
        JNZ L1

        XOR CX,CX
L3:     XOR DX,DX
        MOV SI,10
        DIV SI
        PUSH DX
        INC CX
        CMP AX,0
        JNE L3
L4:     LEA DX,STR
        MOV AH,9
        INT 21H
L5:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP L5
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END    MAIN


