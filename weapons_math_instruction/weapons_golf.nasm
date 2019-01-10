; https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction

; credit to gwaugh on stack exchange for program logic
; https://codegolf.stackexchange.com/a/178491/56718
BITS 64
DEFAULT REL

section .text
	global	weapons_asm

; double *input passed through rdi
; unsigned long length passed through rsi
; double *output passed through rdx
weapons_asm:
	mov		rcx, rsi

	fild dword	[rdi]		; load first value into st0

math_loop:
	add		rdi, 0x4
	dec		rcx
	jrcxz		done

	fiadd dword	[rdi]		; float add

	add		rdi, 0x4
	dec		rcx
	jrcxz		done

	fisub dword	[rdi]		; float sub

	add		rdi, 0x4
	dec		rcx
	jrcxz		done

	fimul dword	[rdi]		; float multiply

	add		rdi, 0x4
	dec		rcx
	jrcxz		done

	fidiv dword	[rdi]		; float divide

	add		rdi, 0x4
	dec		rcx
	jrcxz		done

exp_rept:				; exponentation through repeated multiplication
	push		rcx
	mov 		ecx, [rdi]	; move exponent to ecx
	fld1
	cmp		ecx, 0x0
	jz		exp_rept.done	; if exponent is 0, st0 will have value 1
	pushf				; save comparison flags for later
	jg		exp_rept.l
	neg		ecx		; if exponent is negative, switch to positive

.l:
	fmul		st0, st1
	loop		exp_rept.l	; loop until ecx is 0
	popf
	jge		exp_rept.done	; if exponent was negative, perform 1/x
	fld1
	fdiv

.done:
	pop		rcx

	jmp		math_loop	; loop again

done:
	fstp qword	[rdx]		; move result to output location
	ret
