DATA    SEGMENT
W1        DB 13H DUP(?)
W2        DB 13H DUP(?)
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 2H DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE

START:  ;输入两个2进制的无符号字数据X和Y
        MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        XOR BX,BX
        MOV CX,16
L1:     MOV AH,1
        INT 21H
        CMP AL,0DH
        JE S1
        CMP AL,30H
        JB L1 
        CMP AL,31H
        JA L1
        SUB AL,30H ;ASCII转为二进制
        SHL BX,1 ;左移一位
        AND AL,1
        ADD BL,AL
        LOOP L1
S1:     MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H
        MOV CX,16
L2:     MOV AH,1
        INT 21H
        CMP AL,0DH
        JE S2
        CMP AL,30H
        JB L2 
        CMP AL,31H
        JA L2
        SUB AL,30H
        SHL DX,1
        AND AL,1
        ADD DL,AL
        LOOP L2
S2:     XOR CX,CX
        MOV CX,DX
        MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H
        ADD CX,BX
        MOV BX,CX
        MOV CX,16
L3:     ROL BX,1
        JC L4
        MOV DL,30H
        JMP L5
L4:     MOV DL,31H
L5:     MOV AH,2
        INT 21H
        LOOP L3 
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START
        






