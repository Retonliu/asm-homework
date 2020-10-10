S1    SEGMENT
WHITE   DB 0DH,0AH,24H
BUFF1   DB 30H
        DB ?
        DB 30H DUP(?)
M1      DB 'NO MATCH',0DH,0AH,24H
M2      DB 'MATCH',0DH,0AH,24H
S1    ENDS
STACK   SEGMENT STACK
        DW 10H DUP(?)
TOS     LABEL WORD
STACK   ENDS
S2   SEGMENT
BUFF2   DB 30H
        DB ?
        DB 30H DUP(?)
S2   ENDS
CODE    SEGMENT
        ASSUME CS:CODE,DS:S1,SS:STACK,ES:S2
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS
        MOV AX,S2
        MOV ES,AX

        CLD
        LEA DX,BUFF1
        MOV AH,0AH
        INT 21H ;输入第一个串

        LEA DX,WHITE
        MOV AH,9
        INT 21H

        PUSH DS
        PUSH ES
        POP DS  ;DS和ES进行交换，这样可以把字符串输入到ES段存储的地址里面去
        MOV AH,0AH
        INT 21H
        POP DS ;把原来的地址重新放回DS

        LEA DX,WHITE ;注意应该放在POP DS 之后
        MOV AH,9
        INT 21H

        MOV CL,[BUFF1+1]
        CMP CL,ES:[BUFF2+1]
        JNE L1 ;长度不同则结束
        LEA SI,BUFF1+1
        LEA DI,BUFF2+1
        XOR CH,CH ;cx存储长度
        REPE CMPSB ;开始比较 以字节为单位
        JNE L1
        LEA DX,M2
        JMP L2
L1:     LEA DX,M1
L2:     MOV AH,9
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END     MAIN

