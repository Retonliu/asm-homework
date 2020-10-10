DATA    SEGMENT
ARRAY     DB 1,2,3,4,5,-6,-7,-8,-9,-10,-11,12,13,14,-15,-16,-17,18,19,20,'$'
ARRAY1    DB 10 DUP(?)
ARRAY2    DB 10 DUP(?)
WHITE1     DB 'fushugeshu:','$'
WHITE2     DB 0DH,0AH,'zhengshugeshu:$'
TEN       DB 10
DATA    ENDS
STACK   SEGMENT STACK
    DB 30H DUP(?)
TOS LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME  DS:DATA, CS:CODE, SS:STACK

START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS

        XOR SI,SI ;负数个数
        XOR DI,DI ;正数个数
        XOR CX,CX
        XOR AX,AX
        LEA BX,ARRAY
L1:     
        MOV AL,[BX]
        INC BX
        CMP AL,'$'
        JE L2 ;结束直接跳转到输出
        CMP AL,0
        JG P
        JL N
P:      MOV ARRAY1[DI],AL
        INC DI
        JMP L1
N:      MOV ARRAY2[SI],AL
        INC SI
        JMP L1

L2:     LEA DX,WHITE1
        MOV AH,9
        INT 21H
        XOR AX,AX
        MOV AX,SI
        XOR CX,CX
L3:     XOR DX,DX
        MOV SI,10
        DIV SI
        PUSH DX ;余数压入堆栈段
        INC CX ;标记当前压入了多少个数
        CMP AX,0
        JNE L3

L4:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP L4

        LEA DX,WHITE2
        MOV AH,9
        INT 21H
        XOR AX,AX
        MOV AX,DI
L5:     XOR DX,DX
        MOV SI,10
        DIV SI
        PUSH DX ;余数压入堆栈段
        INC CX ;标记当前压入了多少个数
        CMP AX,0
        JNE L5

L6:     POP DX
        ADD DL,30H
        MOV AH,2
        INT 21H
        LOOP L6
        MOV AH,4CH
        INT 21H
CODE    ENDS
END     START




