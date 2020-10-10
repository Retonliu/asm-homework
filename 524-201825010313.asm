S1  SEGMENT
    SINGLIST DW MUSIC1,MUSIC2,MUSIC3,MUSIC4,MUSIC5
    STR DB 0DH,0AH,'$'
S1  ENDS
STACK   SEGMENT STACK
    DW 3 DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:S1, CS:CODE, SS:STACK
MAIN    PROC FAR
        MOV AX,S1
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX

I:      MOV AH,1 ;输入
        INT 21H
        SUB AL,30H
        CMP AL,1
        JB I
        CMP AL,5
        JA I
        XOR AH,AH
        DEC AL ;因为MUSIC 是从0开始的
        MOV CL,2
        MUL CL ;AL乘以2
        MOV BX,AX
        LEA DX,STR
        MOV AH,9
        INT 21H
        JMP SINGLIST[BX]
MUSIC1: MOV DL,'1'
        MOV AH,2
        INT 21H
        JMP STOP
MUSIC2: MOV DL,'2'
        MOV AH,2
        INT 21H
        JMP STOP
MUSIC3: MOV DL,'3'
        MOV AH,2
        INT 21H
        JMP STOP
MUSIC4: MOV DL,'4'
        MOV AH,2
        INT 21H
        JMP STOP
MUSIC5: MOV DL,'5'
        MOV AH,2
        INT 21H
        JMP STOP
STOP:   MOV AH,4CH
        INT 21H
MAIN    ENDP
CODE    ENDS
    END MAIN