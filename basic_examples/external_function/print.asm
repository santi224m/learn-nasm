	section	.data
hello:	db	'Hello', 10

	section	.text
	global	print_func

print_func:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, hello
	mov	rdx, 6
	syscall
	ret
