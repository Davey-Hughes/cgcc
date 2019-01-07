; https://codegolf.stackexchange.com/questions/178344/oreoorererereoo
BITS 64

section .text
	global	oreo_asm

; input passed through rdi
; output passed through rsi
oreo_asm:
	push		rbx			; callee saved registers
	push		r12
	push		r13
	push		r14
	push		r15
	push		rbp
	mov		rbp, rsp

	xor		rcx, rcx		; counter
len:
	inc		rcx
	cmp byte	[rdi + rcx], 0x0
	jne		len

	mov		r12, rcx		; r12 is len

	mov		rcx, -0x1
	mov		r13, 0x0		; string byte counter
	mov		r14, rcx
	jmp		outer_loop

extra:
	mov		r15, r13
	sub		r15, 0x2
	mov byte	[rsi + r15], 0x20
	sub		r15, r12
	inc		r15
	mov byte	[rsi + r15], 0x20
	dec		r14
	jmp		outer_loop

newline:
	mov byte	[rsi + r13], 0xa	; put newline in output
	inc		r13

outer_loop:
	inc		r14
	inc		rcx
	mov		r8b, [rdi + rcx]	; byte in input string
	cmp		r8b, 0x65		; skip 'e' chars
	je		extra

	cmp		r8b, 0x0
	je		done

inner_loop:
	mov		[rsi + r13], r8b
	inc		r13
	xor		rdx, rdx
	mov		rax, r13
	sub		rax, r14
	mov		rbx, r12
	div		rbx
	cmp		rdx, 0x0
	je		newline
	jmp		inner_loop

done:
	mov byte	[rsi + r13], 0x0

	mov		rsp, rbp		; restore callee saved registers
	pop		rbp
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx
	ret
