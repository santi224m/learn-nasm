	section	.text
	global	exit

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall
