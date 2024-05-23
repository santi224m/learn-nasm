	section	.data
x:	dd	5
y:	dd	6

	section	.text
	global	_start

_start:
	; Must use 32 bit registers for a double word
	mov	r13d, [x]
	mov	r14d, [y]
	add	r13d, r14d

	mov	rax, 60
	mov	rdi, 0
	syscall
