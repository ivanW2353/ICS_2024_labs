.ORIG x3000

    LDI R0,LENGTH
    LD R1,STRING      ; R1 is the pointer of the string

; 以下代码略去
    LDI R2,LENGTH
    ADD R2,R2,#-1
    ADD R2,R2,R1    ; R2 is the pointer of the last character of the string

COMPARE_LOOP

    NOT R5,R2
    ADD R5,R5,#1    ; R5 = -R2
    ADD R5,R5,R1    ; R5 = R1 - R2
    BRzp PALINDROMIC

    LDR R3,R1,#0    ; Load the first character
    LDR R4,R2,#0    ; Load the last character

    NOT R4,R4
    ADD R4,R4,#1    ; R4 = -R4
    ADD R3,R3,R4    ; R3 = R3 - R4
    BRnp NOT_PALINDROMIC


    ADD R1,R1,#1
    ADD R2,R2,#-1

    BR COMPARE_LOOP

PALINDROMIC
    AND R0,R0,#0    ; R0 = 0
    ADD R0,R0,#1    ; R0 = 1
    STI R0,RESULT
    HALT

NOT_PALINDROMIC
    AND R0,R0,#0    ; R0 = 0
    STI R0,RESULT
    HALT
    ; 以上代码略去


LENGTH  .FILL x3100
STRING  .FILL x3101
RESULT  .FILL x3200

.END

.ORIG x3100
.FILL #5
.STRINGZ "abcba"
.END
