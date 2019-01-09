; https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction
BITS 64
DEFAULT REL

section .text
	global	weapons_asm

; double *input passed through rdi
; unsigned long length passed through rsi
; double output passed through xmm0
weapons_asm:
	mov		rax, rsi
	mov		rbx, 0x8
	mul		rbx
	add		rax, rdi	; rax has address of 1 past last input

	fld qword	[rdi]

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

math_loop:
	fadd qword	[rdi]

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

	fsub qword	[rdi]

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

	fmul qword	[rdi]

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

	fdiv qword	[rdi]

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

	fld qword	[rdi]
	sub		rsp, 0x8
	fisttp qword	[rsp]
	mov		rdx, [rsp]
	test		rdx, rdx
	jz		exponent_zero

	and		rdx, 0x0ffffffffffffffff
	call		pow_by_rept

	mov		rdx, [rsp]
	test		rdx, rdx
	jns		skip_signed

	fld1
	fdiv
	jmp		skip_signed

exponent_zero:
	fld1

skip_signed:
	add		rsp, 0x8

	add		rdi, 0x8
	cmp		rdi, rax
	je		done

	jmp		math_loop

done:
	sub		rsp, 0x8
	fstp qword	[rsp]
	movsd		xmm0, [rsp]
	add		rsp, 0x8

	ret

pow_by_rept:
	sub		rsp, 0x8
	fst qword	[rsp]
pow_loop:
	dec		rdx
	test		rdx, rdx
	jz		pow_done
	fmul qword	[rsp]
	jmp		pow_loop

pow_done:
	add		rsp, 0x8
	ret
