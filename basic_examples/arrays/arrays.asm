	section	.data
arr:	dd	0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144

	section	.text
	global	_start
	extern	print_int

_start:
	mov	r15, 0	; Counter
	mov	rbx, 13	; Array length

loop:
	cmp	r15, rbx
	Je exit

	; Store next int in r13d
	mov	r13d, [arr+r15*4]	; Offset = counter * 4 bytes (32 bits)

	mov	edi, r13d
	call	print_int

	inc r15
	Jmp loop

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall
