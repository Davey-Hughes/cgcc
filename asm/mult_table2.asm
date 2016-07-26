; golfed version of mult_table
; doesn't exit properly and makes some assumptions about table size

section .text
    global _start

_start:

_table:
    mov     r12, 0x9        ; puts 9 into outside loop counter
.L2:
    push    0xa
    mov     r13, r12        ; sets inside loop counter to outside loop counter
.L3:
    mov     rax, r13
    mul     r12             ; multiplies the two numbers

_printInteger:              ; expects int to print in rax
    push    0x20            ; push space char onto the stack

.L1:
    xor     rdx, rdx        ; clear rdx
    mov     r8, 0xa
    div     r8              ; divide by 10
    add     rdx, 0x30       ; convert to ascii
    push    rdx             ; put char on stack
    test    rax, rax        ; check if we've gone through the whole int
    jnz .L1

    push    0x3d            ; push '=' char onto stack
    add     r12, 0x30       ; put multiplicand onto stack
    push    r12
    sub     r12, 0x30
    push    0x78            ; push 'x' char onto stack
    add     r13, 0x30       ; put multiplier onto the stack
    push    r13
    sub     r13, 0x31       ; restores r13 and decrements by 1

    test    r13, r13        ; loops if r13 hasn't reached 0
    jnz _table.L3

    dec     r12
    test    r12, r12        ; loops is r12 hasn't reached 0
    jnz _table.L2

_printChars:
    mov     rdx, 0x9b8
    mov     rax, 0x1        ; syscall code for sys_write
    mov     rdi, 0x1        ; write to stdout
    lea     rsi, [rsp]      ; address of chars to write
    syscall

; _exit:                    ; proper exit not needed in code golf
    ; mov     rax, 0x3c
    ; xor     rdi, rdi
    ; syscall
