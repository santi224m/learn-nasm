	section	.data
mystr:	db	'assembly is fun'	; 15 chars
str_len:
	dd	0

	section	.text
	global	_start

_start:
	mov	r15, 0		; counter

loop:
	mov	r13, [mystr+r15]	; Move mystr to counter offset
	movzx	r13, r13b		; Get next char
	cmp	r13, 0			; Should be 0 when we go past str size
	Je	exit

	inc	r15
	Jmp	loop

exit:
	mov	[str_len], r15		; r15 stores str length at this point
	mov	rax, 60
	mov	rdi, 0
	syscall
