DATA    SEGMENT
        DB 2 DUP(?)
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 2 DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE

START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        MOV CX,5
        XOR BX,BX
L1:     MOV AH,1 ;输入第一次
        INT 21H
        CMP AL,0DH
        JE L2
        CMP AL,30H
        JB L1
        CMP AL,37H
        JA L1
        MOV BL,AL
        SUB BL,30H
        CMP AL,30H
        JE L2
        CMP AL,31H
        JE L2
        DEC CX ;不为0/1，则cx变为4
L2:     PUSH CX
        MOV CL,3
        SHL BX,CL
L3:     MOV AH,1
        INT 21H
        CMP AL,0DH
        JE L4
        CMP AL,30H
        JB L3
        CMP AL,37H
        JA L3
        SUB AL,30H
        AND AL,7
        ADD BL,AL
        POP CX
        LOOP L2
        ;以下部分为输出检查
        MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H

        ROL BX,1
        MOV DL,0 ;清零
        ADC DL,30H
        MOV AH,2
        INT 21H
        MOV CX,5
G1:     PUSH CX
        MOV CL,3
        ROL BX,CL
        MOV DL,BL
        AND DL,7
        ADD DL,30H
        MOV AH,2
        INT 21H
        POP CX
        LOOP G1

L4:     MOV AH,4CH
        INT 21H      
CODE    ENDS
END     START