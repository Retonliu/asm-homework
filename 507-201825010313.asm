S1  SEGMENT
DATA    DW 100D DUP(?)
S1  ENDS
S2  SEGMENT STACK
    DW 10 DUP(?)
    TOS LABEL WORD
S2  ENDS
CODE    SEGMENT
    ASSUME DS:S1,SS:S2,CS:CODE
START:  MOV AX,S1
        MOV DS,AX
        MOV AX,S2
        MOV SS,AX
        LEA SP,TOS
        
        LEA BX,DATA ;初始化AX为第一个值
        MOV AX,[BX]
        ADD BX,2

        MOV CX,99
        XOR DX,DX
L1:     MOV DX,[BX]
        ADD BX,2 ;指针后移两个格子
        TEST DL,01H
        JZ L2
        JMP L3 ;如果是奇数则继续进行
L2:     CMP AX,DX;是偶数
        JNG L3 ;比较大则继续进行
        MOV AX,DX
L3:     LOOP L1 ;CX自减，然后判断是否为0
        MOV AH,4CH ;结束程序并退出
        INT 21H
CODE    ENDS
END     START
