;由于测试，所以用例的数量为4和7，
S1    SEGMENT
A DB 3,4,5,6 ;15 DUP(?)
C DB 4 DUP(?) ;15 DUP(?)
S1    ENDS
STACK   SEGMENT STACK
 DB 10 DUP (?)
TOS LABEL WORD
STACK   ENDS
S2   SEGMENT
B DB 5,6,7,8,9,10,3 ;20 DUP(?)
S2   ENDS
CODE    SEGMENT
        ASSUME DS:S1, SS:STACK, CS:CODE, ES:S2
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX
        LEA SP,TOS
        MOV AX,S2
        MOV ES,AX

        XOR AX,AX
        XOR BX,BX
        LEA SI,A
        MOV CX,4 ;15
O:      MOV AL,[SI]
        PUSH CX
        MOV CX,7 ;20
        LEA DI,B ;使用内存块2的工作偏移
        CLD
        REPNE SCASB ;不相等时进行重复
        JZ E
        JCXZ NEXT
E:      MOV C[BX], AL
        INC BX
NEXT:   INC SI 
        POP CX
        LOOP O
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN
        
           

        