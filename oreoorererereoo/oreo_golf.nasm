; https://codegolf.stackexchange.com/questions/178344/oreoorererereoo
; golfed length in x86-64 machine code is 97 bytes
BITS 64

section .text
	global	oreo_asm

; input char * passed through rdi
; output char * passed through rsi
oreo_asm:
	push		rsi
	push		rdi
len:
	inc		rdi
	cmp byte	[rdi], 0x0		; see if we've reached null byte
	jne		len

	mov		r12, rdi
	pop		rdi
	sub		r12, rdi		; r12 is strlen
	xor		r14, r14
	jmp		outer_loop.skip

extra:						; insert whitespace on 'filling' layers
	mov byte	[r9], 0x20
	mov byte	[rbx], 0x20
	dec		r14
	jmp		outer_loop

newline:
	mov byte	[rsi], 0xa		; put newline in output
	inc		rsi

outer_loop:
	inc		r14
	inc		rdi
.skip:
	mov		r8b, [rdi]		; byte in input string
	cmp		r8b, 0x65		; skip 'e' chars
	je		extra

	test		r8b, r8b
	je		done

	mov		rbx, rsi		; store location of first whitespace

inner_loop:
	mov		[rsi], r8b
	mov		r9, rsi			; store location of second whitespace
	inc		rsi
	xor		rdx, rdx
	mov		rax, rsi
	sub		rax, [rsp]
	sub		rax, r14
	div		r12
	test		rdx, rdx
	je		newline			; put newline at end of output line
	jmp		inner_loop

done:
	pop		rsi
	ret
