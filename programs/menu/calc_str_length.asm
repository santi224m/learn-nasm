	section	.text
	global	calc_str_length

calc_str_length:
	mov	rcx, 0		; counter

loop:
	mov	r13, [rdi+rcx]	; Move mystr to counter offset
	movzx	r13, r13b	; Get next char
	cmp	r13, 0		; Should be 0 when we go past str size
	Je	exit

	inc	rcx
	Jmp	loop

exit:
	dec	rcx
	mov	rax, rcx	; rcx stores str length at this point
	ret
