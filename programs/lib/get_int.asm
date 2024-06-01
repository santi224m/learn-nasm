	section	.bss
userint:
	resd	1

	section	.text
	global	get_int
	extern	calc_str_length

get_int:
	; Preserve registers: rbx (64 bits), r10d (32 bits), r13d (32 bits)
	push	rbp
	mov	rbp, rsp
	sub	rsp, 0x80
	mov	[rsp-0x40], rbx
	mov	[rsp-0x60], r10d
	mov	[rsp-0x80], r13d

	; Get user input and store in userint
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, userint
	mov	rdx, 4
	syscall

	; Calc str length of user input
	mov	rdi, userint
	call calc_str_length
	mov	rbx, rax	; Store length in rbx

	mov	rcx, 0		; Loop counter
	mov	r10d, 0		; Total counter

loop:	cmp	rcx, rbx
	Je	exit

	; Get next int char from user input
	mov	r13d, [userint+rcx]
	movzx	r13d, r13b

	; Exit if char is newline
	cmp	r13d, 10
	Je exit

	; Calc multiplier
	mov	r12d, 1		; Multiplier
	mov	r11d, ecx	; Loop Counter for calcMult
	add	r11d, 2		; Add 2 to counter to exclude nl and last int
	Jmp	calcMult

cont:	sub	r13d, '0'	; Remove ascii offset
	imul	r13d, r12d
	add	r10d, r13d

	inc	rcx
	Jmp	loop

	; Exit
exit:	mov	eax, r10d
	mov	rbx, [rsp-0x40]
	mov	r10d, [rsp-0x60]
	mov	r13d, [rsp-0x80]
	add	rsp, 0x80
	pop	rbp
	ret

calcMult:
	cmp	r11d, ebx
	Je	cont

	imul	r12d, 10
	inc	r11d
	Jmp	calcMult
