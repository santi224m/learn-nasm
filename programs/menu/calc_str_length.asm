	section	.text
	global	calc_str_length

calc_str_length:
	; Preserve r13
	push	rbp
	mov	rbp, rsp
	sub	rsp, 0x40
	mov	[rsp-0x40], r13

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
	; Restore r13
	mov	r13, [rsp-0x40]
	add	rsp, 0x40
	pop	rbp
	ret
