	section	.text
	global	_start
	extern	print_func

_start:
	call	print_func

	; Exit program
	mov	rax, 60
	mov	rdi, 0
	syscall
