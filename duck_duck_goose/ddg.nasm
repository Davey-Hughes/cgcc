; https://codegolf.stackexchange.com/questions/157897/duck-duck-goose
BITS 64

section .data
	goose:		db 'goose', 0xa
	duck:		db 'duck', 0xa

section .text
	global	_start

_start:
	mov		al, 0x1		; syscall for write
	mov		dil, 0x1	; stdout
	mov		esi, duck	; address of string
	mov		dl, 0x6		; length of string
	syscall

	; rdrand 		bx	; using ebx and jnz makes the printing more interesting
	; test		bx, bx	; prints multiple ducks before goose
	; jnz		_start

	rdrand		ecx		; has a 1/(2^32) chance of printing another duck
	jecxz		_start

	mov		al, 0x1		; (needed again since rax gets clobbered)
	mov		esi, goose
	syscall

_exit:
	mov		eax, 0x3c
	xor		edi, edi
	syscall
