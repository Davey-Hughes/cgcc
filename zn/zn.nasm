; https://codegolf.stackexchange.com/questions/35038/generate-the-group-table-for-z-n
BITS 64

section .text
	global	zn_asm

zn_asm:
	push		0xa		; used for division

	mov		rcx, rdi
	dec		rcx		; set outer counter to n - 1
.l1:
	mov byte	[rsi], 0xa
	dec		rsi		; put newline in output

	mov		rbx, rdi
	dec		rbx		; set inner counter to n - 1
.l2:
	mov		rax, rcx
	add		rax, rbx
	xor		rdx, rdx
	div		rdi		; rdx now has (i + k) % n

	mov		rax, rdx
.l3:					; loop converts integer to string (backwards)
	xor		rdx, rdx
	div qword	[rsp]		; divide our integer by 10
	add		rdx, 0x30	; convert to ASCII

	mov byte	[rsi], dl
	dec		rsi

	test		rax, rax
	jne		zn_asm.l3

	dec		rbx		; inner loop
	test		rbx, rbx
	jge		zn_asm.l2

	dec		rcx		; outer loop
	test		rcx, rcx
	jge		zn_asm.l1

	pop		rax		; reset stack location
	mov		rax, rsi	; move pointer to string to return location
	inc		rax		; inc because rsi points to 1 byte before string

	ret
