; https://codegolf.stackexchange.com/questions/178344/oreoorererereoo
BITS 64

section .text
	global	oreo_asm

; input passed through rdi
; output passed through rsi
oreo_asm:
	; push		rbx			; callee saved registers
	; push		r12			; not needed for golfed version
	; push		r13
	; push		r14
	; push		r15
	; push		rbp
	; mov		rbp, rsp

	xor		r12, r12		; counter to store strlen
len:
	inc		r12
	cmp byte	[rdi + r12], 0x0	; see if we've reached null byte
	jne		len

	xor		rcx, rcx
	xor		r13, r13		; string byte counter
	xor		r14, r14
	jmp		outer_loop.skip

extra:
	mov		rax, r13
	sub		rax, 0x2
	mov byte	[rsi + rax], 0x20
	sub		rax, r12
	inc		rax
	mov byte	[rsi + rax], 0x20
	dec		r14
	jmp		outer_loop

newline:
	mov byte	[rsi + r13], 0xa	; put newline in output
	inc		r13

outer_loop:
	inc		r14
	inc		rcx
.skip:
	mov		r8b, [rdi + rcx]	; byte in input string
	cmp		r8b, 0x65		; skip 'e' chars
	je		extra

	test		r8b, r8b
	je		done

inner_loop:
	mov		[rsi + r13], r8b
	inc		r13
	xor		rdx, rdx
	mov		rax, r13
	sub		rax, r14
	div		r12
	test		rdx, rdx
	je		newline
	jmp		inner_loop

done:
	mov byte	[rsi + r13], 0x0

	; mov		rsp, rbp		; restore callee saved registers
	; pop		rbp			; not needed for golfed version
	; pop		r15
	; pop		r14
	; pop		r13
	; pop		r12
	; pop		rbx
	ret
