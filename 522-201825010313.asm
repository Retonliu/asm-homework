;采用字节单位，所以在吧数据从内存拿到AX和CX的时候，记得是拿到AL和CL，高位清零
S1  SEGMENT
STR DB 100,?,100 DUP(?);100,5,'@#$%^'
S1  ENDS
STACK   SEGMENT STACK
 DB 1 DUP(?)
STACK   ENDS
CODE SEGMENT   
    ASSUME DS:S1,SS:STACK,CS:CODE
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        
        ;LEA DX,STR
        ;MOV AH,0AH
        ;INT 21H

        XOR BX,BX ;数字
        XOR DX,DX ;字母
        XOR DI,DI ;其他
        XOR CX,CX
        XOR AX,AX

        LEA SI,STR+1
        MOV CL,[SI]
        LEA SI,STR+2
P:      LODSB ;AX
S:      CMP AX,30H
        JB Q
        CMP AX,39H
        JA Z1
        INC BX
        JMP NEXT

Z1:     CMP AX,41H
        JB Q
        CMP AX,5AH
        JA Z2
        INC DX
        JMP NEXT
Z2:     CMP AX,61H
        JB Q
        CMP AX,7AH
        JA Q
        INC DX
        JMP NEXT

Q:      INC DI
NEXT:   LOOP P
STOP:   MOV DX,DI
        ADD DL,30H
        MOV AH,2
        INT 21H
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN