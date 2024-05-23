	section	.data
x:	dd	5
y:	dd	11

	section	.text
	global	_start

_start:
	; Multiply
	mov	r13d, [x]
	mov	r14d, [y]
	imul	r13d, r14d

	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
