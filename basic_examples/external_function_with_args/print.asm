	section	.text
	global	print_func

print_func:
	mov	r13, rdi	; Store first argument (msg) in r13
	mov	r14d, esi	; Store second argument (size) in r14d (Double word = 32 bits)

	mov	rax, 1
	mov	rdi, 1
	mov	rsi, r13
	mov	edx, r14d
	syscall
	ret
