.ORIG x3000

; 主程序
MAIN
    LD R6, STACK        ; 初始化栈指针
    LDI R0, INPUT
    JSR SAVINGS         ; 调用 SAVINGS(n)
    STI R0, RESULT
    HALT

; EARN 函数
; 输入: R0 = n
; 输出: R0 = EARN(n)
EARN
    ADD R6, R6, #-1     ; 保存返回地址
    STR R7, R6, #0
    ADD R6, R6, #-1     ; 保存 R1
    STR R1, R6, #0
    ADD R1, R0, #0      ; R1 = n
    BRz EARN_BASE       ; 如果 n == 0, 跳转到基础情况
    ADD R0, R1, #-1     ; R0 = n - 1
    JSR EARN            ; 递归调用 EARN(n-1)
    ADD R0, R0, R0      ; EARN(n) = EARN(n-1) * 2
    BR EARN_RETURN
EARN_BASE
    AND R0, R0, #0
    ADD R0, R0, #6      ; EARN(0) = 6
EARN_RETURN
    LDR R1, R6, #0      ; 恢复 R1
    ADD R6, R6, #1
    LDR R7, R6, #0      ; 恢复返回地址
    ADD R6, R6, #1
    RET

; SPEND 函数
; 输入: R0 = n
; 输出: R0 = SPEND(n)
SPEND
    ADD R6, R6, #-1     ; 保存返回地址
    STR R7, R6, #0
    ADD R6, R6, #-1     ; 保存 R1
    STR R1, R6, #0
    ADD R6, R6, #-1     ; 保存 R2
    STR R2, R6, #0
    ADD R6, R6, #-1     ; 保存 R3
    STR R3, R6, #0
    ADD R1, R0, #0      ; R1 = n
    BRz SPEND_BASE      ; 如果 n == 0, 跳转到基础情况
    ADD R0, R1, #-1     ; R0 = n - 1
    JSR SPEND           ; 递归调用 SPEND(n-1)
    ADD R2, R0, #0      ; R2 = SPEND(n-1)
    ADD R0, R1, #-1     ; R0 = n - 1
    JSR EARN            ; 调用 EARN(n-1)
    ADD R3, R0, #0      ; R3 = EARN(n-1)
    NOT R3, R3
    ADD R3, R3, #1      ; R3 = -EARN(n-1)
    ADD R3, R3, R2      ; R3 = SPEND(n-1) - EARN(n-1)
    BRzp SPEND_BASE     ; 如果 SPEND(n-1) >= EARN(n-1), 跳转到基础情况
    ADD R0, R2, R2
    ADD R0, R0, R0      ; SPEND(n) = SPEND(n-1) * 4
    BR SPEND_RETURN
SPEND_BASE
    AND R0, R0, #0
    ADD R0, R0, #2      ; SPEND(0) = 2
SPEND_RETURN
    LDR R3, R6, #0      ; 恢复 R3
    ADD R6, R6, #1
    LDR R2, R6, #0      ; 恢复 R2
    ADD R6, R6, #1
    LDR R1, R6, #0      ; 恢复 R1
    ADD R6, R6, #1
    LDR R7, R6, #0      ; 恢复返回地址
    ADD R6, R6, #1
    RET

; SAVINGS 函数
; 输入: R0 = n
; 输出: R0 = SAVINGS(n)
SAVINGS
    ADD R6, R6, #-1     ; 保存返回地址
    STR R7, R6, #0
    ADD R6, R6, #-1     ; 保存 R1
    STR R1, R6, #0
    ADD R6, R6, #-1     ; 保存 R2
    STR R2, R6, #0
    ADD R6, R6, #-1     ; 保存 R3
    STR R3, R6, #0
    ADD R6, R6, #-1     ; 保存 R4
    STR R4, R6, #0
    ADD R1, R0, #0      ; R1 = n
    BRz SAVINGS_BASE    ; 如果 n == 0, 跳转到基础情况
    ADD R0, R1, #-1     ; R0 = n - 1
    JSR SAVINGS         ; 递归调用 SAVINGS(n-1)
    ADD R2, R0, #0      ; R2 = SAVINGS(n-1)
    ADD R0, R1, #-1     ; n = n - 1
    JSR EARN            ; 调用 EARN(n-1)
    ADD R3, R0, #0      ; R3 = EARN(n-1)
    ADD R0, R1, #-1     ; n = n - 1
    JSR SPEND           ; 调用 SPEND(n-1)
    ADD R4, R0, #0      ; R4 = SPEND(n-1)
    ADD R0, R2, R3
    NOT R4, R4
    ADD R4, R4, #1      ; R4 = -SPEND(n-1)
    ADD R0, R0, R4      ; SAVINGS(n) = SAVINGS(n-1) + EARN(n-1) - SPEND(n-1)
    BR SAVINGS_RETURN
SAVINGS_BASE
    AND R0, R0, #0
    ADD R0, R0, #10     ; SAVINGS(0) = 10
SAVINGS_RETURN
    LDR R4, R6, #0      ; 恢复 R4
    ADD R6, R6, #1
    LDR R3, R6, #0      ; 恢复 R3
    ADD R6, R6, #1
    LDR R2, R6, #0      ; 恢复 R2
    ADD R6, R6, #1
    LDR R1, R6, #0      ; 恢复 R1
    ADD R6, R6, #1
    LDR R7, R6, #0      ; 恢复返回地址
    ADD R6, R6, #1
    RET
    

STACK   .FILL x6000
INPUT   .FILL X3100
RESULT  .FILL X3200

.END

.ORIG X3100
.FILL #5
.END