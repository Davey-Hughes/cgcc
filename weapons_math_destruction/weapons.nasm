; https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction
BITS 64
DEFAULT REL

section .text
	global	weapons_asm

; double *input passed through rdi
; unsigned long length passed through rsi
; double output passed through xmm0
weapons_asm:
	movsd		xmm0, [rdi + 0x8]
	ret
