	section	.text
	global	calc_str_length

calc_str_length:
	mov	r15, 0		; counter

loop:
	mov	r13, [rdi+r15]	; Move mystr to counter offset
	movzx	r13, r13b		; Get next char
	cmp	r13, 0			; Should be 0 when we go past str size
	Je	exit

	inc	r15
	Jmp	loop

exit:
	dec	r15
	mov	rax, r15		; r15 stores str length at this point
	ret
