DATA    SEGMENT
    DB 20H DUP(?)
DATA    ENDS
STACK   SEGMENT STACK
    DB 20H DUP(?)
    TOP LABEL WORD
STACK   ENDS
CODE    SEGMENT
    ASSUME DS:DATA, CS:CODE, SS:STACK
START:  MOV AX,DATA
        MOV DS,AX
        MOV AH,1
        INT 21H
        XOR CX,CX
        MOV CL,AL

L1:     MOV DL,07H
        MOV AH,2
        INT 21H
        MOV AH,4CH
        INT 21H
        LOOP L1
CODE    ENDS
END     START