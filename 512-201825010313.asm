S1    SEGMENT
MEN DW 4,0,5,0,6;100D DUP(?)
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
        
        LEA SI,MEN
        MOV CX,5
NEXT:   LODSW ;将SI的数据放入AX，SI+2
        CMP AX,0
        JNE NZERO

        MOV DI,SI ;保护现场
        PUSH CX
        SUB CX,1

DELETE: MOV BX,[SI]
        MOV [SI-2],BX
        ADD SI,2
        LOOP DELETE

        POP CX;还原现场
        MOV SI,DI
        SUB SI,2
NZERO:  LOOP NEXT
        MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
        END MAIN

