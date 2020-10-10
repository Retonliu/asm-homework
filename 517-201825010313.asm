S1    SEGMENT
MEM DB 4 DUP(?)
S1    ENDS
STACK   SEGMENT STACK
    DB 10 DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME  DS:S1,SS:STACK,CS:CODE
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV ES,AX
        MOV AX,STACK
        MOV SS,AX

        XOR DI,DI
        MOV AX,2A49H
        MOV CX,4
        LEA DI,MEM
NEXT:   PUSH CX
        MOV BX,AX
        AND BX,0FH ;取出低四位
        ADD BX,30H

        CMP BX,39H
        JA DA
        JMP J
DA:     CMP BX,5AH
        JA XIAO
        ADD BX,7
        JMP J
XIAO:   ADD BX,20H
        JMP J

J:      MOV CL,4
        SHR AX,CL ;AX移动四位
        MOV MEM[DI],BL
        INC DI
        POP CX
        LOOP NEXT
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN