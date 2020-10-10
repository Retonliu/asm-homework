DATA    SEGMENT
        BUFF  DB  'result overflow!$'
DATA    ENDS
STACK   SEGMENT STACK
        DB 30H DUP(?)
TOS     LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME CS:CODE, DS:DATA, SS:STACK

START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS
        ;输入范围-65535到65535
L1:     MOV CX,5
        XOR BX,BX
        MOV AH,1
        INT 21H
        CMP AL,'+'
        JE P1
        CMP AL,'-'
        JE P2
        CMP AL,30H
        JB L1
        CMP AL,39H
        JA L1
        AND AX,0FH
        ADD BX,AX
        DEC CX ;第一位是数字则后面还可以输入4位
        JMP P2
P1:     MOV DX,0
        PUSH DX
        JMP L2
P2:     MOV DX,1  
        PUSH DX
L2:     MOV AH,1
        INT 21H
        CMP AL,0DH
        JE L3
        CMP AL,30H
        JB L2
        CMP AL,39H
        JA L2
        AND AX,0FH
        XCHG AX,BX
        MOV SI,10
        MUL SI
        JC S1
        ADD BX,AX
        JC S1   ;如果结果溢出则直接跳到结束
        LOOP L2

        MOV DL,0DH ;回车换行
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H

L3:     MOV CX,4 ;符号位判断
        POP DX
        CMP DX,1
        JNE L4
        NEG BX
        
L4:     PUSH CX
        MOV CL,4
        ROL BX,CL
        MOV DL,BL
        AND DL,0FH
        ADD DL,30H
        CMP DL,39H
        JBE L5
        ADD DL,7
L5:     MOV AH,2
        INT 21H
        POP CX
        LOOP L4
S1:     MOV AH,4CH
        INT 21H
CODE    ENDS
END     START



