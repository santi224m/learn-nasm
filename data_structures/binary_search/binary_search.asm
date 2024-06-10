	section	.data
idxL:	dd	0
idx:	dd	-1

	section	.bss
idxH:	resd	1

	section	.text
	global	binary_search

binary_search:
	; Store 1st arg in idxH
	mov	[idxH], rsi

loop:
	; Exit when idxL <= idxH
	mov	r13, [idxL]
	mov	r14, [idxH]
	cmp	r13, r14
	Jle	exit

	; Get middle integer -- Store in rbx
	mov	rax, idxH
	mov	r14, idxL
	add	rax, r14
	div	r14
	mov	rbx, r14

exit:
	mov	rax, [idx]
	ret
