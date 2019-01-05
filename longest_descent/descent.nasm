; https://codegolf.stackexchange.com/questions/178326/length-of-the-longest-descent
BITS 64
extern printf

section .data
	format:	db "%d", 10, 0

section .text
	global	descent_asm


	; sub	rsp, 0x8
	; mov	rsi, [r12 + r15 * 0x4]
	; mov	rdi, format
	; xor	rax, rax
	; call	printf WRT ..plt
	; add	rsp, 0x8
	; xor	rdi, rdi

; index = r8
; up = (r8 - r10) * 0x4
; down = (r8 + r10) * 0x4
; left = (r8 - 1) * 0x4
; right = (r8 + 1) * 0x4
helper:
	push		r8
	sub		rsp, 0x8
	mov qword	[rsp], 0x0

up:
	mov	rax, [rsp + 0x8]
	sub	rax, r10
	test	rax, rax
	js	down

	mov	rax, [rsp + 0x8]
	mov	edi, [r12 + rax * 0x4]	; value at i
	sub	rax, r10
	mov	esi, [r12 + rax * 0x4]	; value at i - n
	cmp	edi, esi
	jle	down

	mov	r8, rax
	call	helper
	inc	r9
	cmp	[rsp], r9
	jge	down

	mov	[rsp], r9

down:
	mov	rax, r8
	add	rax, r10
	cmp	rax, r14
	jge	left

	mov	rax, [rsp + 0x8]
	mov	edi, [r12 + rax * 0x4]	; value at i
	add	rax, r10
	mov	esi, [r12 + rax * 0x4]	; value at i + n
	cmp	edi, esi
	jle	left

	mov	r8, rax
	call	helper
	inc	r9
	cmp	[rsp], r9
	jge	left

	mov	[rsp], r9

left:
	xor	rdx, rdx
	mov	rax, [rsp + 0x8]
	mov	rbx, r10
	idiv	rbx
	test	rdx, rdx
	jz	right

	mov	rax, [rsp + 0x8]
	mov	edi, [r12 + rax * 0x4]	; value at i
	dec	rax
	mov	esi, [r12 + rax * 0x4]	; value at i - 1
	cmp	edi, esi
	jle	right

	mov	r8, rax
	call	helper
	inc	r9
	cmp	[rsp], r9
	jge	right

	mov	[rsp], r9

right:
	xor	rdx, rdx
	mov	rax, [rsp + 0x8]
	mov	rbx, r10
	idiv	rbx
	dec	rbx
	cmp	rbx, rdx
	je	finish

	mov	rax, [rsp + 0x8]
	mov	edi, [r12 + rax * 0x4]	; value at i
	inc	rax
	mov	esi, [r12 + rax * 0x4]	; value at i + 1
	cmp	edi, esi
	jle	finish

	mov	r8, rax
	call	helper
	inc	r9
	cmp	[rsp], r9
	jge	finish

	mov	[rsp], r9

finish:
	mov	r9, [rsp]
	add	rsp, 0x8
	pop	r8
	ret

; first six parameters from C passed through rdi, rsi, rdx, rdx, r8, r9
; n = rdi, m = rsi, arr = rdx
; arr[0] = [rdx], arr[1] = [rdx + 4], ...
descent_asm:
	push	rbp
	mov	rbp, rsp

	mov	r10, rdi	; saving rdi
	mov	r11, rsi	; saving rsi
	mov	r12, rdx	; saving rdx

	xor	r13, r13	; initial longest descent
	xor	r9, r9		; longest at end of helper

	mov	rax, r10
	mul	rsi
	mov	r14, rax	; r14 is number of elements in the array

	xor 	r15, r15	; counter

; start the algorithm for every index in array
loop_arr:
	mov	r8, r15
	call	helper
	cmp	r13, r9
	jge	skip
	mov	r13, r9

skip:
	inc	r15
	cmp	r15, r14
	jl	loop_arr

done:
	mov	rax, r13
	mov	rsp, rbp
	pop	rbp
	ret
