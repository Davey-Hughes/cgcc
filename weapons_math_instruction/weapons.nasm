; https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction
BITS 64
DEFAULT REL

section .text
	global	weapons_asm

; double *input passed through rdi
; unsigned long length passed through rsi
; double *output passed through rdx
weapons_asm:
	push		rdx		; save for later
	mov		rax, rsi
	mov		rbx, 0x4
	mul		rbx
	add		rax, rdi	; rax has address of 1 past last input

	fild dword	[rdi]

	add		rdi, 0x4
	cmp		rdi, rax
	je		done

math_loop:
	fiadd dword	[rdi]

	add		rdi, 0x4
	cmp		rdi, rax
	je		done

	fisub dword	[rdi]

	add		rdi, 0x4
	cmp		rdi, rax
	je		done

	fimul dword	[rdi]

	add		rdi, 0x4
	cmp		rdi, rax
	je		done

	fidiv dword	[rdi]

	add		rdi, 0x4
	cmp		rdi, rax
	je		done

	mov		rdx, [rdi]
	test		rdx, rdx
	jz		exponent_zero

	and		rdx, 0x0fffffff	; clear sign bit
	call		pow_by_rept

	mov		rdx, [rsp]
	test		rdx, rdx
	jns		skip_signed

	fld1				; perform 1/x if exponent is signed
	fdiv
	jmp		skip_signed

exponent_zero:
	fld1

skip_signed:
	add		rdi, 0x4
	cmp		rdi, rax
	je		done

	jmp		math_loop

done:
	pop		rdx
	fstp qword	[rdx]
	ret

pow_by_rept:				; perform exponent by repeated multiplication
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
