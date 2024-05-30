	section	.bss
userint:
	resd	1

	section	.text
	global	get_user_input

get_user_input:
	; Get user input and store in userint
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, userint
	mov	rdx, 4
	syscall

	; Remove ascii offset
	mov	r13d, [userint]
	movzx	r13d, r13b
	sub	r13d, '0'
	mov	[userint], r13d

	; Exit
	mov	rax, [userint]
	ret
