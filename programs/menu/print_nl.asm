; Print newline

	section	.data
nl:	db	'', 10

	section	.text
	global	print_nl

print_nl:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall
	ret
