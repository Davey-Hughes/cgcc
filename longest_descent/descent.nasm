; https://codegolf.stackexchange.com/questions/178326/length-of-the-longest-descent
BITS 64
extern printf

section .data
	format:	db "%d", 10, 0

section .text
	global descent_asm

helper:


; first six parameters from C passed through rdi, rsi, rdx, rdx, r8, r9
; n = rdi, m = rsi, arr = rdx
; arr[0] = [rdx], arr[1] = [rdx + 4], ...
descent_asm:
	push	rbp
	mov	rbp, rsp

	mov	r10, rdi ; saving rdi
	mov	r11, rsi ; saving rsi
	mov	r12, rdx ; saving rdx

	xor	r13, r13 ; initial longest descent

	mov	rax, r10
	mul	rsi
	; mov	rsi, 0x4
	; mul	rsi
	mov	r14, rax ; r14 is number of elements in the array

	xor 	r15, r15 ; counter

; start the algorithm for every index in array
loop_arr:
	; sub	rsp, 0x8
	; mov	rsi, r15
	; mov	rdi, format
	; xor	rax, rax
	; call	printf WRT ..plt
	; add	rsp, 0x8
	; xor	rdi, rdi
	call helper
	inc	r15
	cmp	r15, r14
	jl loop_arr

done:
	mov	rax, 0x0
	mov	rsp, rbp
	pop	rbp
	ret
