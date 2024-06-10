	section	.data
idxL:	dd	0

	section	.bss
idx:	resd	1
idxH:	resd	1
arr:	resd	10
target:	resd	1

	section	.text
	global	binary_search

binary_search:
	; Store 1st arg in idxH
	mov	r15, rax
	mov	[target], rdi
	dec	rsi
	mov	[idxH], rsi

loop:
	; Exit when idxL > idxH
	mov	r13d, [idxL]
	mov	r14d, [idxH]
	cmp	r14d, r13d
	Jl	exit

	; Get middle integer -- Store in rbx
	mov	eax, [idxH]
	mov	r14d, [idxL]
	add	eax, r14d
	mov	r14d, 2
	mov	rdx, 0		; Reset rdx
	div	r14d
	mov	ebx, eax
	mov	[idx], ebx

	; Store mid int value in ebx
	mov	eax, 4
	imul	eax, ebx
	mov	ebx, [r15d+eax]

checkEq:
	; Check if curr int is target
	mov	eax, [target]
	cmp	eax, ebx
	Jne	checkL
	mov	eax, [idx]
	ret

checkL:
	; Check if curr is less than target
	cmp	ebx, eax
	Jnl	checkG
	mov	eax, [idx]
	inc	eax
	mov	[idxL], eax
	jmp	loop

checkG:
	; Check if curr is greater than target
	mov	eax, [idx]
	dec	eax
	mov	[idxH], eax
	Jmp	loop

exit:
	mov	rax, -1
	ret
