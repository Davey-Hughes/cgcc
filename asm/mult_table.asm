section .data
    newline     db 0xa

section .text
    global _start

_start:

_table:
    mov     r12, 0x1
.L2:
    mov     r13, 0x1
.L3:
    mov     rax, r13
    mul     r12

_printInteger:              ; expects int to print in rax
    push    0x20            ; push space char onto the stack
    mov     rcx, 0x5        ; account for extra push instructions

.L1:
    xor     rdx, rdx        ; clear rdx
    inc     rcx             ; count chars on stack
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
    sub     r13, 0x30

_printChars:
    mov     rax, rcx
    mov     r8, 0x8
    mul     r8              ; mul by 8 for each char pushed on stack
    mov     rdx, rax
    mov     rax, 0x1        ; syscall code for sys_write
    mov     rdi, 0x1        ; write to stdout
    lea     rsi, [rsp]      ; address of chars to write
    syscall
    add     rdx, 0x30       ; extra push instructions (excluded for golfing)
    add     rsp, rdx        ; restore stack address

    add     r13, 0x1
    cmp     r13, r12
    jle _table.L3

_printNewline:
    mov     rax, 0x1        ; syscall code for sys_write
    mov     rdi, 0x1        ; write to stdout
    mov     rdx, 0x1        ; write 1 byte
    mov     rsi, newline    ; address of newline char in .data
    syscall

    add     r12, 0x1
    cmp     r12, 0xa
    jne _table.L2

_exit:
    mov     rax, 0x3c
    xor     rdi, rdi
    syscall
