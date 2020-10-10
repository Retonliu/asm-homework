S1  SEGMENT
    A DW 1
    B DW 1
S1  ENDS
STACK   SEGMENT STACK
    DW 3 DUP(?)
    TOS LABEL WORD
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:S1,  SS:STACK, CS:CODE
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        LEA SP,TOS
        MOV AX,STACK
        MOV SS,AX
        
        XOR BX,BX ;奇数个数
        XOR AX,AX
        MOV CX,2
        LEA SI,A

P1:     LODSW ;放入AX
        TEST AX,01H
        JZ NEXT
        INC BX
NEXT:   LOOP P1
        CMP BX,1
        JA TWO
        JB STOP
        
        PUSH A
        PUSH B
        POP A
        POP B
        JMP STOP
TWO:    INC AX
        MOV B,AX
        LEA SI,A
        MOV BX,[SI]
        INC BX
        MOV A,BX
STOP:   MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN