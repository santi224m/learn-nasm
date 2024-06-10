	section	.data
arr:	dd	10, 13, 33, 34, 55, 56, 65, 66, 68, 93
target:	dd	13
nl:	db	'', 10

	section	.bss
idx:	resd	1
char:	resb	1

	section	.text
	global	_start
	extern	binary_search

_start:
	; Get target index
	mov	rax, arr
	mov	rdi, [target]
	mov	rsi, 10
	call	binary_search
	mov	[idx], rax

	; Print index
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, [idx]
	add	rsi, '0'
	mov	[char], rsi
	mov	rsi, char
	mov	rdx, 1
	syscall

	; Print newline
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall

	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
