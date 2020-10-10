DATA    SEGMENT
        DB 20H DUP(?)
DATA    ENDS
STACK   SEGMENT STACK 'STACK'
        DW 20H DUP(?)
STACK   ENDS
CODE    SEGMENT
        ASSUME DS:DATA,SS:STACK,CS:CODE
START:  MOV AX,DATA
        MOV DS,AX
        MOV AX,STACK
        MOV SS,AX

        MOV AX,3210H
        PUSH AX
L1:     AND AL,7
        MOV BL,AL

        POP AX
        MOV CL,4
        SHR AX,CL
        PUSH AX
        AND AL,7
        MOV DL,AL 

        POP AX
        MOV CL,4
        SHR AX,CL
        PUSH AX
        AND AL,7
        MOV CL,AL

        POP AX
        MOV CL,4
        SHR AX,CL 
CODE    ENDS
END     START






        


