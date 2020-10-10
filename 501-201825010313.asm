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
L1:     MOV AH,1
        INT 21H
        CMP AL,0DH
        JE L2
        CMP AL,'a'
        JB L1
        CMP AL,'z'
        JA L1

        MOV DL,0DH
        MOV AH,2
        INT 21H
        MOV DL,0AH
        MOV AH,2
        INT 21H

        MOV DL,AL
        SUB DL,20H
        MOV AH,2
        INT 21H
        JMP L1
L2:     MOV AH,4CH
        INT 21H
CODE    ENDS
END     START
