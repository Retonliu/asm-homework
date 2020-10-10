DATA    SEGMENT
BUF DB 100 DUP(?)
STR     DB 0DH,0AH,'$'
DATA    ENDS
STACK   SEGMENT STACK
DW 10 DUP(?)
TOS LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
MAIN    PROC FAR
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS
        XOR BX,BX;用于存储4位十六进制数
        MOV CX,4
I:      MOV AH,1;十六进制输入
        INT 21H
        CMP AL,30H
        JB I
        CMP AL,39H
        JA U;可能A到F或者a到f
        SUB AL,30H;0到9之间
        JMP J
U:      CMP AL,41H
        JB I;9到A之间无效
        CMP AL,5AH
        JA L;可能a到f
        SUB AL,37H;A到F之间
        JMP J
L:      CMP AL,61H
        JB I;Z到a之间无效
        CMP AL,7AH
        JA I;大于z无效
        SUB AL,57H
        JMP J
J:      PUSH CX
        MOV CL,4
        AND AL,0FH
        SHL BX,CL ;应该是先移后加
        ADD BL,AL
        POP CX
        LOOP I

        LEA DX,STR
        MOV AH,9
        INT 21H
        MOV CX,16;输出
O1:     SHL BX,1;移一位到CF里面
        JC YI
        MOV DL,30H
        JMP O2
YI:     MOV DL,31H
O2:     MOV AH,2
        INT 21H
        LOOP O1

        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END MAIN