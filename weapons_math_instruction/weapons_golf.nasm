; https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction
BITS 64
DEFAULT REL

section .text
	global	weapons_asm

; double *input passed through rdi
; unsigned long length passed through rsi
; double output passed through xmm0
weapons_asm:
	xor		rax, rax
	mov		rcx, rsi
	fild dword	[rdi]		; load first value into st0

math_loop:
	add		rax, 0x8
	dec		rcx
	jrcxz		done

	fiadd dword	[rdi + rax]

	add		rax, 0x8
	dec		rcx
	jrcxz		done

	fisub dword	[rdi + rax]

	add		rax, 0x8
	dec		rcx
	jrcxz		done

	fimul dword	[rdi + rax]

	add		rax, 0x8
	dec		rcx
	jrcxz		done

	fidiv dword	[rdi + rax]

	add		rax, 0x8
	dec		rcx
	jrcxz		done

exp:
	mov		rdx, [rdi + rax]
	test		rdx, rdx
	jz		exp.zero

	and		rdx, 0x0fffffffffffffff
	jmp		pow_rept

.ret:
	mov		rdx, [rsp]
	test		rdx, rdx
	jns		exp.skip_neg

	fld1
	fdiv
	jmp		exp.skip_neg

.zero:
	fld1

.skip_neg:
	jmp		math_loop

done:
	sub		rsp, 0x8
	fstp qword	[rsp]
	movsd		xmm0, [rsp]
	add		rsp, 0x8

	ret

pow_rept:
	sub		rsp, 0x8
	fst qword	[rsp]
.l:
	dec		rdx
	test		rdx, rdx
	jz		pow_rept.done
	fmul qword	[rsp]
	jmp		pow_rept.l

.done:
	add		rsp, 0x8
	jmp		exp.ret
