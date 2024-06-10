	section	.data
arr:	dd	10, 13, 33, 34, 55, 56, 65, 66, 68, 93
target:	dd	55

	section	.bss
idx:	resd	1

	section	.text
	global	_start

_start:
	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
