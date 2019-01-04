; golfed version of mult_table
; doesn't exit properly and makes some assumptions about table size
; also does crazy unstable stuff with registers

; 76 bytes in machine code
; https://codegolf.stackexchange.com/questions/11305/print-this-multiplication-table/86593#86593

section .text
    global _start

_start:

_table:
    mov     di, 0x9         ; sets outside loop counter to 9

.L2:
    push    0xa
    mov     esi, edi        ; sets inside loop counter to outside loop counter
.L3:
    mov     eax, esi
    mul     edi             ; multiplies the two numbers

_printInteger:              ; expects int to print in rax
    push    0x20            ; push space char onto the stack
    cmp     al, 0xa
    jge     .L1
    push    0x20

.L1:
    xor     dx, dx          ; clears out dx register
    mov     bl, 0xa
    div     bx
    add     edx, 0x30       ; convert to ascii
    push    rdx             ; put char on stack
    test    ax, ax          ; check if we've gone through the whole int
    jnz .L1

    push    0x3d            ; push '=' char onto stack
    push    di
    add     byte [rsp], 0x30; converts to ascii on stack
    push    0x78            ; push 'x' char onto stack
    push    si
    add     byte [rsp], 0x30; converts to ascii on stack

    dec     esi             ; loops if esi hasn't reached 0 (sets ZF)
    jnz _table.L3

    dec     edi             ; loops is edi hasn't reached 0 (sets ZF)
    jnz _table.L2

_printChars:
    mov     dx, 0x800
    mov     al, 0x1         ; syscall code for sys_write
    mov     di, 0x1         ; write to stdout
    mov     rsi, rsp
    syscall

; _exit:                    ; proper exit not needed in code golf
    ; mov     rax, 0x3c
    ; xor     edi, edi
    ; syscall
